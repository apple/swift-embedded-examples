//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors.
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

// swift-format-ignore-file

extension UnsafeMutablePointer where Pointee == UInt32 {
    func volatileLoad() -> Pointee {
        return volatile_load_uint32_t(self)
    }

    func volatileStore(_ value: Pointee) {
        volatile_store_uint32_t(self, value)
    }
}

#if STM32F74_F75

enum RCC {
    static let BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40023800 as UInt)!
    enum Offsets {
        static let AHB1ENR = 0x30
    }
}

enum GPIO {
    static let GPIOa_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40020000 as UInt)!
    static let GPIOb_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40020400 as UInt)!
    static let GPIOc_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40020800 as UInt)!
    static let GPIOd_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40020c00 as UInt)!
    static let GPIOe_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40021000 as UInt)!
    static let GPIOf_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40021400 as UInt)!
    static let GPIOg_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40021800 as UInt)!
    static let GPIOh_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40021c00 as UInt)!
    static let GPIOi_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40022000 as UInt)!
    static let GPIOj_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40022400 as UInt)!
    static let GPIOk_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40022800 as UInt)!

    enum Offsets {
        static let MODER = 0x0
        static let OTYPER = 0x4
        static let OSPEEDR = 0x8
        static let PUPDR = 0xc
        static let IDR = 0x10
        static let ODR = 0x14
    }
}

#elseif STM32F1

enum RCC {
    static let BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40021000 as UInt)!
    enum Offsets {
        static let APB2ENR = 0x18
    }
    enum Bits {
        static let APB2ENR_IOPAEN = 2
        static let APB2ENR_IOPBEN = 3
        static let APB2ENR_IOPCEN = 4
        static let APB2ENR_IOPDEN = 5
        static let APB2ENR_IOPEEN = 6
        static let APB2ENR_IOPFEN = 7
        static let APB2ENR_IOPGEN = 8
    }

    static func APB2ENRBit(for bank: GPIOBank) -> Int {
        return switch bank {
            case .a: Bits.APB2ENR_IOPAEN
            case .b: Bits.APB2ENR_IOPBEN
            case .c: Bits.APB2ENR_IOPCEN
            case .d: Bits.APB2ENR_IOPDEN
            case .e: Bits.APB2ENR_IOPEEN
            case .f: Bits.APB2ENR_IOPFEN
            case .g: Bits.APB2ENR_IOPGEN
            default: fatalError("invalid bank")
        }
    }
}

enum GPIO {
    static let GPIOa_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40010800 as UInt)!
    static let GPIOb_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40010c00 as UInt)!
    static let GPIOc_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40011000 as UInt)!
    static let GPIOd_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40011400 as UInt)!
    static let GPIOe_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40011800 as UInt)!
    static let GPIOf_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40011c00 as UInt)!
    static let GPIOg_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40012000 as UInt)!

    static func GPIOBaseAddress(for bank: GPIOBank) -> UnsafeMutablePointer<UInt32> {
        return switch bank {
            case .a: GPIOa_BaseAddress
            case .b: GPIOb_BaseAddress
            case .c: GPIOc_BaseAddress
            case .d: GPIOd_BaseAddress
            case .e: GPIOe_BaseAddress
            case .f: GPIOf_BaseAddress
            case .g: GPIOg_BaseAddress
            default: fatalError("invalid bank")
        }
    }

    enum Offsets {
        static let CRL = 0x0
        static let CRH = 0x4
        static let IDR = 0x8
        static let ODR = 0xc
    }
}

#elseif STM32C0

enum RCC {
    static let BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40021000 as UInt)!
    enum Offsets {
        static let IOPENR = 0x34
    }
    enum Bits {
        static let IOPENR_GPIOAEN = 0
        static let IOPENR_GPIOBEN = 1
        static let IOPENR_GPIOCEN = 2
        static let IOPENR_GPIODEN = 3
        static let IOPENR_GPIOFEN = 5
    }
}

enum GPIO {
    static let GPIOa_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x50000000 as UInt)!
    static let GPIOb_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x50000400 as UInt)!
    static let GPIOc_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x50000800 as UInt)!
    static let GPIOd_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x50000c00 as UInt)!
    static let GPIOf_BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x50001400 as UInt)!

    static func GPIOBaseAddress(for bank: GPIOBank) -> UnsafeMutablePointer<UInt32> {
        return switch bank {
            case .a: GPIOa_BaseAddress
            case .b: GPIOb_BaseAddress
            case .c: GPIOc_BaseAddress
            case .d: GPIOd_BaseAddress
            case .f: GPIOf_BaseAddress
            default: fatalError("invalid bank")
        }
    }

    enum Offsets {
        static let MODER = 0x0
        static let OTYPER = 0x4
        static let OSPEEDR = 0x8
        static let PUPDR = 0xc
        static let IDR = 0x10
        static let ODR = 0x14
    }
}

#else

#error("Unknown MCU")

#endif

func setRegisterBit(baseAddress: UnsafeMutablePointer<UInt32>, offset: Int, bit: Int, value: Int) {
    precondition(offset % 4 == 0)
    precondition(bit >= 0 && bit < 32)
    precondition(value >= 0 && value < 2)
    let p = baseAddress.advanced(by: offset / 4)
    let previousValue: UInt32 = p.volatileLoad()
    let newValue: UInt32 = previousValue & ~(1 << UInt32(bit)) | (UInt32(value) << UInt32(bit))
    p.volatileStore(newValue)
}

func setRegisterTwoBitField(baseAddress: UnsafeMutablePointer<UInt32>, offset: Int, bitsStartingAt: Int, value: Int) {
    precondition(offset % 4 == 0)
    precondition(bitsStartingAt >= 0 && bitsStartingAt < 31)
    precondition(value >= 0 && value < 4)
    let p = baseAddress.advanced(by: offset / 4)
    let previousValue: UInt32 = p.volatileLoad()
    let newValue: UInt32 = previousValue & ~(0b11 << UInt32(bitsStartingAt)) | (UInt32(value) << UInt32(bitsStartingAt))
    p.volatileStore(newValue)
}
