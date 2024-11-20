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

public struct NimBLE: ~Copyable {

    internal let context: UnsafeMutablePointer<Context>

    public init() throws(ESPError) {
       try nimble_port_init().throwsESPError()
       nimble_port_freertos_init(nimble_host_task)
       // Allocate context on heap for callbacks
       context = .allocate(capacity: 1)
       context.pointee = Context()
    }

    deinit {
        context.deinitialize(count: 1)
        context.deallocate()
        nimble_port_freertos_deinit()
    }
}

internal extension NimBLE {
    
    struct Context {

        var advertisment = LowEnergyAdvertisingData()
        
        var scanResponse = LowEnergyAdvertisingData()
        
        /// Callback to handle GATT read requests.
        //public var willRead: ((GATTReadRequest<Central>) -> ATTError?)?
        
        /// Callback to handle GATT write requests.
        //public var willWrite: ((GATTWriteRequest<Central>) -> ATTError?)?
        
        /// Callback to handle post-write actions for GATT write requests.
        //public var didWrite: ((GATTWriteConfirmation<Central>) -> ())?
    }
}

@_silgen_name("nvs_flash_init")
internal func nvs_flash_init() -> Int32

@_silgen_name("nimble_port_init")
internal func nimble_port_init() -> Int32

@_silgen_name("nimble_port_run")
internal func nimble_port_run() -> Int32

@_silgen_name("nimble_port_freertos_init")
internal func nimble_port_freertos_init(_ function: (UnsafeMutableRawPointer) -> ())

@_silgen_name("nimble_port_freertos_deinit")
internal func nimble_port_freertos_deinit()

internal func nimble_host_task(_ parameters: UnsafeMutableRawPointer) {
    print("BLE Host Task Started")
    nimble_port_run()
    nimble_port_freertos_deinit()
}

public extension NimBLE {
    
    var hostController: HostController { HostController(context: context) }
}

public struct HostController {
    
    internal let context: UnsafeMutablePointer<NimBLE.Context>
    
    public var isEnabled: Bool {
        ble_hs_is_enabled() == 1
    }
    
    public func address(
        type: LowEnergyAddressType = .public
    ) throws(NimBLEError) -> BluetoothAddress {
        var address = BluetoothAddress.zero
        try withUnsafeMutablePointer(to: &address) {
            $0.withMemoryRebound(to: UInt8.self, capacity: 6) {
                ble_hs_id_copy_addr(type.rawValue, $0, nil)
            }
        }.throwsError()
        return address
    }
}

public extension NimBLE {
    
    var gap: GAP {
        GAP(context: context)
    }
}

/// NimBLE GAP interface.
public struct GAP {
    
    internal let context: UnsafeMutablePointer<NimBLE.Context>
    
    /// Indicates whether an advertisement procedure is currently in progress.
    public var isAdvertising: Bool {
        ble_gap_adv_active() == 1
    }
    
    /// Start advertising
    public func startAdvertising(
        addressType: LowEnergyAddressType = .public,
        address: BluetoothAddress? = nil,
        parameters: ble_gap_adv_params = ble_gap_adv_params(conn_mode: UInt8(BLE_GAP_CONN_MODE_UND), disc_mode: UInt8(BLE_GAP_DISC_MODE_GEN), itvl_min: 0, itvl_max: 0, channel_map: 0, filter_policy: 0, high_duty_cycle: 0)
    ) throws(NimBLEError) {
        var address = ble_addr_t(
            type: 0,
            val: (address ?? .zero).bytes
        )
        var parameters = parameters
        try ble_gap_adv_start(addressType.rawValue, &address, BLE_HS_FOREVER, &parameters, _gap_callback, context).throwsError()
    }
    
    /// Stops the currently-active advertising procedure. 
    public func stopAdvertising() throws(NimBLEError) {
        try ble_gap_adv_stop().throwsError()
    }
    
    public var advertisementData: LowEnergyAdvertisingData {
        context.pointee.advertisment
    }
    
    /// Configures the data to include in subsequent advertisements.
    public func setAdvertisement(_ data: LowEnergyAdvertisingData) throws(NimBLEError) {
        context.pointee.advertisment = data
        try context.pointee.advertisment.withUnsafePointer {
            ble_gap_adv_set_data($0, Int32(data.length))
        }.throwsError()
    }
    
    public var scanResponse: LowEnergyAdvertisingData {
        context.pointee.scanResponse
    }
    
    /// Configures the data to include in subsequent scan responses.
    public func setScanResponse(_ data: LowEnergyAdvertisingData) throws(NimBLEError) {
        context.pointee.scanResponse = data
        try context.pointee.scanResponse.withUnsafePointer {
            ble_gap_adv_rsp_set_data($0, Int32(data.length))
        }.throwsError()
    }
}

internal func _gap_callback(event: UnsafeMutablePointer<ble_gap_event>?, context contextPointer: UnsafeMutableRawPointer?) -> Int32 {
    guard let context = contextPointer?.assumingMemoryBound(to: NimBLE.Context.self) else {
        return 0
    }
    
    return 0
}

public extension NimBLE {
    
    var server: GATTServer { GATTServer(context: context) }
}

/// NimBLE GATT Server interface.
public struct GATTServer {
    
    nonisolated(unsafe) private static var services = [ble_gatt_svc_def]()
    
