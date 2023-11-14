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
public enum STM32F746 { }

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

    public init(mode: Mode, outputType: OutputType, outputSpeed: OutputSpeed, pull: Pull, alternateFunction: AlternateFunction, activeHigh: Bool) {
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

//
//  STM32F746.swift
//  STM32F746
//
//  Created by Rauhul Varma on 3/28/23.
//  Copyright © 2023 Apple Inc. All rights reserved.
//

// MARK: - Abstract GPIO -> Platform GPIO
extension Mode {
    var MODER: UInt8 {
        switch self {
        case .input: return 0x0
        case .output: return 0x1
        case .alternateFunction: return 0x2
        case .analog: return 0x3
        }
    }
}

extension OutputType {
    var OTYPER: UInt8 {
        switch self {
        case .pushPull:
            return 0x0
        case .openDrain:
            return 0x1
        }
    }
}

extension OutputSpeed {
    var OSPEEDR: UInt8 {
        switch self {
        case .low: return 0x0
        case .medium: return 0x1
        case .high: return 0x2
        case .max: return 0x3
        }
    }
}

extension Pull {
    var PUPDR: UInt8 {
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
            rawValue.moder.setModer(n: Int(self.number), value: mode.MODER)
        }

        func setOutputType(_ outputType: OutputType) {
            var rawValue = self.port.port
            rawValue.otyper.setOt(n: Int(self.number), value: outputType.OTYPER)
        }

        func setOutputSpeed(_ outputSpeed: OutputSpeed) {
            var rawValue = self.port.port
            rawValue.ospeedr.setOspeed(n: Int(self.number), value: outputSpeed.OSPEEDR)
        }

        func setPull(_ pull: Pull) {
            var rawValue = self.port.port
            rawValue.pupdr.setPupd(n: Int(self.number), value: pull.PUPDR)
        }

        func setAlternateFunction(_ alternateFunction: AlternateFunction) {
            var rawValue = self.port.port
            if self.number < 8 {
                rawValue.afrl.setAf(n: Int(self.number), value: alternateFunction.rawValue)
            } else {
                rawValue.afrh.setAf(n: Int(self.number), value: alternateFunction.rawValue)
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
        return GPIO(baseAddress: UnsafeMutableRawPointer(bitPattern: (0x40020000 + 0x400 * UInt(self.rawValue - Self.a.rawValue)) as UInt)!)
    }
}

extension STM32F746 {
    public static func enableGPIOPortClock(_ port: GPIOPort) {
        var rcc = RCC(baseAddress: UnsafeMutableRawPointer(bitPattern: 0x40023800 as UInt)!)
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
        var rcc = RCC(baseAddress: UnsafeMutableRawPointer(bitPattern: 0x40023800 as UInt)!)
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
        var rcc = RCC(baseAddress: UnsafeMutableRawPointer(bitPattern: 0x40023800 as UInt)!)
        switch i2cNum {
        case 1: rcc.apb1enr.i2c1en = 1
        case 2: rcc.apb1enr.i2c2en = 1
        case 3: rcc.apb1enr.i2c3en = 1
        case 4: rcc.apb1enr.i2c4en = 1
        default: return
        }
    }

    public static func enableSPIClock(_ spiNum: UInt8) {
        var rcc = RCC(baseAddress: UnsafeMutableRawPointer(bitPattern: 0x40023800 as UInt)!)
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
        let flash = UnsafeMutableRawPointer(bitPattern: (0x4002_3C00 as UInt))
        let flashAcr = UnsafeMutablePointer<UInt32>(bitPattern: UInt(bitPattern: flash))!
        // Set FLASH_ACR to 0x5
        flashAcr.volatileStore(0x5)
    }

    public static func initializeLTCD() {
        var rcc = RCC(baseAddress: UnsafeMutableRawPointer(bitPattern: 0x40023800 as UInt)!)
        rcc.cfgr.rawValue = 0
        rcc.cr.hsion = 1
        rcc.cr.csson = 0
        rcc.cr.pllon = 0
        rcc.cr.hsebyp = 0
        rcc.cr.hseon = 1
        while rcc.cr.hserdy == 0 { }
    }

    enum LTDCConstants {
        static let hsync      = 30
        static let vsync      = 10
        static let hbp        = 13
        static let hfp        = 32
        static let vbp        = 2
        static let vfp        = 2
        
        static let PIXEL_SIZE = 4

        static let DISPLAY_WIDTH  = 480
        static let DISPLAY_HEIGHT = 272

        static let LAYER_WIDTH  = 50
        static let LAYER_HEIGHT = 50
    }

    public static func configureLTCD() {
        var ltdc = LTDC(baseAddress: UnsafeMutableRawPointer(bitPattern: 0x4001_6800)!)
        var rcc = RCC(baseAddress: UnsafeMutableRawPointer(bitPattern: 0x40023800 as UInt)!)

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
        while rcc.cr.pllrdy == 0 { }
        
        rcc.cfgr.rawValue &= 0b11
        rcc.cfgr.rawValue |= 0b10
        while rcc.cfgr.rawValue & 0b1100 != 0b1000 { }
        
        rcc.pllsaicfgr.pllsain = 192
        rcc.pllsaicfgr.pllsair = 5
        rcc.dkcfgr1.pllsaidivr = 1
        
        rcc.cr.pllsaion = 1
        while rcc.cr.pllsairdy == 0 { }
        
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
        
        var clk_pin = HALGPIO<STM32F746>(pin: .init(port: .i, number: 14))
        var de_pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 7))
        var hsync_pin = HALGPIO<STM32F746>(pin: .init(port: .i, number: 10))
        var vsync_pin = HALGPIO<STM32F746>(pin: .init(port: .i, number: 9))

        clk_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: false))
        de_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: false))
        hsync_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: false))
        vsync_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: false))
        
        var r0_pin = HALGPIO<STM32F746>(pin: .init(port: .i, number: 15))
        var r1_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 0))
        var r2_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 1))
        var r3_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 2))
        var r4_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 3))
        var r5_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 4))
        var r6_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 5))
        var r7_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 6))
        
        r0_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        r1_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        r2_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        r3_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        r4_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        r5_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        r6_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        r7_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        
        var g0_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 7))
        var g1_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 8))
        var g2_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 9))
        var g3_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 10))
        var g4_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 11))
        var g5_pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 0))
        var g6_pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 1))
        var g7_pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 2))
        
        g0_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        g1_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        g2_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        g3_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        g4_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        g5_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        g6_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        g7_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        
        var b0_pin = HALGPIO<STM32F746>(pin: .init(port: .e, number: 4))
        var b1_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 13))
        var b2_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 14))
        var b3_pin = HALGPIO<STM32F746>(pin: .init(port: .j, number: 15))
        var b4_pin = HALGPIO<STM32F746>(pin: .init(port: .g, number: 12))
        var b5_pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 4))
        var b6_pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 5))
        var b7_pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 6))
        
        b0_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        b1_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        b2_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        b3_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        b4_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction9 /*!*/, activeHigh: true))
        b5_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        b6_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        b7_pin.configure(configuration: .init(mode: .alternateFunction, outputType: .pushPull, outputSpeed: .high, pull: .none, alternateFunction: .alternateFunction14, activeHigh: true))
        
        
        var backlight_pin = HALGPIO<STM32F746>(pin: .init(port: .k, number: 3))
        backlight_pin.configure(configuration: .init(mode: .output, outputType: .pushPull, outputSpeed: .low, pull: .down, alternateFunction: .none, activeHigh: true))
        
        var lcd_disp_pin = HALGPIO<STM32F746>(pin: .init(port: .i, number: 12))
        lcd_disp_pin.configure(configuration: .init(mode: .output, outputType: .pushPull, outputSpeed: .low, pull: .down, alternateFunction: .none, activeHigh: true))

        lcd_disp_pin.assert()
        backlight_pin.assert()
        rcc.apb2enr.ltdcen = 1
                
        ltdc.sscr.vsh = UInt16(LTDCConstants.vsync - 1)
        ltdc.sscr.hsw = UInt16(LTDCConstants.hsync - 1)
        ltdc.bpcr.ahbp = UInt16(LTDCConstants.hsync + LTDCConstants.hbp - 1)
        ltdc.bpcr.avbp = UInt16(LTDCConstants.vsync + LTDCConstants.vbp - 1)
        ltdc.awcr.aah = UInt16(LTDCConstants.DISPLAY_HEIGHT + LTDCConstants.vsync + LTDCConstants.vbp - 1)
        ltdc.awcr.aav = UInt16(LTDCConstants.DISPLAY_WIDTH + LTDCConstants.hsync + LTDCConstants.hbp - 1)
        ltdc.twcr.totalw = UInt16(LTDCConstants.DISPLAY_WIDTH + LTDCConstants.hsync + LTDCConstants.hbp + LTDCConstants.hfp - 1)
        ltdc.twcr.totalh = UInt16(LTDCConstants.DISPLAY_HEIGHT + LTDCConstants.vsync + LTDCConstants.vbp + LTDCConstants.vfp - 1)

        ltdc.bccr.rawValue = 0x00_00_00_00 // background color
        
        setLayer2Position(Point(x: 0, y: 0))

        ltdc.l2pfcr.rawValue = 0 // Format ARGB8888
        ltdc.l2cfbar.rawValue = UInt32(UInt(bitPattern: logoPixelDataStartPointer))
        ltdc.l2cacr.consta = 255
        ltdc.l2bfcr.bf1 = 5
        ltdc.l2bfcr.bf2 = 4
        ltdc.l2cfblr.rawValue = UInt32(UInt32(LTDCConstants.PIXEL_SIZE * LTDCConstants.LAYER_WIDTH) << 16) | UInt32(LTDCConstants.PIXEL_SIZE * LTDCConstants.LAYER_WIDTH + 3)
        ltdc.l2cfblnr.cfblnbr = UInt16(LTDCConstants.LAYER_HEIGHT)
        ltdc.l2cr.len = 1
        
        ltdc.srcr.vbr = 1 // reload
        
        ltdc.gcr.ltdcen = 1
    }

    static func setLayer2Position(_ point: Point) {
        var ltdc = LTDC(baseAddress: UnsafeMutableRawPointer(bitPattern: 0x4001_6800)!)

        let i: Int = ((LTDCConstants.LAYER_WIDTH + LTDCConstants.hbp + LTDCConstants.hsync - 1 + point.x) << 16) | (LTDCConstants.hbp + LTDCConstants.hsync + point.x)
        ltdc.l2whpcr.rawValue = UInt32(i)
        let j: Int = ((LTDCConstants.LAYER_HEIGHT + LTDCConstants.vsync + LTDCConstants.vbp - 1 + point.y) << 16) | (LTDCConstants.vsync + LTDCConstants.vbp + point.y)
        ltdc.l2wvpcr.rawValue = UInt32(j)
        ltdc.srcr.vbr = 1
    }

    static func setBackgroundColor(_ color: Color) {
        var ltdc = LTDC(baseAddress: UnsafeMutableRawPointer(bitPattern: 0x4001_6800)!)

        ltdc.bccr.rawValue = UInt32(color.r | (color.g << 8) | (color.b << 16))
    }
}
