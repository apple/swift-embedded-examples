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

/// General-purpose I/Os
struct GPIO {
    var baseAddress: UnsafeMutableRawPointer

    enum Offsets {
        static let MODER: Int32 = 0x0
        static let OTYPER: Int32 = 0x4
        static let OSPEEDR: Int32 = 0x8
        static let PUPDR: Int32 = 0xc
        static let IDR: Int32 = 0x10
        static let ODR: Int32 = 0x14
        static let BSRR: Int32 = 0x18
        static let LCKR: Int32 = 0x1c
        static let AFRL: Int32 = 0x20
        static let AFRH: Int32 = 0x24
        static let BRR: Int32 = 0x28
    }
    
    private func ld(_ offset: Int32) -> UInt32 {
        UnsafeMutablePointer<UInt32>(bitPattern: UInt(bitPattern: UnsafeMutableRawPointer(baseAddress).advanced(by: Int(offset))))!.volatileLoad()
    }

    private func st(_ offset: Int32, _ value: UInt32) {
        UnsafeMutablePointer<UInt32>(bitPattern: UInt(bitPattern: UnsafeMutableRawPointer(baseAddress).advanced(by: Int(offset))))!.volatileStore(value)
    }

    /// GPIO port mode register
    var moder: MODER {
        get { MODER(rawValue: ld(Offsets.MODER)) }
        set { st(Offsets.MODER, newValue.rawValue) }
    }
    /// GPIO port output type register
    var otyper: OTYPER {
        get { OTYPER(rawValue: ld(Offsets.OTYPER)) }
        set { st(Offsets.OTYPER, newValue.rawValue) }
    }
    /// GPIO port output speed register
    var ospeedr: OSPEEDR {
        get { OSPEEDR(rawValue: ld(Offsets.OSPEEDR)) }
        set { st(Offsets.OSPEEDR, newValue.rawValue) }
    }
    /// GPIO port pull-up/pull-down register
    var pupdr: PUPDR {
        get { PUPDR(rawValue: ld(Offsets.PUPDR)) }
        set { st(Offsets.PUPDR, newValue.rawValue) }
    }
    /// GPIO port input data register
    var idr: IDR {
        get { IDR(rawValue: ld(Offsets.IDR)) }
        set { st(Offsets.IDR, newValue.rawValue) }
    }
    /// GPIO port output data register
    var odr: ODR {
        get { ODR(rawValue: ld(Offsets.ODR)) }
        set { st(Offsets.ODR, newValue.rawValue) }
    }
    /// GPIO port bit set/reset register
    var bsrr: BSRR {
        get { BSRR(rawValue: ld(Offsets.BSRR)) }
        set { st(Offsets.BSRR, newValue.rawValue) }
    }
    /// GPIO port configuration lock register
    var lckr: LCKR {
        get { LCKR(rawValue: ld(Offsets.LCKR)) }
        set { st(Offsets.LCKR, newValue.rawValue) }
    }
    /// GPIO alternate function lowregister
    var afrl: AFRL {
        get { AFRL(rawValue: ld(Offsets.AFRL)) }
        set { st(Offsets.AFRL, newValue.rawValue) }
    }
    /// GPIO alternate function high register
    var afrh: AFRH {
        get { AFRH(rawValue: ld(Offsets.AFRH)) }
        set { st(Offsets.AFRH, newValue.rawValue) }
    }
    /// GPIO port bit reset register
    var brr: BRR {
        get { BRR(rawValue: ld(Offsets.BRR)) }
        set { st(Offsets.BRR, newValue.rawValue) }
    }
}

extension GPIO {
    struct MODER {
        var rawValue: UInt32

