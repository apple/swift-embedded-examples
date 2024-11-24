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

@_cdecl("app_main")
func app_main() {
    print("Hello from Swift on ESP32-C6!")

    var bluetooth: NimBLE
    do {
        try nvs_flash_init().throwsESPError()
        bluetooth = try NimBLE()
        bluetooth.log = { print($0) }
    }
    catch {
        print("Bluetooth init failed \(error)")
        return
    }
    
    do {
        let server = bluetooth.server
        let service = GATTAttribute<[UInt8]>.Service(
            uuid: .bit16(0x180A),
            isPrimary: true,
            characteristics: [
                .init(
                  uuid: .bit16(0x2A29),
                  value: Array("Test Inc.".utf8),
                  permissions: [.read],
                  properties: [.read],
                  descriptors: [
                      
                  ]
              )
            ]
        )
        try server.set(services: [service])
        server.dump()

        while bluetooth.hostController.isEnabled == false {
            vTaskDelay(500 / (1000 / UInt32(configTICK_RATE_HZ)))
        }

        // read address
        let address = try bluetooth.hostController.address()
        print("Bluetooth address: \(address)")
        
        // Estimote iBeacon B9407F30-F5F8-466E-AFF9-25556B57FE6D
        // Major 0x01 Minor 0x01
        guard let uuid = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D") else {
            fatalError("Invalid UUID string")
        }
        let beacon = AppleBeacon(uuid: uuid, major: 0x01, minor: 0x01, rssi: -10)
        let flags: GAPFlags = [.lowEnergyGeneralDiscoverableMode, .notSupportedBREDR]
        let advertisement = LowEnergyAdvertisingData(beacon: beacon, flags: flags)
        try bluetooth.gap.setAdvertisement(advertisement)

        // set scan response
        let name = GAPShortLocalName(name: "ESP32-C6 " + address.description)
        let scanResponse: LowEnergyAdvertisingData = GAPDataEncoder.encode(name)
        try bluetooth.gap.setScanResponse(scanResponse)
        print("Advertisement name: \(name)")

        try bluetooth.gap.startAdvertising()
    }
    catch {
        print("Bluetooth error")
    }

    while bluetooth.hostController.isEnabled {
        vTaskDelay(500 / (1000 / UInt32(configTICK_RATE_HZ)))
    }

    _ = bluetooth // retain
}
