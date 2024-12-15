//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors.
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

var reg = btstack_packet_callback_registration_t()

extension UnsafeMutablePointer: CustomStringConvertible {
    public var description: String {
        return "0x" + String(UInt(bitPattern: self), radix: 16)
    }
}

extension DefaultStringInterpolation {
  mutating func appendInterpolation(hex value: Int) {
    appendInterpolation("0x" + String(value, radix: 16))
  }
}

@main
struct Main {
  static func main() {
    stdio_init_all()
    print("[main] Start")

    // The following makes re-flashing via OpenOCD work, see
    // - https://forums.raspberrypi.com/viewtopic.php?t=363914
    // - https://github.com/raspberrypi/pico-sdk/issues/1152
    // - https://github.com/raspberrypi/debugprobe/issues/45
    timer_reenable_if_under_debug()

    guard cyw43_arch_init() == 0 else {
      print("[main] cyw43_arch_init failed")
      return
    }

    reg.callback = { packet_type, channel, packet, size in
        print("callback: \(packet_type) \(channel) \(packet!) \(size)")
    }
    hci_add_event_handler(&reg)

    let led = UInt32(CYW43_WL_GPIO_LED_PIN)
    let dot = {
      cyw43_arch_gpio_put(led, true)
      sleep_ms(100)
      cyw43_arch_gpio_put(led, false)
      sleep_ms(100)
    }
    let on = {
      cyw43_arch_gpio_put(led, true)
    }
    print("[main] cyw43_arch_init done")
    dot()
    dot()

    A2DPSinkDemo().setupDemo()

    print("[main] Starting BTstack...")
    hci_power_control(HCI_POWER_ON)
    on()

    print("[main] Started, starting btstack run loop")
    btstack_run_loop_execute()
    // btstack_run_loop_execute never returns
  }
}

struct A2DPSinkDemo {
    // Codec capabilities and configuration
    private let mediaSBCCodecCapabilities: UnsafeBufferPointer<UInt8> = {
        let p = UnsafeMutablePointer<UInt8>.allocate(capacity: 4)
        p[0] = 0xFF //(AVDTP_SBC_44100 << 4) | AVDTP_SBC_STEREO,
        p[1] = 0xFF //(AVDTP_SBC_BLOCK_LENGTH_16 << 4) | (AVDTP_SBC_SUBBANDS_8 << 2) | AVDTP_SBC_ALLOCATION_METHOD_LOUDNESS,
        p[2] = 2
        p[3] = 53
        return UnsafeBufferPointer(start: p, count: 4)
    }()
    
