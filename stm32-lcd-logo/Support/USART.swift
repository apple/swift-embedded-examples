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

/// Universal synchronous asynchronous receiver transmitter
struct USART {
    var baseAddress: UnsafeMutableRawPointer

    enum Offsets {
        static let CR1: Int32 = 0x0
        static let CR2: Int32 = 0x4
        static let CR3: Int32 = 0x8
        static let BRR: Int32 = 0xc
        static let GTPR: Int32 = 0x10
        static let RTOR: Int32 = 0x14
        static let RQR: Int32 = 0x18
        static let ISR: Int32 = 0x1c
        static let ICR: Int32 = 0x20
        static let RDR: Int32 = 0x24
        static let TDR: Int32 = 0x28
    }

    private func ld(_ offset: Int32) -> UInt32 {
        UnsafeMutablePointer<UInt32>(bitPattern: UInt(bitPattern: UnsafeMutableRawPointer(baseAddress).advanced(by: Int(offset))))!.volatileLoad()
    }

    private func st(_ offset: Int32, _ value: UInt32) {
        UnsafeMutablePointer<UInt32>(bitPattern: UInt(bitPattern: UnsafeMutableRawPointer(baseAddress).advanced(by: Int(offset))))!.volatileStore(value)
    }

    /// Control register 1
    var cr1: CR1 {
        get { CR1(rawValue: ld(Offsets.CR1)) }
        set { st(Offsets.CR1, newValue.rawValue) }
    }
    /// Control register 2
    var cr2: CR2 {
        get { CR2(rawValue: ld(Offsets.CR2)) }
        set { st(Offsets.CR2, newValue.rawValue) }
    }
    /// Control register 3
    var cr3: CR3 {
        get { CR3(rawValue: ld(Offsets.CR3)) }
        set { st(Offsets.CR3, newValue.rawValue) }
    }
    /// Baud rate register
    var brr: BRR {
        get { BRR(rawValue: ld(Offsets.BRR)) }
        set { st(Offsets.BRR, newValue.rawValue) }
    }
    /// Guard time and prescaler register
    var gtpr: GTPR {
        get { GTPR(rawValue: ld(Offsets.GTPR)) }
        set { st(Offsets.GTPR, newValue.rawValue) }
    }
    /// Receiver timeout register
    var rtor: RTOR {
        get { RTOR(rawValue: ld(Offsets.RTOR)) }
        set { st(Offsets.RTOR, newValue.rawValue) }
    }
    /// Request register
    var rqr: RQR {
        get { RQR(rawValue: ld(Offsets.RQR)) }
        set { st(Offsets.RQR, newValue.rawValue) }
    }
    /// Interrupt & status register
    var isr: ISR {
        get { ISR(rawValue: ld(Offsets.ISR)) }
        set { st(Offsets.ISR, newValue.rawValue) }
    }
    /// Interrupt flag clear register
    var icr: ICR {
        get { ICR(rawValue: ld(Offsets.ICR)) }
        set { st(Offsets.ICR, newValue.rawValue) }
    }
    /// Receive data register
    var rdr: RDR {
        get { RDR(rawValue: ld(Offsets.RDR)) }
        set { st(Offsets.RDR, newValue.rawValue) }
    }
    /// Transmit data register
    var tdr: TDR {
        get { TDR(rawValue: ld(Offsets.TDR)) }
        set { st(Offsets.TDR, newValue.rawValue) }
    }
}

extension USART {
    struct CR1 {
        var rawValue: UInt32

