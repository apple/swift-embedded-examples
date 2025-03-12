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

import Support

extension LTDC {
}

public enum STM32F746 {
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
    rcc.cfgr.write { $0.raw.storage = 0 }
    rcc.cr.modify { r, w in 
      w.hsion = .On
      w.csson = .Off
      w.raw.hseon = 1
      w.raw.pllon = 0
      w.raw.hsebyp = 0
    }
    while rcc.cr.read().raw.hserdy == 0 {}

    rcc.pllcfgr.write {
      $0.raw.pllm = 25
      $0.raw.plln = 432
      $0.pllsrc = .HSE
    }

    rcc.cr.modify { $1.raw.pllon = 1 }
    while rcc.cr.read().raw.pllrdy != 1 {}

    rcc.cfgr.modify { $0.raw.sw = 0b10 }
    while rcc.cfgr.read().raw.sws == 0b10 {}

    rcc.pllsaicfgr.modify {
      $0.raw.pllsain = 192
      $0.raw.pllsair = 5
    }
    // FIXME: pllsai2divr
    rcc.dckcfgr1.modify { $0.raw.pllsaidivr = 0b100 }
    
    rcc.cr.modify { $1.raw.pllsaion = 1 }
    while rcc.cr.read().raw.pllsairdy != 1 {}

    rcc.enableGPIOPortClock(.a)
    rcc.enableGPIOPortClock(.b)
    rcc.enableGPIOPortClock(.c)
    rcc.enableGPIOPortClock(.d)
    rcc.enableGPIOPortClock(.e)
    rcc.enableGPIOPortClock(.f)
    rcc.enableGPIOPortClock(.g)
    rcc.enableGPIOPortClock(.h)
    rcc.enableGPIOPortClock(.i)
    rcc.enableGPIOPortClock(.j)
    rcc.enableGPIOPortClock(.k)

    let clkPinConfiguration = GPIOA.Configuration(
      mode: .alternateFunction,
      outputType: .pushPull,
      outputSpeed: .high,
      pull: .none,
      alternateFunction: 14)

    let clkPin = 14
    let dePin = 7
    let hsyncPin = 10
    let vsyncPin = 9

    gpioi.configure(pin: clkPin, as: clkPinConfiguration)
    gpiok.configure(pin: dePin, as: clkPinConfiguration)
    gpioi.configure(pin: hsyncPin, as: clkPinConfiguration)
    gpioi.configure(pin: vsyncPin, as: clkPinConfiguration)

    let rPinConfiguration = GPIOA.Configuration(
      mode: .alternateFunction,
      outputType: .pushPull,
      outputSpeed: .high,
      pull: .none,
      alternateFunction: 14)

    let r0Pin = 15
    let r1Pin = 0
    let r2Pin = 1
    let r3Pin = 2
    let r4Pin = 3
    let r5Pin = 4
    let r6Pin = 5
    let r7Pin = 6

    gpioi.configure(pin: r0Pin, as: rPinConfiguration)
    gpioj.configure(pin: r1Pin, as: rPinConfiguration)
    gpioj.configure(pin: r2Pin, as: rPinConfiguration)
    gpioj.configure(pin: r3Pin, as: rPinConfiguration)
    gpioj.configure(pin: r4Pin, as: rPinConfiguration)
    gpioj.configure(pin: r5Pin, as: rPinConfiguration)
    gpioj.configure(pin: r6Pin, as: rPinConfiguration)
    gpioj.configure(pin: r7Pin, as: rPinConfiguration)

    let gPinConfiguration = GPIOA.Configuration(
      mode: .alternateFunction,
      outputType: .pushPull,
      outputSpeed: .high,
      pull: .none,
      alternateFunction: 14)

    let g0Pin = 7
    let g1Pin = 8
    let g2Pin = 9
    let g3Pin = 10
    let g4Pin = 11
    let g5Pin = 0
    let g6Pin = 1
    let g7Pin = 2

    gpioj.configure(pin: g0Pin, as: gPinConfiguration)
    gpioj.configure(pin: g1Pin, as: gPinConfiguration)
    gpioj.configure(pin: g2Pin, as: gPinConfiguration)
    gpioj.configure(pin: g3Pin, as: gPinConfiguration)
    gpioj.configure(pin: g4Pin, as: gPinConfiguration)
    gpiok.configure(pin: g5Pin, as: gPinConfiguration)
    gpiok.configure(pin: g6Pin, as: gPinConfiguration)
    gpiok.configure(pin: g7Pin, as: gPinConfiguration)

    let bPinConfiguration = GPIOA.Configuration(
      mode: .alternateFunction,
      outputType: .pushPull,
      outputSpeed: .high,
      pull: .none,
      alternateFunction: 14)

    let b0Pin = 4
    let b1Pin = 13
    let b2Pin = 14
    let b3Pin = 15
    let b4Pin = 12
    let b5Pin = 4
    let b6Pin = 5
    let b7Pin = 6

