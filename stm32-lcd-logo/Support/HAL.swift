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

public protocol GPIOPlatform {
  associatedtype Pin
  static func configure(_ pin: Pin, _ configuration: GPIOConfiguration)
  static func assert(_ pin: Pin, _ configuration: GPIOConfiguration)
  static func deassert(_ pin: Pin, _ configuration: GPIOConfiguration)
  static func value(_ pin: Pin) -> Bool
}
public enum STM32F746 {}

public enum Mode {
  case input
  case output
  case alternateFunction
  case analog
}

public enum OutputType {
  case pushPull
  case openDrain
}

public enum OutputSpeed {
  case low
  case medium
  case high
  case max
}

public enum Pull {
  case `none`
  case up
  case down
}

public enum AlternateFunction {
  case alternateFunction0
  case alternateFunction1
  case alternateFunction2
  case alternateFunction3
  case alternateFunction4
  case alternateFunction5
  case alternateFunction6
  case alternateFunction7
  case alternateFunction8
  case alternateFunction9
  case alternateFunction10
  case alternateFunction11
  case alternateFunction12
  case alternateFunction13
  case alternateFunction14
  case alternateFunction15
  case `none`
}

public struct GPIOConfiguration {
  public var mode: Mode
  public var outputType: OutputType
  public var outputSpeed: OutputSpeed
  public var pull: Pull
  public var alternateFunction: AlternateFunction
  public var activeHigh: Bool

  public init(
    mode: Mode, outputType: OutputType, outputSpeed: OutputSpeed, pull: Pull,
    alternateFunction: AlternateFunction, activeHigh: Bool
  ) {
    self.mode = mode
    self.outputType = outputType
    self.outputSpeed = outputSpeed
    self.pull = pull
    self.alternateFunction = alternateFunction
    self.activeHigh = activeHigh
  }
}

public struct HALGPIO<Platform: GPIOPlatform> {
  let pin: Platform.Pin
  var configuration: GPIOConfiguration?

  public init(pin: Platform.Pin) {
    self.pin = pin
    self.configuration = nil
  }

  public mutating func configure(configuration: GPIOConfiguration) {
    self.configuration = configuration
    guard let configuration = self.configuration else { return }
    Platform.configure(pin, configuration)
  }

  public func assert() {
    guard let configuration = self.configuration else { return }
    Platform.assert(pin, configuration)
  }

  public func deassert() {
    guard let configuration = self.configuration else { return }
    Platform.deassert(pin, configuration)
  }

  public func value() -> Bool {
    Platform.value(pin)
  }
}

// MARK: - Abstract GPIO -> Platform GPIO
extension Mode {
  var rawValue: UInt8 {
    switch self {
    case .input: return 0x0
    case .output: return 0x1
    case .alternateFunction: return 0x2
    case .analog: return 0x3
    }
  }
}

extension OutputType {
  var rawValue: UInt8 {
    switch self {
    case .pushPull:
      return 0x0
    case .openDrain:
      return 0x1
    }
  }
}

extension OutputSpeed {
  var rawValue: UInt8 {
    switch self {
    case .low: return 0x0
    case .medium: return 0x1
    case .high: return 0x2
    case .max: return 0x3
    }
  }
}

extension Pull {
  var rawValue: UInt8 {
    switch self {
    case .none: return 0x0
    case .up: return 0x1
    case .down: return 0x2
    }
  }
}

extension AlternateFunction {
  var rawValue: UInt8 {
    switch self {
    case .alternateFunction0: return 0
    case .alternateFunction1: return 1
    case .alternateFunction2: return 2
    case .alternateFunction3: return 3
    case .alternateFunction4: return 4
    case .alternateFunction5: return 5
    case .alternateFunction6: return 6
    case .alternateFunction7: return 7
    case .alternateFunction8: return 8
    case .alternateFunction9: return 9
    case .alternateFunction10: return 10
    case .alternateFunction11: return 11
    case .alternateFunction12: return 12
    case .alternateFunction13: return 13
    case .alternateFunction14: return 14
    case .alternateFunction15: return 15
    case .none: return .max
    }
  }
}

