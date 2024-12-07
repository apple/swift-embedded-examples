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

/// LCD-TFT Controller
public struct LTDC {
    public var baseAddress: UnsafeMutableRawPointer

    enum Offsets {
        static let SSCR: Int32 = 0x8
        static let BPCR: Int32 = 0xc
        static let AWCR: Int32 = 0x10
        static let TWCR: Int32 = 0x14
        static let GCR: Int32 = 0x18
        static let SRCR: Int32 = 0x24
        static let BCCR: Int32 = 0x2c
        static let IER: Int32 = 0x34
        static let ISR: Int32 = 0x38
        static let ICR: Int32 = 0x3c
        static let LIPCR: Int32 = 0x40
        static let CPSR: Int32 = 0x44
        static let CDSR: Int32 = 0x48
        static let L1CR: Int32 = 0x84
        static let L1WHPCR: Int32 = 0x88
        static let L1WVPCR: Int32 = 0x8c
        static let L1CKCR: Int32 = 0x90
        static let L1PFCR: Int32 = 0x94
        static let L1CACR: Int32 = 0x98
        static let L1DCCR: Int32 = 0x9c
        static let L1BFCR: Int32 = 0xa0
        static let L1CFBAR: Int32 = 0xac
        static let L1CFBLR: Int32 = 0xb0
        static let L1CFBLNR: Int32 = 0xb4
        static let L1CLUTWR: Int32 = 0xc4
        static let L2CR: Int32 = 0x104
        static let L2WHPCR: Int32 = 0x108
        static let L2WVPCR: Int32 = 0x10c
        static let L2CKCR: Int32 = 0x110
        static let L2PFCR: Int32 = 0x114
        static let L2CACR: Int32 = 0x118
        static let L2DCCR: Int32 = 0x11c
        static let L2BFCR: Int32 = 0x120
        static let L2CFBAR: Int32 = 0x12c
        static let L2CFBLR: Int32 = 0x130
        static let L2CFBLNR: Int32 = 0x134
        static let L2CLUTWR: Int32 = 0x144
    }

    private func ld(_ offset: Int32) -> UInt32 {
        UnsafeMutablePointer<UInt32>(bitPattern: UInt(bitPattern: UnsafeMutableRawPointer(baseAddress).advanced(by: Int(offset))))!.volatileLoad()
    }

    private func st(_ offset: Int32, _ value: UInt32) {
        UnsafeMutablePointer<UInt32>(bitPattern: UInt(bitPattern: UnsafeMutableRawPointer(baseAddress).advanced(by: Int(offset))))!.volatileStore(value)
    }