    gpioe.configure(pin: b0Pin, as: bPinConfiguration)
    gpioj.configure(pin: b1Pin, as: bPinConfiguration)
    gpioj.configure(pin: b2Pin, as: bPinConfiguration)
    gpioj.configure(pin: b3Pin, as: bPinConfiguration)
    gpiog.configure(pin: b4Pin, as: bPinConfiguration) // alternateFunction9 ???
    gpiok.configure(pin: b5Pin, as: bPinConfiguration)
    gpiok.configure(pin: b6Pin, as: bPinConfiguration)
    gpiok.configure(pin: b7Pin, as: bPinConfiguration)

    let lcdPinConfiguration = GPIOA.Configuration(
      mode: .output,
      outputType: .pushPull,
      outputSpeed: .low,
      pull: .down,
      alternateFunction: 0)

    let backlightPin = 3
    let lcdDispPin = 12
    
    gpiok.configure(pin: backlightPin, as: lcdPinConfiguration)
    gpioi.configure(pin: lcdDispPin, as: lcdPinConfiguration)

    gpioi.set(pin: lcdDispPin, to: true)
    gpiok.set(pin: backlightPin, to: true)

    rcc.apb2enr.modify { $0.raw.ltdcen = 1 }

    ltdc.sscr.modify { $0.raw.vsh = UInt32(LTDCConstants.vsync - 1) }
    ltdc.sscr.modify { $0.raw.hsw = UInt32(LTDCConstants.hsync - 1) }
    ltdc.bpcr.modify { $0.raw.ahbp = UInt32(LTDCConstants.hsync + LTDCConstants.hbp - 1) }
    ltdc.bpcr.modify { $0.raw.avbp = UInt32(LTDCConstants.vsync + LTDCConstants.vbp - 1) }
    ltdc.awcr.modify { $0.raw.aah = UInt32(LTDCConstants.displayHeight + LTDCConstants.vsync + LTDCConstants.vbp - 1) }
    ltdc.awcr.modify { $0.raw.aaw = UInt32(LTDCConstants.displayWidth + LTDCConstants.hsync + LTDCConstants.hbp - 1) }
    ltdc.twcr.modify { $0.raw.totalw = UInt32(LTDCConstants.displayWidth + LTDCConstants.hsync + LTDCConstants.hbp + LTDCConstants.hfp - 1) }
    ltdc.twcr.modify { $0.raw.totalh = UInt32(LTDCConstants.displayHeight + LTDCConstants.vsync + LTDCConstants.vbp + LTDCConstants.vfp - 1) }

    ltdc.bccr.modify { $0.raw.storage = 0x00_00_00_00 } // background color 

    self.set(layer: 1, position: Point(x: 0, y: 0))

    ltdc.layer[1].pfcr.modify { $0.raw.storage = 0 } // Format ARGB8888
    // ltdc.layer[1].cfbar.modify { $0.raw.storage = UInt32(UInt(bitPattern: logoPixelDataStartPointer)) }
    ltdc.layer[1].cacr.modify { $0.raw.consta = 255 }
    ltdc.layer[1].bfcr.modify { $0.raw.bf1 = 5 }
    ltdc.layer[1].bfcr.modify { $0.raw.bf2 = 4 }
    ltdc.layer[1].cfblr.modify { $0.raw.storage = UInt32(UInt32(LTDCConstants.pixelSize * LTDCConstants.layerWidth) << 16) | UInt32(LTDCConstants.pixelSize * LTDCConstants.layerWidth + 3) }
    ltdc.layer[1].cfblnr.modify { $0.raw.cfblnbr = UInt32(LTDCConstants.layerHeight) }
    ltdc.layer[1].cr.modify { $0.raw.len = 1 }

    ltdc.srcr.modify { $0.raw.vbr = 1 } // reload

    ltdc.gcr.modify { $1.raw.ltdcen = 1 }
  }

  static func set(backgroundColor: Color) {
    ltdc.bccr.modify {
      $0.raw.bcred = UInt32(backgroundColor.red)
      $0.raw.bcgreen = UInt32(backgroundColor.green)
      $0.raw.bcblue = UInt32(backgroundColor.blue)
    }
  }

  static func set(layer: Int, position point: Point) {
    let i: Int =
      ((LTDCConstants.layerWidth + LTDCConstants.hbp + LTDCConstants.hsync - 1
        + point.x) << 16) | (LTDCConstants.hbp + LTDCConstants.hsync + point.x)
    ltdc.layer[layer].whpcr.modify { $0.raw.storage = UInt32(i) }
    let j: Int =
      ((LTDCConstants.layerHeight + LTDCConstants.vsync + LTDCConstants.vbp - 1
        + point.y) << 16) | (LTDCConstants.vsync + LTDCConstants.vbp + point.y)
    ltdc.layer[layer].wvpcr.modify { $0.raw.storage = UInt32(j) }
    ltdc.srcr.modify { $0.raw.vbr = 1 }
  }
}
