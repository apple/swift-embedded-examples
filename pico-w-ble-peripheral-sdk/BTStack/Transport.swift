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

public extension HostController {
    
    enum Transport {
        
        case usb(USB = USB())
    }
}

public extension HostController.Transport {
    
    static var `default`: HostController.Transport {
        #if os(macOS) || os(Linux)
        return .usb(USB())
        #else
        return .usb(USB())
        #endif
    }
}

internal extension HostController.Transport {
    
    var pointer: UnsafePointer<hci_transport_t> {
        switch self {
        case let .usb(transport):
            return transport.pointer
        }
    }
}

public extension HostController.Transport {
    
    /// USB Transport
    struct USB {
        
        internal let pointer: UnsafePointer<hci_transport_t>
        
        internal init(_ pointer: UnsafePointer<hci_transport_t>) {
            self.pointer = pointer
        }
        
        public init() {
            self.init(hci_transport_usb_instance()) // singleton
        }
        
        public func setPath(_ path: [UInt8]) {
            var path = path
            hci_transport_usb_set_path(Int32(path.count), &path)
        }
        
        public func addDevice(vendor: UInt16, product: UInt16) {
            hci_transport_usb_add_device(vendor, product)
        }
    }
}
