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
    case .input: 0x0
    case .output: 0x1
    case .alternateFunction: 0x2
    case .analog: 0x3
    }
  }
}

extension OutputType {
  var rawValue: UInt8 {
    switch self {
    case .pushPull: 0x0
    case .openDrain: 0x1
    }
  }
}

extension OutputSpeed {
  var rawValue: UInt8 {
    switch self {
    case .low: 0x0
    case .medium: 0x1
    case .high: 0x2
    case .max: 0x3
    }
  }
}

extension Pull {
  var rawValue: UInt8 {
    switch self {
    case .none: 0x0
    case .up: 0x1
    case .down: 0x2
    }
  }
}

extension AlternateFunction {
  var rawValue: UInt8 {
    switch self {
    case .alternateFunction0: 0
    case .alternateFunction1: 1
    case .alternateFunction2: 2
    case .alternateFunction3: 3
    case .alternateFunction4: 4
    case .alternateFunction5: 5
    case .alternateFunction6: 6
    case .alternateFunction7: 7
    case .alternateFunction8: 8
    case .alternateFunction9: 9
    case .alternateFunction10: 10
    case .alternateFunction11: 11
    case .alternateFunction12: 12
    case .alternateFunction13: 13
    case .alternateFunction14: 14
    case .alternateFunction15: 15
    case .none: .max
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
      // FIXME: rawValue.moder.setModer(n: Int(self.number), value: mode.rawValue)
    }

    func setOutputType(_ outputType: OutputType) {
      var rawValue = self.port.port
      // FIXME: rawValue.otyper.setOt(n: Int(self.number), value: outputType.rawValue)
    }

    func setOutputSpeed(_ outputSpeed: OutputSpeed) {
      var rawValue = self.port.port
      // FIXME: rawValue.ospeedr.setOspeed(n: Int(self.number), value: outputSpeed.rawValue)
    }

    func setPull(_ pull: Pull) {
      var rawValue = self.port.port
      // FIXME: rawValue.pupdr.setPupd(n: Int(self.number), value: pull.rawValue)
    }

    func setAlternateFunction(_ alternateFunction: AlternateFunction) {
      var rawValue = self.port.port
      if self.number < 8 {
        // FIXME: rawValue.afrl.setAf(n: Int(self.number), value: alternateFunction.rawValue)
      } else {
        // FIXME: rawValue.afrh.setAf(n: Int(self.number), value: alternateFunction.rawValue)
      }
    }

    func setOutputData(_ data: UInt8) {
      var rawValue = self.port.port
      // FIXME: rawValue.odr.setOd(n: Int(self.number), value: data)
    }

    func getInputData() -> UInt8 {
      let rawValue = self.port.port.idr.read().raw
      switch self.number {
      case 0: return UInt8(rawValue.idr0)
      case 1: return UInt8(rawValue.idr1)
      case 2: return UInt8(rawValue.idr2)
      case 3: return UInt8(rawValue.idr3)
      case 4: return UInt8(rawValue.idr4)
      case 5: return UInt8(rawValue.idr5)
      case 6: return UInt8(rawValue.idr6)
      case 7: return UInt8(rawValue.idr7)
      case 8: return UInt8(rawValue.idr8)
      case 9: return UInt8(rawValue.idr9)
      case 10: return UInt8(rawValue.idr10)
      case 11: return UInt8(rawValue.idr11)
      case 12: return UInt8(rawValue.idr12)
      case 13: return UInt8(rawValue.idr13)
      case 14: return UInt8(rawValue.idr14)
      case 15: return UInt8(rawValue.idr15)
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

  var port: GPIOA {
    switch self {
    case .a: gpioa
    case .b: gpiob
    case .c: gpioc
    case .d: gpiod
    case .e: gpioe
    case .f: gpiof
    case .g: gpiog
    case .h: gpioh
    case .i: gpioi
    case .j: gpioj
    case .k: gpiok
    }
  }
}

extension STM32F746 {
  public static func enableGPIOPortClock(_ port: GPIOPort) {

    switch port {
    case .a: rcc.ahb1enr.modify { $0.raw.gpioaen = 1 }
    case .b: rcc.ahb1enr.modify { $0.raw.gpioben = 1 }
    case .c: rcc.ahb1enr.modify { $0.raw.gpiocen = 1 }
    case .d: rcc.ahb1enr.modify { $0.raw.gpioden = 1 }
    case .e: rcc.ahb1enr.modify { $0.raw.gpioeen = 1 }
    case .f: rcc.ahb1enr.modify { $0.raw.gpiofen = 1 }
    case .g: rcc.ahb1enr.modify { $0.raw.gpiogen = 1 }
    case .h: rcc.ahb1enr.modify { $0.raw.gpiohen = 1 }
    case .i: rcc.ahb1enr.modify { $0.raw.gpioien = 1 }
    case .j: rcc.ahb1enr.modify { $0.raw.gpiojen = 1 }
    case .k: rcc.ahb1enr.modify { $0.raw.gpioken = 1 }
    }
  }

  public static func enableUARTClock(_ uartNum: UInt8) {
    switch uartNum {
    case 1: rcc.apb2enr.modify { $0.raw.usart1en = 1 }
    case 2: rcc.apb1enr.modify { $0.raw.usart2en = 1 }
    case 3: rcc.apb1enr.modify { $0.raw.usart3en = 1 }
    case 4: rcc.apb1enr.modify { $0.raw.uart4en = 1 }
    case 5: rcc.apb1enr.modify { $0.raw.uart5en = 1 }
    case 6: rcc.apb2enr.modify { $0.raw.usart6en = 1 }
// FIXME: ?
//    case 7: rcc.apb1enr.modify { $0.raw.uart7enr = 1 }
//    case 8: rcc.apb1enr.modify { $0.raw.uart8enr = 1 }
    default: return
    }
  }

  public static func enableI2CClock(_ i2cNum: UInt8) {
    switch i2cNum {
    case 1: rcc.apb1enr.modify { $0.raw.i2c1en = 1 }
    case 2: rcc.apb1enr.modify { $0.raw.i2c2en = 1 }
    case 3: rcc.apb1enr.modify { $0.raw.i2c3en = 1 }
    case 4: rcc.apb1enr.modify { $0.raw.i2c4en = 1 }
    default: return
    }
  }

  public static func enableSPIClock(_ spiNum: UInt8) {
    switch spiNum {
    case 1: rcc.apb2enr.modify { $0.raw.spi1en = 1 }
    case 2: rcc.apb1enr.modify { $0.raw.spi2en = 1 }
    case 3: rcc.apb1enr.modify { $0.raw.spi3en = 1 }
// FIXME: case 4: rcc.apb2enr.modify { $0.raw.spi4enr = 1 }
// FIXME: case 5: rcc.apb2enr.modify { $0.raw.spi5enr = 1 }
// FIXME: case 6: rcc.apb2enr.modify { $0.raw.spi6enr = 1 }
    default: return
    }
  }

  public static func configureFlash() {
    let flash = UnsafeMutableRawPointer(bitPattern: (0x4002_3C00))
    let flashAcr = UnsafeMutablePointer<UInt32>(
      bitPattern: UInt(bitPattern: flash))!
    // Set FLASH_ACR to 0x5
    // FIXME: flashAcr.volatileStore(0x5)
  }

  public static func initializeLTCD() {
    // FIXME: rcc.cfgr.rawValue = 0
    // FIXME: rcc.cr.hsion = 1
    // FIXME: rcc.cr.csson = 0
    // FIXME: rcc.cr.pllon = 0
    // FIXME: rcc.cr.hsebyp = 0
    // FIXME: rcc.cr.hseon = 1
    // FIXME: while rcc.cr.hserdy == 0 {}
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

    // FIXME: rcc.pllcfgr.modify { $0.raw.rawValue = 0 }
    // FIXME: rcc.pllcfgr.modify { $0.raw.pllm0 = 1 }
    // FIXME: rcc.pllcfgr.modify { $0.raw.pllm3 = 1 }
    // FIXME: rcc.pllcfgr.modify { $0.raw.pllm4 = 1 }
    // FIXME: rcc.pllcfgr.modify { $0.raw.plln4 = 1 }
    // FIXME: rcc.pllcfgr.modify { $0.raw.plln5 = 1 }
    // FIXME: rcc.pllcfgr.modify { $0.raw.plln7 = 1 }
    // FIXME: rcc.pllcfgr.modify { $0.raw.plln8 = 1 }
    // FIXME: rcc.pllcfgr.modify { $0.raw.pllsrc = 1 }

    // FIXME:     rcc.cr.pllon = 1
    // FIXME: while rcc.cr.pllrdy == 0 {}

    // FIXME:     rcc.cfgr.rawValue &= 0b11
    // FIXME:     rcc.cfgr.rawValue |= 0b10
    // FIXME: while rcc.cfgr.rawValue & 0b1100 != 0b1000 {}

    // FIXME:     rcc.pllsaicfgr.pllsain = 192
    // FIXME:     rcc.pllsaicfgr.pllsair = 5
    // FIXME:     rcc.dkcfgr1.pllsaidivr = 1

    // FIXME:     rcc.cr.pllsaion = 1
    // FIXME: while rcc.cr.pllsairdy == 0 {}

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
        pull: .none, alternateFunction: .alternateFunction9, activeHigh: true))
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
    // FIXME: rcc.apb2enr.ltdcen = 1

    // FIXME: ltdc.sscr.vsh = UInt16(LTDCConstants.vsync - 1)
    // FIXME: ltdc.sscr.hsw = UInt16(LTDCConstants.hsync - 1)
    // FIXME: ltdc.bpcr.ahbp = UInt16(LTDCConstants.hsync + LTDCConstants.hbp - 1)
    // FIXME: ltdc.bpcr.avbp = UInt16(LTDCConstants.vsync + LTDCConstants.vbp - 1)
    // FIXME: ltdc.awcr.aah = UInt16(LTDCConstants.displayHeight + LTDCConstants.vsync + LTDCConstants.vbp - 1)
    // FIXME: ltdc.awcr.aav = UInt16(LTDCConstants.displayWidth + LTDCConstants.hsync + LTDCConstants.hbp - 1)
    // FIXME: ltdc.twcr.totalw = UInt16(LTDCConstants.displayWidth + LTDCConstants.hsync + LTDCConstants.hbp + LTDCConstants.hfp - 1)
    // FIXME: ltdc.twcr.totalh = UInt16(LTDCConstants.displayHeight + LTDCConstants.vsync + LTDCConstants.vbp + LTDCConstants.vfp - 1)

    // FIXME: ltdc.bccr.rawValue = 0x00_00_00_00  // background color

    setLayer2Position(Point(x: 0, y: 0))

    // FIXME: ltdc.l2pfcr.rawValue = 0  // Format ARGB8888
    // FIXME: ltdc.l2cfbar.rawValue = UInt32(UInt(bitPattern: logoPixelDataStartPointer))
    // FIXME: ltdc.l2cacr.consta = 255
    // FIXME: ltdc.l2bfcr.bf1 = 5
    // FIXME: ltdc.l2bfcr.bf2 = 4
    // FIXME: ltdc.l2cfblr.rawValue = UInt32(UInt32(LTDCConstants.pixelSize * LTDCConstants.layerWidth) << 16) | UInt32(LTDCConstants.pixelSize * LTDCConstants.layerWidth + 3)
    // FIXME: ltdc.l2cfblnr.cfblnbr = UInt16(LTDCConstants.layerHeight)
    // FIXME: ltdc.l2cr.len = 1

    // FIXME: ltdc.srcr.vbr = 1  // reload

    // FIXME: ltdc.gcr.ltdcen = 1
  }

  static func setLayer2Position(_ point: Point) {
    let i: Int =
      ((LTDCConstants.layerWidth + LTDCConstants.hbp + LTDCConstants.hsync - 1
        + point.x) << 16) | (LTDCConstants.hbp + LTDCConstants.hsync + point.x)
    // FIXME: ltdc.l2whpcr.rawValue = UInt32(i)
    let j: Int =
      ((LTDCConstants.layerHeight + LTDCConstants.vsync + LTDCConstants.vbp - 1
        + point.y) << 16) | (LTDCConstants.vsync + LTDCConstants.vbp + point.y)
    // FIXME: ltdc.l2wvpcr.rawValue = UInt32(j)
    // FIXME: ltdc.srcr.vbr = 1
  }

  static func setBackgroundColor(_ color: Color) {
    // FIXME: ltdc.bccr.rawValue = UInt32(color.r | (color.g << 8) | (color.b << 16))
  }
}