    /// Synchronization Size Configuration Register
    public var sscr: SSCR {
        get { SSCR(rawValue: ld(Offsets.SSCR)) }
        set { st(Offsets.SSCR, newValue.rawValue) }
    }
    /// Back Porch Configuration Register
    public var bpcr: BPCR {
        get { BPCR(rawValue: ld(Offsets.BPCR)) }
        set { st(Offsets.BPCR, newValue.rawValue) }
    }
    /// Active Width Configuration Register
    public var awcr: AWCR {
        get { AWCR(rawValue: ld(Offsets.AWCR)) }
        set { st(Offsets.AWCR, newValue.rawValue) }
    }
    /// Total Width Configuration Register
    public var twcr: TWCR {
        get { TWCR(rawValue: ld(Offsets.TWCR)) }
        set { st(Offsets.TWCR, newValue.rawValue) }
    }
    /// Global Control Register
    public var gcr: GCR {
        get { GCR(rawValue: ld(Offsets.GCR)) }
        set { st(Offsets.GCR, newValue.rawValue) }
    }
    /// Shadow Reload Configuration Register
    public var srcr: SRCR {
        get { SRCR(rawValue: ld(Offsets.SRCR)) }
        set { st(Offsets.SRCR, newValue.rawValue) }
    }
    /// Background Color Configuration Register
    public var bccr: BCCR {
        get { BCCR(rawValue: ld(Offsets.BCCR)) }
        set { st(Offsets.BCCR, newValue.rawValue) }
    }
    /// Interrupt Enable Register
    public var ier: IER {
        get { IER(rawValue: ld(Offsets.IER)) }
        set { st(Offsets.IER, newValue.rawValue) }
    }
    /// Interrupt Status Register
    public var isr: ISR {
        get { ISR(rawValue: ld(Offsets.ISR)) }
        set { st(Offsets.ISR, newValue.rawValue) }
    }
    /// Interrupt Clear Register
    public var icr: ICR {
        get { ICR(rawValue: ld(Offsets.ICR)) }
        set { st(Offsets.ICR, newValue.rawValue) }
    }
    /// Line Interrupt Position Configuration Register
    public var lipcr: LIPCR {
        get { LIPCR(rawValue: ld(Offsets.LIPCR)) }
        set { st(Offsets.LIPCR, newValue.rawValue) }
    }
    /// Current Position Status Register
    public var cpsr: CPSR {
        get { CPSR(rawValue: ld(Offsets.CPSR)) }
        set { st(Offsets.CPSR, newValue.rawValue) }
    }
    /// Current Display Status Register
    public var cdsr: CDSR {
        get { CDSR(rawValue: ld(Offsets.CDSR)) }
        set { st(Offsets.CDSR, newValue.rawValue) }
    }
    /// Layerx Control Register
    public var l1cr: L1CR {
        get { L1CR(rawValue: ld(Offsets.L1CR)) }
        set { st(Offsets.L1CR, newValue.rawValue) }
    }
    /// Layerx Window Horizontal Position Configuration Register
    public var l1whpcr: L1WHPCR {
        get { L1WHPCR(rawValue: ld(Offsets.L1WHPCR)) }
        set { st(Offsets.L1WHPCR, newValue.rawValue) }
    }
    /// Layerx Window Vertical Position Configuration Register
    public var l1wvpcr: L1WVPCR {
        get { L1WVPCR(rawValue: ld(Offsets.L1WVPCR)) }
        set { st(Offsets.L1WVPCR, newValue.rawValue) }
    }
    /// Layerx Color Keying Configuration Register
    public var l1ckcr: L1CKCR {
        get { L1CKCR(rawValue: ld(Offsets.L1CKCR)) }
        set { st(Offsets.L1CKCR, newValue.rawValue) }
    }
    /// Layerx Pixel Format Configuration Register
    public var l1pfcr: L1PFCR {
        get { L1PFCR(rawValue: ld(Offsets.L1PFCR)) }
        set { st(Offsets.L1PFCR, newValue.rawValue) }
    }
    /// Layerx Constant Alpha Configuration Register
    public var l1cacr: L1CACR {
        get { L1CACR(rawValue: ld(Offsets.L1CACR)) }
        set { st(Offsets.L1CACR, newValue.rawValue) }
    }
    /// Layerx Default Color Configuration Register
    public var l1dccr: L1DCCR {
        get { L1DCCR(rawValue: ld(Offsets.L1DCCR)) }
        set { st(Offsets.L1DCCR, newValue.rawValue) }
    }
    /// Layerx Blending Factors Configuration Register
    public var l1bfcr: L1BFCR {
        get { L1BFCR(rawValue: ld(Offsets.L1BFCR)) }
        set { st(Offsets.L1BFCR, newValue.rawValue) }
    }
    /// Layerx Color Frame Buffer Address Register
    public var l1cfbar: L1CFBAR {
        get { L1CFBAR(rawValue: ld(Offsets.L1CFBAR)) }
        set { st(Offsets.L1CFBAR, newValue.rawValue) }
    }
    /// Layerx Color Frame Buffer Length Register
    public var l1cfblr: L1CFBLR {
        get { L1CFBLR(rawValue: ld(Offsets.L1CFBLR)) }
        set { st(Offsets.L1CFBLR, newValue.rawValue) }
    }
    /// Layerx ColorFrame Buffer Line Number Register
    public var l1cfblnr: L1CFBLNR {
        get { L1CFBLNR(rawValue: ld(Offsets.L1CFBLNR)) }
        set { st(Offsets.L1CFBLNR, newValue.rawValue) }
    }
    /// Layerx CLUT Write Register
    public var l1clutwr: L1CLUTWR {
        get { L1CLUTWR(rawValue: ld(Offsets.L1CLUTWR)) }
        set { st(Offsets.L1CLUTWR, newValue.rawValue) }
    }
    /// Layerx Control Register
    public var l2cr: L2CR {
        get { L2CR(rawValue: ld(Offsets.L2CR)) }
        set { st(Offsets.L2CR, newValue.rawValue) }
    }
    /// Layerx Window Horizontal Position Configuration Register
    public var l2whpcr: L2WHPCR {
        get { L2WHPCR(rawValue: ld(Offsets.L2WHPCR)) }
        set { st(Offsets.L2WHPCR, newValue.rawValue) }
    }
    /// Layerx Window Vertical Position Configuration Register
    public var l2wvpcr: L2WVPCR {
        get { L2WVPCR(rawValue: ld(Offsets.L2WVPCR)) }
        set { st(Offsets.L2WVPCR, newValue.rawValue) }
    }
    /// Layerx Color Keying Configuration Register
    public var l2ckcr: L2CKCR {
        get { L2CKCR(rawValue: ld(Offsets.L2CKCR)) }
        set { st(Offsets.L2CKCR, newValue.rawValue) }
    }
    /// Layerx Pixel Format Configuration Register
    public var l2pfcr: L2PFCR {
        get { L2PFCR(rawValue: ld(Offsets.L2PFCR)) }
        set { st(Offsets.L2PFCR, newValue.rawValue) }
    }
    /// Layerx Constant Alpha Configuration Register
    public var l2cacr: L2CACR {
        get { L2CACR(rawValue: ld(Offsets.L2CACR)) }
        set { st(Offsets.L2CACR, newValue.rawValue) }
    }
    /// Layerx Default Color Configuration Register
    public var l2dccr: L2DCCR {
        get { L2DCCR(rawValue: ld(Offsets.L2DCCR)) }
        set { st(Offsets.L2DCCR, newValue.rawValue) }
    }
    /// Layerx Blending Factors Configuration Register
    public var l2bfcr: L2BFCR {
        get { L2BFCR(rawValue: ld(Offsets.L2BFCR)) }
        set { st(Offsets.L2BFCR, newValue.rawValue) }
    }
    /// Layerx Color Frame Buffer Address Register
    public var l2cfbar: L2CFBAR {
        get { L2CFBAR(rawValue: ld(Offsets.L2CFBAR)) }
        set { st(Offsets.L2CFBAR, newValue.rawValue) }
    }
    /// Layerx Color Frame Buffer Length Register
    public var l2cfblr: L2CFBLR {
        get { L2CFBLR(rawValue: ld(Offsets.L2CFBLR)) }
        set { st(Offsets.L2CFBLR, newValue.rawValue) }
    }
    /// Layerx ColorFrame Buffer Line Number Register
    public var l2cfblnr: L2CFBLNR {
        get { L2CFBLNR(rawValue: ld(Offsets.L2CFBLNR)) }
        set { st(Offsets.L2CFBLNR, newValue.rawValue) }
    }
    /// Layerx CLUT Write Register
    public var l2clutwr: L2CLUTWR {
        get { L2CLUTWR(rawValue: ld(Offsets.L2CLUTWR)) }
        set { st(Offsets.L2CLUTWR, newValue.rawValue) }
    }
}

extension LTDC {
    public struct SSCR {
        public var rawValue: UInt32

