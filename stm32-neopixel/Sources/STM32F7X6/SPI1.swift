// Generated by svd2swift.

import MMIO

/// Serial peripheral interface
@RegisterBlock
public struct SPI1 {
  /// control register 1
  @RegisterBlock(offset: 0x0)
  public var cr1: Register<CR1>

  /// control register 2
  @RegisterBlock(offset: 0x4)
  public var cr2: Register<CR2>

  /// status register
  @RegisterBlock(offset: 0x8)
  public var sr: Register<SR>

  /// data register
  @RegisterBlock(offset: 0xc)
  public var dr: Register<DR>

  /// CRC polynomial register
  @RegisterBlock(offset: 0x10)
  public var crcpr: Register<CRCPR>

  /// RX CRC register
  @RegisterBlock(offset: 0x14)
  public var rxcrcr: Register<RXCRCR>

  /// TX CRC register
  @RegisterBlock(offset: 0x18)
  public var txcrcr: Register<TXCRCR>

  /// I2S configuration register
  @RegisterBlock(offset: 0x1c)
  public var i2scfgr: Register<I2SCFGR>

  /// I2S prescaler register
  @RegisterBlock(offset: 0x20)
  public var i2spr: Register<I2SPR>
}

extension SPI1 {
  /// control register 1
  @Register(bitWidth: 32)
  public struct CR1 {
    /// Bidirectional data mode enable
    @ReadWrite(bits: 15..<16, as: BIDIMODEValues.self)
    public var bidimode: BIDIMODE

    /// Output enable in bidirectional mode
    @ReadWrite(bits: 14..<15, as: BIDIOEValues.self)
    public var bidioe: BIDIOE

    /// Hardware CRC calculation enable
    @ReadWrite(bits: 13..<14, as: CRCENValues.self)
    public var crcen: CRCEN

    /// CRC transfer next
    @ReadWrite(bits: 12..<13, as: CRCNEXTValues.self)
    public var crcnext: CRCNEXT

    /// CRC length
    @ReadWrite(bits: 11..<12, as: CRCLValues.self)
    public var crcl: CRCL

    /// Receive only
    @ReadWrite(bits: 10..<11, as: RXONLYValues.self)
    public var rxonly: RXONLY

    /// Software slave management
    @ReadWrite(bits: 9..<10, as: SSMValues.self)
    public var ssm: SSM

    /// Internal slave select
    @ReadWrite(bits: 8..<9, as: SSIValues.self)
    public var ssi: SSI

    /// Frame format
    @ReadWrite(bits: 7..<8, as: LSBFIRSTValues.self)
    public var lsbfirst: LSBFIRST

    /// SPI enable
    @ReadWrite(bits: 6..<7, as: SPEValues.self)
    public var spe: SPE

    /// Baud rate control
    @ReadWrite(bits: 3..<6, as: BRValues.self)
    public var br: BR

    /// Master selection
    @ReadWrite(bits: 2..<3, as: MSTRValues.self)
    public var mstr: MSTR

    /// Clock polarity
    @ReadWrite(bits: 1..<2, as: CPOLValues.self)
    public var cpol: CPOL

    /// Clock phase
    @ReadWrite(bits: 0..<1, as: CPHAValues.self)
    public var cpha: CPHA
  }

  /// control register 2
  @Register(bitWidth: 32)
  public struct CR2 {
    /// Rx buffer DMA enable
    @ReadWrite(bits: 0..<1, as: RXDMAENValues.self)
    public var rxdmaen: RXDMAEN

    /// Tx buffer DMA enable
    @ReadWrite(bits: 1..<2, as: TXDMAENValues.self)
    public var txdmaen: TXDMAEN

    /// SS output enable
    @ReadWrite(bits: 2..<3, as: SSOEValues.self)
    public var ssoe: SSOE

    /// NSS pulse management
    @ReadWrite(bits: 3..<4, as: NSSPValues.self)
    public var nssp: NSSP

    /// Frame format
    @ReadWrite(bits: 4..<5, as: FRFValues.self)
    public var frf: FRF

    /// Error interrupt enable
    @ReadWrite(bits: 5..<6, as: ERRIEValues.self)
    public var errie: ERRIE

    /// RX buffer not empty interrupt enable
    @ReadWrite(bits: 6..<7, as: RXNEIEValues.self)
    public var rxneie: RXNEIE

    /// Tx buffer empty interrupt enable
    @ReadWrite(bits: 7..<8, as: TXEIEValues.self)
    public var txeie: TXEIE

    /// Data size
    @ReadWrite(bits: 8..<12, as: DSValues.self)
    public var ds: DS

    /// FIFO reception threshold
    @ReadWrite(bits: 12..<13, as: FRXTHValues.self)
    public var frxth: FRXTH