        static let m1_offset = UInt32(28)
        static let m1_mask = UInt32(0b1) &<< m1_offset
        var m1: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.m1_mask)) >> USART.CR1.m1_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.m1_mask
                let shift = (UInt32(newValue) << USART.CR1.m1_offset) & USART.CR1.m1_mask
                self.rawValue = preserve | shift
            }
        }

        static let eobie_offset = UInt32(27)
        static let eobie_mask = UInt32(0b1) &<< eobie_offset
        var eobie: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.eobie_mask)) >> USART.CR1.eobie_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.eobie_mask
                let shift = (UInt32(newValue) << USART.CR1.eobie_offset) & USART.CR1.eobie_mask
                self.rawValue = preserve | shift
            }
        }

        static let rtoie_offset = UInt32(26)
        static let rtoie_mask = UInt32(0b1) &<< rtoie_offset
        var rtoie: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.rtoie_mask)) >> USART.CR1.rtoie_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.rtoie_mask
                let shift = (UInt32(newValue) << USART.CR1.rtoie_offset) & USART.CR1.rtoie_mask
                self.rawValue = preserve | shift
            }
        }

        static let deat4_offset = UInt32(25)
        static let deat4_mask = UInt32(0b1) &<< deat4_offset
        var deat4: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.deat4_mask)) >> USART.CR1.deat4_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.deat4_mask
                let shift = (UInt32(newValue) << USART.CR1.deat4_offset) & USART.CR1.deat4_mask
                self.rawValue = preserve | shift
            }
        }

        static let deat3_offset = UInt32(24)
        static let deat3_mask = UInt32(0b1) &<< deat3_offset
        var deat3: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.deat3_mask)) >> USART.CR1.deat3_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.deat3_mask
                let shift = (UInt32(newValue) << USART.CR1.deat3_offset) & USART.CR1.deat3_mask
                self.rawValue = preserve | shift
            }
        }

        static let deat2_offset = UInt32(23)
        static let deat2_mask = UInt32(0b1) &<< deat2_offset
        var deat2: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.deat2_mask)) >> USART.CR1.deat2_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.deat2_mask
                let shift = (UInt32(newValue) << USART.CR1.deat2_offset) & USART.CR1.deat2_mask
                self.rawValue = preserve | shift
            }
        }

        static let deat1_offset = UInt32(22)
        static let deat1_mask = UInt32(0b1) &<< deat1_offset
        var deat1: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.deat1_mask)) >> USART.CR1.deat1_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.deat1_mask
                let shift = (UInt32(newValue) << USART.CR1.deat1_offset) & USART.CR1.deat1_mask
                self.rawValue = preserve | shift
            }
        }

        static let deat0_offset = UInt32(21)
        static let deat0_mask = UInt32(0b1) &<< deat0_offset
        var deat0: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.deat0_mask)) >> USART.CR1.deat0_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.deat0_mask
                let shift = (UInt32(newValue) << USART.CR1.deat0_offset) & USART.CR1.deat0_mask
                self.rawValue = preserve | shift
            }
        }

        static let dedt4_offset = UInt32(20)
        static let dedt4_mask = UInt32(0b1) &<< dedt4_offset
        var dedt4: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.dedt4_mask)) >> USART.CR1.dedt4_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.dedt4_mask
                let shift = (UInt32(newValue) << USART.CR1.dedt4_offset) & USART.CR1.dedt4_mask
                self.rawValue = preserve | shift
            }
        }

        static let dedt3_offset = UInt32(19)
        static let dedt3_mask = UInt32(0b1) &<< dedt3_offset
        var dedt3: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.dedt3_mask)) >> USART.CR1.dedt3_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.dedt3_mask
                let shift = (UInt32(newValue) << USART.CR1.dedt3_offset) & USART.CR1.dedt3_mask
                self.rawValue = preserve | shift
            }
        }

        static let dedt2_offset = UInt32(18)
        static let dedt2_mask = UInt32(0b1) &<< dedt2_offset
        var dedt2: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.dedt2_mask)) >> USART.CR1.dedt2_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.dedt2_mask
                let shift = (UInt32(newValue) << USART.CR1.dedt2_offset) & USART.CR1.dedt2_mask
                self.rawValue = preserve | shift
            }
        }

        static let dedt1_offset = UInt32(17)
        static let dedt1_mask = UInt32(0b1) &<< dedt1_offset
        var dedt1: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.dedt1_mask)) >> USART.CR1.dedt1_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.dedt1_mask
                let shift = (UInt32(newValue) << USART.CR1.dedt1_offset) & USART.CR1.dedt1_mask
                self.rawValue = preserve | shift
            }
        }

        static let dedt0_offset = UInt32(16)
        static let dedt0_mask = UInt32(0b1) &<< dedt0_offset
        var dedt0: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.dedt0_mask)) >> USART.CR1.dedt0_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.dedt0_mask
                let shift = (UInt32(newValue) << USART.CR1.dedt0_offset) & USART.CR1.dedt0_mask
                self.rawValue = preserve | shift
            }
        }

        static let over8_offset = UInt32(15)
        static let over8_mask = UInt32(0b1) &<< over8_offset
        var over8: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.over8_mask)) >> USART.CR1.over8_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.over8_mask
                let shift = (UInt32(newValue) << USART.CR1.over8_offset) & USART.CR1.over8_mask
                self.rawValue = preserve | shift
            }
        }

        static let cmie_offset = UInt32(14)
        static let cmie_mask = UInt32(0b1) &<< cmie_offset
        var cmie: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.cmie_mask)) >> USART.CR1.cmie_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.cmie_mask
                let shift = (UInt32(newValue) << USART.CR1.cmie_offset) & USART.CR1.cmie_mask
                self.rawValue = preserve | shift
            }
        }

        static let mme_offset = UInt32(13)
        static let mme_mask = UInt32(0b1) &<< mme_offset
        var mme: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.mme_mask)) >> USART.CR1.mme_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.mme_mask
                let shift = (UInt32(newValue) << USART.CR1.mme_offset) & USART.CR1.mme_mask
                self.rawValue = preserve | shift
            }
        }

        static let m0_offset = UInt32(12)
        static let m0_mask = UInt32(0b1) &<< m0_offset
        var m0: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.m0_mask)) >> USART.CR1.m0_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.m0_mask
                let shift = (UInt32(newValue) << USART.CR1.m0_offset) & USART.CR1.m0_mask
                self.rawValue = preserve | shift
            }
        }

        static let wake_offset = UInt32(11)
        static let wake_mask = UInt32(0b1) &<< wake_offset
        var wake: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.wake_mask)) >> USART.CR1.wake_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.wake_mask
                let shift = (UInt32(newValue) << USART.CR1.wake_offset) & USART.CR1.wake_mask
                self.rawValue = preserve | shift
            }
        }

        static let pce_offset = UInt32(10)
        static let pce_mask = UInt32(0b1) &<< pce_offset
        var pce: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.pce_mask)) >> USART.CR1.pce_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.pce_mask
                let shift = (UInt32(newValue) << USART.CR1.pce_offset) & USART.CR1.pce_mask
                self.rawValue = preserve | shift
            }
        }

        static let ps_offset = UInt32(9)
        static let ps_mask = UInt32(0b1) &<< ps_offset
        var ps: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.ps_mask)) >> USART.CR1.ps_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.ps_mask
                let shift = (UInt32(newValue) << USART.CR1.ps_offset) & USART.CR1.ps_mask
                self.rawValue = preserve | shift
            }
        }

        static let peie_offset = UInt32(8)
        static let peie_mask = UInt32(0b1) &<< peie_offset
        var peie: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.peie_mask)) >> USART.CR1.peie_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.peie_mask
                let shift = (UInt32(newValue) << USART.CR1.peie_offset) & USART.CR1.peie_mask
                self.rawValue = preserve | shift
            }
        }

        static let txeie_offset = UInt32(7)
        static let txeie_mask = UInt32(0b1) &<< txeie_offset
        var txeie: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.txeie_mask)) >> USART.CR1.txeie_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.txeie_mask
                let shift = (UInt32(newValue) << USART.CR1.txeie_offset) & USART.CR1.txeie_mask
                self.rawValue = preserve | shift
            }
        }

        static let tcie_offset = UInt32(6)
        static let tcie_mask = UInt32(0b1) &<< tcie_offset
        var tcie: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.tcie_mask)) >> USART.CR1.tcie_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.tcie_mask
                let shift = (UInt32(newValue) << USART.CR1.tcie_offset) & USART.CR1.tcie_mask
                self.rawValue = preserve | shift
            }
        }

        static let rxneie_offset = UInt32(5)
        static let rxneie_mask = UInt32(0b1) &<< rxneie_offset
        var rxneie: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.rxneie_mask)) >> USART.CR1.rxneie_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.rxneie_mask
                let shift = (UInt32(newValue) << USART.CR1.rxneie_offset) & USART.CR1.rxneie_mask
                self.rawValue = preserve | shift
            }
        }

        static let idleie_offset = UInt32(4)
        static let idleie_mask = UInt32(0b1) &<< idleie_offset
        var idleie: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.idleie_mask)) >> USART.CR1.idleie_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.idleie_mask
                let shift = (UInt32(newValue) << USART.CR1.idleie_offset) & USART.CR1.idleie_mask
                self.rawValue = preserve | shift
            }
        }

        static let te_offset = UInt32(3)
        static let te_mask = UInt32(0b1) &<< te_offset
        var te: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.te_mask)) >> USART.CR1.te_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.te_mask
                let shift = (UInt32(newValue) << USART.CR1.te_offset) & USART.CR1.te_mask
                self.rawValue = preserve | shift
            }
        }

        static let re_offset = UInt32(2)
        static let re_mask = UInt32(0b1) &<< re_offset
        var re: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.re_mask)) >> USART.CR1.re_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.re_mask
                let shift = (UInt32(newValue) << USART.CR1.re_offset) & USART.CR1.re_mask
                self.rawValue = preserve | shift
            }
        }

        static let uesm_offset = UInt32(1)
        static let uesm_mask = UInt32(0b1) &<< uesm_offset
        var uesm: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.uesm_mask)) >> USART.CR1.uesm_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.uesm_mask
                let shift = (UInt32(newValue) << USART.CR1.uesm_offset) & USART.CR1.uesm_mask
                self.rawValue = preserve | shift
            }
        }

        static let ue_offset = UInt32(0)
        static let ue_mask = UInt32(0b1) &<< ue_offset
        var ue: UInt8 {
            get { UInt8((self.rawValue & (USART.CR1.ue_mask)) >> USART.CR1.ue_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR1.ue_mask
                let shift = (UInt32(newValue) << USART.CR1.ue_offset) & USART.CR1.ue_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct CR2 {
        var rawValue: UInt32

        static let add4_7_offset = UInt32(28)
        static let add4_7_mask = UInt32(0b1111) &<< add4_7_offset
        var add4_7: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.add4_7_mask)) >> USART.CR2.add4_7_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.add4_7_mask
                let shift = (UInt32(newValue) << USART.CR2.add4_7_offset) & USART.CR2.add4_7_mask
                self.rawValue = preserve | shift
            }
        }

        static let add0_3_offset = UInt32(24)
        static let add0_3_mask = UInt32(0b1111) &<< add0_3_offset
        var add0_3: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.add0_3_mask)) >> USART.CR2.add0_3_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.add0_3_mask
                let shift = (UInt32(newValue) << USART.CR2.add0_3_offset) & USART.CR2.add0_3_mask
                self.rawValue = preserve | shift
            }
        }

        static let rtoen_offset = UInt32(23)
        static let rtoen_mask = UInt32(0b1) &<< rtoen_offset
        var rtoen: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.rtoen_mask)) >> USART.CR2.rtoen_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.rtoen_mask
                let shift = (UInt32(newValue) << USART.CR2.rtoen_offset) & USART.CR2.rtoen_mask
                self.rawValue = preserve | shift
            }
        }

        static let abrmod1_offset = UInt32(22)
        static let abrmod1_mask = UInt32(0b1) &<< abrmod1_offset
        var abrmod1: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.abrmod1_mask)) >> USART.CR2.abrmod1_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.abrmod1_mask
                let shift = (UInt32(newValue) << USART.CR2.abrmod1_offset) & USART.CR2.abrmod1_mask
                self.rawValue = preserve | shift
            }
        }

        static let abrmod0_offset = UInt32(21)
        static let abrmod0_mask = UInt32(0b1) &<< abrmod0_offset
        var abrmod0: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.abrmod0_mask)) >> USART.CR2.abrmod0_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.abrmod0_mask
                let shift = (UInt32(newValue) << USART.CR2.abrmod0_offset) & USART.CR2.abrmod0_mask
                self.rawValue = preserve | shift
            }
        }

        static let abren_offset = UInt32(20)
        static let abren_mask = UInt32(0b1) &<< abren_offset
        var abren: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.abren_mask)) >> USART.CR2.abren_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.abren_mask
                let shift = (UInt32(newValue) << USART.CR2.abren_offset) & USART.CR2.abren_mask
                self.rawValue = preserve | shift
            }
        }

        static let msbfirst_offset = UInt32(19)
        static let msbfirst_mask = UInt32(0b1) &<< msbfirst_offset
        var msbfirst: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.msbfirst_mask)) >> USART.CR2.msbfirst_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.msbfirst_mask
                let shift = (UInt32(newValue) << USART.CR2.msbfirst_offset) & USART.CR2.msbfirst_mask
                self.rawValue = preserve | shift
            }
        }

        static let tainv_offset = UInt32(18)
        static let tainv_mask = UInt32(0b1) &<< tainv_offset
        var tainv: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.tainv_mask)) >> USART.CR2.tainv_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.tainv_mask
                let shift = (UInt32(newValue) << USART.CR2.tainv_offset) & USART.CR2.tainv_mask
                self.rawValue = preserve | shift
            }
        }

        static let txinv_offset = UInt32(17)
        static let txinv_mask = UInt32(0b1) &<< txinv_offset
        var txinv: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.txinv_mask)) >> USART.CR2.txinv_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.txinv_mask
                let shift = (UInt32(newValue) << USART.CR2.txinv_offset) & USART.CR2.txinv_mask
                self.rawValue = preserve | shift
            }
        }

        static let rxinv_offset = UInt32(16)
        static let rxinv_mask = UInt32(0b1) &<< rxinv_offset
        var rxinv: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.rxinv_mask)) >> USART.CR2.rxinv_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.rxinv_mask
                let shift = (UInt32(newValue) << USART.CR2.rxinv_offset) & USART.CR2.rxinv_mask
                self.rawValue = preserve | shift
            }
        }

        static let swap_offset = UInt32(15)
        static let swap_mask = UInt32(0b1) &<< swap_offset
        var swap: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.swap_mask)) >> USART.CR2.swap_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.swap_mask
                let shift = (UInt32(newValue) << USART.CR2.swap_offset) & USART.CR2.swap_mask
                self.rawValue = preserve | shift
            }
        }

        static let linen_offset = UInt32(14)
        static let linen_mask = UInt32(0b1) &<< linen_offset
        var linen: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.linen_mask)) >> USART.CR2.linen_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.linen_mask
                let shift = (UInt32(newValue) << USART.CR2.linen_offset) & USART.CR2.linen_mask
                self.rawValue = preserve | shift
            }
        }

        static let stop_offset = UInt32(12)
        static let stop_mask = UInt32(0b11) &<< stop_offset
        var stop: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.stop_mask)) >> USART.CR2.stop_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.stop_mask
                let shift = (UInt32(newValue) << USART.CR2.stop_offset) & USART.CR2.stop_mask
                self.rawValue = preserve | shift
            }
        }

        static let clken_offset = UInt32(11)
        static let clken_mask = UInt32(0b1) &<< clken_offset
        var clken: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.clken_mask)) >> USART.CR2.clken_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.clken_mask
                let shift = (UInt32(newValue) << USART.CR2.clken_offset) & USART.CR2.clken_mask
                self.rawValue = preserve | shift
            }
        }

        static let cpol_offset = UInt32(10)
        static let cpol_mask = UInt32(0b1) &<< cpol_offset
        var cpol: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.cpol_mask)) >> USART.CR2.cpol_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.cpol_mask
                let shift = (UInt32(newValue) << USART.CR2.cpol_offset) & USART.CR2.cpol_mask
                self.rawValue = preserve | shift
            }
        }

        static let cpha_offset = UInt32(9)
        static let cpha_mask = UInt32(0b1) &<< cpha_offset
        var cpha: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.cpha_mask)) >> USART.CR2.cpha_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.cpha_mask
                let shift = (UInt32(newValue) << USART.CR2.cpha_offset) & USART.CR2.cpha_mask
                self.rawValue = preserve | shift
            }
        }

        static let lbcl_offset = UInt32(8)
        static let lbcl_mask = UInt32(0b1) &<< lbcl_offset
        var lbcl: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.lbcl_mask)) >> USART.CR2.lbcl_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.lbcl_mask
                let shift = (UInt32(newValue) << USART.CR2.lbcl_offset) & USART.CR2.lbcl_mask
                self.rawValue = preserve | shift
            }
        }

        static let lbdie_offset = UInt32(6)
        static let lbdie_mask = UInt32(0b1) &<< lbdie_offset
        var lbdie: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.lbdie_mask)) >> USART.CR2.lbdie_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.lbdie_mask
                let shift = (UInt32(newValue) << USART.CR2.lbdie_offset) & USART.CR2.lbdie_mask
                self.rawValue = preserve | shift
            }
        }

        static let lbdl_offset = UInt32(5)
        static let lbdl_mask = UInt32(0b1) &<< lbdl_offset
        var lbdl: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.lbdl_mask)) >> USART.CR2.lbdl_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.lbdl_mask
                let shift = (UInt32(newValue) << USART.CR2.lbdl_offset) & USART.CR2.lbdl_mask
                self.rawValue = preserve | shift
            }
        }

        static let addm7_offset = UInt32(4)
        static let addm7_mask = UInt32(0b1) &<< addm7_offset
        var addm7: UInt8 {
            get { UInt8((self.rawValue & (USART.CR2.addm7_mask)) >> USART.CR2.addm7_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR2.addm7_mask
                let shift = (UInt32(newValue) << USART.CR2.addm7_offset) & USART.CR2.addm7_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct CR3 {
        var rawValue: UInt32

        static let wufie_offset = UInt32(22)
        static let wufie_mask = UInt32(0b1) &<< wufie_offset
        var wufie: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.wufie_mask)) >> USART.CR3.wufie_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.wufie_mask
                let shift = (UInt32(newValue) << USART.CR3.wufie_offset) & USART.CR3.wufie_mask
                self.rawValue = preserve | shift
            }
        }

        static let wus_offset = UInt32(20)
        static let wus_mask = UInt32(0b11) &<< wus_offset
        var wus: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.wus_mask)) >> USART.CR3.wus_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.wus_mask
                let shift = (UInt32(newValue) << USART.CR3.wus_offset) & USART.CR3.wus_mask
                self.rawValue = preserve | shift
            }
        }

        static let scarcnt_offset = UInt32(17)
        static let scarcnt_mask = UInt32(0b111) &<< scarcnt_offset
        var scarcnt: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.scarcnt_mask)) >> USART.CR3.scarcnt_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.scarcnt_mask
                let shift = (UInt32(newValue) << USART.CR3.scarcnt_offset) & USART.CR3.scarcnt_mask
                self.rawValue = preserve | shift
            }
        }

        static let dep_offset = UInt32(15)
        static let dep_mask = UInt32(0b1) &<< dep_offset
        var dep: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.dep_mask)) >> USART.CR3.dep_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.dep_mask
                let shift = (UInt32(newValue) << USART.CR3.dep_offset) & USART.CR3.dep_mask
                self.rawValue = preserve | shift
            }
        }

        static let dem_offset = UInt32(14)
        static let dem_mask = UInt32(0b1) &<< dem_offset
        var dem: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.dem_mask)) >> USART.CR3.dem_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.dem_mask
                let shift = (UInt32(newValue) << USART.CR3.dem_offset) & USART.CR3.dem_mask
                self.rawValue = preserve | shift
            }
        }

        static let ddre_offset = UInt32(13)
        static let ddre_mask = UInt32(0b1) &<< ddre_offset
        var ddre: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.ddre_mask)) >> USART.CR3.ddre_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.ddre_mask
                let shift = (UInt32(newValue) << USART.CR3.ddre_offset) & USART.CR3.ddre_mask
                self.rawValue = preserve | shift
            }
        }

        static let ovrdis_offset = UInt32(12)
        static let ovrdis_mask = UInt32(0b1) &<< ovrdis_offset
        var ovrdis: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.ovrdis_mask)) >> USART.CR3.ovrdis_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.ovrdis_mask
                let shift = (UInt32(newValue) << USART.CR3.ovrdis_offset) & USART.CR3.ovrdis_mask
                self.rawValue = preserve | shift
            }
        }

        static let onebit_offset = UInt32(11)
        static let onebit_mask = UInt32(0b1) &<< onebit_offset
        var onebit: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.onebit_mask)) >> USART.CR3.onebit_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.onebit_mask
                let shift = (UInt32(newValue) << USART.CR3.onebit_offset) & USART.CR3.onebit_mask
                self.rawValue = preserve | shift
            }
        }

        static let ctsie_offset = UInt32(10)
        static let ctsie_mask = UInt32(0b1) &<< ctsie_offset
        var ctsie: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.ctsie_mask)) >> USART.CR3.ctsie_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.ctsie_mask
                let shift = (UInt32(newValue) << USART.CR3.ctsie_offset) & USART.CR3.ctsie_mask
                self.rawValue = preserve | shift
            }
        }

        static let ctse_offset = UInt32(9)
        static let ctse_mask = UInt32(0b1) &<< ctse_offset
        var ctse: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.ctse_mask)) >> USART.CR3.ctse_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.ctse_mask
                let shift = (UInt32(newValue) << USART.CR3.ctse_offset) & USART.CR3.ctse_mask
                self.rawValue = preserve | shift
            }
        }

        static let rtse_offset = UInt32(8)
        static let rtse_mask = UInt32(0b1) &<< rtse_offset
        var rtse: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.rtse_mask)) >> USART.CR3.rtse_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.rtse_mask
                let shift = (UInt32(newValue) << USART.CR3.rtse_offset) & USART.CR3.rtse_mask
                self.rawValue = preserve | shift
            }
        }

        static let dmat_offset = UInt32(7)
        static let dmat_mask = UInt32(0b1) &<< dmat_offset
        var dmat: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.dmat_mask)) >> USART.CR3.dmat_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.dmat_mask
                let shift = (UInt32(newValue) << USART.CR3.dmat_offset) & USART.CR3.dmat_mask
                self.rawValue = preserve | shift
            }
        }

        static let dmar_offset = UInt32(6)
        static let dmar_mask = UInt32(0b1) &<< dmar_offset
        var dmar: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.dmar_mask)) >> USART.CR3.dmar_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.dmar_mask
                let shift = (UInt32(newValue) << USART.CR3.dmar_offset) & USART.CR3.dmar_mask
                self.rawValue = preserve | shift
            }
        }

        static let scen_offset = UInt32(5)
        static let scen_mask = UInt32(0b1) &<< scen_offset
        var scen: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.scen_mask)) >> USART.CR3.scen_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.scen_mask
                let shift = (UInt32(newValue) << USART.CR3.scen_offset) & USART.CR3.scen_mask
                self.rawValue = preserve | shift
            }
        }

        static let nack_offset = UInt32(4)
        static let nack_mask = UInt32(0b1) &<< nack_offset
        var nack: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.nack_mask)) >> USART.CR3.nack_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.nack_mask
                let shift = (UInt32(newValue) << USART.CR3.nack_offset) & USART.CR3.nack_mask
                self.rawValue = preserve | shift
            }
        }

        static let hdsel_offset = UInt32(3)
        static let hdsel_mask = UInt32(0b1) &<< hdsel_offset
        var hdsel: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.hdsel_mask)) >> USART.CR3.hdsel_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.hdsel_mask
                let shift = (UInt32(newValue) << USART.CR3.hdsel_offset) & USART.CR3.hdsel_mask
                self.rawValue = preserve | shift
            }
        }

        static let irlp_offset = UInt32(2)
        static let irlp_mask = UInt32(0b1) &<< irlp_offset
        var irlp: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.irlp_mask)) >> USART.CR3.irlp_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.irlp_mask
                let shift = (UInt32(newValue) << USART.CR3.irlp_offset) & USART.CR3.irlp_mask
                self.rawValue = preserve | shift
            }
        }

        static let iren_offset = UInt32(1)
        static let iren_mask = UInt32(0b1) &<< iren_offset
        var iren: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.iren_mask)) >> USART.CR3.iren_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.iren_mask
                let shift = (UInt32(newValue) << USART.CR3.iren_offset) & USART.CR3.iren_mask
                self.rawValue = preserve | shift
            }
        }

        static let eie_offset = UInt32(0)
        static let eie_mask = UInt32(0b1) &<< eie_offset
        var eie: UInt8 {
            get { UInt8((self.rawValue & (USART.CR3.eie_mask)) >> USART.CR3.eie_offset) }
            set {
                let preserve = self.rawValue & ~USART.CR3.eie_mask
                let shift = (UInt32(newValue) << USART.CR3.eie_offset) & USART.CR3.eie_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct BRR {
        var rawValue: UInt32

        static let div_mantissa_offset = UInt32(4)
        static let div_mantissa_mask = UInt32(0b111111111111) &<< div_mantissa_offset
        var div_mantissa: UInt16 {
            get { UInt16((self.rawValue & (USART.BRR.div_mantissa_mask)) >> USART.BRR.div_mantissa_offset) }
            set {
                let preserve = self.rawValue & ~USART.BRR.div_mantissa_mask
                let shift = (UInt32(newValue) << USART.BRR.div_mantissa_offset) & USART.BRR.div_mantissa_mask
                self.rawValue = preserve | shift
            }
        }

        static let div_fraction_offset = UInt32(0)
        static let div_fraction_mask = UInt32(0b1111) &<< div_fraction_offset
        var div_fraction: UInt8 {
            get { UInt8((self.rawValue & (USART.BRR.div_fraction_mask)) >> USART.BRR.div_fraction_offset) }
            set {
                let preserve = self.rawValue & ~USART.BRR.div_fraction_mask
                let shift = (UInt32(newValue) << USART.BRR.div_fraction_offset) & USART.BRR.div_fraction_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct GTPR {
        var rawValue: UInt32

        static let gt_offset = UInt32(8)
        static let gt_mask = UInt32(0b11111111) &<< gt_offset
        var gt: UInt8 {
            get { UInt8((self.rawValue & (USART.GTPR.gt_mask)) >> USART.GTPR.gt_offset) }
            set {
                let preserve = self.rawValue & ~USART.GTPR.gt_mask
                let shift = (UInt32(newValue) << USART.GTPR.gt_offset) & USART.GTPR.gt_mask
                self.rawValue = preserve | shift
            }
        }

        static let psc_offset = UInt32(0)
        static let psc_mask = UInt32(0b11111111) &<< psc_offset
        var psc: UInt8 {
            get { UInt8((self.rawValue & (USART.GTPR.psc_mask)) >> USART.GTPR.psc_offset) }
            set {
                let preserve = self.rawValue & ~USART.GTPR.psc_mask
                let shift = (UInt32(newValue) << USART.GTPR.psc_offset) & USART.GTPR.psc_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct RTOR {
        var rawValue: UInt32

        static let blen_offset = UInt32(24)
        static let blen_mask = UInt32(0b11111111) &<< blen_offset
        var blen: UInt8 {
            get { UInt8((self.rawValue & (USART.RTOR.blen_mask)) >> USART.RTOR.blen_offset) }
            set {
                let preserve = self.rawValue & ~USART.RTOR.blen_mask
                let shift = (UInt32(newValue) << USART.RTOR.blen_offset) & USART.RTOR.blen_mask
                self.rawValue = preserve | shift
            }
        }

        static let rto_offset = UInt32(0)
        static let rto_mask = UInt32(0b111111111111111111111111) &<< rto_offset
        var rto: UInt32 {
            get { UInt32((self.rawValue & (USART.RTOR.rto_mask)) >> USART.RTOR.rto_offset) }
            set {
                let preserve = self.rawValue & ~USART.RTOR.rto_mask
                let shift = (UInt32(newValue) << USART.RTOR.rto_offset) & USART.RTOR.rto_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct RQR {
        var rawValue: UInt32

        static let txfrq_offset = UInt32(4)
        static let txfrq_mask = UInt32(0b1) &<< txfrq_offset
        var txfrq: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.RQR.txfrq_offset) & USART.RQR.txfrq_mask
            }
        }

        static let rxfrq_offset = UInt32(3)
        static let rxfrq_mask = UInt32(0b1) &<< rxfrq_offset
        var rxfrq: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.RQR.rxfrq_offset) & USART.RQR.rxfrq_mask
            }
        }

        static let mmrq_offset = UInt32(2)
        static let mmrq_mask = UInt32(0b1) &<< mmrq_offset
        var mmrq: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.RQR.mmrq_offset) & USART.RQR.mmrq_mask
            }
        }

        static let sbkrq_offset = UInt32(1)
        static let sbkrq_mask = UInt32(0b1) &<< sbkrq_offset
        var sbkrq: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.RQR.sbkrq_offset) & USART.RQR.sbkrq_mask
            }
        }

        static let abrrq_offset = UInt32(0)
        static let abrrq_mask = UInt32(0b1) &<< abrrq_offset
        var abrrq: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.RQR.abrrq_offset) & USART.RQR.abrrq_mask
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct ISR {
        var rawValue: UInt32

        static let reack_offset = UInt32(22)
        static let reack_mask = UInt32(0b1) &<< reack_offset
        var reack: UInt8 {
            UInt8((self.rawValue & (USART.ISR.reack_mask)) >> USART.ISR.reack_offset)
        }

        static let teack_offset = UInt32(21)
        static let teack_mask = UInt32(0b1) &<< teack_offset
        var teack: UInt8 {
            UInt8((self.rawValue & (USART.ISR.teack_mask)) >> USART.ISR.teack_offset)
        }

        static let wuf_offset = UInt32(20)
        static let wuf_mask = UInt32(0b1) &<< wuf_offset
        var wuf: UInt8 {
            UInt8((self.rawValue & (USART.ISR.wuf_mask)) >> USART.ISR.wuf_offset)
        }

        static let rwu_offset = UInt32(19)
        static let rwu_mask = UInt32(0b1) &<< rwu_offset
        var rwu: UInt8 {
            UInt8((self.rawValue & (USART.ISR.rwu_mask)) >> USART.ISR.rwu_offset)
        }

        static let sbkf_offset = UInt32(18)
        static let sbkf_mask = UInt32(0b1) &<< sbkf_offset
        var sbkf: UInt8 {
            UInt8((self.rawValue & (USART.ISR.sbkf_mask)) >> USART.ISR.sbkf_offset)
        }

        static let cmf_offset = UInt32(17)
        static let cmf_mask = UInt32(0b1) &<< cmf_offset
        var cmf: UInt8 {
            UInt8((self.rawValue & (USART.ISR.cmf_mask)) >> USART.ISR.cmf_offset)
        }

        static let busy_offset = UInt32(16)
        static let busy_mask = UInt32(0b1) &<< busy_offset
        var busy: UInt8 {
            UInt8((self.rawValue & (USART.ISR.busy_mask)) >> USART.ISR.busy_offset)
        }

        static let abrf_offset = UInt32(15)
        static let abrf_mask = UInt32(0b1) &<< abrf_offset
        var abrf: UInt8 {
            UInt8((self.rawValue & (USART.ISR.abrf_mask)) >> USART.ISR.abrf_offset)
        }

        static let abre_offset = UInt32(14)
        static let abre_mask = UInt32(0b1) &<< abre_offset
        var abre: UInt8 {
            UInt8((self.rawValue & (USART.ISR.abre_mask)) >> USART.ISR.abre_offset)
        }

        static let eobf_offset = UInt32(12)
        static let eobf_mask = UInt32(0b1) &<< eobf_offset
        var eobf: UInt8 {
            UInt8((self.rawValue & (USART.ISR.eobf_mask)) >> USART.ISR.eobf_offset)
        }

        static let rtof_offset = UInt32(11)
        static let rtof_mask = UInt32(0b1) &<< rtof_offset
        var rtof: UInt8 {
            UInt8((self.rawValue & (USART.ISR.rtof_mask)) >> USART.ISR.rtof_offset)
        }

        static let cts_offset = UInt32(10)
        static let cts_mask = UInt32(0b1) &<< cts_offset
        var cts: UInt8 {
            UInt8((self.rawValue & (USART.ISR.cts_mask)) >> USART.ISR.cts_offset)
        }

        static let ctsif_offset = UInt32(9)
        static let ctsif_mask = UInt32(0b1) &<< ctsif_offset
        var ctsif: UInt8 {
            UInt8((self.rawValue & (USART.ISR.ctsif_mask)) >> USART.ISR.ctsif_offset)
        }

        static let lbdf_offset = UInt32(8)
        static let lbdf_mask = UInt32(0b1) &<< lbdf_offset
        var lbdf: UInt8 {
            UInt8((self.rawValue & (USART.ISR.lbdf_mask)) >> USART.ISR.lbdf_offset)
        }

        static let txe_offset = UInt32(7)
        static let txe_mask = UInt32(0b1) &<< txe_offset
        var txe: UInt8 {
            UInt8((self.rawValue & (USART.ISR.txe_mask)) >> USART.ISR.txe_offset)
        }

        static let tc_offset = UInt32(6)
        static let tc_mask = UInt32(0b1) &<< tc_offset
        var tc: UInt8 {
            UInt8((self.rawValue & (USART.ISR.tc_mask)) >> USART.ISR.tc_offset)
        }

        static let rxne_offset = UInt32(5)
        static let rxne_mask = UInt32(0b1) &<< rxne_offset
        var rxne: UInt8 {
            UInt8((self.rawValue & (USART.ISR.rxne_mask)) >> USART.ISR.rxne_offset)
        }

        static let idle_offset = UInt32(4)
        static let idle_mask = UInt32(0b1) &<< idle_offset
        var idle: UInt8 {
            UInt8((self.rawValue & (USART.ISR.idle_mask)) >> USART.ISR.idle_offset)
        }

        static let ore_offset = UInt32(3)
        static let ore_mask = UInt32(0b1) &<< ore_offset
        var ore: UInt8 {
            UInt8((self.rawValue & (USART.ISR.ore_mask)) >> USART.ISR.ore_offset)
        }

        static let nf_offset = UInt32(2)
        static let nf_mask = UInt32(0b1) &<< nf_offset
        var nf: UInt8 {
            UInt8((self.rawValue & (USART.ISR.nf_mask)) >> USART.ISR.nf_offset)
        }

        static let fe_offset = UInt32(1)
        static let fe_mask = UInt32(0b1) &<< fe_offset
        var fe: UInt8 {
            UInt8((self.rawValue & (USART.ISR.fe_mask)) >> USART.ISR.fe_offset)
        }

        static let pe_offset = UInt32(0)
        static let pe_mask = UInt32(0b1) &<< pe_offset
        var pe: UInt8 {
            UInt8((self.rawValue & (USART.ISR.pe_mask)) >> USART.ISR.pe_offset)
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct ICR {
        var rawValue: UInt32

        static let wucf_offset = UInt32(20)
        static let wucf_mask = UInt32(0b1) &<< wucf_offset
        var wucf: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.ICR.wucf_offset) & USART.ICR.wucf_mask
            }
        }

        static let cmcf_offset = UInt32(17)
        static let cmcf_mask = UInt32(0b1) &<< cmcf_offset
        var cmcf: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.ICR.cmcf_offset) & USART.ICR.cmcf_mask
            }
        }

        static let eobcf_offset = UInt32(12)
        static let eobcf_mask = UInt32(0b1) &<< eobcf_offset
        var eobcf: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.ICR.eobcf_offset) & USART.ICR.eobcf_mask
            }
        }

        static let rtocf_offset = UInt32(11)
        static let rtocf_mask = UInt32(0b1) &<< rtocf_offset
        var rtocf: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.ICR.rtocf_offset) & USART.ICR.rtocf_mask
            }
        }

        static let ctscf_offset = UInt32(9)
        static let ctscf_mask = UInt32(0b1) &<< ctscf_offset
        var ctscf: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.ICR.ctscf_offset) & USART.ICR.ctscf_mask
            }
        }

        static let lbdcf_offset = UInt32(8)
        static let lbdcf_mask = UInt32(0b1) &<< lbdcf_offset
        var lbdcf: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.ICR.lbdcf_offset) & USART.ICR.lbdcf_mask
            }
        }

        static let tccf_offset = UInt32(6)
        static let tccf_mask = UInt32(0b1) &<< tccf_offset
        var tccf: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.ICR.tccf_offset) & USART.ICR.tccf_mask
            }
        }

        static let idlecf_offset = UInt32(4)
        static let idlecf_mask = UInt32(0b1) &<< idlecf_offset
        var idlecf: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.ICR.idlecf_offset) & USART.ICR.idlecf_mask
            }
        }

        static let orecf_offset = UInt32(3)
        static let orecf_mask = UInt32(0b1) &<< orecf_offset
        var orecf: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.ICR.orecf_offset) & USART.ICR.orecf_mask
            }
        }

        static let ncf_offset = UInt32(2)
        static let ncf_mask = UInt32(0b1) &<< ncf_offset
        var ncf: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.ICR.ncf_offset) & USART.ICR.ncf_mask
            }
        }

        static let fecf_offset = UInt32(1)
        static let fecf_mask = UInt32(0b1) &<< fecf_offset
        var fecf: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.ICR.fecf_offset) & USART.ICR.fecf_mask
            }
        }

        static let pecf_offset = UInt32(0)
        static let pecf_mask = UInt32(0b1) &<< pecf_offset
        var pecf: UInt8 {
            get { fatalError("Trying to read a write-only field") }
            set {
                self.rawValue = (UInt32(newValue) << USART.ICR.pecf_offset) & USART.ICR.pecf_mask
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct RDR {
        var rawValue: UInt32

        static let rdr_offset = UInt32(0)
        static let rdr_mask = UInt32(0b111111111) &<< rdr_offset
        var rdr: UInt16 {
            UInt16((self.rawValue & (USART.RDR.rdr_mask)) >> USART.RDR.rdr_offset)
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    struct TDR {
        var rawValue: UInt32

        static let tdr_offset = UInt32(0)
        static let tdr_mask = UInt32(0b111111111) &<< tdr_offset
        var tdr: UInt16 {
            get { UInt16((self.rawValue & (USART.TDR.tdr_mask)) >> USART.TDR.tdr_offset) }
            set {
                let preserve = self.rawValue & ~USART.TDR.tdr_mask
                let shift = (UInt32(newValue) << USART.TDR.tdr_offset) & USART.TDR.tdr_mask
                self.rawValue = preserve | shift
            }
        }

        init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
}