        static let hsw_offset = UInt32(16)
        static let hsw_mask = UInt32(0b1111111111) &<< hsw_offset
        public var hsw: UInt16 {
            get { UInt16((self.rawValue & (LTDC.SSCR.hsw_mask)) >> LTDC.SSCR.hsw_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.SSCR.hsw_mask
                let shift = (UInt32(newValue) << LTDC.SSCR.hsw_offset) & LTDC.SSCR.hsw_mask
                self.rawValue = preserve | shift
            }
        }

        static let vsh_offset = UInt32(0)
        static let vsh_mask = UInt32(0b11111111111) &<< vsh_offset
        public var vsh: UInt16 {
            get { UInt16((self.rawValue & (LTDC.SSCR.vsh_mask)) >> LTDC.SSCR.vsh_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.SSCR.vsh_mask
                let shift = (UInt32(newValue) << LTDC.SSCR.vsh_offset) & LTDC.SSCR.vsh_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct BPCR {
        public var rawValue: UInt32

        static let ahbp_offset = UInt32(16)
        static let ahbp_mask = UInt32(0b1111111111) &<< ahbp_offset
        public var ahbp: UInt16 {
            get { UInt16((self.rawValue & (LTDC.BPCR.ahbp_mask)) >> LTDC.BPCR.ahbp_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.BPCR.ahbp_mask
                let shift = (UInt32(newValue) << LTDC.BPCR.ahbp_offset) & LTDC.BPCR.ahbp_mask
                self.rawValue = preserve | shift
            }
        }

        static let avbp_offset = UInt32(0)
        static let avbp_mask = UInt32(0b11111111111) &<< avbp_offset
        public var avbp: UInt16 {
            get { UInt16((self.rawValue & (LTDC.BPCR.avbp_mask)) >> LTDC.BPCR.avbp_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.BPCR.avbp_mask
                let shift = (UInt32(newValue) << LTDC.BPCR.avbp_offset) & LTDC.BPCR.avbp_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct AWCR {
        public var rawValue: UInt32

        static let aav_offset = UInt32(16)
        static let aav_mask = UInt32(0b1111111111) &<< aav_offset
        public var aav: UInt16 {
            get { UInt16((self.rawValue & (LTDC.AWCR.aav_mask)) >> LTDC.AWCR.aav_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.AWCR.aav_mask
                let shift = (UInt32(newValue) << LTDC.AWCR.aav_offset) & LTDC.AWCR.aav_mask
                self.rawValue = preserve | shift
            }
        }

        static let aah_offset = UInt32(0)
        static let aah_mask = UInt32(0b11111111111) &<< aah_offset
        public var aah: UInt16 {
            get { UInt16((self.rawValue & (LTDC.AWCR.aah_mask)) >> LTDC.AWCR.aah_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.AWCR.aah_mask
                let shift = (UInt32(newValue) << LTDC.AWCR.aah_offset) & LTDC.AWCR.aah_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct TWCR {
        public var rawValue: UInt32

        static let totalw_offset = UInt32(16)
        static let totalw_mask = UInt32(0b1111111111) &<< totalw_offset
        public var totalw: UInt16 {
            get { UInt16((self.rawValue & (LTDC.TWCR.totalw_mask)) >> LTDC.TWCR.totalw_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.TWCR.totalw_mask
                let shift = (UInt32(newValue) << LTDC.TWCR.totalw_offset) & LTDC.TWCR.totalw_mask
                self.rawValue = preserve | shift
            }
        }

        static let totalh_offset = UInt32(0)
        static let totalh_mask = UInt32(0b11111111111) &<< totalh_offset
        public var totalh: UInt16 {
            get { UInt16((self.rawValue & (LTDC.TWCR.totalh_mask)) >> LTDC.TWCR.totalh_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.TWCR.totalh_mask
                let shift = (UInt32(newValue) << LTDC.TWCR.totalh_offset) & LTDC.TWCR.totalh_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct GCR {
        public var rawValue: UInt32

        static let hspol_offset = UInt32(31)
        static let hspol_mask = UInt32(0b1) &<< hspol_offset
        public var hspol: UInt8 {
            get { UInt8((self.rawValue & (LTDC.GCR.hspol_mask)) >> LTDC.GCR.hspol_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.GCR.hspol_mask
                let shift = (UInt32(newValue) << LTDC.GCR.hspol_offset) & LTDC.GCR.hspol_mask
                self.rawValue = preserve | shift
            }
        }

        static let vspol_offset = UInt32(30)
        static let vspol_mask = UInt32(0b1) &<< vspol_offset
        public var vspol: UInt8 {
            get { UInt8((self.rawValue & (LTDC.GCR.vspol_mask)) >> LTDC.GCR.vspol_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.GCR.vspol_mask
                let shift = (UInt32(newValue) << LTDC.GCR.vspol_offset) & LTDC.GCR.vspol_mask
                self.rawValue = preserve | shift
            }
        }

        static let depol_offset = UInt32(29)
        static let depol_mask = UInt32(0b1) &<< depol_offset
        public var depol: UInt8 {
            get { UInt8((self.rawValue & (LTDC.GCR.depol_mask)) >> LTDC.GCR.depol_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.GCR.depol_mask
                let shift = (UInt32(newValue) << LTDC.GCR.depol_offset) & LTDC.GCR.depol_mask
                self.rawValue = preserve | shift
            }
        }

        static let pcpol_offset = UInt32(28)
        static let pcpol_mask = UInt32(0b1) &<< pcpol_offset
        public var pcpol: UInt8 {
            get { UInt8((self.rawValue & (LTDC.GCR.pcpol_mask)) >> LTDC.GCR.pcpol_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.GCR.pcpol_mask
                let shift = (UInt32(newValue) << LTDC.GCR.pcpol_offset) & LTDC.GCR.pcpol_mask
                self.rawValue = preserve | shift
            }
        }

        static let den_offset = UInt32(16)
        static let den_mask = UInt32(0b1) &<< den_offset
        public var den: UInt8 {
            get { UInt8((self.rawValue & (LTDC.GCR.den_mask)) >> LTDC.GCR.den_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.GCR.den_mask
                let shift = (UInt32(newValue) << LTDC.GCR.den_offset) & LTDC.GCR.den_mask
                self.rawValue = preserve | shift
            }
        }

        static let drw_offset = UInt32(12)
        static let drw_mask = UInt32(0b111) &<< drw_offset
        public var drw: UInt8 {
            UInt8((self.rawValue & (LTDC.GCR.drw_mask)) >> LTDC.GCR.drw_offset)
        }

        static let dgw_offset = UInt32(8)
        static let dgw_mask = UInt32(0b111) &<< dgw_offset
        public var dgw: UInt8 {
            UInt8((self.rawValue & (LTDC.GCR.dgw_mask)) >> LTDC.GCR.dgw_offset)
        }

        static let dbw_offset = UInt32(4)
        static let dbw_mask = UInt32(0b111) &<< dbw_offset
        public var dbw: UInt8 {
            UInt8((self.rawValue & (LTDC.GCR.dbw_mask)) >> LTDC.GCR.dbw_offset)
        }

        static let ltdcen_offset = UInt32(0)
        static let ltdcen_mask = UInt32(0b1) &<< ltdcen_offset
        public var ltdcen: UInt8 {
            get { UInt8((self.rawValue & (LTDC.GCR.ltdcen_mask)) >> LTDC.GCR.ltdcen_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.GCR.ltdcen_mask
                let shift = (UInt32(newValue) << LTDC.GCR.ltdcen_offset) & LTDC.GCR.ltdcen_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct SRCR {
        public var rawValue: UInt32

        static let vbr_offset = UInt32(1)
        static let vbr_mask = UInt32(0b1) &<< vbr_offset
        public var vbr: UInt8 {
            get { UInt8((self.rawValue & (LTDC.SRCR.vbr_mask)) >> LTDC.SRCR.vbr_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.SRCR.vbr_mask
                let shift = (UInt32(newValue) << LTDC.SRCR.vbr_offset) & LTDC.SRCR.vbr_mask
                self.rawValue = preserve | shift
            }
        }

        static let imr_offset = UInt32(0)
        static let imr_mask = UInt32(0b1) &<< imr_offset
        public var imr: UInt8 {
            get { UInt8((self.rawValue & (LTDC.SRCR.imr_mask)) >> LTDC.SRCR.imr_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.SRCR.imr_mask
                let shift = (UInt32(newValue) << LTDC.SRCR.imr_offset) & LTDC.SRCR.imr_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct BCCR {
        public var rawValue: UInt32

        static let bc_offset = UInt32(0)
        static let bc_mask = UInt32(0b111111111111111111111111) &<< bc_offset
        public var bc: UInt32 {
            get { UInt32((self.rawValue & (LTDC.BCCR.bc_mask)) >> LTDC.BCCR.bc_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.BCCR.bc_mask
                let shift = (UInt32(newValue) << LTDC.BCCR.bc_offset) & LTDC.BCCR.bc_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct IER {
        public var rawValue: UInt32

        static let rrie_offset = UInt32(3)
        static let rrie_mask = UInt32(0b1) &<< rrie_offset
        public var rrie: UInt8 {
            get { UInt8((self.rawValue & (LTDC.IER.rrie_mask)) >> LTDC.IER.rrie_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.IER.rrie_mask
                let shift = (UInt32(newValue) << LTDC.IER.rrie_offset) & LTDC.IER.rrie_mask
                self.rawValue = preserve | shift
            }
        }

        static let terrie_offset = UInt32(2)
        static let terrie_mask = UInt32(0b1) &<< terrie_offset
        public var terrie: UInt8 {
            get { UInt8((self.rawValue & (LTDC.IER.terrie_mask)) >> LTDC.IER.terrie_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.IER.terrie_mask
                let shift = (UInt32(newValue) << LTDC.IER.terrie_offset) & LTDC.IER.terrie_mask
                self.rawValue = preserve | shift
            }
        }

        static let fuie_offset = UInt32(1)
        static let fuie_mask = UInt32(0b1) &<< fuie_offset
        public var fuie: UInt8 {
            get { UInt8((self.rawValue & (LTDC.IER.fuie_mask)) >> LTDC.IER.fuie_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.IER.fuie_mask
                let shift = (UInt32(newValue) << LTDC.IER.fuie_offset) & LTDC.IER.fuie_mask
                self.rawValue = preserve | shift
            }
        }

        static let lie_offset = UInt32(0)
        static let lie_mask = UInt32(0b1) &<< lie_offset
        public var lie: UInt8 {
            get { UInt8((self.rawValue & (LTDC.IER.lie_mask)) >> LTDC.IER.lie_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.IER.lie_mask
                let shift = (UInt32(newValue) << LTDC.IER.lie_offset) & LTDC.IER.lie_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct ISR {
        public var rawValue: UInt32

        static let rrif_offset = UInt32(3)
        static let rrif_mask = UInt32(0b1) &<< rrif_offset
        public var rrif: UInt8 {
            UInt8((self.rawValue & (LTDC.ISR.rrif_mask)) >> LTDC.ISR.rrif_offset)
        }

        static let terrif_offset = UInt32(2)
        static let terrif_mask = UInt32(0b1) &<< terrif_offset
        public var terrif: UInt8 {
            UInt8((self.rawValue & (LTDC.ISR.terrif_mask)) >> LTDC.ISR.terrif_offset)
        }

        static let fuif_offset = UInt32(1)
        static let fuif_mask = UInt32(0b1) &<< fuif_offset
        public var fuif: UInt8 {
            UInt8((self.rawValue & (LTDC.ISR.fuif_mask)) >> LTDC.ISR.fuif_offset)
        }

        static let lif_offset = UInt32(0)
        static let lif_mask = UInt32(0b1) &<< lif_offset
        public var lif: UInt8 {
            UInt8((self.rawValue & (LTDC.ISR.lif_mask)) >> LTDC.ISR.lif_offset)
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct ICR {
        public var rawValue: UInt32

        static let crrif_offset = UInt32(3)
        static let crrif_mask = UInt32(0b1) &<< crrif_offset
        public var crrif: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << LTDC.ICR.crrif_offset) & LTDC.ICR.crrif_mask
            }
        }

        static let cterrif_offset = UInt32(2)
        static let cterrif_mask = UInt32(0b1) &<< cterrif_offset
        public var cterrif: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << LTDC.ICR.cterrif_offset) & LTDC.ICR.cterrif_mask
            }
        }

        static let cfuif_offset = UInt32(1)
        static let cfuif_mask = UInt32(0b1) &<< cfuif_offset
        public var cfuif: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << LTDC.ICR.cfuif_offset) & LTDC.ICR.cfuif_mask
            }
        }

        static let clif_offset = UInt32(0)
        static let clif_mask = UInt32(0b1) &<< clif_offset
        public var clif: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << LTDC.ICR.clif_offset) & LTDC.ICR.clif_mask
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct LIPCR {
        public var rawValue: UInt32

        static let lipos_offset = UInt32(0)
        static let lipos_mask = UInt32(0b11111111111) &<< lipos_offset
        public var lipos: UInt16 {
            get { UInt16((self.rawValue & (LTDC.LIPCR.lipos_mask)) >> LTDC.LIPCR.lipos_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.LIPCR.lipos_mask
                let shift = (UInt32(newValue) << LTDC.LIPCR.lipos_offset) & LTDC.LIPCR.lipos_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct CPSR {
        public var rawValue: UInt32

        static let cxpos_offset = UInt32(16)
        static let cxpos_mask = UInt32(0b1111111111111111) &<< cxpos_offset
        public var cxpos: UInt16 {
            UInt16((self.rawValue & (LTDC.CPSR.cxpos_mask)) >> LTDC.CPSR.cxpos_offset)
        }

        static let cypos_offset = UInt32(0)
        static let cypos_mask = UInt32(0b1111111111111111) &<< cypos_offset
        public var cypos: UInt16 {
            UInt16((self.rawValue & (LTDC.CPSR.cypos_mask)) >> LTDC.CPSR.cypos_offset)
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct CDSR {
        public var rawValue: UInt32

        static let hsyncs_offset = UInt32(3)
        static let hsyncs_mask = UInt32(0b1) &<< hsyncs_offset
        public var hsyncs: UInt8 {
            UInt8((self.rawValue & (LTDC.CDSR.hsyncs_mask)) >> LTDC.CDSR.hsyncs_offset)
        }

        static let vsyncs_offset = UInt32(2)
        static let vsyncs_mask = UInt32(0b1) &<< vsyncs_offset
        public var vsyncs: UInt8 {
            UInt8((self.rawValue & (LTDC.CDSR.vsyncs_mask)) >> LTDC.CDSR.vsyncs_offset)
        }

        static let hdes_offset = UInt32(1)
        static let hdes_mask = UInt32(0b1) &<< hdes_offset
        public var hdes: UInt8 {
            UInt8((self.rawValue & (LTDC.CDSR.hdes_mask)) >> LTDC.CDSR.hdes_offset)
        }

        static let vdes_offset = UInt32(0)
        static let vdes_mask = UInt32(0b1) &<< vdes_offset
        public var vdes: UInt8 {
            UInt8((self.rawValue & (LTDC.CDSR.vdes_mask)) >> LTDC.CDSR.vdes_offset)
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L1CR {
        public var rawValue: UInt32

        static let cluten_offset = UInt32(4)
        static let cluten_mask = UInt32(0b1) &<< cluten_offset
        public var cluten: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1CR.cluten_mask)) >> LTDC.L1CR.cluten_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1CR.cluten_mask
                let shift = (UInt32(newValue) << LTDC.L1CR.cluten_offset) & LTDC.L1CR.cluten_mask
                self.rawValue = preserve | shift
            }
        }

        static let colken_offset = UInt32(1)
        static let colken_mask = UInt32(0b1) &<< colken_offset
        public var colken: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1CR.colken_mask)) >> LTDC.L1CR.colken_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1CR.colken_mask
                let shift = (UInt32(newValue) << LTDC.L1CR.colken_offset) & LTDC.L1CR.colken_mask
                self.rawValue = preserve | shift
            }
        }

        static let len_offset = UInt32(0)
        static let len_mask = UInt32(0b1) &<< len_offset
        public var len: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1CR.len_mask)) >> LTDC.L1CR.len_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1CR.len_mask
                let shift = (UInt32(newValue) << LTDC.L1CR.len_offset) & LTDC.L1CR.len_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L1WHPCR {
        public var rawValue: UInt32

        static let whsppos_offset = UInt32(16)
        static let whsppos_mask = UInt32(0b111111111111) &<< whsppos_offset
        public var whsppos: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L1WHPCR.whsppos_mask)) >> LTDC.L1WHPCR.whsppos_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1WHPCR.whsppos_mask
                let shift = (UInt32(newValue) << LTDC.L1WHPCR.whsppos_offset) & LTDC.L1WHPCR.whsppos_mask
                self.rawValue = preserve | shift
            }
        }

        static let whstpos_offset = UInt32(0)
        static let whstpos_mask = UInt32(0b111111111111) &<< whstpos_offset
        public var whstpos: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L1WHPCR.whstpos_mask)) >> LTDC.L1WHPCR.whstpos_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1WHPCR.whstpos_mask
                let shift = (UInt32(newValue) << LTDC.L1WHPCR.whstpos_offset) & LTDC.L1WHPCR.whstpos_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L1WVPCR {
        public var rawValue: UInt32

        static let wvsppos_offset = UInt32(16)
        static let wvsppos_mask = UInt32(0b11111111111) &<< wvsppos_offset
        public var wvsppos: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L1WVPCR.wvsppos_mask)) >> LTDC.L1WVPCR.wvsppos_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1WVPCR.wvsppos_mask
                let shift = (UInt32(newValue) << LTDC.L1WVPCR.wvsppos_offset) & LTDC.L1WVPCR.wvsppos_mask
                self.rawValue = preserve | shift
            }
        }

        static let wvstpos_offset = UInt32(0)
        static let wvstpos_mask = UInt32(0b11111111111) &<< wvstpos_offset
        public var wvstpos: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L1WVPCR.wvstpos_mask)) >> LTDC.L1WVPCR.wvstpos_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1WVPCR.wvstpos_mask
                let shift = (UInt32(newValue) << LTDC.L1WVPCR.wvstpos_offset) & LTDC.L1WVPCR.wvstpos_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L1CKCR {
        public var rawValue: UInt32

        static let ckred_offset = UInt32(16)
        static let ckred_mask = UInt32(0b11111111) &<< ckred_offset
        public var ckred: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1CKCR.ckred_mask)) >> LTDC.L1CKCR.ckred_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1CKCR.ckred_mask
                let shift = (UInt32(newValue) << LTDC.L1CKCR.ckred_offset) & LTDC.L1CKCR.ckred_mask
                self.rawValue = preserve | shift
            }
        }

        static let ckgreen_offset = UInt32(8)
        static let ckgreen_mask = UInt32(0b11111111) &<< ckgreen_offset
        public var ckgreen: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1CKCR.ckgreen_mask)) >> LTDC.L1CKCR.ckgreen_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1CKCR.ckgreen_mask
                let shift = (UInt32(newValue) << LTDC.L1CKCR.ckgreen_offset) & LTDC.L1CKCR.ckgreen_mask
                self.rawValue = preserve | shift
            }
        }

        static let ckblue_offset = UInt32(0)
        static let ckblue_mask = UInt32(0b11111111) &<< ckblue_offset
        public var ckblue: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1CKCR.ckblue_mask)) >> LTDC.L1CKCR.ckblue_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1CKCR.ckblue_mask
                let shift = (UInt32(newValue) << LTDC.L1CKCR.ckblue_offset) & LTDC.L1CKCR.ckblue_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L1PFCR {
        public var rawValue: UInt32

        static let pf_offset = UInt32(0)
        static let pf_mask = UInt32(0b111) &<< pf_offset
        public var pf: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1PFCR.pf_mask)) >> LTDC.L1PFCR.pf_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1PFCR.pf_mask
                let shift = (UInt32(newValue) << LTDC.L1PFCR.pf_offset) & LTDC.L1PFCR.pf_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L1CACR {
        public var rawValue: UInt32

        static let consta_offset = UInt32(0)
        static let consta_mask = UInt32(0b11111111) &<< consta_offset
        public var consta: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1CACR.consta_mask)) >> LTDC.L1CACR.consta_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1CACR.consta_mask
                let shift = (UInt32(newValue) << LTDC.L1CACR.consta_offset) & LTDC.L1CACR.consta_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L1DCCR {
        public var rawValue: UInt32

        static let dcalpha_offset = UInt32(24)
        static let dcalpha_mask = UInt32(0b11111111) &<< dcalpha_offset
        public var dcalpha: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1DCCR.dcalpha_mask)) >> LTDC.L1DCCR.dcalpha_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1DCCR.dcalpha_mask
                let shift = (UInt32(newValue) << LTDC.L1DCCR.dcalpha_offset) & LTDC.L1DCCR.dcalpha_mask
                self.rawValue = preserve | shift
            }
        }

        static let dcred_offset = UInt32(16)
        static let dcred_mask = UInt32(0b11111111) &<< dcred_offset
        public var dcred: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1DCCR.dcred_mask)) >> LTDC.L1DCCR.dcred_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1DCCR.dcred_mask
                let shift = (UInt32(newValue) << LTDC.L1DCCR.dcred_offset) & LTDC.L1DCCR.dcred_mask
                self.rawValue = preserve | shift
            }
        }

        static let dcgreen_offset = UInt32(8)
        static let dcgreen_mask = UInt32(0b11111111) &<< dcgreen_offset
        public var dcgreen: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1DCCR.dcgreen_mask)) >> LTDC.L1DCCR.dcgreen_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1DCCR.dcgreen_mask
                let shift = (UInt32(newValue) << LTDC.L1DCCR.dcgreen_offset) & LTDC.L1DCCR.dcgreen_mask
                self.rawValue = preserve | shift
            }
        }

        static let dcblue_offset = UInt32(0)
        static let dcblue_mask = UInt32(0b11111111) &<< dcblue_offset
        public var dcblue: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1DCCR.dcblue_mask)) >> LTDC.L1DCCR.dcblue_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1DCCR.dcblue_mask
                let shift = (UInt32(newValue) << LTDC.L1DCCR.dcblue_offset) & LTDC.L1DCCR.dcblue_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L1BFCR {
        public var rawValue: UInt32

        static let bf1_offset = UInt32(8)
        static let bf1_mask = UInt32(0b111) &<< bf1_offset
        public var bf1: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1BFCR.bf1_mask)) >> LTDC.L1BFCR.bf1_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1BFCR.bf1_mask
                let shift = (UInt32(newValue) << LTDC.L1BFCR.bf1_offset) & LTDC.L1BFCR.bf1_mask
                self.rawValue = preserve | shift
            }
        }