    nonisolated(unsafe) private static var buffers = [[UInt8]]()
    
    // MARK: - Properties
    
    internal let context: UnsafeMutablePointer<NimBLE.Context>
    
    /*
    /// Callback to handle GATT read requests.
    public var willRead: ((GATTReadRequest<Central>) -> ATTError?)?
    
    /// Callback to handle GATT write requests.
    public var willWrite: ((GATTWriteRequest<Central>) -> ATTError?)?
    
    /// Callback to handle post-write actions for GATT write requests.
    public var didWrite: ((GATTWriteConfirmation<Central>) -> ())?
    */
    
    // MARK: - Methods
    
    public func start() throws(NimBLEError) {
        try ble_gatts_start().throwsError()
    }
    
    /// Attempts to add the specified service to the GATT database.
    public func add(services: [GATTAttribute<[UInt8]>.Service]) throws(NimBLEError) {
        var cServices = [ble_gatt_svc_def].init(repeating: .init(), count: services.count + 1)
        var buffers = [[UInt8]]()
        // TODO: Free memory
        for (serviceIndex, service) in services.enumerated() {
            cServices[serviceIndex].type = service.isPrimary ? UInt8(BLE_GATT_SVC_TYPE_PRIMARY) : UInt8(BLE_GATT_SVC_TYPE_SECONDARY)
            let serviceUUID = ble_uuid_any_t(service.uuid)
            withUnsafeBytes(of: serviceUUID) {
                let buffer = [UInt8]($0)
                buffers.append(buffer)
                buffer.withUnsafeBytes {
                    cServices[serviceIndex].uuid = .init(OpaquePointer($0.baseAddress))
                }
            }
            assert(ble_uuid_any_t(cServices[serviceIndex].uuid) == serviceUUID)
            //assert(serviceUUID.dataLength == service.uuid.dataLength)
        }
        try withExtendedLifetime(buffers) { _ throws(NimBLEError) -> () in
            try ble_gatts_count_cfg(cServices).throwsError()
            try ble_gatts_add_svcs(cServices).throwsError()
        }
        Self.services = cServices
        Self.buffers = buffers
    }
    
    /// Removes the service with the specified handle.
    public func remove(service: UInt16) {
        // iterate all services and find the specified handle
    }
    
    /// Clears the local GATT database.
    public func removeAllServices() {
        ble_gatts_reset()
    }
    
    public func dump() {
        ble_gatts_show_local()
    }
}


internal extension ble_uuid_any_t {
    
    init(_ uuid: BluetoothUUID) {
        switch uuid {
        case .bit16(let value):
            self.init(u16: .init(uuid: value))
        case .bit32(let value):
            self.init(u32: .init(uuid: value))
        case .bit128(let value):
            self.init(u128: .init(uuid: value))
        }
    }
    
    init(_ string: String) throws(NimBLEError) {
        self.init()
        try withUnsafeMutablePointer(to: &self) { uuidBuffer in
            string.withCString { cString in
                ble_uuid_from_str(uuidBuffer, cString)
            }
        }.throwsError()
    }
    
    init(buffer: UnsafeRawBufferPointer) throws(NimBLEError) {
        self.init()
        try ble_uuid_init_from_buf(
            &self,
            buffer.baseAddress,
            buffer.count
        ).throwsError()
    }
    
    init(_ pointer: UnsafePointer<ble_uuid_t>) {
        self.init()
        ble_uuid_copy(&self, pointer)
    }
}

extension ble_uuid_any_t: @retroactive CustomStringConvertible {
    
    public var description: String {
        withUnsafeBytes(of: self) { uuidBuffer in
            var cString = [CChar](repeating: 0, count: 37)
            ble_uuid_to_str(
                uuidBuffer.assumingMemoryBound(to: ble_uuid_t.self).baseAddress,
                &cString
            )
            return String(cString: &cString)
        }
    }
}

extension ble_uuid_any_t: @retroactive Equatable {
    
    public static func == (lhs: ble_uuid_any_t, rhs: ble_uuid_any_t) -> Bool {
        withUnsafeBytes(of: lhs) {
            $0.withMemoryRebound(to: ble_uuid_t.self) { lhsPointer in
                withUnsafeBytes(of: rhs) {
                    $0.withMemoryRebound(to: ble_uuid_t.self) { rhsPointer in
                        ble_uuid_cmp(lhsPointer.baseAddress, rhsPointer.baseAddress) == 0
                    }
                }
            }
        }
    }
}

extension ble_uuid_any_t { //: @retroactive DataConvertible {
    
    public var dataLength: Int {
        let value = withUnsafeBytes(of: self) {
            $0.withMemoryRebound(to: ble_uuid_t.self) {
                ble_uuid_length($0.baseAddress)
            }
        }
        return Int(value)
    }
}

internal extension ble_uuid16_t {
    
    init(uuid: UInt16) {
        self.init(u: .init(type: UInt8(BLE_UUID_TYPE_16)), value: uuid)
    }
}

internal extension ble_uuid32_t {
    
    init(uuid: UInt32) {
        self.init(u: .init(type: UInt8(BLE_UUID_TYPE_32)), value: uuid)
    }
}

internal extension ble_uuid128_t {
    
    init(uuid: UInt128) {
        self.init(u: .init(type: UInt8(BLE_UUID_TYPE_128)), value: uuid.bytes)
    }
}