// MARK: - GPIOPlatform Conformance
extension STM32F746: GPIOPlatform {
  public struct Pin {
    var port: GPIOPort
    var number: UInt8

    public init(port: GPIOPort, number: UInt8) {
      self.port = port
      self.number = number
    }

    func checkValidPin() {
      if self.number < 0 || self.number > 16 {
        fatalError("STM32F746: invalid GPIO pin number")
      }
    }

    func setMode(_ mode: Mode) {
      var rawValue = self.port.port
      rawValue.moder.setModer(n: Int(self.number), value: mode.rawValue)
    }

    func setOutputType(_ outputType: OutputType) {
      var rawValue = self.port.port
      rawValue.otyper.setOt(n: Int(self.number), value: outputType.rawValue)
    }

    func setOutputSpeed(_ outputSpeed: OutputSpeed) {
      var rawValue = self.port.port
      rawValue.ospeedr.setOspeed(
        n: Int(self.number), value: outputSpeed.rawValue)
    }

    func setPull(_ pull: Pull) {
      var rawValue = self.port.port
      rawValue.pupdr.setPupd(n: Int(self.number), value: pull.rawValue)
    }

    func setAlternateFunction(_ alternateFunction: AlternateFunction) {
      var rawValue = self.port.port
      if self.number < 8 {
        rawValue.afrl.setAf(
          n: Int(self.number), value: alternateFunction.rawValue)
      } else {
        rawValue.afrh.setAf(
          n: Int(self.number), value: alternateFunction.rawValue)
      }
    }

    func setOutputData(_ data: UInt8) {
      var rawValue = self.port.port
      rawValue.odr.setOd(n: Int(self.number), value: data)
    }

    func getInputData() -> UInt8 {
      let rawValue = self.port.port
      switch self.number {
      case 0: return rawValue.idr.idr0
      case 1: return rawValue.idr.idr1
      case 2: return rawValue.idr.idr2
      case 3: return rawValue.idr.idr3
      case 4: return rawValue.idr.idr4
      case 5: return rawValue.idr.idr5
      case 6: return rawValue.idr.idr6
      case 7: return rawValue.idr.idr7
      case 8: return rawValue.idr.idr8
      case 9: return rawValue.idr.idr9
      case 10: return rawValue.idr.idr10
      case 11: return rawValue.idr.idr11
      case 12: return rawValue.idr.idr12
      case 13: return rawValue.idr.idr13
      case 14: return rawValue.idr.idr14
      case 15: return rawValue.idr.idr15
      default: fatalError("STM32F746: invalid GPIO pin number")
      }
    }
  }

  public static func configure(_ pin: Pin, _ configuration: GPIOConfiguration) {
    pin.checkValidPin()

    pin.setMode(configuration.mode)
    pin.setOutputType(configuration.outputType)
    pin.setOutputSpeed(configuration.outputSpeed)
    pin.setPull(configuration.pull)

    if configuration.mode == .alternateFunction {
      pin.setAlternateFunction(configuration.alternateFunction)
    }

  }

  public static func assert(_ pin: Pin, _ configuration: GPIOConfiguration) {
    if configuration.activeHigh {
      pin.setOutputData(1)
    } else {
      pin.setOutputData(0)
    }
  }

  public static func deassert(_ pin: Pin, _ configuration: GPIOConfiguration) {
    if configuration.activeHigh {
      pin.setOutputData(0)
    } else {
      pin.setOutputData(1)
    }
  }

  public static func value(_ pin: Pin) -> Bool {
    (pin.getInputData() & 0x1) != 0
  }
}

public enum GPIOPort: Int {
  case a, b, c, d, e, f, g, h, i, j, k

  var port: GPIO {
    // swift-format-ignore: NeverForceUnwrap
    GPIO(
      baseAddress: UnsafeMutableRawPointer(
        bitPattern: (0x4002_0000 + 0x400 * UInt(self.rawValue - Self.a.rawValue))
      )!)
  }
}