        static let bf2_offset = UInt32(0)
        static let bf2_mask = UInt32(0b111) &<< bf2_offset
        public var bf2: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L1BFCR.bf2_mask)) >> LTDC.L1BFCR.bf2_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1BFCR.bf2_mask
                let shift = (UInt32(newValue) << LTDC.L1BFCR.bf2_offset) & LTDC.L1BFCR.bf2_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L1CFBAR {
        public var rawValue: UInt32

        static let cfbadd_offset = UInt32(0)
        static let cfbadd_mask = UInt32(0b11111111111111111111111111111111) &<< cfbadd_offset
        public var cfbadd: UInt32 {
            get { UInt32((self.rawValue & (LTDC.L1CFBAR.cfbadd_mask)) >> LTDC.L1CFBAR.cfbadd_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1CFBAR.cfbadd_mask
                let shift = (UInt32(newValue) << LTDC.L1CFBAR.cfbadd_offset) & LTDC.L1CFBAR.cfbadd_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L1CFBLR {
        public var rawValue: UInt32

        static let cfbp_offset = UInt32(16)
        static let cfbp_mask = UInt32(0b1111111111111) &<< cfbp_offset
        public var cfbp: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L1CFBLR.cfbp_mask)) >> LTDC.L1CFBLR.cfbp_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1CFBLR.cfbp_mask
                let shift = (UInt32(newValue) << LTDC.L1CFBLR.cfbp_offset) & LTDC.L1CFBLR.cfbp_mask
                self.rawValue = preserve | shift
            }
        }

        static let cfbll_offset = UInt32(0)
        static let cfbll_mask = UInt32(0b1111111111111) &<< cfbll_offset
        public var cfbll: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L1CFBLR.cfbll_mask)) >> LTDC.L1CFBLR.cfbll_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1CFBLR.cfbll_mask
                let shift = (UInt32(newValue) << LTDC.L1CFBLR.cfbll_offset) & LTDC.L1CFBLR.cfbll_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L1CFBLNR {
        public var rawValue: UInt32

        static let cfblnbr_offset = UInt32(0)
        static let cfblnbr_mask = UInt32(0b11111111111) &<< cfblnbr_offset
        public var cfblnbr: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L1CFBLNR.cfblnbr_mask)) >> LTDC.L1CFBLNR.cfblnbr_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L1CFBLNR.cfblnbr_mask
                let shift = (UInt32(newValue) << LTDC.L1CFBLNR.cfblnbr_offset) & LTDC.L1CFBLNR.cfblnbr_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L1CLUTWR {
        public var rawValue: UInt32

        static let clutadd_offset = UInt32(24)
        static let clutadd_mask = UInt32(0b11111111) &<< clutadd_offset
        public var clutadd: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << LTDC.L1CLUTWR.clutadd_offset) & LTDC.L1CLUTWR.clutadd_mask
            }
        }

        static let red_offset = UInt32(16)
        static let red_mask = UInt32(0b11111111) &<< red_offset
        public var red: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << LTDC.L1CLUTWR.red_offset) & LTDC.L1CLUTWR.red_mask
            }
        }

        static let green_offset = UInt32(8)
        static let green_mask = UInt32(0b11111111) &<< green_offset
        public var green: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << LTDC.L1CLUTWR.green_offset) & LTDC.L1CLUTWR.green_mask
            }
        }

        static let blue_offset = UInt32(0)
        static let blue_mask = UInt32(0b11111111) &<< blue_offset
        public var blue: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << LTDC.L1CLUTWR.blue_offset) & LTDC.L1CLUTWR.blue_mask
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L2CR {
        public var rawValue: UInt32

        static let cluten_offset = UInt32(4)
        static let cluten_mask = UInt32(0b1) &<< cluten_offset
        public var cluten: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L2CR.cluten_mask)) >> LTDC.L2CR.cluten_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2CR.cluten_mask
                let shift = (UInt32(newValue) << LTDC.L2CR.cluten_offset) & LTDC.L2CR.cluten_mask
                self.rawValue = preserve | shift
            }
        }

        static let colken_offset = UInt32(1)
        static let colken_mask = UInt32(0b1) &<< colken_offset
        public var colken: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L2CR.colken_mask)) >> LTDC.L2CR.colken_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2CR.colken_mask
                let shift = (UInt32(newValue) << LTDC.L2CR.colken_offset) & LTDC.L2CR.colken_mask
                self.rawValue = preserve | shift
            }
        }

        static let len_offset = UInt32(0)
        static let len_mask = UInt32(0b1) &<< len_offset
        public var len: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L2CR.len_mask)) >> LTDC.L2CR.len_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2CR.len_mask
                let shift = (UInt32(newValue) << LTDC.L2CR.len_offset) & LTDC.L2CR.len_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L2WHPCR {
        public var rawValue: UInt32

        static let whsppos_offset = UInt32(16)
        static let whsppos_mask = UInt32(0b111111111111) &<< whsppos_offset
        public var whsppos: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L2WHPCR.whsppos_mask)) >> LTDC.L2WHPCR.whsppos_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2WHPCR.whsppos_mask
                let shift = (UInt32(newValue) << LTDC.L2WHPCR.whsppos_offset) & LTDC.L2WHPCR.whsppos_mask
                self.rawValue = preserve | shift
            }
        }

        static let whstpos_offset = UInt32(0)
        static let whstpos_mask = UInt32(0b111111111111) &<< whstpos_offset
        public var whstpos: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L2WHPCR.whstpos_mask)) >> LTDC.L2WHPCR.whstpos_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2WHPCR.whstpos_mask
                let shift = (UInt32(newValue) << LTDC.L2WHPCR.whstpos_offset) & LTDC.L2WHPCR.whstpos_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L2WVPCR {
        public var rawValue: UInt32

        static let wvsppos_offset = UInt32(16)
        static let wvsppos_mask = UInt32(0b11111111111) &<< wvsppos_offset
        public var wvsppos: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L2WVPCR.wvsppos_mask)) >> LTDC.L2WVPCR.wvsppos_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2WVPCR.wvsppos_mask
                let shift = (UInt32(newValue) << LTDC.L2WVPCR.wvsppos_offset) & LTDC.L2WVPCR.wvsppos_mask
                self.rawValue = preserve | shift
            }
        }

        static let wvstpos_offset = UInt32(0)
        static let wvstpos_mask = UInt32(0b11111111111) &<< wvstpos_offset
        public var wvstpos: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L2WVPCR.wvstpos_mask)) >> LTDC.L2WVPCR.wvstpos_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2WVPCR.wvstpos_mask
                let shift = (UInt32(newValue) << LTDC.L2WVPCR.wvstpos_offset) & LTDC.L2WVPCR.wvstpos_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L2CKCR {
        public var rawValue: UInt32

        static let ckred_offset = UInt32(15)
        static let ckred_mask = UInt32(0b111111111) &<< ckred_offset
        public var ckred: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L2CKCR.ckred_mask)) >> LTDC.L2CKCR.ckred_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2CKCR.ckred_mask
                let shift = (UInt32(newValue) << LTDC.L2CKCR.ckred_offset) & LTDC.L2CKCR.ckred_mask
                self.rawValue = preserve | shift
            }
        }

        static let ckgreen_offset = UInt32(8)
        static let ckgreen_mask = UInt32(0b1111111) &<< ckgreen_offset
        public var ckgreen: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L2CKCR.ckgreen_mask)) >> LTDC.L2CKCR.ckgreen_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2CKCR.ckgreen_mask
                let shift = (UInt32(newValue) << LTDC.L2CKCR.ckgreen_offset) & LTDC.L2CKCR.ckgreen_mask
                self.rawValue = preserve | shift
            }
        }

        static let ckblue_offset = UInt32(0)
        static let ckblue_mask = UInt32(0b11111111) &<< ckblue_offset
        public var ckblue: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L2CKCR.ckblue_mask)) >> LTDC.L2CKCR.ckblue_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2CKCR.ckblue_mask
                let shift = (UInt32(newValue) << LTDC.L2CKCR.ckblue_offset) & LTDC.L2CKCR.ckblue_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L2PFCR {
        public var rawValue: UInt32

        static let pf_offset = UInt32(0)
        static let pf_mask = UInt32(0b111) &<< pf_offset
        public var pf: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L2PFCR.pf_mask)) >> LTDC.L2PFCR.pf_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2PFCR.pf_mask
                let shift = (UInt32(newValue) << LTDC.L2PFCR.pf_offset) & LTDC.L2PFCR.pf_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L2CACR {
        public var rawValue: UInt32

        static let consta_offset = UInt32(0)
        static let consta_mask = UInt32(0b11111111) &<< consta_offset
        public var consta: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L2CACR.consta_mask)) >> LTDC.L2CACR.consta_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2CACR.consta_mask
                let shift = (UInt32(newValue) << LTDC.L2CACR.consta_offset) & LTDC.L2CACR.consta_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L2DCCR {
        public var rawValue: UInt32

        static let dcalpha_offset = UInt32(24)
        static let dcalpha_mask = UInt32(0b11111111) &<< dcalpha_offset
        public var dcalpha: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L2DCCR.dcalpha_mask)) >> LTDC.L2DCCR.dcalpha_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2DCCR.dcalpha_mask
                let shift = (UInt32(newValue) << LTDC.L2DCCR.dcalpha_offset) & LTDC.L2DCCR.dcalpha_mask
                self.rawValue = preserve | shift
            }
        }

        static let dcred_offset = UInt32(16)
        static let dcred_mask = UInt32(0b11111111) &<< dcred_offset
        public var dcred: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L2DCCR.dcred_mask)) >> LTDC.L2DCCR.dcred_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2DCCR.dcred_mask
                let shift = (UInt32(newValue) << LTDC.L2DCCR.dcred_offset) & LTDC.L2DCCR.dcred_mask
                self.rawValue = preserve | shift
            }
        }

        static let dcgreen_offset = UInt32(8)
        static let dcgreen_mask = UInt32(0b11111111) &<< dcgreen_offset
        public var dcgreen: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L2DCCR.dcgreen_mask)) >> LTDC.L2DCCR.dcgreen_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2DCCR.dcgreen_mask
                let shift = (UInt32(newValue) << LTDC.L2DCCR.dcgreen_offset) & LTDC.L2DCCR.dcgreen_mask
                self.rawValue = preserve | shift
            }
        }

        static let dcblue_offset = UInt32(0)
        static let dcblue_mask = UInt32(0b11111111) &<< dcblue_offset
        public var dcblue: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L2DCCR.dcblue_mask)) >> LTDC.L2DCCR.dcblue_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2DCCR.dcblue_mask
                let shift = (UInt32(newValue) << LTDC.L2DCCR.dcblue_offset) & LTDC.L2DCCR.dcblue_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L2BFCR {
        public var rawValue: UInt32

        static let bf1_offset = UInt32(8)
        static let bf1_mask = UInt32(0b111) &<< bf1_offset
        public var bf1: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L2BFCR.bf1_mask)) >> LTDC.L2BFCR.bf1_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2BFCR.bf1_mask
                let shift = (UInt32(newValue) << LTDC.L2BFCR.bf1_offset) & LTDC.L2BFCR.bf1_mask
                self.rawValue = preserve | shift
            }
        }

        static let bf2_offset = UInt32(0)
        static let bf2_mask = UInt32(0b111) &<< bf2_offset
        public var bf2: UInt8 {
            get { UInt8((self.rawValue & (LTDC.L2BFCR.bf2_mask)) >> LTDC.L2BFCR.bf2_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2BFCR.bf2_mask
                let shift = (UInt32(newValue) << LTDC.L2BFCR.bf2_offset) & LTDC.L2BFCR.bf2_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L2CFBAR {
        public var rawValue: UInt32

        static let cfbadd_offset = UInt32(0)
        static let cfbadd_mask = UInt32(0b11111111111111111111111111111111) &<< cfbadd_offset
        public var cfbadd: UInt32 {
            get { UInt32((self.rawValue & (LTDC.L2CFBAR.cfbadd_mask)) >> LTDC.L2CFBAR.cfbadd_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2CFBAR.cfbadd_mask
                let shift = (UInt32(newValue) << LTDC.L2CFBAR.cfbadd_offset) & LTDC.L2CFBAR.cfbadd_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L2CFBLR {
        public var rawValue: UInt32

        static let cfbp_offset = UInt32(16)
        static let cfbp_mask = UInt32(0b1111111111111) &<< cfbp_offset
        public var cfbp: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L2CFBLR.cfbp_mask)) >> LTDC.L2CFBLR.cfbp_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2CFBLR.cfbp_mask
                let shift = (UInt32(newValue) << LTDC.L2CFBLR.cfbp_offset) & LTDC.L2CFBLR.cfbp_mask
                self.rawValue = preserve | shift
            }
        }

        static let cfbll_offset = UInt32(0)
        static let cfbll_mask = UInt32(0b1111111111111) &<< cfbll_offset
        public var cfbll: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L2CFBLR.cfbll_mask)) >> LTDC.L2CFBLR.cfbll_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2CFBLR.cfbll_mask
                let shift = (UInt32(newValue) << LTDC.L2CFBLR.cfbll_offset) & LTDC.L2CFBLR.cfbll_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L2CFBLNR {
        public var rawValue: UInt32

        static let cfblnbr_offset = UInt32(0)
        static let cfblnbr_mask = UInt32(0b11111111111) &<< cfblnbr_offset
        public var cfblnbr: UInt16 {
            get { UInt16((self.rawValue & (LTDC.L2CFBLNR.cfblnbr_mask)) >> LTDC.L2CFBLNR.cfblnbr_offset) }
            set {
                let preserve = self.rawValue & ~LTDC.L2CFBLNR.cfblnbr_mask
                let shift = (UInt32(newValue) << LTDC.L2CFBLNR.cfblnbr_offset) & LTDC.L2CFBLNR.cfblnbr_mask
                self.rawValue = preserve | shift
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    public struct L2CLUTWR {
        public var rawValue: UInt32

        static let clutadd_offset = UInt32(24)
        static let clutadd_mask = UInt32(0b11111111) &<< clutadd_offset
        public var clutadd: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << LTDC.L2CLUTWR.clutadd_offset) & LTDC.L2CLUTWR.clutadd_mask
            }
        }

        static let red_offset = UInt32(16)
        static let red_mask = UInt32(0b11111111) &<< red_offset
        public var red: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << LTDC.L2CLUTWR.red_offset) & LTDC.L2CLUTWR.red_mask
            }
        }

        static let green_offset = UInt32(8)
        static let green_mask = UInt32(0b11111111) &<< green_offset
        public var green: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << LTDC.L2CLUTWR.green_offset) & LTDC.L2CLUTWR.green_mask
            }
        }

        static let blue_offset = UInt32(0)
        static let blue_mask = UInt32(0b11111111) &<< blue_offset
        public var blue: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << LTDC.L2CLUTWR.blue_offset) & LTDC.L2CLUTWR.blue_mask
            }
        }

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
}
