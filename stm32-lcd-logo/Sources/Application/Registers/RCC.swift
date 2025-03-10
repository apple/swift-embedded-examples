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

/// Reset and clock control
struct RCC {
    var baseAddress: UnsafeMutableRawPointer

    enum Offsets {
        static let CR: Int32 = 0x0
        static let PLLCFGR: Int32 = 0x4
        static let CFGR: Int32 = 0x8
        static let CIR: Int32 = 0xc
        static let AHB1RSTR: Int32 = 0x10
        static let AHB2RSTR: Int32 = 0x14
        static let AHB3RSTR: Int32 = 0x18
        static let APB1RSTR: Int32 = 0x20
        static let APB2RSTR: Int32 = 0x24
        static let AHB1ENR: Int32 = 0x30
        static let AHB2ENR: Int32 = 0x34
        static let AHB3ENR: Int32 = 0x38
        static let APB1ENR: Int32 = 0x40
        static let APB2ENR: Int32 = 0x44
        static let AHB1LPENR: Int32 = 0x50
        static let AHB2LPENR: Int32 = 0x54
        static let AHB3LPENR: Int32 = 0x58
        static let APB1LPENR: Int32 = 0x60
        static let APB2LPENR: Int32 = 0x64
        static let BDCR: Int32 = 0x70
        static let CSR: Int32 = 0x74
        static let SSCGR: Int32 = 0x80
        static let PLLI2SCFGR: Int32 = 0x84
        static let PLLSAICFGR: Int32 = 0x88
        static let DKCFGR1: Int32 = 0x8c
        static let DKCFGR2: Int32 = 0x90
    }

    private func ld(_ offset: Int32) -> UInt32 {
        UnsafeMutablePointer<UInt32>(bitPattern: UInt(bitPattern: UnsafeMutableRawPointer(baseAddress).advanced(by: Int(offset))))!.volatileLoad()
    }

    private func st(_ offset: Int32, _ value: UInt32) {
        UnsafeMutablePointer<UInt32>(bitPattern: UInt(bitPattern: UnsafeMutableRawPointer(baseAddress).advanced(by: Int(offset))))!.volatileStore(value)
    }

    /// clock control register
    var cr: CR {
        get { CR(rawValue: ld(Offsets.CR)) }
        set { st(Offsets.CR, newValue.rawValue) }
    }
    /// PLL configuration register
    var pllcfgr: PLLCFGR {
        get { PLLCFGR(rawValue: ld(Offsets.PLLCFGR)) }
        set { st(Offsets.PLLCFGR, newValue.rawValue) }
    }
    /// clock configuration register
    var cfgr: CFGR {
        get { CFGR(rawValue: ld(Offsets.CFGR)) }
        set { st(Offsets.CFGR, newValue.rawValue) }
    }
    /// clock interrupt register
    var cir: CIR {
        get { CIR(rawValue: ld(Offsets.CIR)) }
        set { st(Offsets.CIR, newValue.rawValue) }
    }
    /// AHB1 peripheral reset register
    var ahb1rstr: AHB1RSTR {
        get { AHB1RSTR(rawValue: ld(Offsets.AHB1RSTR)) }
        set { st(Offsets.AHB1RSTR, newValue.rawValue) }
    }
    /// AHB2 peripheral reset register
    var ahb2rstr: AHB2RSTR {
        get { AHB2RSTR(rawValue: ld(Offsets.AHB2RSTR)) }
        set { st(Offsets.AHB2RSTR, newValue.rawValue) }
    }
    /// AHB3 peripheral reset register
    var ahb3rstr: AHB3RSTR {
        get { AHB3RSTR(rawValue: ld(Offsets.AHB3RSTR)) }
        set { st(Offsets.AHB3RSTR, newValue.rawValue) }
    }
    /// APB1 peripheral reset register
    var apb1rstr: APB1RSTR {
        get { APB1RSTR(rawValue: ld(Offsets.APB1RSTR)) }
        set { st(Offsets.APB1RSTR, newValue.rawValue) }
    }
    /// APB2 peripheral reset register
    var apb2rstr: APB2RSTR {
        get { APB2RSTR(rawValue: ld(Offsets.APB2RSTR)) }
        set { st(Offsets.APB2RSTR, newValue.rawValue) }
    }
    /// AHB1 peripheral clock register
    var ahb1enr: AHB1ENR {
        get { AHB1ENR(rawValue: ld(Offsets.AHB1ENR)) }
        set { st(Offsets.AHB1ENR, newValue.rawValue) }
    }
    /// AHB2 peripheral clock enable register
    var ahb2enr: AHB2ENR {
        get { AHB2ENR(rawValue: ld(Offsets.AHB2ENR)) }
        set { st(Offsets.AHB2ENR, newValue.rawValue) }
    }
    /// AHB3 peripheral clock enable register
    var ahb3enr: AHB3ENR {
        get { AHB3ENR(rawValue: ld(Offsets.AHB3ENR)) }
        set { st(Offsets.AHB3ENR, newValue.rawValue) }
    }
    /// APB1 peripheral clock enable register
    var apb1enr: APB1ENR {
        get { APB1ENR(rawValue: ld(Offsets.APB1ENR)) }
        set { st(Offsets.APB1ENR, newValue.rawValue) }
    }
    /// APB2 peripheral clock enable register
    var apb2enr: APB2ENR {
        get { APB2ENR(rawValue: ld(Offsets.APB2ENR)) }
        set { st(Offsets.APB2ENR, newValue.rawValue) }
    }
    /// AHB1 peripheral clock enable in low power mode register
    var ahb1lpenr: AHB1LPENR {
        get { AHB1LPENR(rawValue: ld(Offsets.AHB1LPENR)) }
        set { st(Offsets.AHB1LPENR, newValue.rawValue) }
    }
    /// AHB2 peripheral clock enable in low power mode register
    var ahb2lpenr: AHB2LPENR {
        get { AHB2LPENR(rawValue: ld(Offsets.AHB2LPENR)) }
        set { st(Offsets.AHB2LPENR, newValue.rawValue) }
    }
    /// AHB3 peripheral clock enable in low power mode register
    var ahb3lpenr: AHB3LPENR {
        get { AHB3LPENR(rawValue: ld(Offsets.AHB3LPENR)) }
        set { st(Offsets.AHB3LPENR, newValue.rawValue) }
    }
    /// APB1 peripheral clock enable in low power mode register
    var apb1lpenr: APB1LPENR {
        get { APB1LPENR(rawValue: ld(Offsets.APB1LPENR)) }
        set { st(Offsets.APB1LPENR, newValue.rawValue) }
    }
    /// APB2 peripheral clock enabled in low power mode register
    var apb2lpenr: APB2LPENR {
        get { APB2LPENR(rawValue: ld(Offsets.APB2LPENR)) }
        set { st(Offsets.APB2LPENR, newValue.rawValue) }
    }
    /// Backup domain control register
    var bdcr: BDCR {
        get { BDCR(rawValue: ld(Offsets.BDCR)) }
        set { st(Offsets.BDCR, newValue.rawValue) }
    }
    /// clock control & status register
    var csr: CSR {
        get { CSR(rawValue: ld(Offsets.CSR)) }
        set { st(Offsets.CSR, newValue.rawValue) }
    }
    /// spread spectrum clock generation register
    var sscgr: SSCGR {
        get { SSCGR(rawValue: ld(Offsets.SSCGR)) }
        set { st(Offsets.SSCGR, newValue.rawValue) }
    }
    /// PLLI2S configuration register
    var plli2scfgr: PLLI2SCFGR {
        get { PLLI2SCFGR(rawValue: ld(Offsets.PLLI2SCFGR)) }
        set { st(Offsets.PLLI2SCFGR, newValue.rawValue) }
    }
    /// PLL configuration register
    var pllsaicfgr: PLLSAICFGR {
        get { PLLSAICFGR(rawValue: ld(Offsets.PLLSAICFGR)) }
        set { st(Offsets.PLLSAICFGR, newValue.rawValue) }
    }
    /// dedicated clocks configuration register
    var dkcfgr1: DKCFGR1 {
        get { DKCFGR1(rawValue: ld(Offsets.DKCFGR1)) }
        set { st(Offsets.DKCFGR1, newValue.rawValue) }
    }
    /// dedicated clocks configuration register
    var dkcfgr2: DKCFGR2 {
        get { DKCFGR2(rawValue: ld(Offsets.DKCFGR2)) }
        set { st(Offsets.DKCFGR2, newValue.rawValue) }
    }
}

extension RCC {
    struct CR {
        var rawValue: UInt32

        static let pllsairdy_offset = UInt32(29)
        static let pllsairdy_mask = UInt32(0b1) &<< pllsairdy_offset
        var pllsairdy: UInt8 {
            UInt8((self.rawValue & (RCC.CR.pllsairdy_mask)) >> RCC.CR.pllsairdy_offset)
        }