extension STM32F746 {
  public static func enableGPIOPortClock(_ port: GPIOPort) {
    // swift-format-ignore: NeverForceUnwrap
    var rcc = RCC(
      baseAddress: UnsafeMutableRawPointer(bitPattern: 0x4002_3800)!)
    switch port {
    case .a: rcc.ahb1enr.gpioaen = 1
    case .b: rcc.ahb1enr.gpioben = 1
    case .c: rcc.ahb1enr.gpiocen = 1
    case .d: rcc.ahb1enr.gpioden = 1
    case .e: rcc.ahb1enr.gpioeen = 1
    case .f: rcc.ahb1enr.gpiofen = 1
    case .g: rcc.ahb1enr.gpiogen = 1
    case .h: rcc.ahb1enr.gpiohen = 1
    case .i: rcc.ahb1enr.gpioien = 1
    case .j: rcc.ahb1enr.gpiojen = 1
    case .k: rcc.ahb1enr.gpioken = 1
    }
  }

  public static func enableUARTClock(_ uartNum: UInt8) {
    // swift-format-ignore: NeverForceUnwrap
    var rcc = RCC(
      baseAddress: UnsafeMutableRawPointer(bitPattern: 0x4002_3800)!)
    switch uartNum {
    case 1: rcc.apb2enr.usart1en = 1
    case 2: rcc.apb1enr.usart2en = 1
    case 3: rcc.apb1enr.usart3en = 1
    case 4: rcc.apb1enr.uart4en = 1
    case 5: rcc.apb1enr.uart5en = 1
    case 6: rcc.apb2enr.usart6en = 1
    case 7: rcc.apb1enr.uart7enr = 1
    case 8: rcc.apb1enr.uart8enr = 1
    default: return
    }
  }

  public static func enableI2CClock(_ i2cNum: UInt8) {
    // swift-format-ignore: NeverForceUnwrap
    var rcc = RCC(
      baseAddress: UnsafeMutableRawPointer(bitPattern: 0x4002_3800)!)
    switch i2cNum {
    case 1: rcc.apb1enr.i2c1en = 1
    case 2: rcc.apb1enr.i2c2en = 1
    case 3: rcc.apb1enr.i2c3en = 1
    case 4: rcc.apb1enr.i2c4en = 1
    default: return
    }
  }

  public static func enableSPIClock(_ spiNum: UInt8) {
    // swift-format-ignore: NeverForceUnwrap
    var rcc = RCC(
      baseAddress: UnsafeMutableRawPointer(bitPattern: 0x4002_3800)!)
    switch spiNum {
    case 1: rcc.apb2enr.spi1en = 1
    case 2: rcc.apb1enr.spi2en = 1
    case 3: rcc.apb1enr.spi3en = 1
    case 4: rcc.apb2enr.spi4enr = 1
    case 5: rcc.apb2enr.spi5enr = 1
    case 6: rcc.apb2enr.spi6enr = 1
    default: return
    }
  }

  public static func configureFlash() {
    let flash = UnsafeMutableRawPointer(bitPattern: (0x4002_3C00))
    // swift-format-ignore: NeverForceUnwrap
    let flashAcr = UnsafeMutablePointer<UInt32>(
      bitPattern: UInt(bitPattern: flash))!
    // Set FLASH_ACR to 0x5
    flashAcr.volatileStore(0x5)
  }

  public static func initializeLTCD() {
    // swift-format-ignore: NeverForceUnwrap
    var rcc = RCC(
      baseAddress: UnsafeMutableRawPointer(bitPattern: 0x4002_3800)!)
    rcc.cfgr.rawValue = 0
    rcc.cr.hsion = 1
    rcc.cr.csson = 0
    rcc.cr.pllon = 0
    rcc.cr.hsebyp = 0
    rcc.cr.hseon = 1
    while rcc.cr.hserdy == 0 {}
  }