        static let moder15_offset = UInt32(30)
        static let moder15_mask = UInt32(0b11) &<< moder15_offset
        var moder15: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder15_mask)) >> GPIO.MODER.moder15_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder15_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder15_offset) & GPIO.MODER.moder15_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder14_offset = UInt32(28)
        static let moder14_mask = UInt32(0b11) &<< moder14_offset
        var moder14: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder14_mask)) >> GPIO.MODER.moder14_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder14_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder14_offset) & GPIO.MODER.moder14_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder13_offset = UInt32(26)
        static let moder13_mask = UInt32(0b11) &<< moder13_offset
        var moder13: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder13_mask)) >> GPIO.MODER.moder13_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder13_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder13_offset) & GPIO.MODER.moder13_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder12_offset = UInt32(24)
        static let moder12_mask = UInt32(0b11) &<< moder12_offset
        var moder12: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder12_mask)) >> GPIO.MODER.moder12_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder12_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder12_offset) & GPIO.MODER.moder12_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder11_offset = UInt32(22)
        static let moder11_mask = UInt32(0b11) &<< moder11_offset
        var moder11: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder11_mask)) >> GPIO.MODER.moder11_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder11_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder11_offset) & GPIO.MODER.moder11_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder10_offset = UInt32(20)
        static let moder10_mask = UInt32(0b11) &<< moder10_offset
        var moder10: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder10_mask)) >> GPIO.MODER.moder10_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder10_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder10_offset) & GPIO.MODER.moder10_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder9_offset = UInt32(18)
        static let moder9_mask = UInt32(0b11) &<< moder9_offset
        var moder9: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder9_mask)) >> GPIO.MODER.moder9_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder9_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder9_offset) & GPIO.MODER.moder9_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder8_offset = UInt32(16)
        static let moder8_mask = UInt32(0b11) &<< moder8_offset
        var moder8: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder8_mask)) >> GPIO.MODER.moder8_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder8_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder8_offset) & GPIO.MODER.moder8_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder7_offset = UInt32(14)
        static let moder7_mask = UInt32(0b11) &<< moder7_offset
        var moder7: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder7_mask)) >> GPIO.MODER.moder7_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder7_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder7_offset) & GPIO.MODER.moder7_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder6_offset = UInt32(12)
        static let moder6_mask = UInt32(0b11) &<< moder6_offset
        var moder6: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder6_mask)) >> GPIO.MODER.moder6_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder6_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder6_offset) & GPIO.MODER.moder6_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder5_offset = UInt32(10)
        static let moder5_mask = UInt32(0b11) &<< moder5_offset
        var moder5: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder5_mask)) >> GPIO.MODER.moder5_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder5_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder5_offset) & GPIO.MODER.moder5_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder4_offset = UInt32(8)
        static let moder4_mask = UInt32(0b11) &<< moder4_offset
        var moder4: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder4_mask)) >> GPIO.MODER.moder4_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder4_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder4_offset) & GPIO.MODER.moder4_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder3_offset = UInt32(6)
        static let moder3_mask = UInt32(0b11) &<< moder3_offset
        var moder3: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder3_mask)) >> GPIO.MODER.moder3_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder3_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder3_offset) & GPIO.MODER.moder3_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder2_offset = UInt32(4)
        static let moder2_mask = UInt32(0b11) &<< moder2_offset
        var moder2: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder2_mask)) >> GPIO.MODER.moder2_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder2_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder2_offset) & GPIO.MODER.moder2_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder1_offset = UInt32(2)
        static let moder1_mask = UInt32(0b11) &<< moder1_offset
        var moder1: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder1_mask)) >> GPIO.MODER.moder1_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder1_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder1_offset) & GPIO.MODER.moder1_mask
                self.rawValue = preserve | shift
            }
        }

        static let moder0_offset = UInt32(0)
        static let moder0_mask = UInt32(0b11) &<< moder0_offset
        var moder0: UInt8 {
            get { UInt8((self.rawValue & (GPIO.MODER.moder0_mask)) >> GPIO.MODER.moder0_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.MODER.moder0_mask
                let shift = (UInt32(newValue) << GPIO.MODER.moder0_offset) & GPIO.MODER.moder0_mask
                self.rawValue = preserve | shift
            }
        }
        
        func moder(n: Int) -> UInt8 {
            precondition(n >= 0 && n < 16)
            let moder_offset = n * 2
            let moder_mask = UInt32(0b11) &<< moder_offset
            return UInt8((self.rawValue & (moder_mask)) &>> moder_offset)
        }
        
        mutating func setModer(n: Int, value: UInt8) {
            precondition(n >= 0 && n < 16)
            precondition(value < 4)
            let moder_offset = n * 2
            let moder_mask = UInt32(0b11) &<< moder_offset
            let preserve = self.rawValue & ~moder_mask
            let shift = (UInt32(value) << moder_offset) & moder_mask
            self.rawValue = preserve | shift
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct OTYPER {
        var rawValue: UInt32

        static let ot15_offset = UInt32(15)
        static let ot15_mask = UInt32(0b1) &<< ot15_offset
        var ot15: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot15_mask)) >> GPIO.OTYPER.ot15_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot15_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot15_offset) & GPIO.OTYPER.ot15_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot14_offset = UInt32(14)
        static let ot14_mask = UInt32(0b1) &<< ot14_offset
        var ot14: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot14_mask)) >> GPIO.OTYPER.ot14_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot14_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot14_offset) & GPIO.OTYPER.ot14_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot13_offset = UInt32(13)
        static let ot13_mask = UInt32(0b1) &<< ot13_offset
        var ot13: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot13_mask)) >> GPIO.OTYPER.ot13_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot13_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot13_offset) & GPIO.OTYPER.ot13_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot12_offset = UInt32(12)
        static let ot12_mask = UInt32(0b1) &<< ot12_offset
        var ot12: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot12_mask)) >> GPIO.OTYPER.ot12_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot12_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot12_offset) & GPIO.OTYPER.ot12_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot11_offset = UInt32(11)
        static let ot11_mask = UInt32(0b1) &<< ot11_offset
        var ot11: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot11_mask)) >> GPIO.OTYPER.ot11_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot11_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot11_offset) & GPIO.OTYPER.ot11_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot10_offset = UInt32(10)
        static let ot10_mask = UInt32(0b1) &<< ot10_offset
        var ot10: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot10_mask)) >> GPIO.OTYPER.ot10_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot10_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot10_offset) & GPIO.OTYPER.ot10_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot9_offset = UInt32(9)
        static let ot9_mask = UInt32(0b1) &<< ot9_offset
        var ot9: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot9_mask)) >> GPIO.OTYPER.ot9_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot9_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot9_offset) & GPIO.OTYPER.ot9_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot8_offset = UInt32(8)
        static let ot8_mask = UInt32(0b1) &<< ot8_offset
        var ot8: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot8_mask)) >> GPIO.OTYPER.ot8_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot8_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot8_offset) & GPIO.OTYPER.ot8_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot7_offset = UInt32(7)
        static let ot7_mask = UInt32(0b1) &<< ot7_offset
        var ot7: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot7_mask)) >> GPIO.OTYPER.ot7_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot7_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot7_offset) & GPIO.OTYPER.ot7_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot6_offset = UInt32(6)
        static let ot6_mask = UInt32(0b1) &<< ot6_offset
        var ot6: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot6_mask)) >> GPIO.OTYPER.ot6_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot6_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot6_offset) & GPIO.OTYPER.ot6_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot5_offset = UInt32(5)
        static let ot5_mask = UInt32(0b1) &<< ot5_offset
        var ot5: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot5_mask)) >> GPIO.OTYPER.ot5_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot5_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot5_offset) & GPIO.OTYPER.ot5_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot4_offset = UInt32(4)
        static let ot4_mask = UInt32(0b1) &<< ot4_offset
        var ot4: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot4_mask)) >> GPIO.OTYPER.ot4_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot4_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot4_offset) & GPIO.OTYPER.ot4_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot3_offset = UInt32(3)
        static let ot3_mask = UInt32(0b1) &<< ot3_offset
        var ot3: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot3_mask)) >> GPIO.OTYPER.ot3_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot3_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot3_offset) & GPIO.OTYPER.ot3_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot2_offset = UInt32(2)
        static let ot2_mask = UInt32(0b1) &<< ot2_offset
        var ot2: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot2_mask)) >> GPIO.OTYPER.ot2_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot2_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot2_offset) & GPIO.OTYPER.ot2_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot1_offset = UInt32(1)
        static let ot1_mask = UInt32(0b1) &<< ot1_offset
        var ot1: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot1_mask)) >> GPIO.OTYPER.ot1_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot1_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot1_offset) & GPIO.OTYPER.ot1_mask
                self.rawValue = preserve | shift
            }
        }

        static let ot0_offset = UInt32(0)
        static let ot0_mask = UInt32(0b1) &<< ot0_offset
        var ot0: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OTYPER.ot0_mask)) >> GPIO.OTYPER.ot0_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OTYPER.ot0_mask
                let shift = (UInt32(newValue) << GPIO.OTYPER.ot0_offset) & GPIO.OTYPER.ot0_mask
                self.rawValue = preserve | shift
            }
        }
        
        func ot(n: Int) -> UInt8 {
            precondition(n >= 0 && n < 16)
            let ot_offset = n * 1
            let ot_mask = UInt32(0b1) &<< ot_offset
            return UInt8((self.rawValue & (ot_mask)) &>> ot_offset)
        }
        
        mutating func setOt(n: Int, value: UInt8) {
            precondition(n >= 0 && n < 16)
            precondition(value < 2)
            let ot_offset = n * 1
            let ot_mask = UInt32(0b1) &<< ot_offset
            let preserve = self.rawValue & ~ot_mask
            let shift = (UInt32(value) << ot_offset) & ot_mask
            self.rawValue = preserve | shift
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct OSPEEDR {
        var rawValue: UInt32

        static let ospeedr15_offset = UInt32(30)
        static let ospeedr15_mask = UInt32(0b11) &<< ospeedr15_offset
        var ospeedr15: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr15_mask)) >> GPIO.OSPEEDR.ospeedr15_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr15_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr15_offset) & GPIO.OSPEEDR.ospeedr15_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr14_offset = UInt32(28)
        static let ospeedr14_mask = UInt32(0b11) &<< ospeedr14_offset
        var ospeedr14: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr14_mask)) >> GPIO.OSPEEDR.ospeedr14_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr14_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr14_offset) & GPIO.OSPEEDR.ospeedr14_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr13_offset = UInt32(26)
        static let ospeedr13_mask = UInt32(0b11) &<< ospeedr13_offset
        var ospeedr13: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr13_mask)) >> GPIO.OSPEEDR.ospeedr13_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr13_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr13_offset) & GPIO.OSPEEDR.ospeedr13_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr12_offset = UInt32(24)
        static let ospeedr12_mask = UInt32(0b11) &<< ospeedr12_offset
        var ospeedr12: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr12_mask)) >> GPIO.OSPEEDR.ospeedr12_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr12_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr12_offset) & GPIO.OSPEEDR.ospeedr12_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr11_offset = UInt32(22)
        static let ospeedr11_mask = UInt32(0b11) &<< ospeedr11_offset
        var ospeedr11: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr11_mask)) >> GPIO.OSPEEDR.ospeedr11_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr11_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr11_offset) & GPIO.OSPEEDR.ospeedr11_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr10_offset = UInt32(20)
        static let ospeedr10_mask = UInt32(0b11) &<< ospeedr10_offset
        var ospeedr10: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr10_mask)) >> GPIO.OSPEEDR.ospeedr10_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr10_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr10_offset) & GPIO.OSPEEDR.ospeedr10_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr9_offset = UInt32(18)
        static let ospeedr9_mask = UInt32(0b11) &<< ospeedr9_offset
        var ospeedr9: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr9_mask)) >> GPIO.OSPEEDR.ospeedr9_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr9_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr9_offset) & GPIO.OSPEEDR.ospeedr9_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr8_offset = UInt32(16)
        static let ospeedr8_mask = UInt32(0b11) &<< ospeedr8_offset
        var ospeedr8: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr8_mask)) >> GPIO.OSPEEDR.ospeedr8_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr8_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr8_offset) & GPIO.OSPEEDR.ospeedr8_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr7_offset = UInt32(14)
        static let ospeedr7_mask = UInt32(0b11) &<< ospeedr7_offset
        var ospeedr7: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr7_mask)) >> GPIO.OSPEEDR.ospeedr7_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr7_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr7_offset) & GPIO.OSPEEDR.ospeedr7_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr6_offset = UInt32(12)
        static let ospeedr6_mask = UInt32(0b11) &<< ospeedr6_offset
        var ospeedr6: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr6_mask)) >> GPIO.OSPEEDR.ospeedr6_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr6_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr6_offset) & GPIO.OSPEEDR.ospeedr6_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr5_offset = UInt32(10)
        static let ospeedr5_mask = UInt32(0b11) &<< ospeedr5_offset
        var ospeedr5: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr5_mask)) >> GPIO.OSPEEDR.ospeedr5_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr5_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr5_offset) & GPIO.OSPEEDR.ospeedr5_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr4_offset = UInt32(8)
        static let ospeedr4_mask = UInt32(0b11) &<< ospeedr4_offset
        var ospeedr4: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr4_mask)) >> GPIO.OSPEEDR.ospeedr4_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr4_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr4_offset) & GPIO.OSPEEDR.ospeedr4_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr3_offset = UInt32(6)
        static let ospeedr3_mask = UInt32(0b11) &<< ospeedr3_offset
        var ospeedr3: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr3_mask)) >> GPIO.OSPEEDR.ospeedr3_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr3_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr3_offset) & GPIO.OSPEEDR.ospeedr3_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr2_offset = UInt32(4)
        static let ospeedr2_mask = UInt32(0b11) &<< ospeedr2_offset
        var ospeedr2: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr2_mask)) >> GPIO.OSPEEDR.ospeedr2_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr2_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr2_offset) & GPIO.OSPEEDR.ospeedr2_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr1_offset = UInt32(2)
        static let ospeedr1_mask = UInt32(0b11) &<< ospeedr1_offset
        var ospeedr1: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr1_mask)) >> GPIO.OSPEEDR.ospeedr1_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr1_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr1_offset) & GPIO.OSPEEDR.ospeedr1_mask
                self.rawValue = preserve | shift
            }
        }

        static let ospeedr0_offset = UInt32(0)
        static let ospeedr0_mask = UInt32(0b11) &<< ospeedr0_offset
        var ospeedr0: UInt8 {
            get { UInt8((self.rawValue & (GPIO.OSPEEDR.ospeedr0_mask)) >> GPIO.OSPEEDR.ospeedr0_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.OSPEEDR.ospeedr0_mask
                let shift = (UInt32(newValue) << GPIO.OSPEEDR.ospeedr0_offset) & GPIO.OSPEEDR.ospeedr0_mask
                self.rawValue = preserve | shift
            }
        }
        
        func ospeed(n: Int) -> UInt8 {
            precondition(n >= 0 && n < 16)
            let ospeed_offset = n * 2
            let ospeed_mask = UInt32(0b11) &<< ospeed_offset
            return UInt8((self.rawValue & (ospeed_mask)) &>> ospeed_offset)
        }
        
        mutating func setOspeed(n: Int, value: UInt8) {
            precondition(n >= 0 && n < 16)
            precondition(value < 4)
            let ospeed_offset = n * 2
            let ospeed_mask = UInt32(0b11) &<< ospeed_offset
            let preserve = self.rawValue & ~ospeed_mask
            let shift = (UInt32(value) << ospeed_offset) & ospeed_mask
            self.rawValue = preserve | shift
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct PUPDR {
        var rawValue: UInt32

        static let pupdr15_offset = UInt32(30)
        static let pupdr15_mask = UInt32(0b11) &<< pupdr15_offset
        var pupdr15: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr15_mask)) >> GPIO.PUPDR.pupdr15_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr15_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr15_offset) & GPIO.PUPDR.pupdr15_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr14_offset = UInt32(28)
        static let pupdr14_mask = UInt32(0b11) &<< pupdr14_offset
        var pupdr14: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr14_mask)) >> GPIO.PUPDR.pupdr14_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr14_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr14_offset) & GPIO.PUPDR.pupdr14_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr13_offset = UInt32(26)
        static let pupdr13_mask = UInt32(0b11) &<< pupdr13_offset
        var pupdr13: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr13_mask)) >> GPIO.PUPDR.pupdr13_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr13_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr13_offset) & GPIO.PUPDR.pupdr13_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr12_offset = UInt32(24)
        static let pupdr12_mask = UInt32(0b11) &<< pupdr12_offset
        var pupdr12: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr12_mask)) >> GPIO.PUPDR.pupdr12_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr12_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr12_offset) & GPIO.PUPDR.pupdr12_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr11_offset = UInt32(22)
        static let pupdr11_mask = UInt32(0b11) &<< pupdr11_offset
        var pupdr11: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr11_mask)) >> GPIO.PUPDR.pupdr11_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr11_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr11_offset) & GPIO.PUPDR.pupdr11_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr10_offset = UInt32(20)
        static let pupdr10_mask = UInt32(0b11) &<< pupdr10_offset
        var pupdr10: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr10_mask)) >> GPIO.PUPDR.pupdr10_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr10_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr10_offset) & GPIO.PUPDR.pupdr10_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr9_offset = UInt32(18)
        static let pupdr9_mask = UInt32(0b11) &<< pupdr9_offset
        var pupdr9: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr9_mask)) >> GPIO.PUPDR.pupdr9_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr9_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr9_offset) & GPIO.PUPDR.pupdr9_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr8_offset = UInt32(16)
        static let pupdr8_mask = UInt32(0b11) &<< pupdr8_offset
        var pupdr8: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr8_mask)) >> GPIO.PUPDR.pupdr8_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr8_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr8_offset) & GPIO.PUPDR.pupdr8_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr7_offset = UInt32(14)
        static let pupdr7_mask = UInt32(0b11) &<< pupdr7_offset
        var pupdr7: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr7_mask)) >> GPIO.PUPDR.pupdr7_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr7_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr7_offset) & GPIO.PUPDR.pupdr7_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr6_offset = UInt32(12)
        static let pupdr6_mask = UInt32(0b11) &<< pupdr6_offset
        var pupdr6: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr6_mask)) >> GPIO.PUPDR.pupdr6_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr6_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr6_offset) & GPIO.PUPDR.pupdr6_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr5_offset = UInt32(10)
        static let pupdr5_mask = UInt32(0b11) &<< pupdr5_offset
        var pupdr5: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr5_mask)) >> GPIO.PUPDR.pupdr5_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr5_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr5_offset) & GPIO.PUPDR.pupdr5_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr4_offset = UInt32(8)
        static let pupdr4_mask = UInt32(0b11) &<< pupdr4_offset
        var pupdr4: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr4_mask)) >> GPIO.PUPDR.pupdr4_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr4_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr4_offset) & GPIO.PUPDR.pupdr4_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr3_offset = UInt32(6)
        static let pupdr3_mask = UInt32(0b11) &<< pupdr3_offset
        var pupdr3: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr3_mask)) >> GPIO.PUPDR.pupdr3_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr3_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr3_offset) & GPIO.PUPDR.pupdr3_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr2_offset = UInt32(4)
        static let pupdr2_mask = UInt32(0b11) &<< pupdr2_offset
        var pupdr2: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr2_mask)) >> GPIO.PUPDR.pupdr2_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr2_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr2_offset) & GPIO.PUPDR.pupdr2_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr1_offset = UInt32(2)
        static let pupdr1_mask = UInt32(0b11) &<< pupdr1_offset
        var pupdr1: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr1_mask)) >> GPIO.PUPDR.pupdr1_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr1_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr1_offset) & GPIO.PUPDR.pupdr1_mask
                self.rawValue = preserve | shift
            }
        }

        static let pupdr0_offset = UInt32(0)
        static let pupdr0_mask = UInt32(0b11) &<< pupdr0_offset
        var pupdr0: UInt8 {
            get { UInt8((self.rawValue & (GPIO.PUPDR.pupdr0_mask)) >> GPIO.PUPDR.pupdr0_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.PUPDR.pupdr0_mask
                let shift = (UInt32(newValue) << GPIO.PUPDR.pupdr0_offset) & GPIO.PUPDR.pupdr0_mask
                self.rawValue = preserve | shift
            }
        }

        func pupd(n: Int) -> UInt8 {
            precondition(n >= 0 && n < 16)
            let pupd_offset = n * 2
            let pupd_mask = UInt32(0b11) &<< pupd_offset
            return UInt8((self.rawValue & (pupd_mask)) &>> pupd_offset)
        }
        
        mutating func setPupd(n: Int, value: UInt8) {
            precondition(n >= 0 && n < 16)
            precondition(value < 4)
            let pupd_offset = n * 2
            let pupd_mask = UInt32(0b11) &<< pupd_offset
            let preserve = self.rawValue & ~pupd_mask
            let shift = (UInt32(value) << pupd_offset) & pupd_mask
            self.rawValue = preserve | shift
        }
        
        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct IDR {
        var rawValue: UInt32

        static let idr15_offset = UInt32(15)
        static let idr15_mask = UInt32(0b1) &<< idr15_offset
        var idr15: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr15_mask)) >> GPIO.IDR.idr15_offset)
        }

        static let idr14_offset = UInt32(14)
        static let idr14_mask = UInt32(0b1) &<< idr14_offset
        var idr14: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr14_mask)) >> GPIO.IDR.idr14_offset)
        }

        static let idr13_offset = UInt32(13)
        static let idr13_mask = UInt32(0b1) &<< idr13_offset
        var idr13: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr13_mask)) >> GPIO.IDR.idr13_offset)
        }

        static let idr12_offset = UInt32(12)
        static let idr12_mask = UInt32(0b1) &<< idr12_offset
        var idr12: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr12_mask)) >> GPIO.IDR.idr12_offset)
        }

        static let idr11_offset = UInt32(11)
        static let idr11_mask = UInt32(0b1) &<< idr11_offset
        var idr11: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr11_mask)) >> GPIO.IDR.idr11_offset)
        }

        static let idr10_offset = UInt32(10)
        static let idr10_mask = UInt32(0b1) &<< idr10_offset
        var idr10: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr10_mask)) >> GPIO.IDR.idr10_offset)
        }

        static let idr9_offset = UInt32(9)
        static let idr9_mask = UInt32(0b1) &<< idr9_offset
        var idr9: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr9_mask)) >> GPIO.IDR.idr9_offset)
        }

        static let idr8_offset = UInt32(8)
        static let idr8_mask = UInt32(0b1) &<< idr8_offset
        var idr8: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr8_mask)) >> GPIO.IDR.idr8_offset)
        }

        static let idr7_offset = UInt32(7)
        static let idr7_mask = UInt32(0b1) &<< idr7_offset
        var idr7: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr7_mask)) >> GPIO.IDR.idr7_offset)
        }

        static let idr6_offset = UInt32(6)
        static let idr6_mask = UInt32(0b1) &<< idr6_offset
        var idr6: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr6_mask)) >> GPIO.IDR.idr6_offset)
        }

        static let idr5_offset = UInt32(5)
        static let idr5_mask = UInt32(0b1) &<< idr5_offset
        var idr5: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr5_mask)) >> GPIO.IDR.idr5_offset)
        }

        static let idr4_offset = UInt32(4)
        static let idr4_mask = UInt32(0b1) &<< idr4_offset
        var idr4: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr4_mask)) >> GPIO.IDR.idr4_offset)
        }

        static let idr3_offset = UInt32(3)
        static let idr3_mask = UInt32(0b1) &<< idr3_offset
        var idr3: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr3_mask)) >> GPIO.IDR.idr3_offset)
        }

        static let idr2_offset = UInt32(2)
        static let idr2_mask = UInt32(0b1) &<< idr2_offset
        var idr2: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr2_mask)) >> GPIO.IDR.idr2_offset)
        }

        static let idr1_offset = UInt32(1)
        static let idr1_mask = UInt32(0b1) &<< idr1_offset
        var idr1: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr1_mask)) >> GPIO.IDR.idr1_offset)
        }

        static let idr0_offset = UInt32(0)
        static let idr0_mask = UInt32(0b1) &<< idr0_offset
        var idr0: UInt8 {
            UInt8((self.rawValue & (GPIO.IDR.idr0_mask)) >> GPIO.IDR.idr0_offset)
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct ODR {
        var rawValue: UInt32

        static let odr15_offset = UInt32(15)
        static let odr15_mask = UInt32(0b1) &<< odr15_offset
        var odr15: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr15_mask)) >> GPIO.ODR.odr15_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr15_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr15_offset) & GPIO.ODR.odr15_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr14_offset = UInt32(14)
        static let odr14_mask = UInt32(0b1) &<< odr14_offset
        var odr14: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr14_mask)) >> GPIO.ODR.odr14_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr14_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr14_offset) & GPIO.ODR.odr14_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr13_offset = UInt32(13)
        static let odr13_mask = UInt32(0b1) &<< odr13_offset
        var odr13: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr13_mask)) >> GPIO.ODR.odr13_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr13_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr13_offset) & GPIO.ODR.odr13_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr12_offset = UInt32(12)
        static let odr12_mask = UInt32(0b1) &<< odr12_offset
        var odr12: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr12_mask)) >> GPIO.ODR.odr12_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr12_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr12_offset) & GPIO.ODR.odr12_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr11_offset = UInt32(11)
        static let odr11_mask = UInt32(0b1) &<< odr11_offset
        var odr11: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr11_mask)) >> GPIO.ODR.odr11_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr11_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr11_offset) & GPIO.ODR.odr11_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr10_offset = UInt32(10)
        static let odr10_mask = UInt32(0b1) &<< odr10_offset
        var odr10: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr10_mask)) >> GPIO.ODR.odr10_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr10_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr10_offset) & GPIO.ODR.odr10_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr9_offset = UInt32(9)
        static let odr9_mask = UInt32(0b1) &<< odr9_offset
        var odr9: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr9_mask)) >> GPIO.ODR.odr9_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr9_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr9_offset) & GPIO.ODR.odr9_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr8_offset = UInt32(8)
        static let odr8_mask = UInt32(0b1) &<< odr8_offset
        var odr8: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr8_mask)) >> GPIO.ODR.odr8_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr8_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr8_offset) & GPIO.ODR.odr8_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr7_offset = UInt32(7)
        static let odr7_mask = UInt32(0b1) &<< odr7_offset
        var odr7: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr7_mask)) >> GPIO.ODR.odr7_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr7_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr7_offset) & GPIO.ODR.odr7_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr6_offset = UInt32(6)
        static let odr6_mask = UInt32(0b1) &<< odr6_offset
        var odr6: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr6_mask)) >> GPIO.ODR.odr6_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr6_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr6_offset) & GPIO.ODR.odr6_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr5_offset = UInt32(5)
        static let odr5_mask = UInt32(0b1) &<< odr5_offset
        var odr5: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr5_mask)) >> GPIO.ODR.odr5_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr5_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr5_offset) & GPIO.ODR.odr5_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr4_offset = UInt32(4)
        static let odr4_mask = UInt32(0b1) &<< odr4_offset
        var odr4: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr4_mask)) >> GPIO.ODR.odr4_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr4_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr4_offset) & GPIO.ODR.odr4_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr3_offset = UInt32(3)
        static let odr3_mask = UInt32(0b1) &<< odr3_offset
        var odr3: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr3_mask)) >> GPIO.ODR.odr3_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr3_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr3_offset) & GPIO.ODR.odr3_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr2_offset = UInt32(2)
        static let odr2_mask = UInt32(0b1) &<< odr2_offset
        var odr2: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr2_mask)) >> GPIO.ODR.odr2_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr2_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr2_offset) & GPIO.ODR.odr2_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr1_offset = UInt32(1)
        static let odr1_mask = UInt32(0b1) &<< odr1_offset
        var odr1: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr1_mask)) >> GPIO.ODR.odr1_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr1_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr1_offset) & GPIO.ODR.odr1_mask
                self.rawValue = preserve | shift
            }
        }

        static let odr0_offset = UInt32(0)
        static let odr0_mask = UInt32(0b1) &<< odr0_offset
        var odr0: UInt8 {
            get { UInt8((self.rawValue & (GPIO.ODR.odr0_mask)) >> GPIO.ODR.odr0_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.ODR.odr0_mask
                let shift = (UInt32(newValue) << GPIO.ODR.odr0_offset) & GPIO.ODR.odr0_mask
                self.rawValue = preserve | shift
            }
        }
        
        func od(n: Int) -> UInt8 {
            precondition(n >= 0 && n < 16)
            let od_offset = n * 1
            let od_mask = UInt32(0b1) &<< od_offset
            return UInt8((self.rawValue & (od_mask)) &>> od_offset)
        }
        
        mutating func setOd(n: Int, value: UInt8) {
            precondition(n >= 0 && n < 16)
            precondition(value < 2)
            let od_offset = n * 1
            let od_mask = UInt32(0b1) &<< od_offset
            let preserve = self.rawValue & ~od_mask
            let shift = (UInt32(value) << od_offset) & od_mask
            self.rawValue = preserve | shift
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct BSRR {
        var rawValue: UInt32

        static let br15_offset = UInt32(31)
        static let br15_mask = UInt32(0b1) &<< br15_offset
        var br15: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br15_offset) & GPIO.BSRR.br15_mask
            }
        }

        static let br14_offset = UInt32(30)
        static let br14_mask = UInt32(0b1) &<< br14_offset
        var br14: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br14_offset) & GPIO.BSRR.br14_mask
            }
        }

        static let br13_offset = UInt32(29)
        static let br13_mask = UInt32(0b1) &<< br13_offset
        var br13: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br13_offset) & GPIO.BSRR.br13_mask
            }
        }

        static let br12_offset = UInt32(28)
        static let br12_mask = UInt32(0b1) &<< br12_offset
        var br12: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br12_offset) & GPIO.BSRR.br12_mask
            }
        }

        static let br11_offset = UInt32(27)
        static let br11_mask = UInt32(0b1) &<< br11_offset
        var br11: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br11_offset) & GPIO.BSRR.br11_mask
            }
        }

        static let br10_offset = UInt32(26)
        static let br10_mask = UInt32(0b1) &<< br10_offset
        var br10: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br10_offset) & GPIO.BSRR.br10_mask
            }
        }

        static let br9_offset = UInt32(25)
        static let br9_mask = UInt32(0b1) &<< br9_offset
        var br9: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br9_offset) & GPIO.BSRR.br9_mask
            }
        }

        static let br8_offset = UInt32(24)
        static let br8_mask = UInt32(0b1) &<< br8_offset
        var br8: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br8_offset) & GPIO.BSRR.br8_mask
            }
        }

        static let br7_offset = UInt32(23)
        static let br7_mask = UInt32(0b1) &<< br7_offset
        var br7: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br7_offset) & GPIO.BSRR.br7_mask
            }
        }

        static let br6_offset = UInt32(22)
        static let br6_mask = UInt32(0b1) &<< br6_offset
        var br6: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br6_offset) & GPIO.BSRR.br6_mask
            }
        }

        static let br5_offset = UInt32(21)
        static let br5_mask = UInt32(0b1) &<< br5_offset
        var br5: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br5_offset) & GPIO.BSRR.br5_mask
            }
        }

        static let br4_offset = UInt32(20)
        static let br4_mask = UInt32(0b1) &<< br4_offset
        var br4: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br4_offset) & GPIO.BSRR.br4_mask
            }
        }

        static let br3_offset = UInt32(19)
        static let br3_mask = UInt32(0b1) &<< br3_offset
        var br3: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br3_offset) & GPIO.BSRR.br3_mask
            }
        }

        static let br2_offset = UInt32(18)
        static let br2_mask = UInt32(0b1) &<< br2_offset
        var br2: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br2_offset) & GPIO.BSRR.br2_mask
            }
        }

        static let br1_offset = UInt32(17)
        static let br1_mask = UInt32(0b1) &<< br1_offset
        var br1: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br1_offset) & GPIO.BSRR.br1_mask
            }
        }

        static let br0_offset = UInt32(16)
        static let br0_mask = UInt32(0b1) &<< br0_offset
        var br0: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.br0_offset) & GPIO.BSRR.br0_mask
            }
        }

        static let bs15_offset = UInt32(15)
        static let bs15_mask = UInt32(0b1) &<< bs15_offset
        var bs15: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs15_offset) & GPIO.BSRR.bs15_mask
            }
        }

        static let bs14_offset = UInt32(14)
        static let bs14_mask = UInt32(0b1) &<< bs14_offset
        var bs14: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs14_offset) & GPIO.BSRR.bs14_mask
            }
        }

        static let bs13_offset = UInt32(13)
        static let bs13_mask = UInt32(0b1) &<< bs13_offset
        var bs13: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs13_offset) & GPIO.BSRR.bs13_mask
            }
        }

        static let bs12_offset = UInt32(12)
        static let bs12_mask = UInt32(0b1) &<< bs12_offset
        var bs12: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs12_offset) & GPIO.BSRR.bs12_mask
            }
        }

        static let bs11_offset = UInt32(11)
        static let bs11_mask = UInt32(0b1) &<< bs11_offset
        var bs11: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs11_offset) & GPIO.BSRR.bs11_mask
            }
        }

        static let bs10_offset = UInt32(10)
        static let bs10_mask = UInt32(0b1) &<< bs10_offset
        var bs10: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs10_offset) & GPIO.BSRR.bs10_mask
            }
        }

        static let bs9_offset = UInt32(9)
        static let bs9_mask = UInt32(0b1) &<< bs9_offset
        var bs9: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs9_offset) & GPIO.BSRR.bs9_mask
            }
        }

        static let bs8_offset = UInt32(8)
        static let bs8_mask = UInt32(0b1) &<< bs8_offset
        var bs8: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs8_offset) & GPIO.BSRR.bs8_mask
            }
        }

        static let bs7_offset = UInt32(7)
        static let bs7_mask = UInt32(0b1) &<< bs7_offset
        var bs7: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs7_offset) & GPIO.BSRR.bs7_mask
            }
        }

        static let bs6_offset = UInt32(6)
        static let bs6_mask = UInt32(0b1) &<< bs6_offset
        var bs6: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs6_offset) & GPIO.BSRR.bs6_mask
            }
        }

        static let bs5_offset = UInt32(5)
        static let bs5_mask = UInt32(0b1) &<< bs5_offset
        var bs5: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs5_offset) & GPIO.BSRR.bs5_mask
            }
        }

        static let bs4_offset = UInt32(4)
        static let bs4_mask = UInt32(0b1) &<< bs4_offset
        var bs4: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs4_offset) & GPIO.BSRR.bs4_mask
            }
        }

        static let bs3_offset = UInt32(3)
        static let bs3_mask = UInt32(0b1) &<< bs3_offset
        var bs3: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs3_offset) & GPIO.BSRR.bs3_mask
            }
        }

        static let bs2_offset = UInt32(2)
        static let bs2_mask = UInt32(0b1) &<< bs2_offset
        var bs2: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs2_offset) & GPIO.BSRR.bs2_mask
            }
        }

        static let bs1_offset = UInt32(1)
        static let bs1_mask = UInt32(0b1) &<< bs1_offset
        var bs1: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs1_offset) & GPIO.BSRR.bs1_mask
            }
        }

        static let bs0_offset = UInt32(0)
        static let bs0_mask = UInt32(0b1) &<< bs0_offset
        var bs0: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << GPIO.BSRR.bs0_offset) & GPIO.BSRR.bs0_mask
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct LCKR {
        var rawValue: UInt32

        static let lckk_offset = UInt32(16)
        static let lckk_mask = UInt32(0b1) &<< lckk_offset
        var lckk: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lckk_mask)) >> GPIO.LCKR.lckk_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lckk_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lckk_offset) & GPIO.LCKR.lckk_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck15_offset = UInt32(15)
        static let lck15_mask = UInt32(0b1) &<< lck15_offset
        var lck15: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck15_mask)) >> GPIO.LCKR.lck15_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck15_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck15_offset) & GPIO.LCKR.lck15_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck14_offset = UInt32(14)
        static let lck14_mask = UInt32(0b1) &<< lck14_offset
        var lck14: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck14_mask)) >> GPIO.LCKR.lck14_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck14_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck14_offset) & GPIO.LCKR.lck14_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck13_offset = UInt32(13)
        static let lck13_mask = UInt32(0b1) &<< lck13_offset
        var lck13: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck13_mask)) >> GPIO.LCKR.lck13_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck13_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck13_offset) & GPIO.LCKR.lck13_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck12_offset = UInt32(12)
        static let lck12_mask = UInt32(0b1) &<< lck12_offset
        var lck12: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck12_mask)) >> GPIO.LCKR.lck12_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck12_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck12_offset) & GPIO.LCKR.lck12_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck11_offset = UInt32(11)
        static let lck11_mask = UInt32(0b1) &<< lck11_offset
        var lck11: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck11_mask)) >> GPIO.LCKR.lck11_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck11_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck11_offset) & GPIO.LCKR.lck11_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck10_offset = UInt32(10)
        static let lck10_mask = UInt32(0b1) &<< lck10_offset
        var lck10: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck10_mask)) >> GPIO.LCKR.lck10_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck10_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck10_offset) & GPIO.LCKR.lck10_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck9_offset = UInt32(9)
        static let lck9_mask = UInt32(0b1) &<< lck9_offset
        var lck9: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck9_mask)) >> GPIO.LCKR.lck9_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck9_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck9_offset) & GPIO.LCKR.lck9_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck8_offset = UInt32(8)
        static let lck8_mask = UInt32(0b1) &<< lck8_offset
        var lck8: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck8_mask)) >> GPIO.LCKR.lck8_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck8_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck8_offset) & GPIO.LCKR.lck8_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck7_offset = UInt32(7)
        static let lck7_mask = UInt32(0b1) &<< lck7_offset
        var lck7: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck7_mask)) >> GPIO.LCKR.lck7_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck7_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck7_offset) & GPIO.LCKR.lck7_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck6_offset = UInt32(6)
        static let lck6_mask = UInt32(0b1) &<< lck6_offset
        var lck6: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck6_mask)) >> GPIO.LCKR.lck6_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck6_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck6_offset) & GPIO.LCKR.lck6_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck5_offset = UInt32(5)
        static let lck5_mask = UInt32(0b1) &<< lck5_offset
        var lck5: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck5_mask)) >> GPIO.LCKR.lck5_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck5_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck5_offset) & GPIO.LCKR.lck5_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck4_offset = UInt32(4)
        static let lck4_mask = UInt32(0b1) &<< lck4_offset
        var lck4: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck4_mask)) >> GPIO.LCKR.lck4_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck4_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck4_offset) & GPIO.LCKR.lck4_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck3_offset = UInt32(3)
        static let lck3_mask = UInt32(0b1) &<< lck3_offset
        var lck3: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck3_mask)) >> GPIO.LCKR.lck3_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck3_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck3_offset) & GPIO.LCKR.lck3_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck2_offset = UInt32(2)
        static let lck2_mask = UInt32(0b1) &<< lck2_offset
        var lck2: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck2_mask)) >> GPIO.LCKR.lck2_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck2_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck2_offset) & GPIO.LCKR.lck2_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck1_offset = UInt32(1)
        static let lck1_mask = UInt32(0b1) &<< lck1_offset
        var lck1: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck1_mask)) >> GPIO.LCKR.lck1_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck1_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck1_offset) & GPIO.LCKR.lck1_mask
                self.rawValue = preserve | shift
            }
        }

        static let lck0_offset = UInt32(0)
        static let lck0_mask = UInt32(0b1) &<< lck0_offset
        var lck0: UInt8 {
            get { UInt8((self.rawValue & (GPIO.LCKR.lck0_mask)) >> GPIO.LCKR.lck0_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.LCKR.lck0_mask
                let shift = (UInt32(newValue) << GPIO.LCKR.lck0_offset) & GPIO.LCKR.lck0_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct AFRL {
        var rawValue: UInt32

        static let afrl7_offset = UInt32(28)
        static let afrl7_mask = UInt32(0b1111) &<< afrl7_offset
        var afrl7: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRL.afrl7_mask)) >> GPIO.AFRL.afrl7_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRL.afrl7_mask
                let shift = (UInt32(newValue) << GPIO.AFRL.afrl7_offset) & GPIO.AFRL.afrl7_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrl6_offset = UInt32(24)
        static let afrl6_mask = UInt32(0b1111) &<< afrl6_offset
        var afrl6: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRL.afrl6_mask)) >> GPIO.AFRL.afrl6_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRL.afrl6_mask
                let shift = (UInt32(newValue) << GPIO.AFRL.afrl6_offset) & GPIO.AFRL.afrl6_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrl5_offset = UInt32(20)
        static let afrl5_mask = UInt32(0b1111) &<< afrl5_offset
        var afrl5: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRL.afrl5_mask)) >> GPIO.AFRL.afrl5_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRL.afrl5_mask
                let shift = (UInt32(newValue) << GPIO.AFRL.afrl5_offset) & GPIO.AFRL.afrl5_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrl4_offset = UInt32(16)
        static let afrl4_mask = UInt32(0b1111) &<< afrl4_offset
        var afrl4: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRL.afrl4_mask)) >> GPIO.AFRL.afrl4_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRL.afrl4_mask
                let shift = (UInt32(newValue) << GPIO.AFRL.afrl4_offset) & GPIO.AFRL.afrl4_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrl3_offset = UInt32(12)
        static let afrl3_mask = UInt32(0b1111) &<< afrl3_offset
        var afrl3: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRL.afrl3_mask)) >> GPIO.AFRL.afrl3_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRL.afrl3_mask
                let shift = (UInt32(newValue) << GPIO.AFRL.afrl3_offset) & GPIO.AFRL.afrl3_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrl2_offset = UInt32(8)
        static let afrl2_mask = UInt32(0b1111) &<< afrl2_offset
        var afrl2: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRL.afrl2_mask)) >> GPIO.AFRL.afrl2_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRL.afrl2_mask
                let shift = (UInt32(newValue) << GPIO.AFRL.afrl2_offset) & GPIO.AFRL.afrl2_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrl1_offset = UInt32(4)
        static let afrl1_mask = UInt32(0b1111) &<< afrl1_offset
        var afrl1: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRL.afrl1_mask)) >> GPIO.AFRL.afrl1_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRL.afrl1_mask
                let shift = (UInt32(newValue) << GPIO.AFRL.afrl1_offset) & GPIO.AFRL.afrl1_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrl0_offset = UInt32(0)
        static let afrl0_mask = UInt32(0b1111) &<< afrl0_offset
        var afrl0: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRL.afrl0_mask)) >> GPIO.AFRL.afrl0_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRL.afrl0_mask
                let shift = (UInt32(newValue) << GPIO.AFRL.afrl0_offset) & GPIO.AFRL.afrl0_mask
                self.rawValue = preserve | shift
            }
        }
        
        func af(n: Int) -> UInt8 {
            precondition(n >= 0 && n < 8)
            let af_offset = n * 4
            let af_mask = UInt32(0b1111) &<< af_offset
            return UInt8((self.rawValue & (af_mask)) &>> af_offset)
        }
        
        mutating func setAf(n: Int, value: UInt8) {
            precondition(n >= 0 && n < 8)
            precondition(value < 16)
            let af_offset = n * 4
            let af_mask = UInt32(0b1111) &<< af_offset
            let preserve = self.rawValue & ~af_mask
            let shift = (UInt32(value) << af_offset) & af_mask
            self.rawValue = preserve | shift
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct AFRH {
        var rawValue: UInt32

        static let afrh15_offset = UInt32(28)
        static let afrh15_mask = UInt32(0b1111) &<< afrh15_offset
        var afrh15: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRH.afrh15_mask)) >> GPIO.AFRH.afrh15_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRH.afrh15_mask
                let shift = (UInt32(newValue) << GPIO.AFRH.afrh15_offset) & GPIO.AFRH.afrh15_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrh14_offset = UInt32(24)
        static let afrh14_mask = UInt32(0b1111) &<< afrh14_offset
        var afrh14: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRH.afrh14_mask)) >> GPIO.AFRH.afrh14_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRH.afrh14_mask
                let shift = (UInt32(newValue) << GPIO.AFRH.afrh14_offset) & GPIO.AFRH.afrh14_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrh13_offset = UInt32(20)
        static let afrh13_mask = UInt32(0b1111) &<< afrh13_offset
        var afrh13: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRH.afrh13_mask)) >> GPIO.AFRH.afrh13_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRH.afrh13_mask
                let shift = (UInt32(newValue) << GPIO.AFRH.afrh13_offset) & GPIO.AFRH.afrh13_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrh12_offset = UInt32(16)
        static let afrh12_mask = UInt32(0b1111) &<< afrh12_offset
        var afrh12: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRH.afrh12_mask)) >> GPIO.AFRH.afrh12_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRH.afrh12_mask
                let shift = (UInt32(newValue) << GPIO.AFRH.afrh12_offset) & GPIO.AFRH.afrh12_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrh11_offset = UInt32(12)
        static let afrh11_mask = UInt32(0b1111) &<< afrh11_offset
        var afrh11: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRH.afrh11_mask)) >> GPIO.AFRH.afrh11_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRH.afrh11_mask
                let shift = (UInt32(newValue) << GPIO.AFRH.afrh11_offset) & GPIO.AFRH.afrh11_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrh10_offset = UInt32(8)
        static let afrh10_mask = UInt32(0b1111) &<< afrh10_offset
        var afrh10: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRH.afrh10_mask)) >> GPIO.AFRH.afrh10_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRH.afrh10_mask
                let shift = (UInt32(newValue) << GPIO.AFRH.afrh10_offset) & GPIO.AFRH.afrh10_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrh9_offset = UInt32(4)
        static let afrh9_mask = UInt32(0b1111) &<< afrh9_offset
        var afrh9: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRH.afrh9_mask)) >> GPIO.AFRH.afrh9_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRH.afrh9_mask
                let shift = (UInt32(newValue) << GPIO.AFRH.afrh9_offset) & GPIO.AFRH.afrh9_mask
                self.rawValue = preserve | shift
            }
        }

        static let afrh8_offset = UInt32(0)
        static let afrh8_mask = UInt32(0b1111) &<< afrh8_offset
        var afrh8: UInt8 {
            get { UInt8((self.rawValue & (GPIO.AFRH.afrh8_mask)) >> GPIO.AFRH.afrh8_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.AFRH.afrh8_mask
                let shift = (UInt32(newValue) << GPIO.AFRH.afrh8_offset) & GPIO.AFRH.afrh8_mask
                self.rawValue = preserve | shift
            }
        }
        
        func af(n: Int) -> UInt8 {
            precondition(n >= 8 && n < 16)
            let af_offset = (n - 8) * 4
            let af_mask = UInt32(0b1111) &<< af_offset
            return UInt8((self.rawValue & (af_mask)) &>> af_offset)
        }
        
        mutating func setAf(n: Int, value: UInt8) {
            precondition(n >= 8 && n < 16)
            precondition(value < 16)
            let af_offset = (n - 8) * 4
            let af_mask = UInt32(0b1111) &<< af_offset
            let preserve = self.rawValue & ~af_mask
            let shift = (UInt32(value) << af_offset) & af_mask
            self.rawValue = preserve | shift
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct BRR {
        var rawValue: UInt32

        static let br0_offset = UInt32(0)
        static let br0_mask = UInt32(0b1) &<< br0_offset
        var br0: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br0_mask)) >> GPIO.BRR.br0_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br0_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br0_offset) & GPIO.BRR.br0_mask
                self.rawValue = preserve | shift
            }
        }

        static let br1_offset = UInt32(1)
        static let br1_mask = UInt32(0b1) &<< br1_offset
        var br1: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br1_mask)) >> GPIO.BRR.br1_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br1_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br1_offset) & GPIO.BRR.br1_mask
                self.rawValue = preserve | shift
            }
        }

        static let br2_offset = UInt32(2)
        static let br2_mask = UInt32(0b1) &<< br2_offset
        var br2: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br2_mask)) >> GPIO.BRR.br2_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br2_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br2_offset) & GPIO.BRR.br2_mask
                self.rawValue = preserve | shift
            }
        }

        static let br3_offset = UInt32(3)
        static let br3_mask = UInt32(0b1) &<< br3_offset
        var br3: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br3_mask)) >> GPIO.BRR.br3_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br3_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br3_offset) & GPIO.BRR.br3_mask
                self.rawValue = preserve | shift
            }
        }

        static let br4_offset = UInt32(4)
        static let br4_mask = UInt32(0b1) &<< br4_offset
        var br4: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br4_mask)) >> GPIO.BRR.br4_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br4_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br4_offset) & GPIO.BRR.br4_mask
                self.rawValue = preserve | shift
            }
        }

        static let br5_offset = UInt32(5)
        static let br5_mask = UInt32(0b1) &<< br5_offset
        var br5: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br5_mask)) >> GPIO.BRR.br5_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br5_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br5_offset) & GPIO.BRR.br5_mask
                self.rawValue = preserve | shift
            }
        }

        static let br6_offset = UInt32(6)
        static let br6_mask = UInt32(0b1) &<< br6_offset
        var br6: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br6_mask)) >> GPIO.BRR.br6_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br6_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br6_offset) & GPIO.BRR.br6_mask
                self.rawValue = preserve | shift
            }
        }

        static let br7_offset = UInt32(7)
        static let br7_mask = UInt32(0b1) &<< br7_offset
        var br7: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br7_mask)) >> GPIO.BRR.br7_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br7_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br7_offset) & GPIO.BRR.br7_mask
                self.rawValue = preserve | shift
            }
        }

        static let br8_offset = UInt32(8)
        static let br8_mask = UInt32(0b1) &<< br8_offset
        var br8: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br8_mask)) >> GPIO.BRR.br8_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br8_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br8_offset) & GPIO.BRR.br8_mask
                self.rawValue = preserve | shift
            }
        }

        static let br9_offset = UInt32(9)
        static let br9_mask = UInt32(0b1) &<< br9_offset
        var br9: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br9_mask)) >> GPIO.BRR.br9_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br9_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br9_offset) & GPIO.BRR.br9_mask
                self.rawValue = preserve | shift
            }
        }

        static let br10_offset = UInt32(10)
        static let br10_mask = UInt32(0b1) &<< br10_offset
        var br10: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br10_mask)) >> GPIO.BRR.br10_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br10_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br10_offset) & GPIO.BRR.br10_mask
                self.rawValue = preserve | shift
            }
        }

        static let br11_offset = UInt32(11)
        static let br11_mask = UInt32(0b1) &<< br11_offset
        var br11: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br11_mask)) >> GPIO.BRR.br11_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br11_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br11_offset) & GPIO.BRR.br11_mask
                self.rawValue = preserve | shift
            }
        }

        static let br12_offset = UInt32(12)
        static let br12_mask = UInt32(0b1) &<< br12_offset
        var br12: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br12_mask)) >> GPIO.BRR.br12_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br12_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br12_offset) & GPIO.BRR.br12_mask
                self.rawValue = preserve | shift
            }
        }

        static let br13_offset = UInt32(13)
        static let br13_mask = UInt32(0b1) &<< br13_offset
        var br13: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br13_mask)) >> GPIO.BRR.br13_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br13_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br13_offset) & GPIO.BRR.br13_mask
                self.rawValue = preserve | shift
            }
        }

        static let br14_offset = UInt32(14)
        static let br14_mask = UInt32(0b1) &<< br14_offset
        var br14: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br14_mask)) >> GPIO.BRR.br14_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br14_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br14_offset) & GPIO.BRR.br14_mask
                self.rawValue = preserve | shift
            }
        }

        static let br15_offset = UInt32(15)
        static let br15_mask = UInt32(0b1) &<< br15_offset
        var br15: UInt8 {
            get { UInt8((self.rawValue & (GPIO.BRR.br15_mask)) >> GPIO.BRR.br15_offset) }
            set {
                let preserve = self.rawValue & ~GPIO.BRR.br15_mask
                let shift = (UInt32(newValue) << GPIO.BRR.br15_offset) & GPIO.BRR.br15_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
}
