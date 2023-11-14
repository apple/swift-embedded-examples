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

extension UnsafeMutablePointer where Pointee == UInt32 {
    func volatileLoad() -> Pointee {
        return volatile_load_uint32_t(self)
    }

    func volatileStore(_ value: Pointee) {
        volatile_store_uint32_t(self, value)
    }
}

enum RCC {
    static let BaseAddress = UnsafeMutablePointer<UInt32>(bitPattern: 0x40023800 as UInt)!
    enum Offsets {
        static let CR = 0x0
        static let PLLCFGR = 0x4
        static let CFGR = 0x8
        static let CIR = 0xc
        static let AHB1RSTR = 0x10
        static let AHB2RSTR = 0x14
        static let AHB3RSTR = 0x18
        static let APB1RSTR = 0x20
        static let APB2RSTR = 0x24
        static let AHB1ENR = 0x30
        static let AHB2ENR = 0x34
        static let AHB3ENR = 0x38
        static let APB1ENR = 0x40
        static let APB2ENR = 0x44
        static let AHB1LPENR = 0x50
        static let AHB2LPENR = 0x54
        static let AHB3LPENR = 0x58
        static let APB1LPENR = 0x60
        static let APB2LPENR = 0x64
        static let BDCR = 0x70
        static let CSR = 0x74
        static let SSCGR = 0x80
        static let PLLI2SCFGR = 0x84
        static let PLLSAICFGR = 0x88
        static let DKCFGR1 = 0x8c
        static let DKCFGR2 = 0x90
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
        static let BSRR = 0x18
        static let LCKR = 0x1c
        static let AFRL = 0x20
        static let AFRH = 0x24
        static let BRR = 0x28
    }
}

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
    precondition(bitsStartingAt >= 0 && bitsStartingAt < 16)
    precondition(value >= 0 && value < 4)
    let p = baseAddress.advanced(by: offset / 4)
    let previousValue: UInt32 = p.volatileLoad()
    let newValue: UInt32 = previousValue & ~(0b11 << UInt32(bitsStartingAt)) | (UInt32(value) << UInt32(bitsStartingAt))
    p.volatileStore(newValue)
}