  enum LTDCConstants {
    static let hsync = 30
    static let vsync = 10
    static let hbp = 13
    static let hfp = 32
    static let vbp = 2
    static let vfp = 2

    static let pixelSize = 4

    static let displayWidth = 480
    static let displayHeight = 272

    static let layerWidth = 50
    static let layerHeight = 50
  }

  public static func configureLTCD() {
    // swift-format-ignore: NeverForceUnwrap
    var ltdc = LTDC(
      baseAddress: UnsafeMutableRawPointer(bitPattern: 0x4001_6800)!)
    // swift-format-ignore: NeverForceUnwrap
    var rcc = RCC(
      baseAddress: UnsafeMutableRawPointer(bitPattern: 0x4002_3800)!)

    rcc.pllcfgr.rawValue = 0
    rcc.pllcfgr.pllm0 = 1
    rcc.pllcfgr.pllm3 = 1
    rcc.pllcfgr.pllm4 = 1
    rcc.pllcfgr.plln4 = 1
    rcc.pllcfgr.plln5 = 1
    rcc.pllcfgr.plln7 = 1
    rcc.pllcfgr.plln8 = 1
    rcc.pllcfgr.pllsrc = 1

    rcc.cr.pllon = 1
    while rcc.cr.pllrdy == 0 {}

    rcc.cfgr.rawValue &= 0b11
    rcc.cfgr.rawValue |= 0b10
    while rcc.cfgr.rawValue & 0b1100 != 0b1000 {}

    rcc.pllsaicfgr.pllsain = 192
    rcc.pllsaicfgr.pllsair = 5
    rcc.dkcfgr1.pllsaidivr = 1

    rcc.cr.pllsaion = 1
    while rcc.cr.pllsairdy == 0 {}

    STM32F746.enableGPIOPortClock(.i)

    STM32F746.enableGPIOPortClock(.a)
    STM32F746.enableGPIOPortClock(.b)
    STM32F746.enableGPIOPortClock(.c)
    STM32F746.enableGPIOPortClock(.d)
    STM32F746.enableGPIOPortClock(.e)
    STM32F746.enableGPIOPortClock(.f)
    STM32F746.enableGPIOPortClock(.g)
    STM32F746.enableGPIOPortClock(.h)
    STM32F746.enableGPIOPortClock(.j)
    STM32F746.enableGPIOPortClock(.k)

    var clkPin = HALGPIO<STM32F746>(pin: .init(port: .i, number: 14))
    var dePin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 7))
    var hsyncPin = HALGPIO<STM32F746>(pin: .init(port: .i, number: 10))
    var vsyncPin = HALGPIO<STM32F746>(pin: .init(port: .i, number: 9))

    clkPin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: false)
    )
    dePin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: false)
    )
    hsyncPin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: false)
    )
    vsyncPin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: false)
    )

    var r0Pin = HALGPIO<STM32F746>(pin: .init(port: .i, number: 15))
    var r1Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 0))
    var r2Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 1))
    var r3Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 2))
    var r4Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 3))
    var r5Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 4))
    var r6Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 5))
    var r7Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 6))

    r0Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    r1Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    r2Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    r3Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    r4Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    r5Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    r6Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    r7Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))

    var g0Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 7))
    var g1Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 8))
    var g2Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 9))
    var g3Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 10))
    var g4Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 11))
    var g5Pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 0))
    var g6Pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 1))
    var g7Pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 2))

    g0Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    g1Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    g2Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    g3Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    g4Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    g5Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    g6Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    g7Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))

    var b0Pin = HALGPIO<STM32F746>(pin: .init(port: .e, number: 4))
    var b1Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 13))
    var b2Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 14))
    var b3Pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 15))
    var b4Pin = HALGPIO<STM32F746>(pin: .init(port: .g, number: 12))
    var b5Pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 4))
    var b6Pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 5))
    var b7Pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 6))

    b0Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    b1Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    b2Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    b3Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    b4Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction9,
        activeHigh: true))
    b5Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    b6Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
    b7Pin.configure(
      configuration: .init(
        mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high,
        pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))

    var backlightPin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 3))
    backlightPin.configure(
      configuration: .init(
        mode: .output, outputType: .pushPull, outputSpeed: .low, pull: .down,
        alternateFunction: .none, activeHigh: true))

    var lcdDispPin = HALGPIO<STM32F746>(pin: .init(port: .i, number: 12))
    lcdDispPin.configure(
      configuration: .init(
        mode: .output, outputType: .pushPull, outputSpeed: .low, pull: .down,
        alternateFunction: .none, activeHigh: true))

    lcdDispPin.assert()
    backlightPin.assert()
    rcc.apb2enr.ltdcen = 1

    ltdc.sscr.vsh = UInt16(LTDCConstants.vsync - 1)
    ltdc.sscr.hsw = UInt16(LTDCConstants.hsync - 1)
    ltdc.bpcr.ahbp = UInt16(LTDCConstants.hsync + LTDCConstants.hbp - 1)
    ltdc.bpcr.avbp = UInt16(LTDCConstants.vsync + LTDCConstants.vbp - 1)
    ltdc.awcr.aah = UInt16(
      LTDCConstants.displayHeight + LTDCConstants.vsync + LTDCConstants.vbp - 1
    )
    ltdc.awcr.aav = UInt16(
      LTDCConstants.displayWidth + LTDCConstants.hsync + LTDCConstants.hbp - 1)
    ltdc.twcr.totalw = UInt16(
      LTDCConstants.displayWidth + LTDCConstants.hsync + LTDCConstants.hbp
        + LTDCConstants.hfp - 1)
    ltdc.twcr.totalh = UInt16(
      LTDCConstants.displayHeight + LTDCConstants.vsync + LTDCConstants.vbp
        + LTDCConstants.vfp - 1)

    ltdc.bccr.rawValue = 0x00_00_00_00  // background color

    setLayer2Position(Point(x: 0, y: 0))

    ltdc.l2pfcr.rawValue = 0  // Format ARGB8888
    ltdc.l2cfbar.rawValue = UInt32(UInt(bitPattern: logoPixelDataStartPointer))
    ltdc.l2cacr.consta = 255
    ltdc.l2bfcr.bf1 = 5
    ltdc.l2bfcr.bf2 = 4
    ltdc.l2cfblr.rawValue =
      UInt32(UInt32(LTDCConstants.pixelSize * LTDCConstants.layerWidth) << 16)
      | UInt32(LTDCConstants.pixelSize * LTDCConstants.layerWidth + 3)
    ltdc.l2cfblnr.cfblnbr = UInt16(LTDCConstants.layerHeight)
    ltdc.l2cr.len = 1

    ltdc.srcr.vbr = 1  // reload

    ltdc.gcr.ltdcen = 1
  }

  static func setLayer2Position(_ point: Point) {
    // swift-format-ignore: NeverForceUnwrap
    var ltdc = LTDC(
      baseAddress: UnsafeMutableRawPointer(bitPattern: 0x4001_6800)!)

    let i: Int =
      ((LTDCConstants.layerWidth + LTDCConstants.hbp + LTDCConstants.hsync - 1
        + point.x) << 16) | (LTDCConstants.hbp + LTDCConstants.hsync + point.x)
    ltdc.l2whpcr.rawValue = UInt32(i)
    let j: Int =
      ((LTDCConstants.layerHeight + LTDCConstants.vsync + LTDCConstants.vbp - 1
        + point.y) << 16) | (LTDCConstants.vsync + LTDCConstants.vbp + point.y)
    ltdc.l2wvpcr.rawValue = UInt32(j)
    ltdc.srcr.vbr = 1
  }

  static func setBackgroundColor(_ color: Color) {
    // swift-format-ignore: NeverForceUnwrap
    var ltdc = LTDC(
      baseAddress: UnsafeMutableRawPointer(bitPattern: 0x4001_6800)!)

    ltdc.bccr.rawValue = UInt32(color.r | (color.g << 8) | (color.b << 16))
  }
}