    // Service record buffers
    private var sdpAvdtpSinkServiceBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 256)
    private var sdpAvrcpControllerServiceBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 256)
    private var sdpAvrcpTargetServiceBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 256)
    private var deviceIdSdpServiceBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 256)
    
    func setupDemo() {
        // Initialize Bluetooth protocols
        print("initializeProtocols()")
        initializeProtocols()
        
        // Configure A2DP Sink
        print("configureA2DPSink()")
        configureA2DPSink()
        
        // Configure AVRCP
        print("configureAVRCP()")
        configureAVRCP()
        
        // Configure Service Discovery Protocol (SDP)
        print("configureSDP()")
        configureSDP()
        
        // Configure GAP (Generic Access Profile)
        print("configureGAP()")
        configureGAP()
        
        // Register HCI event handler
        print("registerHCIEventHandler()")
        registerHCIEventHandler()
        
        // Optionally log audio playback capabilities
        print("logAudioPlaybackStatus()")
        logAudioPlaybackStatus()
    }
    
    private func initializeProtocols() {
        L2CAP.initialize()
        SDP.initialize()
        
        #if ENABLE_BLE
        SecurityManager.initialize()
        #endif
        
        #if ENABLE_AVRCP_COVER_ART
        GOEPClient.initialize()
        AVRCPCoverArtClient.initialize()
        #endif
    }
    
    private func configureA2DPSink() {
        A2DPSink.registerPacketHandler { packet in
            // Handle A2DP sink packet
            self.a2dpSinkPacketHandler(packet)
        }
        
        A2DPSink.registerMediaHandler { mediaData in
            self.handleL2CAPMediaDataPacket(mediaData)
        }
        
        // Create stream endpoint
        guard let streamEndpoint = A2DPSink.createStreamEndpoint(
            type: .audio,
            codec: .SBC,
            codecCapabilities: mediaSBCCodecCapabilities
        ) else {
            fatalError("Failed to create A2DP stream endpoint")
        }
    }
    
    private func configureAVRCP() {
        AVRCP.registerPacketHandler(
            mainHandler: { packet in self.avrcpPacketHandler(packet) },
            controllerHandler: { packet in self.avrcpControllerPacketHandler(packet) },
            targetHandler: { packet in self.avrcpTargetPacketHandler(packet) }
        )
    }
    
    private func configureSDP() {
        // A2DP Sink Service Record
        createA2DPSinkServiceRecord()
        
        // AVRCP Controller Service Record
        createAvrcpControllerServiceRecord()
        
        // AVRCP Target Service Record
        createAvrcpTargetServiceRecord()
        
        // Device ID Service Record
        createDeviceIdServiceRecord()
    }
    
    private func createA2DPSinkServiceRecord() {
        SDP.createA2DPSinkRecord(
            buffer: sdpAvdtpSinkServiceBuffer,
            featureMask: .headphone
        )
        SDP.registerService(sdpAvdtpSinkServiceBuffer)
    }
    
    private func createAvrcpControllerServiceRecord() {
        var supportedFeatures: UInt16 = 1 << AvrcpControllerFeature.categoryPlayerOrRecorder.rawValue
        
        #if AVRCP_BROWSING_ENABLED
        supportedFeatures |= 1 << AvrcpControllerFeature.browsing.rawValue
        #endif
        
        #if ENABLE_AVRCP_COVER_ART
        supportedFeatures |= 1 << AvrcpControllerFeature.coverArtGetLinkedThumbnail.rawValue
        #endif
        
        SDP.createAvrcpControllerRecord(
            buffer: sdpAvrcpControllerServiceBuffer,
            supportedFeatures: supportedFeatures
        )
        SDP.registerService(sdpAvrcpControllerServiceBuffer)
    }
    
    private func createAvrcpTargetServiceRecord() {
        let supportedFeatures: UInt16 = 1 << AvrcpTargetFeature.categoryMonitorOrAmplifier.rawValue
        
        SDP.createAvrcpTargetRecord(
            buffer: sdpAvrcpTargetServiceBuffer,
            supportedFeatures: supportedFeatures
        )
        SDP.registerService(sdpAvrcpTargetServiceBuffer)
    }
    
    private func createDeviceIdServiceRecord() {
        SDP.createDeviceIdRecord(
            buffer: deviceIdSdpServiceBuffer,
            vendorIdSource: .bluetooth,
            vendorId: .blueKitchenGmbh,
            productId: 1,
            version: 1
        )
        SDP.registerService(deviceIdSdpServiceBuffer)
    }
    
    private func configureGAP() {
        GAP.setLocalName("Sink 00:00:00:00:00:00")
        GAP.setDiscoverable(true)
        GAP.setClassOfDevice(0x200404)
        
        // Configure link policy
        GAP.setDefaultLinkPolicySettings([
            .enableRoleSwitch,
            .enableSniffMode
        ])
        
        GAP.setAllowRoleSwitch(true)
    }
    
    private func registerHCIEventHandler() {
        //HCI.registerEventHandler { packet in
        //    self.hciPacketHandler(packet)
        //}
    }
    
    private func logAudioPlaybackStatus() {
        #if HAVE_POSIX_FILE_IO
        if AudioSink.getInstance() == nil {
            print("No audio playback.")
        } else {
            print("Audio playback supported.")
        }
        
        #if STORE_TO_WAV_FILE
        print("Audio will be stored to '\(wavFilename)' file.")
        #endif
        #endif
    }
    
    // Packet handlers would be defined here (placeholders)
    private func a2dpSinkPacketHandler(_ packet: A2DPPacket) {
        print("a2dpSinkPacketHandler")
    }
    private func handleL2CAPMediaDataPacket(_ mediaData: UnsafeBufferPointer<UInt8>) {
        print("handleL2CAPMediaDataPacket")
    }
    private func avrcpPacketHandler(_ packet: AVRCPPacket) {
        print("avrcpPacketHandler")
    }
    private func avrcpControllerPacketHandler(_ packet: AVRCPControllerPacket) {
        print("avrcpControllerPacketHandler")
    }
    private func avrcpTargetPacketHandler(_ packet: AVRCPTargetPacket) {
        print("avrcpTargetPacketHandler")
    }
    private func hciPacketHandler(_ packet: HCIPacket) {
        print("hciPacketHandler")
    }
}

// MARK: - Bluetooth Protocol Extensions