    /// Last DMA transfer for reception
    @ReadWrite(bits: 13..<14, as: LDMA_RXValues.self)
    public var ldma_rx: LDMA_RX

    /// Last DMA transfer for transmission
    @ReadWrite(bits: 14..<15, as: LDMA_TXValues.self)
    public var ldma_tx: LDMA_TX
  }

  /// status register
  @Register(bitWidth: 32)
  public struct SR {
    /// Frame format error
    @ReadOnly(bits: 8..<9)
    public var fre: FRE

    /// Busy flag
    @ReadOnly(bits: 7..<8)
    public var bsy: BSY

    /// Overrun flag
    @ReadOnly(bits: 6..<7)
    public var ovr: OVR

    /// Mode fault
    @ReadOnly(bits: 5..<6)
    public var modf: MODF

    /// CRC error flag
    @ReadWrite(bits: 4..<5)
    public var crcerr: CRCERR

    /// Underrun flag
    @ReadOnly(bits: 3..<4)
    public var udr: UDR

    /// Channel side
    @ReadOnly(bits: 2..<3)
    public var chside: CHSIDE

    /// Transmit buffer empty
    @ReadOnly(bits: 1..<2)
    public var txe: TXE

    /// Receive buffer not empty
    @ReadOnly(bits: 0..<1)
    public var rxne: RXNE

    /// FIFO reception level
    @ReadOnly(bits: 9..<11)
    public var frlvl: FRLVL

    /// FIFO Transmission Level
    @ReadOnly(bits: 11..<13)
    public var ftlvl: FTLVL
  }

  /// data register
  @Register(bitWidth: 32)
  public struct DR {
    /// Data register
    @ReadWrite(bits: 0..<16)
    public var dr_field: DR_FIELD
  }

  /// CRC polynomial register
  @Register(bitWidth: 32)
  public struct CRCPR {
    /// CRC polynomial register
    @ReadWrite(bits: 0..<16)
    public var crcpoly: CRCPOLY
  }

  /// RX CRC register
  @Register(bitWidth: 32)
  public struct RXCRCR {
    /// Rx CRC register
    @ReadOnly(bits: 0..<16)
    public var rxcrc: RxCRC
  }

  /// TX CRC register
  @Register(bitWidth: 32)
  public struct TXCRCR {
    /// Tx CRC register
    @ReadOnly(bits: 0..<16)
    public var txcrc: TxCRC
  }

  /// I2S configuration register
  @Register(bitWidth: 32)
  public struct I2SCFGR {
    /// I2S mode selection
    @ReadWrite(bits: 11..<12, as: I2SMODValues.self)
    public var i2smod: I2SMOD

    /// I2S Enable
    @ReadWrite(bits: 10..<11, as: I2SEValues.self)
    public var i2se: I2SE

    /// I2S configuration mode
    @ReadWrite(bits: 8..<10, as: I2SCFGValues.self)
    public var i2scfg: I2SCFG

    /// PCM frame synchronization
    @ReadWrite(bits: 7..<8, as: PCMSYNCValues.self)
    public var pcmsync: PCMSYNC

    /// I2S standard selection
    @ReadWrite(bits: 4..<6, as: I2SSTDValues.self)
    public var i2sstd: I2SSTD

    /// Steady state clock polarity
    @ReadWrite(bits: 3..<4, as: CKPOLValues.self)
    public var ckpol: CKPOL

    /// Data length to be transferred
    @ReadWrite(bits: 1..<3, as: DATLENValues.self)
    public var datlen: DATLEN

    /// Channel length (number of bits per audio channel)
    @ReadWrite(bits: 0..<1, as: CHLENValues.self)
    public var chlen: CHLEN

    /// Asynchronous start enable
    @ReadWrite(bits: 12..<13)
    public var astrten: ASTRTEN
  }

  /// I2S prescaler register
  @Register(bitWidth: 32)
  public struct I2SPR {
    /// Master clock output enable
    @ReadWrite(bits: 9..<10, as: MCKOEValues.self)
    public var mckoe: MCKOE

    /// Odd factor for the prescaler
    @ReadWrite(bits: 8..<9, as: ODDValues.self)
    public var odd: ODD

    /// I2S Linear prescaler
    @ReadWrite(bits: 0..<8)
    public var i2sdiv: I2SDIV
  }
}

extension SPI1.CR1 {
  public struct BIDIMODEValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// 2-line unidirectional data mode selected
    public static let Unidirectional = Self(rawValue: 0x0)