        static let pllsaion_offset = UInt32(28)
        static let pllsaion_mask = UInt32(0b1) &<< pllsaion_offset
        var pllsaion: UInt8 {
            get { UInt8((self.rawValue & (RCC.CR.pllsaion_mask)) >> RCC.CR.pllsaion_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CR.pllsaion_mask
                let shift = (UInt32(newValue) << RCC.CR.pllsaion_offset) & RCC.CR.pllsaion_mask
                self.rawValue = preserve | shift
            }
        }

        static let plli2srdy_offset = UInt32(27)
        static let plli2srdy_mask = UInt32(0b1) &<< plli2srdy_offset
        var plli2srdy: UInt8 {
            UInt8((self.rawValue & (RCC.CR.plli2srdy_mask)) >> RCC.CR.plli2srdy_offset)
        }

        static let plli2son_offset = UInt32(26)
        static let plli2son_mask = UInt32(0b1) &<< plli2son_offset
        var plli2son: UInt8 {
            get { UInt8((self.rawValue & (RCC.CR.plli2son_mask)) >> RCC.CR.plli2son_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CR.plli2son_mask
                let shift = (UInt32(newValue) << RCC.CR.plli2son_offset) & RCC.CR.plli2son_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllrdy_offset = UInt32(25)
        static let pllrdy_mask = UInt32(0b1) &<< pllrdy_offset
        var pllrdy: UInt8 {
            UInt8((self.rawValue & (RCC.CR.pllrdy_mask)) >> RCC.CR.pllrdy_offset)
        }

        static let pllon_offset = UInt32(24)
        static let pllon_mask = UInt32(0b1) &<< pllon_offset
        var pllon: UInt8 {
            get { UInt8((self.rawValue & (RCC.CR.pllon_mask)) >> RCC.CR.pllon_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CR.pllon_mask
                let shift = (UInt32(newValue) << RCC.CR.pllon_offset) & RCC.CR.pllon_mask
                self.rawValue = preserve | shift
            }
        }

        static let csson_offset = UInt32(19)
        static let csson_mask = UInt32(0b1) &<< csson_offset
        var csson: UInt8 {
            get { UInt8((self.rawValue & (RCC.CR.csson_mask)) >> RCC.CR.csson_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CR.csson_mask
                let shift = (UInt32(newValue) << RCC.CR.csson_offset) & RCC.CR.csson_mask
                self.rawValue = preserve | shift
            }
        }

        static let hsebyp_offset = UInt32(18)
        static let hsebyp_mask = UInt32(0b1) &<< hsebyp_offset
        var hsebyp: UInt8 {
            get { UInt8((self.rawValue & (RCC.CR.hsebyp_mask)) >> RCC.CR.hsebyp_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CR.hsebyp_mask
                let shift = (UInt32(newValue) << RCC.CR.hsebyp_offset) & RCC.CR.hsebyp_mask
                self.rawValue = preserve | shift
            }
        }

        static let hserdy_offset = UInt32(17)
        static let hserdy_mask = UInt32(0b1) &<< hserdy_offset
        var hserdy: UInt8 {
            UInt8((self.rawValue & (RCC.CR.hserdy_mask)) >> RCC.CR.hserdy_offset)
        }

        static let hseon_offset = UInt32(16)
        static let hseon_mask = UInt32(0b1) &<< hseon_offset
        var hseon: UInt8 {
            get { UInt8((self.rawValue & (RCC.CR.hseon_mask)) >> RCC.CR.hseon_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CR.hseon_mask
                let shift = (UInt32(newValue) << RCC.CR.hseon_offset) & RCC.CR.hseon_mask
                self.rawValue = preserve | shift
            }
        }

        static let hsical_offset = UInt32(8)
        static let hsical_mask = UInt32(0b11111111) &<< hsical_offset
        var hsical: UInt8 {
            UInt8((self.rawValue & (RCC.CR.hsical_mask)) >> RCC.CR.hsical_offset)
        }

        static let hsitrim_offset = UInt32(3)
        static let hsitrim_mask = UInt32(0b11111) &<< hsitrim_offset
        var hsitrim: UInt8 {
            get { UInt8((self.rawValue & (RCC.CR.hsitrim_mask)) >> RCC.CR.hsitrim_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CR.hsitrim_mask
                let shift = (UInt32(newValue) << RCC.CR.hsitrim_offset) & RCC.CR.hsitrim_mask
                self.rawValue = preserve | shift
            }
        }

        static let hsirdy_offset = UInt32(1)
        static let hsirdy_mask = UInt32(0b1) &<< hsirdy_offset
        var hsirdy: UInt8 {
            UInt8((self.rawValue & (RCC.CR.hsirdy_mask)) >> RCC.CR.hsirdy_offset)
        }

        static let hsion_offset = UInt32(0)
        static let hsion_mask = UInt32(0b1) &<< hsion_offset
        var hsion: UInt8 {
            get { UInt8((self.rawValue & (RCC.CR.hsion_mask)) >> RCC.CR.hsion_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CR.hsion_mask
                let shift = (UInt32(newValue) << RCC.CR.hsion_offset) & RCC.CR.hsion_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct PLLCFGR {
        var rawValue: UInt32

        static let pllq3_offset = UInt32(27)
        static let pllq3_mask = UInt32(0b1) &<< pllq3_offset
        var pllq3: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.pllq3_mask)) >> RCC.PLLCFGR.pllq3_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.pllq3_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.pllq3_offset) & RCC.PLLCFGR.pllq3_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllq2_offset = UInt32(26)
        static let pllq2_mask = UInt32(0b1) &<< pllq2_offset
        var pllq2: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.pllq2_mask)) >> RCC.PLLCFGR.pllq2_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.pllq2_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.pllq2_offset) & RCC.PLLCFGR.pllq2_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllq1_offset = UInt32(25)
        static let pllq1_mask = UInt32(0b1) &<< pllq1_offset
        var pllq1: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.pllq1_mask)) >> RCC.PLLCFGR.pllq1_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.pllq1_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.pllq1_offset) & RCC.PLLCFGR.pllq1_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllq0_offset = UInt32(24)
        static let pllq0_mask = UInt32(0b1) &<< pllq0_offset
        var pllq0: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.pllq0_mask)) >> RCC.PLLCFGR.pllq0_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.pllq0_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.pllq0_offset) & RCC.PLLCFGR.pllq0_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllsrc_offset = UInt32(22)
        static let pllsrc_mask = UInt32(0b1) &<< pllsrc_offset
        var pllsrc: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.pllsrc_mask)) >> RCC.PLLCFGR.pllsrc_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.pllsrc_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.pllsrc_offset) & RCC.PLLCFGR.pllsrc_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllp1_offset = UInt32(17)
        static let pllp1_mask = UInt32(0b1) &<< pllp1_offset
        var pllp1: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.pllp1_mask)) >> RCC.PLLCFGR.pllp1_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.pllp1_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.pllp1_offset) & RCC.PLLCFGR.pllp1_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllp0_offset = UInt32(16)
        static let pllp0_mask = UInt32(0b1) &<< pllp0_offset
        var pllp0: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.pllp0_mask)) >> RCC.PLLCFGR.pllp0_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.pllp0_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.pllp0_offset) & RCC.PLLCFGR.pllp0_mask
                self.rawValue = preserve | shift
            }
        }

        static let plln8_offset = UInt32(14)
        static let plln8_mask = UInt32(0b1) &<< plln8_offset
        var plln8: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.plln8_mask)) >> RCC.PLLCFGR.plln8_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.plln8_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.plln8_offset) & RCC.PLLCFGR.plln8_mask
                self.rawValue = preserve | shift
            }
        }

        static let plln7_offset = UInt32(13)
        static let plln7_mask = UInt32(0b1) &<< plln7_offset
        var plln7: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.plln7_mask)) >> RCC.PLLCFGR.plln7_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.plln7_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.plln7_offset) & RCC.PLLCFGR.plln7_mask
                self.rawValue = preserve | shift
            }
        }

        static let plln6_offset = UInt32(12)
        static let plln6_mask = UInt32(0b1) &<< plln6_offset
        var plln6: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.plln6_mask)) >> RCC.PLLCFGR.plln6_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.plln6_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.plln6_offset) & RCC.PLLCFGR.plln6_mask
                self.rawValue = preserve | shift
            }
        }

        static let plln5_offset = UInt32(11)
        static let plln5_mask = UInt32(0b1) &<< plln5_offset
        var plln5: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.plln5_mask)) >> RCC.PLLCFGR.plln5_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.plln5_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.plln5_offset) & RCC.PLLCFGR.plln5_mask
                self.rawValue = preserve | shift
            }
        }

        static let plln4_offset = UInt32(10)
        static let plln4_mask = UInt32(0b1) &<< plln4_offset
        var plln4: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.plln4_mask)) >> RCC.PLLCFGR.plln4_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.plln4_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.plln4_offset) & RCC.PLLCFGR.plln4_mask
                self.rawValue = preserve | shift
            }
        }

        static let plln3_offset = UInt32(9)
        static let plln3_mask = UInt32(0b1) &<< plln3_offset
        var plln3: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.plln3_mask)) >> RCC.PLLCFGR.plln3_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.plln3_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.plln3_offset) & RCC.PLLCFGR.plln3_mask
                self.rawValue = preserve | shift
            }
        }

        static let plln2_offset = UInt32(8)
        static let plln2_mask = UInt32(0b1) &<< plln2_offset
        var plln2: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.plln2_mask)) >> RCC.PLLCFGR.plln2_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.plln2_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.plln2_offset) & RCC.PLLCFGR.plln2_mask
                self.rawValue = preserve | shift
            }
        }

        static let plln1_offset = UInt32(7)
        static let plln1_mask = UInt32(0b1) &<< plln1_offset
        var plln1: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.plln1_mask)) >> RCC.PLLCFGR.plln1_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.plln1_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.plln1_offset) & RCC.PLLCFGR.plln1_mask
                self.rawValue = preserve | shift
            }
        }

        static let plln0_offset = UInt32(6)
        static let plln0_mask = UInt32(0b1) &<< plln0_offset
        var plln0: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.plln0_mask)) >> RCC.PLLCFGR.plln0_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.plln0_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.plln0_offset) & RCC.PLLCFGR.plln0_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllm5_offset = UInt32(5)
        static let pllm5_mask = UInt32(0b1) &<< pllm5_offset
        var pllm5: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.pllm5_mask)) >> RCC.PLLCFGR.pllm5_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.pllm5_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.pllm5_offset) & RCC.PLLCFGR.pllm5_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllm4_offset = UInt32(4)
        static let pllm4_mask = UInt32(0b1) &<< pllm4_offset
        var pllm4: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.pllm4_mask)) >> RCC.PLLCFGR.pllm4_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.pllm4_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.pllm4_offset) & RCC.PLLCFGR.pllm4_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllm3_offset = UInt32(3)
        static let pllm3_mask = UInt32(0b1) &<< pllm3_offset
        var pllm3: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.pllm3_mask)) >> RCC.PLLCFGR.pllm3_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.pllm3_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.pllm3_offset) & RCC.PLLCFGR.pllm3_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllm2_offset = UInt32(2)
        static let pllm2_mask = UInt32(0b1) &<< pllm2_offset
        var pllm2: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.pllm2_mask)) >> RCC.PLLCFGR.pllm2_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.pllm2_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.pllm2_offset) & RCC.PLLCFGR.pllm2_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllm1_offset = UInt32(1)
        static let pllm1_mask = UInt32(0b1) &<< pllm1_offset
        var pllm1: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.pllm1_mask)) >> RCC.PLLCFGR.pllm1_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.pllm1_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.pllm1_offset) & RCC.PLLCFGR.pllm1_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllm0_offset = UInt32(0)
        static let pllm0_mask = UInt32(0b1) &<< pllm0_offset
        var pllm0: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLCFGR.pllm0_mask)) >> RCC.PLLCFGR.pllm0_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLCFGR.pllm0_mask
                let shift = (UInt32(newValue) << RCC.PLLCFGR.pllm0_offset) & RCC.PLLCFGR.pllm0_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct CFGR {
        var rawValue: UInt32

        static let mco2_offset = UInt32(30)
        static let mco2_mask = UInt32(0b11) &<< mco2_offset
        var mco2: UInt8 {
            get { UInt8((self.rawValue & (RCC.CFGR.mco2_mask)) >> RCC.CFGR.mco2_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CFGR.mco2_mask
                let shift = (UInt32(newValue) << RCC.CFGR.mco2_offset) & RCC.CFGR.mco2_mask
                self.rawValue = preserve | shift
            }
        }

        static let mco2pre_offset = UInt32(27)
        static let mco2pre_mask = UInt32(0b111) &<< mco2pre_offset
        var mco2pre: UInt8 {
            get { UInt8((self.rawValue & (RCC.CFGR.mco2pre_mask)) >> RCC.CFGR.mco2pre_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CFGR.mco2pre_mask
                let shift = (UInt32(newValue) << RCC.CFGR.mco2pre_offset) & RCC.CFGR.mco2pre_mask
                self.rawValue = preserve | shift
            }
        }

        static let mco1pre_offset = UInt32(24)
        static let mco1pre_mask = UInt32(0b111) &<< mco1pre_offset
        var mco1pre: UInt8 {
            get { UInt8((self.rawValue & (RCC.CFGR.mco1pre_mask)) >> RCC.CFGR.mco1pre_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CFGR.mco1pre_mask
                let shift = (UInt32(newValue) << RCC.CFGR.mco1pre_offset) & RCC.CFGR.mco1pre_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2ssrc_offset = UInt32(23)
        static let i2ssrc_mask = UInt32(0b1) &<< i2ssrc_offset
        var i2ssrc: UInt8 {
            get { UInt8((self.rawValue & (RCC.CFGR.i2ssrc_mask)) >> RCC.CFGR.i2ssrc_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CFGR.i2ssrc_mask
                let shift = (UInt32(newValue) << RCC.CFGR.i2ssrc_offset) & RCC.CFGR.i2ssrc_mask
                self.rawValue = preserve | shift
            }
        }

        static let mco1_offset = UInt32(21)
        static let mco1_mask = UInt32(0b11) &<< mco1_offset
        var mco1: UInt8 {
            get { UInt8((self.rawValue & (RCC.CFGR.mco1_mask)) >> RCC.CFGR.mco1_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CFGR.mco1_mask
                let shift = (UInt32(newValue) << RCC.CFGR.mco1_offset) & RCC.CFGR.mco1_mask
                self.rawValue = preserve | shift
            }
        }

        static let rtcpre_offset = UInt32(16)
        static let rtcpre_mask = UInt32(0b11111) &<< rtcpre_offset
        var rtcpre: UInt8 {
            get { UInt8((self.rawValue & (RCC.CFGR.rtcpre_mask)) >> RCC.CFGR.rtcpre_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CFGR.rtcpre_mask
                let shift = (UInt32(newValue) << RCC.CFGR.rtcpre_offset) & RCC.CFGR.rtcpre_mask
                self.rawValue = preserve | shift
            }
        }

        static let ppre2_offset = UInt32(13)
        static let ppre2_mask = UInt32(0b111) &<< ppre2_offset
        var ppre2: UInt8 {
            get { UInt8((self.rawValue & (RCC.CFGR.ppre2_mask)) >> RCC.CFGR.ppre2_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CFGR.ppre2_mask
                let shift = (UInt32(newValue) << RCC.CFGR.ppre2_offset) & RCC.CFGR.ppre2_mask
                self.rawValue = preserve | shift
            }
        }

        static let ppre1_offset = UInt32(10)
        static let ppre1_mask = UInt32(0b111) &<< ppre1_offset
        var ppre1: UInt8 {
            get { UInt8((self.rawValue & (RCC.CFGR.ppre1_mask)) >> RCC.CFGR.ppre1_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CFGR.ppre1_mask
                let shift = (UInt32(newValue) << RCC.CFGR.ppre1_offset) & RCC.CFGR.ppre1_mask
                self.rawValue = preserve | shift
            }
        }

        static let hpre_offset = UInt32(4)
        static let hpre_mask = UInt32(0b1111) &<< hpre_offset
        var hpre: UInt8 {
            get { UInt8((self.rawValue & (RCC.CFGR.hpre_mask)) >> RCC.CFGR.hpre_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CFGR.hpre_mask
                let shift = (UInt32(newValue) << RCC.CFGR.hpre_offset) & RCC.CFGR.hpre_mask
                self.rawValue = preserve | shift
            }
        }

        static let sws1_offset = UInt32(3)
        static let sws1_mask = UInt32(0b1) &<< sws1_offset
        var sws1: UInt8 {
            UInt8((self.rawValue & (RCC.CFGR.sws1_mask)) >> RCC.CFGR.sws1_offset)
        }

        static let sws0_offset = UInt32(2)
        static let sws0_mask = UInt32(0b1) &<< sws0_offset
        var sws0: UInt8 {
            UInt8((self.rawValue & (RCC.CFGR.sws0_mask)) >> RCC.CFGR.sws0_offset)
        }

        static let sw1_offset = UInt32(1)
        static let sw1_mask = UInt32(0b1) &<< sw1_offset
        var sw1: UInt8 {
            get { UInt8((self.rawValue & (RCC.CFGR.sw1_mask)) >> RCC.CFGR.sw1_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CFGR.sw1_mask
                let shift = (UInt32(newValue) << RCC.CFGR.sw1_offset) & RCC.CFGR.sw1_mask
                self.rawValue = preserve | shift
            }
        }

        static let sw0_offset = UInt32(0)
        static let sw0_mask = UInt32(0b1) &<< sw0_offset
        var sw0: UInt8 {
            get { UInt8((self.rawValue & (RCC.CFGR.sw0_mask)) >> RCC.CFGR.sw0_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CFGR.sw0_mask
                let shift = (UInt32(newValue) << RCC.CFGR.sw0_offset) & RCC.CFGR.sw0_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct CIR {
        var rawValue: UInt32

        static let cssc_offset = UInt32(23)
        static let cssc_mask = UInt32(0b1) &<< cssc_offset
        var cssc: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << RCC.CIR.cssc_offset) & RCC.CIR.cssc_mask
            }
        }

        static let pllsairdyc_offset = UInt32(22)
        static let pllsairdyc_mask = UInt32(0b1) &<< pllsairdyc_offset
        var pllsairdyc: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << RCC.CIR.pllsairdyc_offset) & RCC.CIR.pllsairdyc_mask
            }
        }

        static let plli2srdyc_offset = UInt32(21)
        static let plli2srdyc_mask = UInt32(0b1) &<< plli2srdyc_offset
        var plli2srdyc: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << RCC.CIR.plli2srdyc_offset) & RCC.CIR.plli2srdyc_mask
            }
        }

        static let pllrdyc_offset = UInt32(20)
        static let pllrdyc_mask = UInt32(0b1) &<< pllrdyc_offset
        var pllrdyc: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << RCC.CIR.pllrdyc_offset) & RCC.CIR.pllrdyc_mask
            }
        }

        static let hserdyc_offset = UInt32(19)
        static let hserdyc_mask = UInt32(0b1) &<< hserdyc_offset
        var hserdyc: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << RCC.CIR.hserdyc_offset) & RCC.CIR.hserdyc_mask
            }
        }

        static let hsirdyc_offset = UInt32(18)
        static let hsirdyc_mask = UInt32(0b1) &<< hsirdyc_offset
        var hsirdyc: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << RCC.CIR.hsirdyc_offset) & RCC.CIR.hsirdyc_mask
            }
        }

        static let lserdyc_offset = UInt32(17)
        static let lserdyc_mask = UInt32(0b1) &<< lserdyc_offset
        var lserdyc: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << RCC.CIR.lserdyc_offset) & RCC.CIR.lserdyc_mask
            }
        }

        static let lsirdyc_offset = UInt32(16)
        static let lsirdyc_mask = UInt32(0b1) &<< lsirdyc_offset
        var lsirdyc: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << RCC.CIR.lsirdyc_offset) & RCC.CIR.lsirdyc_mask
            }
        }

        static let pllsairdyie_offset = UInt32(14)
        static let pllsairdyie_mask = UInt32(0b1) &<< pllsairdyie_offset
        var pllsairdyie: UInt8 {
            get { UInt8((self.rawValue & (RCC.CIR.pllsairdyie_mask)) >> RCC.CIR.pllsairdyie_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CIR.pllsairdyie_mask
                let shift = (UInt32(newValue) << RCC.CIR.pllsairdyie_offset) & RCC.CIR.pllsairdyie_mask
                self.rawValue = preserve | shift
            }
        }

        static let plli2srdyie_offset = UInt32(13)
        static let plli2srdyie_mask = UInt32(0b1) &<< plli2srdyie_offset
        var plli2srdyie: UInt8 {
            get { UInt8((self.rawValue & (RCC.CIR.plli2srdyie_mask)) >> RCC.CIR.plli2srdyie_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CIR.plli2srdyie_mask
                let shift = (UInt32(newValue) << RCC.CIR.plli2srdyie_offset) & RCC.CIR.plli2srdyie_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllrdyie_offset = UInt32(12)
        static let pllrdyie_mask = UInt32(0b1) &<< pllrdyie_offset
        var pllrdyie: UInt8 {
            get { UInt8((self.rawValue & (RCC.CIR.pllrdyie_mask)) >> RCC.CIR.pllrdyie_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CIR.pllrdyie_mask
                let shift = (UInt32(newValue) << RCC.CIR.pllrdyie_offset) & RCC.CIR.pllrdyie_mask
                self.rawValue = preserve | shift
            }
        }

        static let hserdyie_offset = UInt32(11)
        static let hserdyie_mask = UInt32(0b1) &<< hserdyie_offset
        var hserdyie: UInt8 {
            get { UInt8((self.rawValue & (RCC.CIR.hserdyie_mask)) >> RCC.CIR.hserdyie_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CIR.hserdyie_mask
                let shift = (UInt32(newValue) << RCC.CIR.hserdyie_offset) & RCC.CIR.hserdyie_mask
                self.rawValue = preserve | shift
            }
        }

        static let hsirdyie_offset = UInt32(10)
        static let hsirdyie_mask = UInt32(0b1) &<< hsirdyie_offset
        var hsirdyie: UInt8 {
            get { UInt8((self.rawValue & (RCC.CIR.hsirdyie_mask)) >> RCC.CIR.hsirdyie_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CIR.hsirdyie_mask
                let shift = (UInt32(newValue) << RCC.CIR.hsirdyie_offset) & RCC.CIR.hsirdyie_mask
                self.rawValue = preserve | shift
            }
        }

        static let lserdyie_offset = UInt32(9)
        static let lserdyie_mask = UInt32(0b1) &<< lserdyie_offset
        var lserdyie: UInt8 {
            get { UInt8((self.rawValue & (RCC.CIR.lserdyie_mask)) >> RCC.CIR.lserdyie_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CIR.lserdyie_mask
                let shift = (UInt32(newValue) << RCC.CIR.lserdyie_offset) & RCC.CIR.lserdyie_mask
                self.rawValue = preserve | shift
            }
        }

        static let lsirdyie_offset = UInt32(8)
        static let lsirdyie_mask = UInt32(0b1) &<< lsirdyie_offset
        var lsirdyie: UInt8 {
            get { UInt8((self.rawValue & (RCC.CIR.lsirdyie_mask)) >> RCC.CIR.lsirdyie_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CIR.lsirdyie_mask
                let shift = (UInt32(newValue) << RCC.CIR.lsirdyie_offset) & RCC.CIR.lsirdyie_mask
                self.rawValue = preserve | shift
            }
        }

        static let cssf_offset = UInt32(7)
        static let cssf_mask = UInt32(0b1) &<< cssf_offset
        var cssf: UInt8 {
            UInt8((self.rawValue & (RCC.CIR.cssf_mask)) >> RCC.CIR.cssf_offset)
        }

        static let pllsairdyf_offset = UInt32(6)
        static let pllsairdyf_mask = UInt32(0b1) &<< pllsairdyf_offset
        var pllsairdyf: UInt8 {
            UInt8((self.rawValue & (RCC.CIR.pllsairdyf_mask)) >> RCC.CIR.pllsairdyf_offset)
        }

        static let plli2srdyf_offset = UInt32(5)
        static let plli2srdyf_mask = UInt32(0b1) &<< plli2srdyf_offset
        var plli2srdyf: UInt8 {
            UInt8((self.rawValue & (RCC.CIR.plli2srdyf_mask)) >> RCC.CIR.plli2srdyf_offset)
        }

        static let pllrdyf_offset = UInt32(4)
        static let pllrdyf_mask = UInt32(0b1) &<< pllrdyf_offset
        var pllrdyf: UInt8 {
            UInt8((self.rawValue & (RCC.CIR.pllrdyf_mask)) >> RCC.CIR.pllrdyf_offset)
        }

        static let hserdyf_offset = UInt32(3)
        static let hserdyf_mask = UInt32(0b1) &<< hserdyf_offset
        var hserdyf: UInt8 {
            UInt8((self.rawValue & (RCC.CIR.hserdyf_mask)) >> RCC.CIR.hserdyf_offset)
        }

        static let hsirdyf_offset = UInt32(2)
        static let hsirdyf_mask = UInt32(0b1) &<< hsirdyf_offset
        var hsirdyf: UInt8 {
            UInt8((self.rawValue & (RCC.CIR.hsirdyf_mask)) >> RCC.CIR.hsirdyf_offset)
        }

        static let lserdyf_offset = UInt32(1)
        static let lserdyf_mask = UInt32(0b1) &<< lserdyf_offset
        var lserdyf: UInt8 {
            UInt8((self.rawValue & (RCC.CIR.lserdyf_mask)) >> RCC.CIR.lserdyf_offset)
        }

        static let lsirdyf_offset = UInt32(0)
        static let lsirdyf_mask = UInt32(0b1) &<< lsirdyf_offset
        var lsirdyf: UInt8 {
            UInt8((self.rawValue & (RCC.CIR.lsirdyf_mask)) >> RCC.CIR.lsirdyf_offset)
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct AHB1RSTR {
        var rawValue: UInt32

        static let otghsrst_offset = UInt32(29)
        static let otghsrst_mask = UInt32(0b1) &<< otghsrst_offset
        var otghsrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.otghsrst_mask)) >> RCC.AHB1RSTR.otghsrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.otghsrst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.otghsrst_offset) & RCC.AHB1RSTR.otghsrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let ethmacrst_offset = UInt32(25)
        static let ethmacrst_mask = UInt32(0b1) &<< ethmacrst_offset
        var ethmacrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.ethmacrst_mask)) >> RCC.AHB1RSTR.ethmacrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.ethmacrst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.ethmacrst_offset) & RCC.AHB1RSTR.ethmacrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let dma2drst_offset = UInt32(23)
        static let dma2drst_mask = UInt32(0b1) &<< dma2drst_offset
        var dma2drst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.dma2drst_mask)) >> RCC.AHB1RSTR.dma2drst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.dma2drst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.dma2drst_offset) & RCC.AHB1RSTR.dma2drst_mask
                self.rawValue = preserve | shift
            }
        }

        static let dma2rst_offset = UInt32(22)
        static let dma2rst_mask = UInt32(0b1) &<< dma2rst_offset
        var dma2rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.dma2rst_mask)) >> RCC.AHB1RSTR.dma2rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.dma2rst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.dma2rst_offset) & RCC.AHB1RSTR.dma2rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let dma1rst_offset = UInt32(21)
        static let dma1rst_mask = UInt32(0b1) &<< dma1rst_offset
        var dma1rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.dma1rst_mask)) >> RCC.AHB1RSTR.dma1rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.dma1rst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.dma1rst_offset) & RCC.AHB1RSTR.dma1rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let crcrst_offset = UInt32(12)
        static let crcrst_mask = UInt32(0b1) &<< crcrst_offset
        var crcrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.crcrst_mask)) >> RCC.AHB1RSTR.crcrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.crcrst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.crcrst_offset) & RCC.AHB1RSTR.crcrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiokrst_offset = UInt32(10)
        static let gpiokrst_mask = UInt32(0b1) &<< gpiokrst_offset
        var gpiokrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.gpiokrst_mask)) >> RCC.AHB1RSTR.gpiokrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.gpiokrst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.gpiokrst_offset) & RCC.AHB1RSTR.gpiokrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiojrst_offset = UInt32(9)
        static let gpiojrst_mask = UInt32(0b1) &<< gpiojrst_offset
        var gpiojrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.gpiojrst_mask)) >> RCC.AHB1RSTR.gpiojrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.gpiojrst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.gpiojrst_offset) & RCC.AHB1RSTR.gpiojrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioirst_offset = UInt32(8)
        static let gpioirst_mask = UInt32(0b1) &<< gpioirst_offset
        var gpioirst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.gpioirst_mask)) >> RCC.AHB1RSTR.gpioirst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.gpioirst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.gpioirst_offset) & RCC.AHB1RSTR.gpioirst_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiohrst_offset = UInt32(7)
        static let gpiohrst_mask = UInt32(0b1) &<< gpiohrst_offset
        var gpiohrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.gpiohrst_mask)) >> RCC.AHB1RSTR.gpiohrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.gpiohrst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.gpiohrst_offset) & RCC.AHB1RSTR.gpiohrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiogrst_offset = UInt32(6)
        static let gpiogrst_mask = UInt32(0b1) &<< gpiogrst_offset
        var gpiogrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.gpiogrst_mask)) >> RCC.AHB1RSTR.gpiogrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.gpiogrst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.gpiogrst_offset) & RCC.AHB1RSTR.gpiogrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiofrst_offset = UInt32(5)
        static let gpiofrst_mask = UInt32(0b1) &<< gpiofrst_offset
        var gpiofrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.gpiofrst_mask)) >> RCC.AHB1RSTR.gpiofrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.gpiofrst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.gpiofrst_offset) & RCC.AHB1RSTR.gpiofrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioerst_offset = UInt32(4)
        static let gpioerst_mask = UInt32(0b1) &<< gpioerst_offset
        var gpioerst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.gpioerst_mask)) >> RCC.AHB1RSTR.gpioerst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.gpioerst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.gpioerst_offset) & RCC.AHB1RSTR.gpioerst_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiodrst_offset = UInt32(3)
        static let gpiodrst_mask = UInt32(0b1) &<< gpiodrst_offset
        var gpiodrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.gpiodrst_mask)) >> RCC.AHB1RSTR.gpiodrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.gpiodrst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.gpiodrst_offset) & RCC.AHB1RSTR.gpiodrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiocrst_offset = UInt32(2)
        static let gpiocrst_mask = UInt32(0b1) &<< gpiocrst_offset
        var gpiocrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.gpiocrst_mask)) >> RCC.AHB1RSTR.gpiocrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.gpiocrst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.gpiocrst_offset) & RCC.AHB1RSTR.gpiocrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiobrst_offset = UInt32(1)
        static let gpiobrst_mask = UInt32(0b1) &<< gpiobrst_offset
        var gpiobrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.gpiobrst_mask)) >> RCC.AHB1RSTR.gpiobrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.gpiobrst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.gpiobrst_offset) & RCC.AHB1RSTR.gpiobrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioarst_offset = UInt32(0)
        static let gpioarst_mask = UInt32(0b1) &<< gpioarst_offset
        var gpioarst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1RSTR.gpioarst_mask)) >> RCC.AHB1RSTR.gpioarst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1RSTR.gpioarst_mask
                let shift = (UInt32(newValue) << RCC.AHB1RSTR.gpioarst_offset) & RCC.AHB1RSTR.gpioarst_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct AHB2RSTR {
        var rawValue: UInt32

        static let otgfsrst_offset = UInt32(7)
        static let otgfsrst_mask = UInt32(0b1) &<< otgfsrst_offset
        var otgfsrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2RSTR.otgfsrst_mask)) >> RCC.AHB2RSTR.otgfsrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2RSTR.otgfsrst_mask
                let shift = (UInt32(newValue) << RCC.AHB2RSTR.otgfsrst_offset) & RCC.AHB2RSTR.otgfsrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let rngrst_offset = UInt32(6)
        static let rngrst_mask = UInt32(0b1) &<< rngrst_offset
        var rngrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2RSTR.rngrst_mask)) >> RCC.AHB2RSTR.rngrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2RSTR.rngrst_mask
                let shift = (UInt32(newValue) << RCC.AHB2RSTR.rngrst_offset) & RCC.AHB2RSTR.rngrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let hsahrst_offset = UInt32(5)
        static let hsahrst_mask = UInt32(0b1) &<< hsahrst_offset
        var hsahrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2RSTR.hsahrst_mask)) >> RCC.AHB2RSTR.hsahrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2RSTR.hsahrst_mask
                let shift = (UInt32(newValue) << RCC.AHB2RSTR.hsahrst_offset) & RCC.AHB2RSTR.hsahrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let cryprst_offset = UInt32(4)
        static let cryprst_mask = UInt32(0b1) &<< cryprst_offset
        var cryprst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2RSTR.cryprst_mask)) >> RCC.AHB2RSTR.cryprst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2RSTR.cryprst_mask
                let shift = (UInt32(newValue) << RCC.AHB2RSTR.cryprst_offset) & RCC.AHB2RSTR.cryprst_mask
                self.rawValue = preserve | shift
            }
        }

        static let dcmirst_offset = UInt32(0)
        static let dcmirst_mask = UInt32(0b1) &<< dcmirst_offset
        var dcmirst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2RSTR.dcmirst_mask)) >> RCC.AHB2RSTR.dcmirst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2RSTR.dcmirst_mask
                let shift = (UInt32(newValue) << RCC.AHB2RSTR.dcmirst_offset) & RCC.AHB2RSTR.dcmirst_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct AHB3RSTR {
        var rawValue: UInt32

        static let fmcrst_offset = UInt32(0)
        static let fmcrst_mask = UInt32(0b1) &<< fmcrst_offset
        var fmcrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB3RSTR.fmcrst_mask)) >> RCC.AHB3RSTR.fmcrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB3RSTR.fmcrst_mask
                let shift = (UInt32(newValue) << RCC.AHB3RSTR.fmcrst_offset) & RCC.AHB3RSTR.fmcrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let qspirst_offset = UInt32(1)
        static let qspirst_mask = UInt32(0b1) &<< qspirst_offset
        var qspirst: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB3RSTR.qspirst_mask)) >> RCC.AHB3RSTR.qspirst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB3RSTR.qspirst_mask
                let shift = (UInt32(newValue) << RCC.AHB3RSTR.qspirst_offset) & RCC.AHB3RSTR.qspirst_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct APB1RSTR {
        var rawValue: UInt32

        static let tim2rst_offset = UInt32(0)
        static let tim2rst_mask = UInt32(0b1) &<< tim2rst_offset
        var tim2rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.tim2rst_mask)) >> RCC.APB1RSTR.tim2rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.tim2rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.tim2rst_offset) & RCC.APB1RSTR.tim2rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim3rst_offset = UInt32(1)
        static let tim3rst_mask = UInt32(0b1) &<< tim3rst_offset
        var tim3rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.tim3rst_mask)) >> RCC.APB1RSTR.tim3rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.tim3rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.tim3rst_offset) & RCC.APB1RSTR.tim3rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim4rst_offset = UInt32(2)
        static let tim4rst_mask = UInt32(0b1) &<< tim4rst_offset
        var tim4rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.tim4rst_mask)) >> RCC.APB1RSTR.tim4rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.tim4rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.tim4rst_offset) & RCC.APB1RSTR.tim4rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim5rst_offset = UInt32(3)
        static let tim5rst_mask = UInt32(0b1) &<< tim5rst_offset
        var tim5rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.tim5rst_mask)) >> RCC.APB1RSTR.tim5rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.tim5rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.tim5rst_offset) & RCC.APB1RSTR.tim5rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim6rst_offset = UInt32(4)
        static let tim6rst_mask = UInt32(0b1) &<< tim6rst_offset
        var tim6rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.tim6rst_mask)) >> RCC.APB1RSTR.tim6rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.tim6rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.tim6rst_offset) & RCC.APB1RSTR.tim6rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim7rst_offset = UInt32(5)
        static let tim7rst_mask = UInt32(0b1) &<< tim7rst_offset
        var tim7rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.tim7rst_mask)) >> RCC.APB1RSTR.tim7rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.tim7rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.tim7rst_offset) & RCC.APB1RSTR.tim7rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim12rst_offset = UInt32(6)
        static let tim12rst_mask = UInt32(0b1) &<< tim12rst_offset
        var tim12rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.tim12rst_mask)) >> RCC.APB1RSTR.tim12rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.tim12rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.tim12rst_offset) & RCC.APB1RSTR.tim12rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim13rst_offset = UInt32(7)
        static let tim13rst_mask = UInt32(0b1) &<< tim13rst_offset
        var tim13rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.tim13rst_mask)) >> RCC.APB1RSTR.tim13rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.tim13rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.tim13rst_offset) & RCC.APB1RSTR.tim13rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim14rst_offset = UInt32(8)
        static let tim14rst_mask = UInt32(0b1) &<< tim14rst_offset
        var tim14rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.tim14rst_mask)) >> RCC.APB1RSTR.tim14rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.tim14rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.tim14rst_offset) & RCC.APB1RSTR.tim14rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let wwdgrst_offset = UInt32(11)
        static let wwdgrst_mask = UInt32(0b1) &<< wwdgrst_offset
        var wwdgrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.wwdgrst_mask)) >> RCC.APB1RSTR.wwdgrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.wwdgrst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.wwdgrst_offset) & RCC.APB1RSTR.wwdgrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi2rst_offset = UInt32(14)
        static let spi2rst_mask = UInt32(0b1) &<< spi2rst_offset
        var spi2rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.spi2rst_mask)) >> RCC.APB1RSTR.spi2rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.spi2rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.spi2rst_offset) & RCC.APB1RSTR.spi2rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi3rst_offset = UInt32(15)
        static let spi3rst_mask = UInt32(0b1) &<< spi3rst_offset
        var spi3rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.spi3rst_mask)) >> RCC.APB1RSTR.spi3rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.spi3rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.spi3rst_offset) & RCC.APB1RSTR.spi3rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart2rst_offset = UInt32(17)
        static let uart2rst_mask = UInt32(0b1) &<< uart2rst_offset
        var uart2rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.uart2rst_mask)) >> RCC.APB1RSTR.uart2rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.uart2rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.uart2rst_offset) & RCC.APB1RSTR.uart2rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart3rst_offset = UInt32(18)
        static let uart3rst_mask = UInt32(0b1) &<< uart3rst_offset
        var uart3rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.uart3rst_mask)) >> RCC.APB1RSTR.uart3rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.uart3rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.uart3rst_offset) & RCC.APB1RSTR.uart3rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart4rst_offset = UInt32(19)
        static let uart4rst_mask = UInt32(0b1) &<< uart4rst_offset
        var uart4rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.uart4rst_mask)) >> RCC.APB1RSTR.uart4rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.uart4rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.uart4rst_offset) & RCC.APB1RSTR.uart4rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart5rst_offset = UInt32(20)
        static let uart5rst_mask = UInt32(0b1) &<< uart5rst_offset
        var uart5rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.uart5rst_mask)) >> RCC.APB1RSTR.uart5rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.uart5rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.uart5rst_offset) & RCC.APB1RSTR.uart5rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c1rst_offset = UInt32(21)
        static let i2c1rst_mask = UInt32(0b1) &<< i2c1rst_offset
        var i2c1rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.i2c1rst_mask)) >> RCC.APB1RSTR.i2c1rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.i2c1rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.i2c1rst_offset) & RCC.APB1RSTR.i2c1rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c2rst_offset = UInt32(22)
        static let i2c2rst_mask = UInt32(0b1) &<< i2c2rst_offset
        var i2c2rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.i2c2rst_mask)) >> RCC.APB1RSTR.i2c2rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.i2c2rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.i2c2rst_offset) & RCC.APB1RSTR.i2c2rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c3rst_offset = UInt32(23)
        static let i2c3rst_mask = UInt32(0b1) &<< i2c3rst_offset
        var i2c3rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.i2c3rst_mask)) >> RCC.APB1RSTR.i2c3rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.i2c3rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.i2c3rst_offset) & RCC.APB1RSTR.i2c3rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let can1rst_offset = UInt32(25)
        static let can1rst_mask = UInt32(0b1) &<< can1rst_offset
        var can1rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.can1rst_mask)) >> RCC.APB1RSTR.can1rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.can1rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.can1rst_offset) & RCC.APB1RSTR.can1rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let can2rst_offset = UInt32(26)
        static let can2rst_mask = UInt32(0b1) &<< can2rst_offset
        var can2rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.can2rst_mask)) >> RCC.APB1RSTR.can2rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.can2rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.can2rst_offset) & RCC.APB1RSTR.can2rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let pwrrst_offset = UInt32(28)
        static let pwrrst_mask = UInt32(0b1) &<< pwrrst_offset
        var pwrrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.pwrrst_mask)) >> RCC.APB1RSTR.pwrrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.pwrrst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.pwrrst_offset) & RCC.APB1RSTR.pwrrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let dacrst_offset = UInt32(29)
        static let dacrst_mask = UInt32(0b1) &<< dacrst_offset
        var dacrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.dacrst_mask)) >> RCC.APB1RSTR.dacrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.dacrst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.dacrst_offset) & RCC.APB1RSTR.dacrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart7rst_offset = UInt32(30)
        static let uart7rst_mask = UInt32(0b1) &<< uart7rst_offset
        var uart7rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.uart7rst_mask)) >> RCC.APB1RSTR.uart7rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.uart7rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.uart7rst_offset) & RCC.APB1RSTR.uart7rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart8rst_offset = UInt32(31)
        static let uart8rst_mask = UInt32(0b1) &<< uart8rst_offset
        var uart8rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.uart8rst_mask)) >> RCC.APB1RSTR.uart8rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.uart8rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.uart8rst_offset) & RCC.APB1RSTR.uart8rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let spdifrxrst_offset = UInt32(16)
        static let spdifrxrst_mask = UInt32(0b1) &<< spdifrxrst_offset
        var spdifrxrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.spdifrxrst_mask)) >> RCC.APB1RSTR.spdifrxrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.spdifrxrst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.spdifrxrst_offset) & RCC.APB1RSTR.spdifrxrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let cecrst_offset = UInt32(27)
        static let cecrst_mask = UInt32(0b1) &<< cecrst_offset
        var cecrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.cecrst_mask)) >> RCC.APB1RSTR.cecrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.cecrst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.cecrst_offset) & RCC.APB1RSTR.cecrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let lptim1rst_offset = UInt32(9)
        static let lptim1rst_mask = UInt32(0b1) &<< lptim1rst_offset
        var lptim1rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.lptim1rst_mask)) >> RCC.APB1RSTR.lptim1rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.lptim1rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.lptim1rst_offset) & RCC.APB1RSTR.lptim1rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c4rst_offset = UInt32(24)
        static let i2c4rst_mask = UInt32(0b1) &<< i2c4rst_offset
        var i2c4rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1RSTR.i2c4rst_mask)) >> RCC.APB1RSTR.i2c4rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1RSTR.i2c4rst_mask
                let shift = (UInt32(newValue) << RCC.APB1RSTR.i2c4rst_offset) & RCC.APB1RSTR.i2c4rst_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct APB2RSTR {
        var rawValue: UInt32

        static let tim1rst_offset = UInt32(0)
        static let tim1rst_mask = UInt32(0b1) &<< tim1rst_offset
        var tim1rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.tim1rst_mask)) >> RCC.APB2RSTR.tim1rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.tim1rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.tim1rst_offset) & RCC.APB2RSTR.tim1rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim8rst_offset = UInt32(1)
        static let tim8rst_mask = UInt32(0b1) &<< tim8rst_offset
        var tim8rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.tim8rst_mask)) >> RCC.APB2RSTR.tim8rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.tim8rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.tim8rst_offset) & RCC.APB2RSTR.tim8rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let usart1rst_offset = UInt32(4)
        static let usart1rst_mask = UInt32(0b1) &<< usart1rst_offset
        var usart1rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.usart1rst_mask)) >> RCC.APB2RSTR.usart1rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.usart1rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.usart1rst_offset) & RCC.APB2RSTR.usart1rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let usart6rst_offset = UInt32(5)
        static let usart6rst_mask = UInt32(0b1) &<< usart6rst_offset
        var usart6rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.usart6rst_mask)) >> RCC.APB2RSTR.usart6rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.usart6rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.usart6rst_offset) & RCC.APB2RSTR.usart6rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let adcrst_offset = UInt32(8)
        static let adcrst_mask = UInt32(0b1) &<< adcrst_offset
        var adcrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.adcrst_mask)) >> RCC.APB2RSTR.adcrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.adcrst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.adcrst_offset) & RCC.APB2RSTR.adcrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi1rst_offset = UInt32(12)
        static let spi1rst_mask = UInt32(0b1) &<< spi1rst_offset
        var spi1rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.spi1rst_mask)) >> RCC.APB2RSTR.spi1rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.spi1rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.spi1rst_offset) & RCC.APB2RSTR.spi1rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi4rst_offset = UInt32(13)
        static let spi4rst_mask = UInt32(0b1) &<< spi4rst_offset
        var spi4rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.spi4rst_mask)) >> RCC.APB2RSTR.spi4rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.spi4rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.spi4rst_offset) & RCC.APB2RSTR.spi4rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let syscfgrst_offset = UInt32(14)
        static let syscfgrst_mask = UInt32(0b1) &<< syscfgrst_offset
        var syscfgrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.syscfgrst_mask)) >> RCC.APB2RSTR.syscfgrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.syscfgrst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.syscfgrst_offset) & RCC.APB2RSTR.syscfgrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim9rst_offset = UInt32(16)
        static let tim9rst_mask = UInt32(0b1) &<< tim9rst_offset
        var tim9rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.tim9rst_mask)) >> RCC.APB2RSTR.tim9rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.tim9rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.tim9rst_offset) & RCC.APB2RSTR.tim9rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim10rst_offset = UInt32(17)
        static let tim10rst_mask = UInt32(0b1) &<< tim10rst_offset
        var tim10rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.tim10rst_mask)) >> RCC.APB2RSTR.tim10rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.tim10rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.tim10rst_offset) & RCC.APB2RSTR.tim10rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim11rst_offset = UInt32(18)
        static let tim11rst_mask = UInt32(0b1) &<< tim11rst_offset
        var tim11rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.tim11rst_mask)) >> RCC.APB2RSTR.tim11rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.tim11rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.tim11rst_offset) & RCC.APB2RSTR.tim11rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi5rst_offset = UInt32(20)
        static let spi5rst_mask = UInt32(0b1) &<< spi5rst_offset
        var spi5rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.spi5rst_mask)) >> RCC.APB2RSTR.spi5rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.spi5rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.spi5rst_offset) & RCC.APB2RSTR.spi5rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi6rst_offset = UInt32(21)
        static let spi6rst_mask = UInt32(0b1) &<< spi6rst_offset
        var spi6rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.spi6rst_mask)) >> RCC.APB2RSTR.spi6rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.spi6rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.spi6rst_offset) & RCC.APB2RSTR.spi6rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let sai1rst_offset = UInt32(22)
        static let sai1rst_mask = UInt32(0b1) &<< sai1rst_offset
        var sai1rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.sai1rst_mask)) >> RCC.APB2RSTR.sai1rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.sai1rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.sai1rst_offset) & RCC.APB2RSTR.sai1rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let ltdcrst_offset = UInt32(26)
        static let ltdcrst_mask = UInt32(0b1) &<< ltdcrst_offset
        var ltdcrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.ltdcrst_mask)) >> RCC.APB2RSTR.ltdcrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.ltdcrst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.ltdcrst_offset) & RCC.APB2RSTR.ltdcrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let sai2rst_offset = UInt32(23)
        static let sai2rst_mask = UInt32(0b1) &<< sai2rst_offset
        var sai2rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.sai2rst_mask)) >> RCC.APB2RSTR.sai2rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.sai2rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.sai2rst_offset) & RCC.APB2RSTR.sai2rst_mask
                self.rawValue = preserve | shift
            }
        }

        static let sdmmc1rst_offset = UInt32(11)
        static let sdmmc1rst_mask = UInt32(0b1) &<< sdmmc1rst_offset
        var sdmmc1rst: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2RSTR.sdmmc1rst_mask)) >> RCC.APB2RSTR.sdmmc1rst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2RSTR.sdmmc1rst_mask
                let shift = (UInt32(newValue) << RCC.APB2RSTR.sdmmc1rst_offset) & RCC.APB2RSTR.sdmmc1rst_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct AHB1ENR {
        var rawValue: UInt32

        static let otghsulpien_offset = UInt32(30)
        static let otghsulpien_mask = UInt32(0b1) &<< otghsulpien_offset
        var otghsulpien: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.otghsulpien_mask)) >> RCC.AHB1ENR.otghsulpien_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.otghsulpien_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.otghsulpien_offset) & RCC.AHB1ENR.otghsulpien_mask
                self.rawValue = preserve | shift
            }
        }

        static let otghsen_offset = UInt32(29)
        static let otghsen_mask = UInt32(0b1) &<< otghsen_offset
        var otghsen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.otghsen_mask)) >> RCC.AHB1ENR.otghsen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.otghsen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.otghsen_offset) & RCC.AHB1ENR.otghsen_mask
                self.rawValue = preserve | shift
            }
        }

        static let ethmacptpen_offset = UInt32(28)
        static let ethmacptpen_mask = UInt32(0b1) &<< ethmacptpen_offset
        var ethmacptpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.ethmacptpen_mask)) >> RCC.AHB1ENR.ethmacptpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.ethmacptpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.ethmacptpen_offset) & RCC.AHB1ENR.ethmacptpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let ethmacrxen_offset = UInt32(27)
        static let ethmacrxen_mask = UInt32(0b1) &<< ethmacrxen_offset
        var ethmacrxen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.ethmacrxen_mask)) >> RCC.AHB1ENR.ethmacrxen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.ethmacrxen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.ethmacrxen_offset) & RCC.AHB1ENR.ethmacrxen_mask
                self.rawValue = preserve | shift
            }
        }

        static let ethmactxen_offset = UInt32(26)
        static let ethmactxen_mask = UInt32(0b1) &<< ethmactxen_offset
        var ethmactxen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.ethmactxen_mask)) >> RCC.AHB1ENR.ethmactxen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.ethmactxen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.ethmactxen_offset) & RCC.AHB1ENR.ethmactxen_mask
                self.rawValue = preserve | shift
            }
        }

        static let ethmacen_offset = UInt32(25)
        static let ethmacen_mask = UInt32(0b1) &<< ethmacen_offset
        var ethmacen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.ethmacen_mask)) >> RCC.AHB1ENR.ethmacen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.ethmacen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.ethmacen_offset) & RCC.AHB1ENR.ethmacen_mask
                self.rawValue = preserve | shift
            }
        }

        static let dma2den_offset = UInt32(23)
        static let dma2den_mask = UInt32(0b1) &<< dma2den_offset
        var dma2den: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.dma2den_mask)) >> RCC.AHB1ENR.dma2den_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.dma2den_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.dma2den_offset) & RCC.AHB1ENR.dma2den_mask
                self.rawValue = preserve | shift
            }
        }

        static let dma2en_offset = UInt32(22)
        static let dma2en_mask = UInt32(0b1) &<< dma2en_offset
        var dma2en: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.dma2en_mask)) >> RCC.AHB1ENR.dma2en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.dma2en_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.dma2en_offset) & RCC.AHB1ENR.dma2en_mask
                self.rawValue = preserve | shift
            }
        }

        static let dma1en_offset = UInt32(21)
        static let dma1en_mask = UInt32(0b1) &<< dma1en_offset
        var dma1en: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.dma1en_mask)) >> RCC.AHB1ENR.dma1en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.dma1en_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.dma1en_offset) & RCC.AHB1ENR.dma1en_mask
                self.rawValue = preserve | shift
            }
        }

        static let ccmdataramen_offset = UInt32(20)
        static let ccmdataramen_mask = UInt32(0b1) &<< ccmdataramen_offset
        var ccmdataramen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.ccmdataramen_mask)) >> RCC.AHB1ENR.ccmdataramen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.ccmdataramen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.ccmdataramen_offset) & RCC.AHB1ENR.ccmdataramen_mask
                self.rawValue = preserve | shift
            }
        }

        static let bkpsramen_offset = UInt32(18)
        static let bkpsramen_mask = UInt32(0b1) &<< bkpsramen_offset
        var bkpsramen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.bkpsramen_mask)) >> RCC.AHB1ENR.bkpsramen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.bkpsramen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.bkpsramen_offset) & RCC.AHB1ENR.bkpsramen_mask
                self.rawValue = preserve | shift
            }
        }

        static let crcen_offset = UInt32(12)
        static let crcen_mask = UInt32(0b1) &<< crcen_offset
        var crcen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.crcen_mask)) >> RCC.AHB1ENR.crcen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.crcen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.crcen_offset) & RCC.AHB1ENR.crcen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioken_offset = UInt32(10)
        static let gpioken_mask = UInt32(0b1) &<< gpioken_offset
        var gpioken: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.gpioken_mask)) >> RCC.AHB1ENR.gpioken_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.gpioken_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.gpioken_offset) & RCC.AHB1ENR.gpioken_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiojen_offset = UInt32(9)
        static let gpiojen_mask = UInt32(0b1) &<< gpiojen_offset
        var gpiojen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.gpiojen_mask)) >> RCC.AHB1ENR.gpiojen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.gpiojen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.gpiojen_offset) & RCC.AHB1ENR.gpiojen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioien_offset = UInt32(8)
        static let gpioien_mask = UInt32(0b1) &<< gpioien_offset
        var gpioien: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.gpioien_mask)) >> RCC.AHB1ENR.gpioien_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.gpioien_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.gpioien_offset) & RCC.AHB1ENR.gpioien_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiohen_offset = UInt32(7)
        static let gpiohen_mask = UInt32(0b1) &<< gpiohen_offset
        var gpiohen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.gpiohen_mask)) >> RCC.AHB1ENR.gpiohen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.gpiohen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.gpiohen_offset) & RCC.AHB1ENR.gpiohen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiogen_offset = UInt32(6)
        static let gpiogen_mask = UInt32(0b1) &<< gpiogen_offset
        var gpiogen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.gpiogen_mask)) >> RCC.AHB1ENR.gpiogen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.gpiogen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.gpiogen_offset) & RCC.AHB1ENR.gpiogen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiofen_offset = UInt32(5)
        static let gpiofen_mask = UInt32(0b1) &<< gpiofen_offset
        var gpiofen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.gpiofen_mask)) >> RCC.AHB1ENR.gpiofen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.gpiofen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.gpiofen_offset) & RCC.AHB1ENR.gpiofen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioeen_offset = UInt32(4)
        static let gpioeen_mask = UInt32(0b1) &<< gpioeen_offset
        var gpioeen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.gpioeen_mask)) >> RCC.AHB1ENR.gpioeen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.gpioeen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.gpioeen_offset) & RCC.AHB1ENR.gpioeen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioden_offset = UInt32(3)
        static let gpioden_mask = UInt32(0b1) &<< gpioden_offset
        var gpioden: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.gpioden_mask)) >> RCC.AHB1ENR.gpioden_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.gpioden_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.gpioden_offset) & RCC.AHB1ENR.gpioden_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiocen_offset = UInt32(2)
        static let gpiocen_mask = UInt32(0b1) &<< gpiocen_offset
        var gpiocen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.gpiocen_mask)) >> RCC.AHB1ENR.gpiocen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.gpiocen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.gpiocen_offset) & RCC.AHB1ENR.gpiocen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioben_offset = UInt32(1)
        static let gpioben_mask = UInt32(0b1) &<< gpioben_offset
        var gpioben: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.gpioben_mask)) >> RCC.AHB1ENR.gpioben_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.gpioben_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.gpioben_offset) & RCC.AHB1ENR.gpioben_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioaen_offset = UInt32(0)
        static let gpioaen_mask = UInt32(0b1) &<< gpioaen_offset
        var gpioaen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1ENR.gpioaen_mask)) >> RCC.AHB1ENR.gpioaen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1ENR.gpioaen_mask
                let shift = (UInt32(newValue) << RCC.AHB1ENR.gpioaen_offset) & RCC.AHB1ENR.gpioaen_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct AHB2ENR {
        var rawValue: UInt32

        static let otgfsen_offset = UInt32(7)
        static let otgfsen_mask = UInt32(0b1) &<< otgfsen_offset
        var otgfsen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2ENR.otgfsen_mask)) >> RCC.AHB2ENR.otgfsen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2ENR.otgfsen_mask
                let shift = (UInt32(newValue) << RCC.AHB2ENR.otgfsen_offset) & RCC.AHB2ENR.otgfsen_mask
                self.rawValue = preserve | shift
            }
        }

        static let rngen_offset = UInt32(6)
        static let rngen_mask = UInt32(0b1) &<< rngen_offset
        var rngen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2ENR.rngen_mask)) >> RCC.AHB2ENR.rngen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2ENR.rngen_mask
                let shift = (UInt32(newValue) << RCC.AHB2ENR.rngen_offset) & RCC.AHB2ENR.rngen_mask
                self.rawValue = preserve | shift
            }
        }

        static let hashen_offset = UInt32(5)
        static let hashen_mask = UInt32(0b1) &<< hashen_offset
        var hashen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2ENR.hashen_mask)) >> RCC.AHB2ENR.hashen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2ENR.hashen_mask
                let shift = (UInt32(newValue) << RCC.AHB2ENR.hashen_offset) & RCC.AHB2ENR.hashen_mask
                self.rawValue = preserve | shift
            }
        }

        static let crypen_offset = UInt32(4)
        static let crypen_mask = UInt32(0b1) &<< crypen_offset
        var crypen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2ENR.crypen_mask)) >> RCC.AHB2ENR.crypen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2ENR.crypen_mask
                let shift = (UInt32(newValue) << RCC.AHB2ENR.crypen_offset) & RCC.AHB2ENR.crypen_mask
                self.rawValue = preserve | shift
            }
        }

        static let dcmien_offset = UInt32(0)
        static let dcmien_mask = UInt32(0b1) &<< dcmien_offset
        var dcmien: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2ENR.dcmien_mask)) >> RCC.AHB2ENR.dcmien_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2ENR.dcmien_mask
                let shift = (UInt32(newValue) << RCC.AHB2ENR.dcmien_offset) & RCC.AHB2ENR.dcmien_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct AHB3ENR {
        var rawValue: UInt32

        static let fmcen_offset = UInt32(0)
        static let fmcen_mask = UInt32(0b1) &<< fmcen_offset
        var fmcen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB3ENR.fmcen_mask)) >> RCC.AHB3ENR.fmcen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB3ENR.fmcen_mask
                let shift = (UInt32(newValue) << RCC.AHB3ENR.fmcen_offset) & RCC.AHB3ENR.fmcen_mask
                self.rawValue = preserve | shift
            }
        }

        static let qspien_offset = UInt32(1)
        static let qspien_mask = UInt32(0b1) &<< qspien_offset
        var qspien: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB3ENR.qspien_mask)) >> RCC.AHB3ENR.qspien_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB3ENR.qspien_mask
                let shift = (UInt32(newValue) << RCC.AHB3ENR.qspien_offset) & RCC.AHB3ENR.qspien_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct APB1ENR {
        var rawValue: UInt32

        static let tim2en_offset = UInt32(0)
        static let tim2en_mask = UInt32(0b1) &<< tim2en_offset
        var tim2en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.tim2en_mask)) >> RCC.APB1ENR.tim2en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.tim2en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.tim2en_offset) & RCC.APB1ENR.tim2en_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim3en_offset = UInt32(1)
        static let tim3en_mask = UInt32(0b1) &<< tim3en_offset
        var tim3en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.tim3en_mask)) >> RCC.APB1ENR.tim3en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.tim3en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.tim3en_offset) & RCC.APB1ENR.tim3en_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim4en_offset = UInt32(2)
        static let tim4en_mask = UInt32(0b1) &<< tim4en_offset
        var tim4en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.tim4en_mask)) >> RCC.APB1ENR.tim4en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.tim4en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.tim4en_offset) & RCC.APB1ENR.tim4en_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim5en_offset = UInt32(3)
        static let tim5en_mask = UInt32(0b1) &<< tim5en_offset
        var tim5en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.tim5en_mask)) >> RCC.APB1ENR.tim5en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.tim5en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.tim5en_offset) & RCC.APB1ENR.tim5en_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim6en_offset = UInt32(4)
        static let tim6en_mask = UInt32(0b1) &<< tim6en_offset
        var tim6en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.tim6en_mask)) >> RCC.APB1ENR.tim6en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.tim6en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.tim6en_offset) & RCC.APB1ENR.tim6en_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim7en_offset = UInt32(5)
        static let tim7en_mask = UInt32(0b1) &<< tim7en_offset
        var tim7en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.tim7en_mask)) >> RCC.APB1ENR.tim7en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.tim7en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.tim7en_offset) & RCC.APB1ENR.tim7en_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim12en_offset = UInt32(6)
        static let tim12en_mask = UInt32(0b1) &<< tim12en_offset
        var tim12en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.tim12en_mask)) >> RCC.APB1ENR.tim12en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.tim12en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.tim12en_offset) & RCC.APB1ENR.tim12en_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim13en_offset = UInt32(7)
        static let tim13en_mask = UInt32(0b1) &<< tim13en_offset
        var tim13en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.tim13en_mask)) >> RCC.APB1ENR.tim13en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.tim13en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.tim13en_offset) & RCC.APB1ENR.tim13en_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim14en_offset = UInt32(8)
        static let tim14en_mask = UInt32(0b1) &<< tim14en_offset
        var tim14en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.tim14en_mask)) >> RCC.APB1ENR.tim14en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.tim14en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.tim14en_offset) & RCC.APB1ENR.tim14en_mask
                self.rawValue = preserve | shift
            }
        }

        static let wwdgen_offset = UInt32(11)
        static let wwdgen_mask = UInt32(0b1) &<< wwdgen_offset
        var wwdgen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.wwdgen_mask)) >> RCC.APB1ENR.wwdgen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.wwdgen_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.wwdgen_offset) & RCC.APB1ENR.wwdgen_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi2en_offset = UInt32(14)
        static let spi2en_mask = UInt32(0b1) &<< spi2en_offset
        var spi2en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.spi2en_mask)) >> RCC.APB1ENR.spi2en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.spi2en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.spi2en_offset) & RCC.APB1ENR.spi2en_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi3en_offset = UInt32(15)
        static let spi3en_mask = UInt32(0b1) &<< spi3en_offset
        var spi3en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.spi3en_mask)) >> RCC.APB1ENR.spi3en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.spi3en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.spi3en_offset) & RCC.APB1ENR.spi3en_mask
                self.rawValue = preserve | shift
            }
        }

        static let usart2en_offset = UInt32(17)
        static let usart2en_mask = UInt32(0b1) &<< usart2en_offset
        var usart2en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.usart2en_mask)) >> RCC.APB1ENR.usart2en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.usart2en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.usart2en_offset) & RCC.APB1ENR.usart2en_mask
                self.rawValue = preserve | shift
            }
        }

        static let usart3en_offset = UInt32(18)
        static let usart3en_mask = UInt32(0b1) &<< usart3en_offset
        var usart3en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.usart3en_mask)) >> RCC.APB1ENR.usart3en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.usart3en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.usart3en_offset) & RCC.APB1ENR.usart3en_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart4en_offset = UInt32(19)
        static let uart4en_mask = UInt32(0b1) &<< uart4en_offset
        var uart4en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.uart4en_mask)) >> RCC.APB1ENR.uart4en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.uart4en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.uart4en_offset) & RCC.APB1ENR.uart4en_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart5en_offset = UInt32(20)
        static let uart5en_mask = UInt32(0b1) &<< uart5en_offset
        var uart5en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.uart5en_mask)) >> RCC.APB1ENR.uart5en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.uart5en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.uart5en_offset) & RCC.APB1ENR.uart5en_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c1en_offset = UInt32(21)
        static let i2c1en_mask = UInt32(0b1) &<< i2c1en_offset
        var i2c1en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.i2c1en_mask)) >> RCC.APB1ENR.i2c1en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.i2c1en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.i2c1en_offset) & RCC.APB1ENR.i2c1en_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c2en_offset = UInt32(22)
        static let i2c2en_mask = UInt32(0b1) &<< i2c2en_offset
        var i2c2en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.i2c2en_mask)) >> RCC.APB1ENR.i2c2en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.i2c2en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.i2c2en_offset) & RCC.APB1ENR.i2c2en_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c3en_offset = UInt32(23)
        static let i2c3en_mask = UInt32(0b1) &<< i2c3en_offset
        var i2c3en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.i2c3en_mask)) >> RCC.APB1ENR.i2c3en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.i2c3en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.i2c3en_offset) & RCC.APB1ENR.i2c3en_mask
                self.rawValue = preserve | shift
            }
        }

        static let can1en_offset = UInt32(25)
        static let can1en_mask = UInt32(0b1) &<< can1en_offset
        var can1en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.can1en_mask)) >> RCC.APB1ENR.can1en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.can1en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.can1en_offset) & RCC.APB1ENR.can1en_mask
                self.rawValue = preserve | shift
            }
        }

        static let can2en_offset = UInt32(26)
        static let can2en_mask = UInt32(0b1) &<< can2en_offset
        var can2en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.can2en_mask)) >> RCC.APB1ENR.can2en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.can2en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.can2en_offset) & RCC.APB1ENR.can2en_mask
                self.rawValue = preserve | shift
            }
        }

        static let pwren_offset = UInt32(28)
        static let pwren_mask = UInt32(0b1) &<< pwren_offset
        var pwren: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.pwren_mask)) >> RCC.APB1ENR.pwren_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.pwren_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.pwren_offset) & RCC.APB1ENR.pwren_mask
                self.rawValue = preserve | shift
            }
        }

        static let dacen_offset = UInt32(29)
        static let dacen_mask = UInt32(0b1) &<< dacen_offset
        var dacen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.dacen_mask)) >> RCC.APB1ENR.dacen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.dacen_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.dacen_offset) & RCC.APB1ENR.dacen_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart7enr_offset = UInt32(30)
        static let uart7enr_mask = UInt32(0b1) &<< uart7enr_offset
        var uart7enr: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.uart7enr_mask)) >> RCC.APB1ENR.uart7enr_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.uart7enr_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.uart7enr_offset) & RCC.APB1ENR.uart7enr_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart8enr_offset = UInt32(31)
        static let uart8enr_mask = UInt32(0b1) &<< uart8enr_offset
        var uart8enr: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.uart8enr_mask)) >> RCC.APB1ENR.uart8enr_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.uart8enr_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.uart8enr_offset) & RCC.APB1ENR.uart8enr_mask
                self.rawValue = preserve | shift
            }
        }

        static let spdifrxen_offset = UInt32(16)
        static let spdifrxen_mask = UInt32(0b1) &<< spdifrxen_offset
        var spdifrxen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.spdifrxen_mask)) >> RCC.APB1ENR.spdifrxen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.spdifrxen_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.spdifrxen_offset) & RCC.APB1ENR.spdifrxen_mask
                self.rawValue = preserve | shift
            }
        }

        static let cecen_offset = UInt32(27)
        static let cecen_mask = UInt32(0b1) &<< cecen_offset
        var cecen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.cecen_mask)) >> RCC.APB1ENR.cecen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.cecen_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.cecen_offset) & RCC.APB1ENR.cecen_mask
                self.rawValue = preserve | shift
            }
        }

        static let lptmi1en_offset = UInt32(9)
        static let lptmi1en_mask = UInt32(0b1) &<< lptmi1en_offset
        var lptmi1en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.lptmi1en_mask)) >> RCC.APB1ENR.lptmi1en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.lptmi1en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.lptmi1en_offset) & RCC.APB1ENR.lptmi1en_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c4en_offset = UInt32(24)
        static let i2c4en_mask = UInt32(0b1) &<< i2c4en_offset
        var i2c4en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1ENR.i2c4en_mask)) >> RCC.APB1ENR.i2c4en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1ENR.i2c4en_mask
                let shift = (UInt32(newValue) << RCC.APB1ENR.i2c4en_offset) & RCC.APB1ENR.i2c4en_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct APB2ENR {
        var rawValue: UInt32

        static let tim1en_offset = UInt32(0)
        static let tim1en_mask = UInt32(0b1) &<< tim1en_offset
        var tim1en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.tim1en_mask)) >> RCC.APB2ENR.tim1en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.tim1en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.tim1en_offset) & RCC.APB2ENR.tim1en_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim8en_offset = UInt32(1)
        static let tim8en_mask = UInt32(0b1) &<< tim8en_offset
        var tim8en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.tim8en_mask)) >> RCC.APB2ENR.tim8en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.tim8en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.tim8en_offset) & RCC.APB2ENR.tim8en_mask
                self.rawValue = preserve | shift
            }
        }

        static let usart1en_offset = UInt32(4)
        static let usart1en_mask = UInt32(0b1) &<< usart1en_offset
        var usart1en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.usart1en_mask)) >> RCC.APB2ENR.usart1en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.usart1en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.usart1en_offset) & RCC.APB2ENR.usart1en_mask
                self.rawValue = preserve | shift
            }
        }

        static let usart6en_offset = UInt32(5)
        static let usart6en_mask = UInt32(0b1) &<< usart6en_offset
        var usart6en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.usart6en_mask)) >> RCC.APB2ENR.usart6en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.usart6en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.usart6en_offset) & RCC.APB2ENR.usart6en_mask
                self.rawValue = preserve | shift
            }
        }

        static let adc1en_offset = UInt32(8)
        static let adc1en_mask = UInt32(0b1) &<< adc1en_offset
        var adc1en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.adc1en_mask)) >> RCC.APB2ENR.adc1en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.adc1en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.adc1en_offset) & RCC.APB2ENR.adc1en_mask
                self.rawValue = preserve | shift
            }
        }

        static let adc2en_offset = UInt32(9)
        static let adc2en_mask = UInt32(0b1) &<< adc2en_offset
        var adc2en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.adc2en_mask)) >> RCC.APB2ENR.adc2en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.adc2en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.adc2en_offset) & RCC.APB2ENR.adc2en_mask
                self.rawValue = preserve | shift
            }
        }

        static let adc3en_offset = UInt32(10)
        static let adc3en_mask = UInt32(0b1) &<< adc3en_offset
        var adc3en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.adc3en_mask)) >> RCC.APB2ENR.adc3en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.adc3en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.adc3en_offset) & RCC.APB2ENR.adc3en_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi1en_offset = UInt32(12)
        static let spi1en_mask = UInt32(0b1) &<< spi1en_offset
        var spi1en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.spi1en_mask)) >> RCC.APB2ENR.spi1en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.spi1en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.spi1en_offset) & RCC.APB2ENR.spi1en_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi4enr_offset = UInt32(13)
        static let spi4enr_mask = UInt32(0b1) &<< spi4enr_offset
        var spi4enr: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.spi4enr_mask)) >> RCC.APB2ENR.spi4enr_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.spi4enr_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.spi4enr_offset) & RCC.APB2ENR.spi4enr_mask
                self.rawValue = preserve | shift
            }
        }

        static let syscfgen_offset = UInt32(14)
        static let syscfgen_mask = UInt32(0b1) &<< syscfgen_offset
        var syscfgen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.syscfgen_mask)) >> RCC.APB2ENR.syscfgen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.syscfgen_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.syscfgen_offset) & RCC.APB2ENR.syscfgen_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim9en_offset = UInt32(16)
        static let tim9en_mask = UInt32(0b1) &<< tim9en_offset
        var tim9en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.tim9en_mask)) >> RCC.APB2ENR.tim9en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.tim9en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.tim9en_offset) & RCC.APB2ENR.tim9en_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim10en_offset = UInt32(17)
        static let tim10en_mask = UInt32(0b1) &<< tim10en_offset
        var tim10en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.tim10en_mask)) >> RCC.APB2ENR.tim10en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.tim10en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.tim10en_offset) & RCC.APB2ENR.tim10en_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim11en_offset = UInt32(18)
        static let tim11en_mask = UInt32(0b1) &<< tim11en_offset
        var tim11en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.tim11en_mask)) >> RCC.APB2ENR.tim11en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.tim11en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.tim11en_offset) & RCC.APB2ENR.tim11en_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi5enr_offset = UInt32(20)
        static let spi5enr_mask = UInt32(0b1) &<< spi5enr_offset
        var spi5enr: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.spi5enr_mask)) >> RCC.APB2ENR.spi5enr_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.spi5enr_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.spi5enr_offset) & RCC.APB2ENR.spi5enr_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi6enr_offset = UInt32(21)
        static let spi6enr_mask = UInt32(0b1) &<< spi6enr_offset
        var spi6enr: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.spi6enr_mask)) >> RCC.APB2ENR.spi6enr_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.spi6enr_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.spi6enr_offset) & RCC.APB2ENR.spi6enr_mask
                self.rawValue = preserve | shift
            }
        }

        static let sai1en_offset = UInt32(22)
        static let sai1en_mask = UInt32(0b1) &<< sai1en_offset
        var sai1en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.sai1en_mask)) >> RCC.APB2ENR.sai1en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.sai1en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.sai1en_offset) & RCC.APB2ENR.sai1en_mask
                self.rawValue = preserve | shift
            }
        }

        static let ltdcen_offset = UInt32(26)
        static let ltdcen_mask = UInt32(0b1) &<< ltdcen_offset
        var ltdcen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.ltdcen_mask)) >> RCC.APB2ENR.ltdcen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.ltdcen_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.ltdcen_offset) & RCC.APB2ENR.ltdcen_mask
                self.rawValue = preserve | shift
            }
        }

        static let sai2en_offset = UInt32(23)
        static let sai2en_mask = UInt32(0b1) &<< sai2en_offset
        var sai2en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.sai2en_mask)) >> RCC.APB2ENR.sai2en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.sai2en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.sai2en_offset) & RCC.APB2ENR.sai2en_mask
                self.rawValue = preserve | shift
            }
        }

        static let sdmmc1en_offset = UInt32(11)
        static let sdmmc1en_mask = UInt32(0b1) &<< sdmmc1en_offset
        var sdmmc1en: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2ENR.sdmmc1en_mask)) >> RCC.APB2ENR.sdmmc1en_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2ENR.sdmmc1en_mask
                let shift = (UInt32(newValue) << RCC.APB2ENR.sdmmc1en_offset) & RCC.APB2ENR.sdmmc1en_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct AHB1LPENR {
        var rawValue: UInt32

        static let gpioalpen_offset = UInt32(0)
        static let gpioalpen_mask = UInt32(0b1) &<< gpioalpen_offset
        var gpioalpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.gpioalpen_mask)) >> RCC.AHB1LPENR.gpioalpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.gpioalpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.gpioalpen_offset) & RCC.AHB1LPENR.gpioalpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioblpen_offset = UInt32(1)
        static let gpioblpen_mask = UInt32(0b1) &<< gpioblpen_offset
        var gpioblpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.gpioblpen_mask)) >> RCC.AHB1LPENR.gpioblpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.gpioblpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.gpioblpen_offset) & RCC.AHB1LPENR.gpioblpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioclpen_offset = UInt32(2)
        static let gpioclpen_mask = UInt32(0b1) &<< gpioclpen_offset
        var gpioclpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.gpioclpen_mask)) >> RCC.AHB1LPENR.gpioclpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.gpioclpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.gpioclpen_offset) & RCC.AHB1LPENR.gpioclpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiodlpen_offset = UInt32(3)
        static let gpiodlpen_mask = UInt32(0b1) &<< gpiodlpen_offset
        var gpiodlpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.gpiodlpen_mask)) >> RCC.AHB1LPENR.gpiodlpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.gpiodlpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.gpiodlpen_offset) & RCC.AHB1LPENR.gpiodlpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioelpen_offset = UInt32(4)
        static let gpioelpen_mask = UInt32(0b1) &<< gpioelpen_offset
        var gpioelpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.gpioelpen_mask)) >> RCC.AHB1LPENR.gpioelpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.gpioelpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.gpioelpen_offset) & RCC.AHB1LPENR.gpioelpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioflpen_offset = UInt32(5)
        static let gpioflpen_mask = UInt32(0b1) &<< gpioflpen_offset
        var gpioflpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.gpioflpen_mask)) >> RCC.AHB1LPENR.gpioflpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.gpioflpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.gpioflpen_offset) & RCC.AHB1LPENR.gpioflpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioglpen_offset = UInt32(6)
        static let gpioglpen_mask = UInt32(0b1) &<< gpioglpen_offset
        var gpioglpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.gpioglpen_mask)) >> RCC.AHB1LPENR.gpioglpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.gpioglpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.gpioglpen_offset) & RCC.AHB1LPENR.gpioglpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiohlpen_offset = UInt32(7)
        static let gpiohlpen_mask = UInt32(0b1) &<< gpiohlpen_offset
        var gpiohlpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.gpiohlpen_mask)) >> RCC.AHB1LPENR.gpiohlpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.gpiohlpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.gpiohlpen_offset) & RCC.AHB1LPENR.gpiohlpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioilpen_offset = UInt32(8)
        static let gpioilpen_mask = UInt32(0b1) &<< gpioilpen_offset
        var gpioilpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.gpioilpen_mask)) >> RCC.AHB1LPENR.gpioilpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.gpioilpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.gpioilpen_offset) & RCC.AHB1LPENR.gpioilpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpiojlpen_offset = UInt32(9)
        static let gpiojlpen_mask = UInt32(0b1) &<< gpiojlpen_offset
        var gpiojlpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.gpiojlpen_mask)) >> RCC.AHB1LPENR.gpiojlpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.gpiojlpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.gpiojlpen_offset) & RCC.AHB1LPENR.gpiojlpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let gpioklpen_offset = UInt32(10)
        static let gpioklpen_mask = UInt32(0b1) &<< gpioklpen_offset
        var gpioklpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.gpioklpen_mask)) >> RCC.AHB1LPENR.gpioklpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.gpioklpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.gpioklpen_offset) & RCC.AHB1LPENR.gpioklpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let crclpen_offset = UInt32(12)
        static let crclpen_mask = UInt32(0b1) &<< crclpen_offset
        var crclpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.crclpen_mask)) >> RCC.AHB1LPENR.crclpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.crclpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.crclpen_offset) & RCC.AHB1LPENR.crclpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let flitflpen_offset = UInt32(15)
        static let flitflpen_mask = UInt32(0b1) &<< flitflpen_offset
        var flitflpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.flitflpen_mask)) >> RCC.AHB1LPENR.flitflpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.flitflpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.flitflpen_offset) & RCC.AHB1LPENR.flitflpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let sram1lpen_offset = UInt32(16)
        static let sram1lpen_mask = UInt32(0b1) &<< sram1lpen_offset
        var sram1lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.sram1lpen_mask)) >> RCC.AHB1LPENR.sram1lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.sram1lpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.sram1lpen_offset) & RCC.AHB1LPENR.sram1lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let sram2lpen_offset = UInt32(17)
        static let sram2lpen_mask = UInt32(0b1) &<< sram2lpen_offset
        var sram2lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.sram2lpen_mask)) >> RCC.AHB1LPENR.sram2lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.sram2lpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.sram2lpen_offset) & RCC.AHB1LPENR.sram2lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let bkpsramlpen_offset = UInt32(18)
        static let bkpsramlpen_mask = UInt32(0b1) &<< bkpsramlpen_offset
        var bkpsramlpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.bkpsramlpen_mask)) >> RCC.AHB1LPENR.bkpsramlpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.bkpsramlpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.bkpsramlpen_offset) & RCC.AHB1LPENR.bkpsramlpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let sram3lpen_offset = UInt32(19)
        static let sram3lpen_mask = UInt32(0b1) &<< sram3lpen_offset
        var sram3lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.sram3lpen_mask)) >> RCC.AHB1LPENR.sram3lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.sram3lpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.sram3lpen_offset) & RCC.AHB1LPENR.sram3lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let dma1lpen_offset = UInt32(21)
        static let dma1lpen_mask = UInt32(0b1) &<< dma1lpen_offset
        var dma1lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.dma1lpen_mask)) >> RCC.AHB1LPENR.dma1lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.dma1lpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.dma1lpen_offset) & RCC.AHB1LPENR.dma1lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let dma2lpen_offset = UInt32(22)
        static let dma2lpen_mask = UInt32(0b1) &<< dma2lpen_offset
        var dma2lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.dma2lpen_mask)) >> RCC.AHB1LPENR.dma2lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.dma2lpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.dma2lpen_offset) & RCC.AHB1LPENR.dma2lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let dma2dlpen_offset = UInt32(23)
        static let dma2dlpen_mask = UInt32(0b1) &<< dma2dlpen_offset
        var dma2dlpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.dma2dlpen_mask)) >> RCC.AHB1LPENR.dma2dlpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.dma2dlpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.dma2dlpen_offset) & RCC.AHB1LPENR.dma2dlpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let ethmaclpen_offset = UInt32(25)
        static let ethmaclpen_mask = UInt32(0b1) &<< ethmaclpen_offset
        var ethmaclpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.ethmaclpen_mask)) >> RCC.AHB1LPENR.ethmaclpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.ethmaclpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.ethmaclpen_offset) & RCC.AHB1LPENR.ethmaclpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let ethmactxlpen_offset = UInt32(26)
        static let ethmactxlpen_mask = UInt32(0b1) &<< ethmactxlpen_offset
        var ethmactxlpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.ethmactxlpen_mask)) >> RCC.AHB1LPENR.ethmactxlpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.ethmactxlpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.ethmactxlpen_offset) & RCC.AHB1LPENR.ethmactxlpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let ethmacrxlpen_offset = UInt32(27)
        static let ethmacrxlpen_mask = UInt32(0b1) &<< ethmacrxlpen_offset
        var ethmacrxlpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.ethmacrxlpen_mask)) >> RCC.AHB1LPENR.ethmacrxlpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.ethmacrxlpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.ethmacrxlpen_offset) & RCC.AHB1LPENR.ethmacrxlpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let ethmacptplpen_offset = UInt32(28)
        static let ethmacptplpen_mask = UInt32(0b1) &<< ethmacptplpen_offset
        var ethmacptplpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.ethmacptplpen_mask)) >> RCC.AHB1LPENR.ethmacptplpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.ethmacptplpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.ethmacptplpen_offset) & RCC.AHB1LPENR.ethmacptplpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let otghslpen_offset = UInt32(29)
        static let otghslpen_mask = UInt32(0b1) &<< otghslpen_offset
        var otghslpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.otghslpen_mask)) >> RCC.AHB1LPENR.otghslpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.otghslpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.otghslpen_offset) & RCC.AHB1LPENR.otghslpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let otghsulpilpen_offset = UInt32(30)
        static let otghsulpilpen_mask = UInt32(0b1) &<< otghsulpilpen_offset
        var otghsulpilpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB1LPENR.otghsulpilpen_mask)) >> RCC.AHB1LPENR.otghsulpilpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB1LPENR.otghsulpilpen_mask
                let shift = (UInt32(newValue) << RCC.AHB1LPENR.otghsulpilpen_offset) & RCC.AHB1LPENR.otghsulpilpen_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct AHB2LPENR {
        var rawValue: UInt32

        static let otgfslpen_offset = UInt32(7)
        static let otgfslpen_mask = UInt32(0b1) &<< otgfslpen_offset
        var otgfslpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2LPENR.otgfslpen_mask)) >> RCC.AHB2LPENR.otgfslpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2LPENR.otgfslpen_mask
                let shift = (UInt32(newValue) << RCC.AHB2LPENR.otgfslpen_offset) & RCC.AHB2LPENR.otgfslpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let rnglpen_offset = UInt32(6)
        static let rnglpen_mask = UInt32(0b1) &<< rnglpen_offset
        var rnglpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2LPENR.rnglpen_mask)) >> RCC.AHB2LPENR.rnglpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2LPENR.rnglpen_mask
                let shift = (UInt32(newValue) << RCC.AHB2LPENR.rnglpen_offset) & RCC.AHB2LPENR.rnglpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let hashlpen_offset = UInt32(5)
        static let hashlpen_mask = UInt32(0b1) &<< hashlpen_offset
        var hashlpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2LPENR.hashlpen_mask)) >> RCC.AHB2LPENR.hashlpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2LPENR.hashlpen_mask
                let shift = (UInt32(newValue) << RCC.AHB2LPENR.hashlpen_offset) & RCC.AHB2LPENR.hashlpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let cryplpen_offset = UInt32(4)
        static let cryplpen_mask = UInt32(0b1) &<< cryplpen_offset
        var cryplpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2LPENR.cryplpen_mask)) >> RCC.AHB2LPENR.cryplpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2LPENR.cryplpen_mask
                let shift = (UInt32(newValue) << RCC.AHB2LPENR.cryplpen_offset) & RCC.AHB2LPENR.cryplpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let dcmilpen_offset = UInt32(0)
        static let dcmilpen_mask = UInt32(0b1) &<< dcmilpen_offset
        var dcmilpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB2LPENR.dcmilpen_mask)) >> RCC.AHB2LPENR.dcmilpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB2LPENR.dcmilpen_mask
                let shift = (UInt32(newValue) << RCC.AHB2LPENR.dcmilpen_offset) & RCC.AHB2LPENR.dcmilpen_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct AHB3LPENR {
        var rawValue: UInt32

        static let fmclpen_offset = UInt32(0)
        static let fmclpen_mask = UInt32(0b1) &<< fmclpen_offset
        var fmclpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB3LPENR.fmclpen_mask)) >> RCC.AHB3LPENR.fmclpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB3LPENR.fmclpen_mask
                let shift = (UInt32(newValue) << RCC.AHB3LPENR.fmclpen_offset) & RCC.AHB3LPENR.fmclpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let qspilpen_offset = UInt32(1)
        static let qspilpen_mask = UInt32(0b1) &<< qspilpen_offset
        var qspilpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.AHB3LPENR.qspilpen_mask)) >> RCC.AHB3LPENR.qspilpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.AHB3LPENR.qspilpen_mask
                let shift = (UInt32(newValue) << RCC.AHB3LPENR.qspilpen_offset) & RCC.AHB3LPENR.qspilpen_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct APB1LPENR {
        var rawValue: UInt32

        static let tim2lpen_offset = UInt32(0)
        static let tim2lpen_mask = UInt32(0b1) &<< tim2lpen_offset
        var tim2lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.tim2lpen_mask)) >> RCC.APB1LPENR.tim2lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.tim2lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.tim2lpen_offset) & RCC.APB1LPENR.tim2lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim3lpen_offset = UInt32(1)
        static let tim3lpen_mask = UInt32(0b1) &<< tim3lpen_offset
        var tim3lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.tim3lpen_mask)) >> RCC.APB1LPENR.tim3lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.tim3lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.tim3lpen_offset) & RCC.APB1LPENR.tim3lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim4lpen_offset = UInt32(2)
        static let tim4lpen_mask = UInt32(0b1) &<< tim4lpen_offset
        var tim4lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.tim4lpen_mask)) >> RCC.APB1LPENR.tim4lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.tim4lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.tim4lpen_offset) & RCC.APB1LPENR.tim4lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim5lpen_offset = UInt32(3)
        static let tim5lpen_mask = UInt32(0b1) &<< tim5lpen_offset
        var tim5lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.tim5lpen_mask)) >> RCC.APB1LPENR.tim5lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.tim5lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.tim5lpen_offset) & RCC.APB1LPENR.tim5lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim6lpen_offset = UInt32(4)
        static let tim6lpen_mask = UInt32(0b1) &<< tim6lpen_offset
        var tim6lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.tim6lpen_mask)) >> RCC.APB1LPENR.tim6lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.tim6lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.tim6lpen_offset) & RCC.APB1LPENR.tim6lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim7lpen_offset = UInt32(5)
        static let tim7lpen_mask = UInt32(0b1) &<< tim7lpen_offset
        var tim7lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.tim7lpen_mask)) >> RCC.APB1LPENR.tim7lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.tim7lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.tim7lpen_offset) & RCC.APB1LPENR.tim7lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim12lpen_offset = UInt32(6)
        static let tim12lpen_mask = UInt32(0b1) &<< tim12lpen_offset
        var tim12lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.tim12lpen_mask)) >> RCC.APB1LPENR.tim12lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.tim12lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.tim12lpen_offset) & RCC.APB1LPENR.tim12lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim13lpen_offset = UInt32(7)
        static let tim13lpen_mask = UInt32(0b1) &<< tim13lpen_offset
        var tim13lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.tim13lpen_mask)) >> RCC.APB1LPENR.tim13lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.tim13lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.tim13lpen_offset) & RCC.APB1LPENR.tim13lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim14lpen_offset = UInt32(8)
        static let tim14lpen_mask = UInt32(0b1) &<< tim14lpen_offset
        var tim14lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.tim14lpen_mask)) >> RCC.APB1LPENR.tim14lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.tim14lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.tim14lpen_offset) & RCC.APB1LPENR.tim14lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let wwdglpen_offset = UInt32(11)
        static let wwdglpen_mask = UInt32(0b1) &<< wwdglpen_offset
        var wwdglpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.wwdglpen_mask)) >> RCC.APB1LPENR.wwdglpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.wwdglpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.wwdglpen_offset) & RCC.APB1LPENR.wwdglpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi2lpen_offset = UInt32(14)
        static let spi2lpen_mask = UInt32(0b1) &<< spi2lpen_offset
        var spi2lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.spi2lpen_mask)) >> RCC.APB1LPENR.spi2lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.spi2lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.spi2lpen_offset) & RCC.APB1LPENR.spi2lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi3lpen_offset = UInt32(15)
        static let spi3lpen_mask = UInt32(0b1) &<< spi3lpen_offset
        var spi3lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.spi3lpen_mask)) >> RCC.APB1LPENR.spi3lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.spi3lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.spi3lpen_offset) & RCC.APB1LPENR.spi3lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let usart2lpen_offset = UInt32(17)
        static let usart2lpen_mask = UInt32(0b1) &<< usart2lpen_offset
        var usart2lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.usart2lpen_mask)) >> RCC.APB1LPENR.usart2lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.usart2lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.usart2lpen_offset) & RCC.APB1LPENR.usart2lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let usart3lpen_offset = UInt32(18)
        static let usart3lpen_mask = UInt32(0b1) &<< usart3lpen_offset
        var usart3lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.usart3lpen_mask)) >> RCC.APB1LPENR.usart3lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.usart3lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.usart3lpen_offset) & RCC.APB1LPENR.usart3lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart4lpen_offset = UInt32(19)
        static let uart4lpen_mask = UInt32(0b1) &<< uart4lpen_offset
        var uart4lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.uart4lpen_mask)) >> RCC.APB1LPENR.uart4lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.uart4lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.uart4lpen_offset) & RCC.APB1LPENR.uart4lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart5lpen_offset = UInt32(20)
        static let uart5lpen_mask = UInt32(0b1) &<< uart5lpen_offset
        var uart5lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.uart5lpen_mask)) >> RCC.APB1LPENR.uart5lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.uart5lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.uart5lpen_offset) & RCC.APB1LPENR.uart5lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c1lpen_offset = UInt32(21)
        static let i2c1lpen_mask = UInt32(0b1) &<< i2c1lpen_offset
        var i2c1lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.i2c1lpen_mask)) >> RCC.APB1LPENR.i2c1lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.i2c1lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.i2c1lpen_offset) & RCC.APB1LPENR.i2c1lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c2lpen_offset = UInt32(22)
        static let i2c2lpen_mask = UInt32(0b1) &<< i2c2lpen_offset
        var i2c2lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.i2c2lpen_mask)) >> RCC.APB1LPENR.i2c2lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.i2c2lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.i2c2lpen_offset) & RCC.APB1LPENR.i2c2lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c3lpen_offset = UInt32(23)
        static let i2c3lpen_mask = UInt32(0b1) &<< i2c3lpen_offset
        var i2c3lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.i2c3lpen_mask)) >> RCC.APB1LPENR.i2c3lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.i2c3lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.i2c3lpen_offset) & RCC.APB1LPENR.i2c3lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let can1lpen_offset = UInt32(25)
        static let can1lpen_mask = UInt32(0b1) &<< can1lpen_offset
        var can1lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.can1lpen_mask)) >> RCC.APB1LPENR.can1lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.can1lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.can1lpen_offset) & RCC.APB1LPENR.can1lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let can2lpen_offset = UInt32(26)
        static let can2lpen_mask = UInt32(0b1) &<< can2lpen_offset
        var can2lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.can2lpen_mask)) >> RCC.APB1LPENR.can2lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.can2lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.can2lpen_offset) & RCC.APB1LPENR.can2lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let pwrlpen_offset = UInt32(28)
        static let pwrlpen_mask = UInt32(0b1) &<< pwrlpen_offset
        var pwrlpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.pwrlpen_mask)) >> RCC.APB1LPENR.pwrlpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.pwrlpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.pwrlpen_offset) & RCC.APB1LPENR.pwrlpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let daclpen_offset = UInt32(29)
        static let daclpen_mask = UInt32(0b1) &<< daclpen_offset
        var daclpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.daclpen_mask)) >> RCC.APB1LPENR.daclpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.daclpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.daclpen_offset) & RCC.APB1LPENR.daclpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart7lpen_offset = UInt32(30)
        static let uart7lpen_mask = UInt32(0b1) &<< uart7lpen_offset
        var uart7lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.uart7lpen_mask)) >> RCC.APB1LPENR.uart7lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.uart7lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.uart7lpen_offset) & RCC.APB1LPENR.uart7lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart8lpen_offset = UInt32(31)
        static let uart8lpen_mask = UInt32(0b1) &<< uart8lpen_offset
        var uart8lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.uart8lpen_mask)) >> RCC.APB1LPENR.uart8lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.uart8lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.uart8lpen_offset) & RCC.APB1LPENR.uart8lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let spdifrxlpen_offset = UInt32(16)
        static let spdifrxlpen_mask = UInt32(0b1) &<< spdifrxlpen_offset
        var spdifrxlpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.spdifrxlpen_mask)) >> RCC.APB1LPENR.spdifrxlpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.spdifrxlpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.spdifrxlpen_offset) & RCC.APB1LPENR.spdifrxlpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let ceclpen_offset = UInt32(27)
        static let ceclpen_mask = UInt32(0b1) &<< ceclpen_offset
        var ceclpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.ceclpen_mask)) >> RCC.APB1LPENR.ceclpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.ceclpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.ceclpen_offset) & RCC.APB1LPENR.ceclpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let lptim1lpen_offset = UInt32(9)
        static let lptim1lpen_mask = UInt32(0b1) &<< lptim1lpen_offset
        var lptim1lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.lptim1lpen_mask)) >> RCC.APB1LPENR.lptim1lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.lptim1lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.lptim1lpen_offset) & RCC.APB1LPENR.lptim1lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c4lpen_offset = UInt32(24)
        static let i2c4lpen_mask = UInt32(0b1) &<< i2c4lpen_offset
        var i2c4lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB1LPENR.i2c4lpen_mask)) >> RCC.APB1LPENR.i2c4lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB1LPENR.i2c4lpen_mask
                let shift = (UInt32(newValue) << RCC.APB1LPENR.i2c4lpen_offset) & RCC.APB1LPENR.i2c4lpen_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct APB2LPENR {
        var rawValue: UInt32

        static let tim1lpen_offset = UInt32(0)
        static let tim1lpen_mask = UInt32(0b1) &<< tim1lpen_offset
        var tim1lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.tim1lpen_mask)) >> RCC.APB2LPENR.tim1lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.tim1lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.tim1lpen_offset) & RCC.APB2LPENR.tim1lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim8lpen_offset = UInt32(1)
        static let tim8lpen_mask = UInt32(0b1) &<< tim8lpen_offset
        var tim8lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.tim8lpen_mask)) >> RCC.APB2LPENR.tim8lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.tim8lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.tim8lpen_offset) & RCC.APB2LPENR.tim8lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let usart1lpen_offset = UInt32(4)
        static let usart1lpen_mask = UInt32(0b1) &<< usart1lpen_offset
        var usart1lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.usart1lpen_mask)) >> RCC.APB2LPENR.usart1lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.usart1lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.usart1lpen_offset) & RCC.APB2LPENR.usart1lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let usart6lpen_offset = UInt32(5)
        static let usart6lpen_mask = UInt32(0b1) &<< usart6lpen_offset
        var usart6lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.usart6lpen_mask)) >> RCC.APB2LPENR.usart6lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.usart6lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.usart6lpen_offset) & RCC.APB2LPENR.usart6lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let adc1lpen_offset = UInt32(8)
        static let adc1lpen_mask = UInt32(0b1) &<< adc1lpen_offset
        var adc1lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.adc1lpen_mask)) >> RCC.APB2LPENR.adc1lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.adc1lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.adc1lpen_offset) & RCC.APB2LPENR.adc1lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let adc2lpen_offset = UInt32(9)
        static let adc2lpen_mask = UInt32(0b1) &<< adc2lpen_offset
        var adc2lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.adc2lpen_mask)) >> RCC.APB2LPENR.adc2lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.adc2lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.adc2lpen_offset) & RCC.APB2LPENR.adc2lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let adc3lpen_offset = UInt32(10)
        static let adc3lpen_mask = UInt32(0b1) &<< adc3lpen_offset
        var adc3lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.adc3lpen_mask)) >> RCC.APB2LPENR.adc3lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.adc3lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.adc3lpen_offset) & RCC.APB2LPENR.adc3lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi1lpen_offset = UInt32(12)
        static let spi1lpen_mask = UInt32(0b1) &<< spi1lpen_offset
        var spi1lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.spi1lpen_mask)) >> RCC.APB2LPENR.spi1lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.spi1lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.spi1lpen_offset) & RCC.APB2LPENR.spi1lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi4lpen_offset = UInt32(13)
        static let spi4lpen_mask = UInt32(0b1) &<< spi4lpen_offset
        var spi4lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.spi4lpen_mask)) >> RCC.APB2LPENR.spi4lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.spi4lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.spi4lpen_offset) & RCC.APB2LPENR.spi4lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let syscfglpen_offset = UInt32(14)
        static let syscfglpen_mask = UInt32(0b1) &<< syscfglpen_offset
        var syscfglpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.syscfglpen_mask)) >> RCC.APB2LPENR.syscfglpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.syscfglpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.syscfglpen_offset) & RCC.APB2LPENR.syscfglpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim9lpen_offset = UInt32(16)
        static let tim9lpen_mask = UInt32(0b1) &<< tim9lpen_offset
        var tim9lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.tim9lpen_mask)) >> RCC.APB2LPENR.tim9lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.tim9lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.tim9lpen_offset) & RCC.APB2LPENR.tim9lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim10lpen_offset = UInt32(17)
        static let tim10lpen_mask = UInt32(0b1) &<< tim10lpen_offset
        var tim10lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.tim10lpen_mask)) >> RCC.APB2LPENR.tim10lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.tim10lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.tim10lpen_offset) & RCC.APB2LPENR.tim10lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let tim11lpen_offset = UInt32(18)
        static let tim11lpen_mask = UInt32(0b1) &<< tim11lpen_offset
        var tim11lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.tim11lpen_mask)) >> RCC.APB2LPENR.tim11lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.tim11lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.tim11lpen_offset) & RCC.APB2LPENR.tim11lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi5lpen_offset = UInt32(20)
        static let spi5lpen_mask = UInt32(0b1) &<< spi5lpen_offset
        var spi5lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.spi5lpen_mask)) >> RCC.APB2LPENR.spi5lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.spi5lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.spi5lpen_offset) & RCC.APB2LPENR.spi5lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let spi6lpen_offset = UInt32(21)
        static let spi6lpen_mask = UInt32(0b1) &<< spi6lpen_offset
        var spi6lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.spi6lpen_mask)) >> RCC.APB2LPENR.spi6lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.spi6lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.spi6lpen_offset) & RCC.APB2LPENR.spi6lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let sai1lpen_offset = UInt32(22)
        static let sai1lpen_mask = UInt32(0b1) &<< sai1lpen_offset
        var sai1lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.sai1lpen_mask)) >> RCC.APB2LPENR.sai1lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.sai1lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.sai1lpen_offset) & RCC.APB2LPENR.sai1lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let ltdclpen_offset = UInt32(26)
        static let ltdclpen_mask = UInt32(0b1) &<< ltdclpen_offset
        var ltdclpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.ltdclpen_mask)) >> RCC.APB2LPENR.ltdclpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.ltdclpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.ltdclpen_offset) & RCC.APB2LPENR.ltdclpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let sai2lpen_offset = UInt32(23)
        static let sai2lpen_mask = UInt32(0b1) &<< sai2lpen_offset
        var sai2lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.sai2lpen_mask)) >> RCC.APB2LPENR.sai2lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.sai2lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.sai2lpen_offset) & RCC.APB2LPENR.sai2lpen_mask
                self.rawValue = preserve | shift
            }
        }

        static let sdmmc1lpen_offset = UInt32(11)
        static let sdmmc1lpen_mask = UInt32(0b1) &<< sdmmc1lpen_offset
        var sdmmc1lpen: UInt8 {
            get { UInt8((self.rawValue & (RCC.APB2LPENR.sdmmc1lpen_mask)) >> RCC.APB2LPENR.sdmmc1lpen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.APB2LPENR.sdmmc1lpen_mask
                let shift = (UInt32(newValue) << RCC.APB2LPENR.sdmmc1lpen_offset) & RCC.APB2LPENR.sdmmc1lpen_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct BDCR {
        var rawValue: UInt32

        static let bdrst_offset = UInt32(16)
        static let bdrst_mask = UInt32(0b1) &<< bdrst_offset
        var bdrst: UInt8 {
            get { UInt8((self.rawValue & (RCC.BDCR.bdrst_mask)) >> RCC.BDCR.bdrst_offset) }
            set {
                let preserve = self.rawValue & ~RCC.BDCR.bdrst_mask
                let shift = (UInt32(newValue) << RCC.BDCR.bdrst_offset) & RCC.BDCR.bdrst_mask
                self.rawValue = preserve | shift
            }
        }

        static let rtcen_offset = UInt32(15)
        static let rtcen_mask = UInt32(0b1) &<< rtcen_offset
        var rtcen: UInt8 {
            get { UInt8((self.rawValue & (RCC.BDCR.rtcen_mask)) >> RCC.BDCR.rtcen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.BDCR.rtcen_mask
                let shift = (UInt32(newValue) << RCC.BDCR.rtcen_offset) & RCC.BDCR.rtcen_mask
                self.rawValue = preserve | shift
            }
        }

        static let rtcsel1_offset = UInt32(9)
        static let rtcsel1_mask = UInt32(0b1) &<< rtcsel1_offset
        var rtcsel1: UInt8 {
            get { UInt8((self.rawValue & (RCC.BDCR.rtcsel1_mask)) >> RCC.BDCR.rtcsel1_offset) }
            set {
                let preserve = self.rawValue & ~RCC.BDCR.rtcsel1_mask
                let shift = (UInt32(newValue) << RCC.BDCR.rtcsel1_offset) & RCC.BDCR.rtcsel1_mask
                self.rawValue = preserve | shift
            }
        }

        static let rtcsel0_offset = UInt32(8)
        static let rtcsel0_mask = UInt32(0b1) &<< rtcsel0_offset
        var rtcsel0: UInt8 {
            get { UInt8((self.rawValue & (RCC.BDCR.rtcsel0_mask)) >> RCC.BDCR.rtcsel0_offset) }
            set {
                let preserve = self.rawValue & ~RCC.BDCR.rtcsel0_mask
                let shift = (UInt32(newValue) << RCC.BDCR.rtcsel0_offset) & RCC.BDCR.rtcsel0_mask
                self.rawValue = preserve | shift
            }
        }

        static let lsebyp_offset = UInt32(2)
        static let lsebyp_mask = UInt32(0b1) &<< lsebyp_offset
        var lsebyp: UInt8 {
            get { UInt8((self.rawValue & (RCC.BDCR.lsebyp_mask)) >> RCC.BDCR.lsebyp_offset) }
            set {
                let preserve = self.rawValue & ~RCC.BDCR.lsebyp_mask
                let shift = (UInt32(newValue) << RCC.BDCR.lsebyp_offset) & RCC.BDCR.lsebyp_mask
                self.rawValue = preserve | shift
            }
        }

        static let lserdy_offset = UInt32(1)
        static let lserdy_mask = UInt32(0b1) &<< lserdy_offset
        var lserdy: UInt8 {
            UInt8((self.rawValue & (RCC.BDCR.lserdy_mask)) >> RCC.BDCR.lserdy_offset)
        }

        static let lseon_offset = UInt32(0)
        static let lseon_mask = UInt32(0b1) &<< lseon_offset
        var lseon: UInt8 {
            get { UInt8((self.rawValue & (RCC.BDCR.lseon_mask)) >> RCC.BDCR.lseon_offset) }
            set {
                let preserve = self.rawValue & ~RCC.BDCR.lseon_mask
                let shift = (UInt32(newValue) << RCC.BDCR.lseon_offset) & RCC.BDCR.lseon_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct CSR {
        var rawValue: UInt32

        static let lpwrrstf_offset = UInt32(31)
        static let lpwrrstf_mask = UInt32(0b1) &<< lpwrrstf_offset
        var lpwrrstf: UInt8 {
            get { UInt8((self.rawValue & (RCC.CSR.lpwrrstf_mask)) >> RCC.CSR.lpwrrstf_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CSR.lpwrrstf_mask
                let shift = (UInt32(newValue) << RCC.CSR.lpwrrstf_offset) & RCC.CSR.lpwrrstf_mask
                self.rawValue = preserve | shift
            }
        }

        static let wwdgrstf_offset = UInt32(30)
        static let wwdgrstf_mask = UInt32(0b1) &<< wwdgrstf_offset
        var wwdgrstf: UInt8 {
            get { UInt8((self.rawValue & (RCC.CSR.wwdgrstf_mask)) >> RCC.CSR.wwdgrstf_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CSR.wwdgrstf_mask
                let shift = (UInt32(newValue) << RCC.CSR.wwdgrstf_offset) & RCC.CSR.wwdgrstf_mask
                self.rawValue = preserve | shift
            }
        }

        static let wdgrstf_offset = UInt32(29)
        static let wdgrstf_mask = UInt32(0b1) &<< wdgrstf_offset
        var wdgrstf: UInt8 {
            get { UInt8((self.rawValue & (RCC.CSR.wdgrstf_mask)) >> RCC.CSR.wdgrstf_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CSR.wdgrstf_mask
                let shift = (UInt32(newValue) << RCC.CSR.wdgrstf_offset) & RCC.CSR.wdgrstf_mask
                self.rawValue = preserve | shift
            }
        }

        static let sftrstf_offset = UInt32(28)
        static let sftrstf_mask = UInt32(0b1) &<< sftrstf_offset
        var sftrstf: UInt8 {
            get { UInt8((self.rawValue & (RCC.CSR.sftrstf_mask)) >> RCC.CSR.sftrstf_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CSR.sftrstf_mask
                let shift = (UInt32(newValue) << RCC.CSR.sftrstf_offset) & RCC.CSR.sftrstf_mask
                self.rawValue = preserve | shift
            }
        }

        static let porrstf_offset = UInt32(27)
        static let porrstf_mask = UInt32(0b1) &<< porrstf_offset
        var porrstf: UInt8 {
            get { UInt8((self.rawValue & (RCC.CSR.porrstf_mask)) >> RCC.CSR.porrstf_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CSR.porrstf_mask
                let shift = (UInt32(newValue) << RCC.CSR.porrstf_offset) & RCC.CSR.porrstf_mask
                self.rawValue = preserve | shift
            }
        }

        static let padrstf_offset = UInt32(26)
        static let padrstf_mask = UInt32(0b1) &<< padrstf_offset
        var padrstf: UInt8 {
            get { UInt8((self.rawValue & (RCC.CSR.padrstf_mask)) >> RCC.CSR.padrstf_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CSR.padrstf_mask
                let shift = (UInt32(newValue) << RCC.CSR.padrstf_offset) & RCC.CSR.padrstf_mask
                self.rawValue = preserve | shift
            }
        }

        static let borrstf_offset = UInt32(25)
        static let borrstf_mask = UInt32(0b1) &<< borrstf_offset
        var borrstf: UInt8 {
            get { UInt8((self.rawValue & (RCC.CSR.borrstf_mask)) >> RCC.CSR.borrstf_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CSR.borrstf_mask
                let shift = (UInt32(newValue) << RCC.CSR.borrstf_offset) & RCC.CSR.borrstf_mask
                self.rawValue = preserve | shift
            }
        }

        static let rmvf_offset = UInt32(24)
        static let rmvf_mask = UInt32(0b1) &<< rmvf_offset
        var rmvf: UInt8 {
            get { UInt8((self.rawValue & (RCC.CSR.rmvf_mask)) >> RCC.CSR.rmvf_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CSR.rmvf_mask
                let shift = (UInt32(newValue) << RCC.CSR.rmvf_offset) & RCC.CSR.rmvf_mask
                self.rawValue = preserve | shift
            }
        }

        static let lsirdy_offset = UInt32(1)
        static let lsirdy_mask = UInt32(0b1) &<< lsirdy_offset
        var lsirdy: UInt8 {
            UInt8((self.rawValue & (RCC.CSR.lsirdy_mask)) >> RCC.CSR.lsirdy_offset)
        }

        static let lsion_offset = UInt32(0)
        static let lsion_mask = UInt32(0b1) &<< lsion_offset
        var lsion: UInt8 {
            get { UInt8((self.rawValue & (RCC.CSR.lsion_mask)) >> RCC.CSR.lsion_offset) }
            set {
                let preserve = self.rawValue & ~RCC.CSR.lsion_mask
                let shift = (UInt32(newValue) << RCC.CSR.lsion_offset) & RCC.CSR.lsion_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct SSCGR {
        var rawValue: UInt32

        static let sscgen_offset = UInt32(31)
        static let sscgen_mask = UInt32(0b1) &<< sscgen_offset
        var sscgen: UInt8 {
            get { UInt8((self.rawValue & (RCC.SSCGR.sscgen_mask)) >> RCC.SSCGR.sscgen_offset) }
            set {
                let preserve = self.rawValue & ~RCC.SSCGR.sscgen_mask
                let shift = (UInt32(newValue) << RCC.SSCGR.sscgen_offset) & RCC.SSCGR.sscgen_mask
                self.rawValue = preserve | shift
            }
        }

        static let spreadsel_offset = UInt32(30)
        static let spreadsel_mask = UInt32(0b1) &<< spreadsel_offset
        var spreadsel: UInt8 {
            get { UInt8((self.rawValue & (RCC.SSCGR.spreadsel_mask)) >> RCC.SSCGR.spreadsel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.SSCGR.spreadsel_mask
                let shift = (UInt32(newValue) << RCC.SSCGR.spreadsel_offset) & RCC.SSCGR.spreadsel_mask
                self.rawValue = preserve | shift
            }
        }

        static let incstep_offset = UInt32(13)
        static let incstep_mask = UInt32(0b111111111111111) &<< incstep_offset
        var incstep: UInt16 {
            get { UInt16((self.rawValue & (RCC.SSCGR.incstep_mask)) >> RCC.SSCGR.incstep_offset) }
            set {
                let preserve = self.rawValue & ~RCC.SSCGR.incstep_mask
                let shift = (UInt32(newValue) << RCC.SSCGR.incstep_offset) & RCC.SSCGR.incstep_mask
                self.rawValue = preserve | shift
            }
        }

        static let modper_offset = UInt32(0)
        static let modper_mask = UInt32(0b1111111111111) &<< modper_offset
        var modper: UInt16 {
            get { UInt16((self.rawValue & (RCC.SSCGR.modper_mask)) >> RCC.SSCGR.modper_offset) }
            set {
                let preserve = self.rawValue & ~RCC.SSCGR.modper_mask
                let shift = (UInt32(newValue) << RCC.SSCGR.modper_offset) & RCC.SSCGR.modper_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct PLLI2SCFGR {
        var rawValue: UInt32

        static let plli2sr_offset = UInt32(28)
        static let plli2sr_mask = UInt32(0b111) &<< plli2sr_offset
        var plli2sr: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLI2SCFGR.plli2sr_mask)) >> RCC.PLLI2SCFGR.plli2sr_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLI2SCFGR.plli2sr_mask
                let shift = (UInt32(newValue) << RCC.PLLI2SCFGR.plli2sr_offset) & RCC.PLLI2SCFGR.plli2sr_mask
                self.rawValue = preserve | shift
            }
        }

        static let plli2sq_offset = UInt32(24)
        static let plli2sq_mask = UInt32(0b1111) &<< plli2sq_offset
        var plli2sq: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLI2SCFGR.plli2sq_mask)) >> RCC.PLLI2SCFGR.plli2sq_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLI2SCFGR.plli2sq_mask
                let shift = (UInt32(newValue) << RCC.PLLI2SCFGR.plli2sq_offset) & RCC.PLLI2SCFGR.plli2sq_mask
                self.rawValue = preserve | shift
            }
        }

        static let plli2sn_offset = UInt32(6)
        static let plli2sn_mask = UInt32(0b111111111) &<< plli2sn_offset
        var plli2sn: UInt16 {
            get { UInt16((self.rawValue & (RCC.PLLI2SCFGR.plli2sn_mask)) >> RCC.PLLI2SCFGR.plli2sn_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLI2SCFGR.plli2sn_mask
                let shift = (UInt32(newValue) << RCC.PLLI2SCFGR.plli2sn_offset) & RCC.PLLI2SCFGR.plli2sn_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct PLLSAICFGR {
        var rawValue: UInt32

        static let pllsain_offset = UInt32(6)
        static let pllsain_mask = UInt32(0b111111111) &<< pllsain_offset
        var pllsain: UInt16 {
            get { UInt16((self.rawValue & (RCC.PLLSAICFGR.pllsain_mask)) >> RCC.PLLSAICFGR.pllsain_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLSAICFGR.pllsain_mask
                let shift = (UInt32(newValue) << RCC.PLLSAICFGR.pllsain_offset) & RCC.PLLSAICFGR.pllsain_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllsaip_offset = UInt32(16)
        static let pllsaip_mask = UInt32(0b11) &<< pllsaip_offset
        var pllsaip: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLSAICFGR.pllsaip_mask)) >> RCC.PLLSAICFGR.pllsaip_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLSAICFGR.pllsaip_mask
                let shift = (UInt32(newValue) << RCC.PLLSAICFGR.pllsaip_offset) & RCC.PLLSAICFGR.pllsaip_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllsaiq_offset = UInt32(24)
        static let pllsaiq_mask = UInt32(0b1111) &<< pllsaiq_offset
        var pllsaiq: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLSAICFGR.pllsaiq_mask)) >> RCC.PLLSAICFGR.pllsaiq_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLSAICFGR.pllsaiq_mask
                let shift = (UInt32(newValue) << RCC.PLLSAICFGR.pllsaiq_offset) & RCC.PLLSAICFGR.pllsaiq_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllsair_offset = UInt32(28)
        static let pllsair_mask = UInt32(0b111) &<< pllsair_offset
        var pllsair: UInt8 {
            get { UInt8((self.rawValue & (RCC.PLLSAICFGR.pllsair_mask)) >> RCC.PLLSAICFGR.pllsair_offset) }
            set {
                let preserve = self.rawValue & ~RCC.PLLSAICFGR.pllsair_mask
                let shift = (UInt32(newValue) << RCC.PLLSAICFGR.pllsair_offset) & RCC.PLLSAICFGR.pllsair_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct DKCFGR1 {
        var rawValue: UInt32

        static let plli2sdiv_offset = UInt32(0)
        static let plli2sdiv_mask = UInt32(0b11111) &<< plli2sdiv_offset
        var plli2sdiv: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR1.plli2sdiv_mask)) >> RCC.DKCFGR1.plli2sdiv_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR1.plli2sdiv_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR1.plli2sdiv_offset) & RCC.DKCFGR1.plli2sdiv_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllsaidivq_offset = UInt32(8)
        static let pllsaidivq_mask = UInt32(0b11111) &<< pllsaidivq_offset
        var pllsaidivq: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR1.pllsaidivq_mask)) >> RCC.DKCFGR1.pllsaidivq_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR1.pllsaidivq_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR1.pllsaidivq_offset) & RCC.DKCFGR1.pllsaidivq_mask
                self.rawValue = preserve | shift
            }
        }

        static let pllsaidivr_offset = UInt32(16)
        static let pllsaidivr_mask = UInt32(0b11) &<< pllsaidivr_offset
        var pllsaidivr: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR1.pllsaidivr_mask)) >> RCC.DKCFGR1.pllsaidivr_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR1.pllsaidivr_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR1.pllsaidivr_offset) & RCC.DKCFGR1.pllsaidivr_mask
                self.rawValue = preserve | shift
            }
        }

        static let sai1sel_offset = UInt32(20)
        static let sai1sel_mask = UInt32(0b11) &<< sai1sel_offset
        var sai1sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR1.sai1sel_mask)) >> RCC.DKCFGR1.sai1sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR1.sai1sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR1.sai1sel_offset) & RCC.DKCFGR1.sai1sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let sai2sel_offset = UInt32(22)
        static let sai2sel_mask = UInt32(0b11) &<< sai2sel_offset
        var sai2sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR1.sai2sel_mask)) >> RCC.DKCFGR1.sai2sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR1.sai2sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR1.sai2sel_offset) & RCC.DKCFGR1.sai2sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let timpre_offset = UInt32(24)
        static let timpre_mask = UInt32(0b1) &<< timpre_offset
        var timpre: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR1.timpre_mask)) >> RCC.DKCFGR1.timpre_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR1.timpre_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR1.timpre_offset) & RCC.DKCFGR1.timpre_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct DKCFGR2 {
        var rawValue: UInt32

        static let usart1sel_offset = UInt32(0)
        static let usart1sel_mask = UInt32(0b11) &<< usart1sel_offset
        var usart1sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.usart1sel_mask)) >> RCC.DKCFGR2.usart1sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.usart1sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.usart1sel_offset) & RCC.DKCFGR2.usart1sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let usart2sel_offset = UInt32(2)
        static let usart2sel_mask = UInt32(0b11) &<< usart2sel_offset
        var usart2sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.usart2sel_mask)) >> RCC.DKCFGR2.usart2sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.usart2sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.usart2sel_offset) & RCC.DKCFGR2.usart2sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let usart3sel_offset = UInt32(4)
        static let usart3sel_mask = UInt32(0b11) &<< usart3sel_offset
        var usart3sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.usart3sel_mask)) >> RCC.DKCFGR2.usart3sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.usart3sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.usart3sel_offset) & RCC.DKCFGR2.usart3sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart4sel_offset = UInt32(6)
        static let uart4sel_mask = UInt32(0b11) &<< uart4sel_offset
        var uart4sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.uart4sel_mask)) >> RCC.DKCFGR2.uart4sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.uart4sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.uart4sel_offset) & RCC.DKCFGR2.uart4sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart5sel_offset = UInt32(8)
        static let uart5sel_mask = UInt32(0b11) &<< uart5sel_offset
        var uart5sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.uart5sel_mask)) >> RCC.DKCFGR2.uart5sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.uart5sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.uart5sel_offset) & RCC.DKCFGR2.uart5sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let usart6sel_offset = UInt32(10)
        static let usart6sel_mask = UInt32(0b11) &<< usart6sel_offset
        var usart6sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.usart6sel_mask)) >> RCC.DKCFGR2.usart6sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.usart6sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.usart6sel_offset) & RCC.DKCFGR2.usart6sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart7sel_offset = UInt32(12)
        static let uart7sel_mask = UInt32(0b11) &<< uart7sel_offset
        var uart7sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.uart7sel_mask)) >> RCC.DKCFGR2.uart7sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.uart7sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.uart7sel_offset) & RCC.DKCFGR2.uart7sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let uart8sel_offset = UInt32(14)
        static let uart8sel_mask = UInt32(0b11) &<< uart8sel_offset
        var uart8sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.uart8sel_mask)) >> RCC.DKCFGR2.uart8sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.uart8sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.uart8sel_offset) & RCC.DKCFGR2.uart8sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c1sel_offset = UInt32(16)
        static let i2c1sel_mask = UInt32(0b11) &<< i2c1sel_offset
        var i2c1sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.i2c1sel_mask)) >> RCC.DKCFGR2.i2c1sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.i2c1sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.i2c1sel_offset) & RCC.DKCFGR2.i2c1sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c2sel_offset = UInt32(18)
        static let i2c2sel_mask = UInt32(0b11) &<< i2c2sel_offset
        var i2c2sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.i2c2sel_mask)) >> RCC.DKCFGR2.i2c2sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.i2c2sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.i2c2sel_offset) & RCC.DKCFGR2.i2c2sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c3sel_offset = UInt32(20)
        static let i2c3sel_mask = UInt32(0b11) &<< i2c3sel_offset
        var i2c3sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.i2c3sel_mask)) >> RCC.DKCFGR2.i2c3sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.i2c3sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.i2c3sel_offset) & RCC.DKCFGR2.i2c3sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let i2c4sel_offset = UInt32(22)
        static let i2c4sel_mask = UInt32(0b11) &<< i2c4sel_offset
        var i2c4sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.i2c4sel_mask)) >> RCC.DKCFGR2.i2c4sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.i2c4sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.i2c4sel_offset) & RCC.DKCFGR2.i2c4sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let lptim1sel_offset = UInt32(24)
        static let lptim1sel_mask = UInt32(0b11) &<< lptim1sel_offset
        var lptim1sel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.lptim1sel_mask)) >> RCC.DKCFGR2.lptim1sel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.lptim1sel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.lptim1sel_offset) & RCC.DKCFGR2.lptim1sel_mask
                self.rawValue = preserve | shift
            }
        }

        static let cecsel_offset = UInt32(26)
        static let cecsel_mask = UInt32(0b1) &<< cecsel_offset
        var cecsel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.cecsel_mask)) >> RCC.DKCFGR2.cecsel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.cecsel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.cecsel_offset) & RCC.DKCFGR2.cecsel_mask
                self.rawValue = preserve | shift
            }
        }

        static let ck48msel_offset = UInt32(27)
        static let ck48msel_mask = UInt32(0b1) &<< ck48msel_offset
        var ck48msel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.ck48msel_mask)) >> RCC.DKCFGR2.ck48msel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.ck48msel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.ck48msel_offset) & RCC.DKCFGR2.ck48msel_mask
                self.rawValue = preserve | shift
            }
        }

        static let sdmmcsel_offset = UInt32(28)
        static let sdmmcsel_mask = UInt32(0b1) &<< sdmmcsel_offset
        var sdmmcsel: UInt8 {
            get { UInt8((self.rawValue & (RCC.DKCFGR2.sdmmcsel_mask)) >> RCC.DKCFGR2.sdmmcsel_offset) }
            set {
                let preserve = self.rawValue & ~RCC.DKCFGR2.sdmmcsel_mask
                let shift = (UInt32(newValue) << RCC.DKCFGR2.sdmmcsel_offset) & RCC.DKCFGR2.sdmmcsel_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
}