enum L2CAP {}
extension L2CAP {
    static func initialize() {
        l2cap_init()
    }
}

enum SDP {}
extension SDP {
    static func initialize() {
        sdp_init()
    }
    
    static func createServiceRecordHandle() -> UInt32 {
        return sdp_create_service_record_handle()
    }
    
    static func registerService(_ serviceBuffer: UnsafeMutablePointer<UInt8>) {
        // Assumes serviceBuffer is a valid SDP service record
        sdp_register_service(serviceBuffer)
    }
    
    static func createA2DPSinkRecord(
        buffer: UnsafeMutablePointer<UInt8>, 
        featureMask: A2DPSinkFeature
    ) {
        a2dp_sink_create_sdp_record(
            buffer, 
            sdp_create_service_record_handle(), 
            featureMask.rawValue, 
            nil, 
            nil
        )
    }
    
    static func createAvrcpControllerRecord(
        buffer: UnsafeMutablePointer<UInt8>, 
        supportedFeatures: UInt16
    ) {
        avrcp_controller_create_sdp_record(
            buffer, 
            sdp_create_service_record_handle(), 
            supportedFeatures, 
            nil, 
            nil
        )
    }
    
    static func createAvrcpTargetRecord(
        buffer: UnsafeMutablePointer<UInt8>, 
        supportedFeatures: UInt16
    ) {
        avrcp_target_create_sdp_record(
            buffer, 
            sdp_create_service_record_handle(), 
            supportedFeatures, 
            nil, 
            nil
        )
    }
    
    static func createDeviceIdRecord(
        buffer: UnsafeMutablePointer<UInt8>, 
        vendorIdSource: DeviceIDVendorSource, 
        vendorId: BluetoothCompanyID, 
        productId: UInt16, 
        version: UInt16
    ) {
        device_id_create_sdp_record(
            buffer, 
            sdp_create_service_record_handle(), 
            vendorIdSource.rawValue, 
            vendorId.rawValue, 
            productId, 
            version
        )
    }
}

enum A2DPSink { }
extension A2DPSink {
    static var packetHandler: ((A2DPPacket) -> Void)?

    static func registerPacketHandler(_ handler: @escaping (A2DPPacket) -> Void) {
        packetHandler = handler
        a2dp_sink_register_packet_handler({ packet_type, channel, packet, size in
            guard let handler = Self.packetHandler else { return }
            // Convert C packet to Swift packet
            let swiftPacket = A2DPPacket(cPacket: packet!, size: Int(size)) 
            handler(swiftPacket)
        })
    }

    static var mediaHandler: ((UnsafeBufferPointer<UInt8>) -> Void)?
    
    static func registerMediaHandler(_ handler: @escaping (UnsafeBufferPointer<UInt8>) -> Void) {
        mediaHandler = handler
        a2dp_sink_register_media_handler { local_seid, data, size in
            guard let handler = Self.mediaHandler else { return }
            let mediaData = UnsafeBufferPointer<UInt8>(start: data, count: Int(size))
            handler(mediaData)
        }
    }

    enum AVDTPMediaType: UInt8 {
        case audio = 0
        case video = 1
        case multimedia = 2
    }

    enum AVDTPCodecType: UInt8 {
        case SBC = 0x00
        case MPEG_1_2_AUDIO = 0x01
        case MPEG_2_4_AAC = 0x02
        case ATRAC_FAMILY = 0x04
        case NON_A2DP = 0xFF
    }
    
    static func createStreamEndpoint(
        type: AVDTPMediaType, 
        codec: AVDTPCodecType, 
        codecCapabilities: UnsafeBufferPointer<UInt8>
    ) -> AVDTPStreamEndpoint? {
        let cEndpoint = a2dp_sink_create_stream_endpoint(
            avdtp_media_type_t(type.rawValue), 
            avdtp_media_codec_type_t(codec.rawValue), 
            codecCapabilities.baseAddress, 
            UInt16(codecCapabilities.count), 
            nil, 
            0
        )
        
        return cEndpoint != nil ? AVDTPStreamEndpoint(cEndpoint: cEndpoint!) : nil
    }
}

enum AVRCP {}
extension AVRCP {
    static var mainHandler: ((AVRCPPacket) -> Void)?
    static var controllerHandler: ((AVRCPControllerPacket) -> Void)? 
    static var targetHandler: ((AVRCPTargetPacket) -> Void)?
    
