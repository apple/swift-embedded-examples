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

extension CYW43 {

    final class Bluetooth {

        static let shared = Bluetooth()

        private var callbackRegistration = btstack_packet_callback_registration_t()

        fileprivate(set) var state: State = .off

        private(set) var address: BluetoothAddress = .zero

        var advertisement = LowEnergyAdvertisingData() {
            didSet {
                let length = advertisement.length
                advertisementBuffer = [UInt8](advertisement)
                // data is not copied, pointer has to stay valid
                gap_advertisements_set_data(length, &advertisementBuffer)
            }
        }

        private var advertisementBuffer = [UInt8]()

        var scanResponse = LowEnergyAdvertisingData() {
            didSet {
                let length = scanResponse.length
                scanResponseBuffer = [UInt8](scanResponse)
                // data is not copied, pointer has to stay valid
                gap_scan_response_set_data(length, &scanResponseBuffer)
            }
        }

        private var scanResponseBuffer = [UInt8]()

        var isAdvertising = false {
            didSet {
                gap_advertisements_enable(isAdvertising ? 1 : 0)
            }
        }

        private init() {
            // register for callbacks
            callbackRegistration.callback = _bluetooth_packet_handler
            hci_add_event_handler(&callbackRegistration)
        }

        deinit {
            hci_remove_event_handler(&callbackRegistration)
        }
    }
}

extension CYW43.Bluetooth {

    func setPower(_ state: PowerState) {
        hci_power_control(.init(rawValue: state.rawValue))
    }

    func setAdvertisementParameters(
        advIntMin: UInt16 = 0x0030,
        advIntMax: UInt16 = 0x0030,
        advType: UInt8 = 0,
        directAddressType: UInt8 = 0,
        directAddress: inout BluetoothAddress,
        channelMap: UInt8 = 0x07,
        filterPolicy: UInt8 = 0x00
    ) {
        withUnsafeMutablePointer(to: &directAddress.bytes) {
            gap_advertisements_set_params(advIntMin, advIntMax, advType, directAddressType, $0, channelMap, filterPolicy)
        }
    }
}

extension CYW43.Bluetooth {

    enum PowerState: UInt8, Sendable {

        case off    = 0
        case on     = 1
        case sleep  = 2
    }

    enum State: UInt8 {

        case off            = 0
        case initializing   = 1
        case on             = 2
        case halting        = 3
        case sleeping       = 4
        case fallingAsleep  = 5
    }
}

// packet_handler(uint8_t packet_type, uint16_t channel, uint8_t *packet, uint16_t size)
@_documentation(visibility: internal)
@_cdecl("bluetooth_packet_handler") 
internal func _bluetooth_packet_handler(packetType: UInt8, channel: UInt16, packetPointer: UnsafeMutablePointer<UInt8>?, packetSize: UInt16) {
    
    switch packetType {
        case UInt8(HCI_EVENT_PACKET):
            switch hci_event_packet_get_type(packetPointer) {
                case UInt8(BTSTACK_EVENT_STATE):
                    let rawState = btstack_event_state_get_state(packetPointer)
                    let newValue = CYW43.Bluetooth.State(rawValue: rawState) ?? .off
                    CYW43.Bluetooth.shared.state = newValue
                case UInt8(HCI_EVENT_VENDOR_SPECIFIC):
                    break
                default:
                    break
            }
        default:
            break
    }
}