    /// 1-line bidirectional data mode selected
    public static let Bidirectional = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR1 {
  public struct BIDIOEValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Output disabled (receive-only mode)
    public static let OutputDisabled = Self(rawValue: 0x0)

    /// Output enabled (transmit-only mode)
    public static let OutputEnabled = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR1 {
  public struct CRCENValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// CRC calculation disabled
    public static let Disabled = Self(rawValue: 0x0)

    /// CRC calculation enabled
    public static let Enabled = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR1 {
  public struct CRCNEXTValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Next transmit value is from Tx buffer
    public static let TxBuffer = Self(rawValue: 0x0)

    /// Next transmit value is from Tx CRC register
    public static let CRC = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR1 {
  public struct CRCLValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// 8-bit CRC length
    public static let EightBit = Self(rawValue: 0x0)

    /// 16-bit CRC length
    public static let SixteenBit = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR1 {
  public struct RXONLYValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Full duplex (Transmit and receive)
    public static let FullDuplex = Self(rawValue: 0x0)

    /// Output disabled (Receive-only mode)
    public static let OutputDisabled = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR1 {
  public struct SSMValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Software slave management disabled
    public static let Disabled = Self(rawValue: 0x0)

    /// Software slave management enabled
    public static let Enabled = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR1 {
  public struct SSIValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// 0 is forced onto the NSS pin and the I/O value of the NSS pin is ignored
    public static let SlaveSelected = Self(rawValue: 0x0)

    /// 1 is forced onto the NSS pin and the I/O value of the NSS pin is ignored
    public static let SlaveNotSelected = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR1 {
  public struct LSBFIRSTValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Data is transmitted/received with the MSB first
    public static let MSBFirst = Self(rawValue: 0x0)

    /// Data is transmitted/received with the LSB first
    public static let LSBFirst = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR1 {
  public struct SPEValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Peripheral disabled
    public static let Disabled = Self(rawValue: 0x0)

    /// Peripheral enabled
    public static let Enabled = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR1 {
  public struct BRValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 3

    /// f_PCLK / 2
    public static let Div2 = Self(rawValue: 0x0)

    /// f_PCLK / 4
    public static let Div4 = Self(rawValue: 0x1)

    /// f_PCLK / 8
    public static let Div8 = Self(rawValue: 0x2)

    /// f_PCLK / 16
    public static let Div16 = Self(rawValue: 0x3)

    /// f_PCLK / 32
    public static let Div32 = Self(rawValue: 0x4)

    /// f_PCLK / 64
    public static let Div64 = Self(rawValue: 0x5)

    /// f_PCLK / 128
    public static let Div128 = Self(rawValue: 0x6)

    /// f_PCLK / 256
    public static let Div256 = Self(rawValue: 0x7)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR1 {
  public struct MSTRValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Slave configuration
    public static let Slave = Self(rawValue: 0x0)

    /// Master configuration
    public static let Master = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR1 {
  public struct CPOLValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// CK to 0 when idle
    public static let IdleLow = Self(rawValue: 0x0)

    /// CK to 1 when idle
    public static let IdleHigh = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR1 {
  public struct CPHAValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// The first clock transition is the first data capture edge
    public static let FirstEdge = Self(rawValue: 0x0)

    /// The second clock transition is the first data capture edge
    public static let SecondEdge = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR2 {
  public struct RXDMAENValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Rx buffer DMA disabled
    public static let Disabled = Self(rawValue: 0x0)

    /// Rx buffer DMA enabled
    public static let Enabled = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR2 {
  public struct TXDMAENValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Tx buffer DMA disabled
    public static let Disabled = Self(rawValue: 0x0)

    /// Tx buffer DMA enabled
    public static let Enabled = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR2 {
  public struct SSOEValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// SS output is disabled in master mode
    public static let Disabled = Self(rawValue: 0x0)

    /// SS output is enabled in master mode
    public static let Enabled = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR2 {
  public struct NSSPValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// No NSS pulse
    public static let NoPulse = Self(rawValue: 0x0)

    /// NSS pulse generated
    public static let PulseGenerated = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR2 {
  public struct FRFValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// SPI Motorola mode
    public static let Motorola = Self(rawValue: 0x0)

    /// SPI TI mode
    public static let TI = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR2 {
  public struct ERRIEValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Error interrupt masked
    public static let Masked = Self(rawValue: 0x0)

    /// Error interrupt not masked
    public static let NotMasked = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR2 {
  public struct RXNEIEValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// RXE interrupt masked
    public static let Masked = Self(rawValue: 0x0)

    /// RXE interrupt not masked
    public static let NotMasked = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR2 {
  public struct TXEIEValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// TXE interrupt masked
    public static let Masked = Self(rawValue: 0x0)

    /// TXE interrupt not masked
    public static let NotMasked = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR2 {
  public struct DSValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 4

    /// 4-bit
    public static let FourBit = Self(rawValue: 0x3)

    /// 5-bit
    public static let FiveBit = Self(rawValue: 0x4)

    /// 6-bit
    public static let SixBit = Self(rawValue: 0x5)

    /// 7-bit
    public static let SevenBit = Self(rawValue: 0x6)

    /// 8-bit
    public static let EightBit = Self(rawValue: 0x7)

    /// 9-bit
    public static let NineBit = Self(rawValue: 0x8)

    /// 10-bit
    public static let TenBit = Self(rawValue: 0x9)

    /// 11-bit
    public static let ElevenBit = Self(rawValue: 0xa)

    /// 12-bit
    public static let TwelveBit = Self(rawValue: 0xb)

    /// 13-bit
    public static let ThirteenBit = Self(rawValue: 0xc)

    /// 14-bit
    public static let FourteenBit = Self(rawValue: 0xd)

    /// 15-bit
    public static let FifteenBit = Self(rawValue: 0xe)

    /// 16-bit
    public static let SixteenBit = Self(rawValue: 0xf)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR2 {
  public struct FRXTHValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// RXNE event is generated if the FIFO level is greater than or equal to 1/2 (16-bit)
    public static let Half = Self(rawValue: 0x0)

    /// RXNE event is generated if the FIFO level is greater than or equal to 1/4 (8-bit)
    public static let Quarter = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR2 {
  public struct LDMA_RXValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Number of data to transfer for receive is even
    public static let Even = Self(rawValue: 0x0)

    /// Number of data to transfer for receive is odd
    public static let Odd = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.CR2 {
  public struct LDMA_TXValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Number of data to transfer for transmit is even
    public static let Even = Self(rawValue: 0x0)

    /// Number of data to transfer for transmit is odd
    public static let Odd = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.I2SCFGR {
  public struct I2SMODValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// SPI mode is selected
    public static let SPIMode = Self(rawValue: 0x0)

    /// I2S mode is selected
    public static let I2SMode = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.I2SCFGR {
  public struct I2SEValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// I2S peripheral is disabled
    public static let Disabled = Self(rawValue: 0x0)

    /// I2S peripheral is enabled
    public static let Enabled = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.I2SCFGR {
  public struct I2SCFGValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 2

    /// Slave - transmit
    public static let SlaveTx = Self(rawValue: 0x0)

    /// Slave - receive
    public static let SlaveRx = Self(rawValue: 0x1)

    /// Master - transmit
    public static let MasterTx = Self(rawValue: 0x2)

    /// Master - receive
    public static let MasterRx = Self(rawValue: 0x3)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.I2SCFGR {
  public struct PCMSYNCValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Short frame synchronisation
    public static let Short = Self(rawValue: 0x0)

    /// Long frame synchronisation
    public static let Long = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.I2SCFGR {
  public struct I2SSTDValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 2

    /// I2S Philips standard
    public static let Philips = Self(rawValue: 0x0)

    /// MSB justified standard
    public static let MSB = Self(rawValue: 0x1)

    /// LSB justified standard
    public static let LSB = Self(rawValue: 0x2)

    /// PCM standard
    public static let PCM = Self(rawValue: 0x3)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.I2SCFGR {
  public struct CKPOLValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// I2S clock inactive state is low level
    public static let IdleLow = Self(rawValue: 0x0)

    /// I2S clock inactive state is high level
    public static let IdleHigh = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.I2SCFGR {
  public struct DATLENValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 2

    /// 16-bit data length
    public static let SixteenBit = Self(rawValue: 0x0)

    /// 24-bit data length
    public static let TwentyFourBit = Self(rawValue: 0x1)

    /// 32-bit data length
    public static let ThirtyTwoBit = Self(rawValue: 0x2)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.I2SCFGR {
  public struct CHLENValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// 16-bit wide
    public static let SixteenBit = Self(rawValue: 0x0)

    /// 32-bit wide
    public static let ThirtyTwoBit = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.I2SPR {
  public struct MCKOEValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Master clock output is disabled
    public static let Disabled = Self(rawValue: 0x0)

    /// Master clock output is enabled
    public static let Enabled = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}

extension SPI1.I2SPR {
  public struct ODDValues: BitFieldProjectable, RawRepresentable {
    public static let bitWidth = 1

    /// Real divider value is I2SDIV * 2
    public static let Even = Self(rawValue: 0x0)

    /// Real divider value is (I2SDIV * 2) + 1
    public static let Odd = Self(rawValue: 0x1)

    public var rawValue: UInt8

    @inlinable @inline(__always)
    public init(rawValue: Self.RawValue) {
      self.rawValue = rawValue
    }
  }
}