    static func registerPacketHandler(
        mainHandler: @escaping (AVRCPPacket) -> Void,
        controllerHandler: @escaping (AVRCPControllerPacket) -> Void,
        targetHandler: @escaping (AVRCPTargetPacket) -> Void
    ) {
        self.mainHandler = mainHandler
        self.controllerHandler = controllerHandler 
        self.targetHandler = targetHandler
    
        avrcp_register_packet_handler({ packet_type, channel, packet, size in
            guard let handler = AVRCP.mainHandler else { return }
            let swiftPacket = AVRCPPacket(cPacket: packet!, size: Int(size))
            handler(swiftPacket)
        })
    
        avrcp_controller_register_packet_handler({ packet_type, channel, packet, size in
            guard let handler = AVRCP.controllerHandler else { return }
            let swiftPacket = AVRCPControllerPacket(cPacket: packet!, size: Int(size))
            handler(swiftPacket)
        })
    
        avrcp_target_register_packet_handler({ packet_type, channel, packet, size in
            guard let handler = AVRCP.targetHandler else { return }
            let swiftPacket = AVRCPTargetPacket(cPacket: packet!, size: Int(size))
            handler(swiftPacket)
        })
    }
}

enum GAP {}
extension GAP {
    static func setLocalName(_ name: StaticString) {
        gap_set_local_name(name.utf8Start)
    }
    
    static func setDiscoverable(_ discoverable: Bool) {
        gap_discoverable_control(discoverable ? 1 : 0)
    }
    
    static func setClassOfDevice(_ classOfDevice: UInt32) {
        gap_set_class_of_device(classOfDevice)
    }
    
    static func setDefaultLinkPolicySettings(_ settings: LinkPolicySettings) {
        gap_set_default_link_policy_settings(settings.rawValue)
    }
    
    static func setAllowRoleSwitch(_ allow: Bool) {
        gap_set_allow_role_switch(allow)
    }
}

/*
enum HCI {}
extension HCI {
    static func registerEventHandler(_ handler: @escaping (HCIPacket) -> Void) {
        var registration = hci_event_callback_registration_t()
        registration.callback = { packet_type, channel, packet, size in
            let swiftPacket = HCIPacket(cPacket: packet, size: size)
            handler(swiftPacket)
        }
        hci_add_event_handler(&registration)
    }
}
*/

// MARK: - Enums and Option Sets

enum A2DPSinkFeature: UInt16 {
    case headphone = 0x01
    // Add other features as needed
}

enum AvrcpControllerFeature: UInt16 {
    case categoryPlayerOrRecorder = 0
    case browsing = 1
    case coverArtGetLinkedThumbnail = 2
    // Add other features as needed
}

enum AvrcpTargetFeature: UInt16 {
    case categoryMonitorOrAmplifier = 0
    // Add other features as needed
}

enum DeviceIDVendorSource: UInt16 {
    case bluetooth = 1
    // Add other sources as needed
}

enum BluetoothCompanyID: UInt16 {
    case blueKitchenGmbh = 0xFFFF
    // Add other company IDs as needed
}

struct LinkPolicySettings: OptionSet {
    let rawValue: UInt16
    
    static let enableRoleSwitch = LinkPolicySettings(rawValue: 1 << 0)
    static let enableSniffMode = LinkPolicySettings(rawValue: 1 << 1)
    // Add other link policy settings as needed
}

// MARK: - Packet Wrapper Structs

struct A2DPPacket {
    let cPacket: UnsafePointer<UInt8>
    let size: Int
    
    // Add methods to extract packet information
}

struct AVRCPPacket {
    let cPacket: UnsafePointer<UInt8>
    let size: Int
    
    // Add methods to extract packet information
}

struct AVRCPControllerPacket {
    let cPacket: UnsafePointer<UInt8>
    let size: Int
    
    // Add methods to extract packet information
}

struct AVRCPTargetPacket {
    let cPacket: UnsafePointer<UInt8>
    let size: Int
    
    // Add methods to extract packet information
}

struct HCIPacket {
    let cPacket: UnsafePointer<UInt8>
    let size: Int
    
    // Add methods to extract packet information
}

struct AVDTPStreamEndpoint {
    let cEndpoint: UnsafePointer<avdtp_stream_endpoint_t>
    
    func getLocalSEID() -> UInt8 {
        return avdtp_local_seid(cEndpoint)
    }
}

// Extensible audio sink interface
enum AudioSink {
    static func getInstance() -> Any? {
        return btstack_audio_sink_get_instance()
    }
}
