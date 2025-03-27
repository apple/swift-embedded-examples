//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors.
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import Support

extension LTDC {
  enum Constants {
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

  func configure() {
    rcc.pllcfgr.write {
      $0.raw.pllm = 25
      $0.raw.plln = 432
      $0.pllsrc = .HSE
    }

    rcc.cr.modify { $1.raw.pllon = 1 }
    while rcc.cr.read().raw.pllrdy != 1 {}

    // FIXME: use named fields
    rcc.cfgr.modify {
      $0.raw.storage &= 0b11
      $0.raw.storage |= 0b10
    }
    while rcc.cfgr.read().raw.storage & 0b1100 != 0b1000 {}

    rcc.pllsaicfgr.modify {
      $0.raw.pllsain = 192
      $0.raw.pllsair = 5
    }
    rcc.dckcfgr1.modify { $0.pllsaidivr = .Div4 }

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

    let pinConfiguration = GPIOA.Configuration(
      mode: .alternateFunction,
      outputType: .pushPull,
      outputSpeed: .high,
      pull: .none,
      alternateFunction: 14)

    let clkPin = 14
    let dePin = 7
    let hsyncPin = 10
    let vsyncPin = 9

    gpioi.configure(pin: clkPin, as: pinConfiguration)
    gpiok.configure(pin: dePin, as: pinConfiguration)
    gpioi.configure(pin: hsyncPin, as: pinConfiguration)
    gpioi.configure(pin: vsyncPin, as: pinConfiguration)

    let r0Pin = 15
    let r1Pin = 0
    let r2Pin = 1
    let r3Pin = 2
    let r4Pin = 3
    let r5Pin = 4
    let r6Pin = 5
    let r7Pin = 6

    gpioi.configure(pin: r0Pin, as: pinConfiguration)
    gpioj.configure(pin: r1Pin, as: pinConfiguration)
    gpioj.configure(pin: r2Pin, as: pinConfiguration)
    gpioj.configure(pin: r3Pin, as: pinConfiguration)
    gpioj.configure(pin: r4Pin, as: pinConfiguration)
    gpioj.configure(pin: r5Pin, as: pinConfiguration)
    gpioj.configure(pin: r6Pin, as: pinConfiguration)
    gpioj.configure(pin: r7Pin, as: pinConfiguration)

    let g0Pin = 7
    let g1Pin = 8
    let g2Pin = 9
    let g3Pin = 10
    let g4Pin = 11
    let g5Pin = 0
    let g6Pin = 1
    let g7Pin = 2

    gpioj.configure(pin: g0Pin, as: pinConfiguration)
    gpioj.configure(pin: g1Pin, as: pinConfiguration)
    gpioj.configure(pin: g2Pin, as: pinConfiguration)
    gpioj.configure(pin: g3Pin, as: pinConfiguration)
    gpioj.configure(pin: g4Pin, as: pinConfiguration)
    gpiok.configure(pin: g5Pin, as: pinConfiguration)
    gpiok.configure(pin: g6Pin, as: pinConfiguration)
    gpiok.configure(pin: g7Pin, as: pinConfiguration)

    let b0Pin = 4
    let b1Pin = 13
    let b2Pin = 14
    let b3Pin = 15
    let b4Pin = 12
    let b5Pin = 4
    let b6Pin = 5
    let b7Pin = 6

    gpioe.configure(pin: b0Pin, as: pinConfiguration)
    gpioj.configure(pin: b1Pin, as: pinConfiguration)
    gpioj.configure(pin: b2Pin, as: pinConfiguration)
    gpioj.configure(pin: b3Pin, as: pinConfiguration)
    gpiog.configure(pin: b4Pin, as: pinConfiguration)
    gpiok.configure(pin: b5Pin, as: pinConfiguration)
    gpiok.configure(pin: b6Pin, as: pinConfiguration)
    gpiok.configure(pin: b7Pin, as: pinConfiguration)

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

    self.sscr.modify { $0.raw.vsh = UInt32(Constants.vsync - 1) }
    self.sscr.modify { $0.raw.hsw = UInt32(Constants.hsync - 1) }
    self.bpcr.modify {
      $0.raw.ahbp = UInt32(Constants.hsync + Constants.hbp - 1)
    }
    self.bpcr.modify {
      $0.raw.avbp = UInt32(Constants.vsync + Constants.vbp - 1)
    }
    self.awcr.modify {
      $0.raw.aah = UInt32(
        Constants.displayHeight + Constants.vsync + Constants.vbp - 1)
    }
    self.awcr.modify {
      $0.raw.aaw = UInt32(
        Constants.displayWidth + Constants.hsync + Constants.hbp - 1)
    }
    self.twcr.modify {
      $0.raw.totalw = UInt32(
        Constants.displayWidth + Constants.hsync + Constants.hbp + Constants.hfp
          - 1)
    }
    self.twcr.modify {
      $0.raw.totalh = UInt32(
        Constants.displayHeight + Constants.vsync + Constants.vbp
          + Constants.vfp - 1)
    }

    self.layer[1].pfcr.modify { $0.raw.storage = 0 }  // Format ARGB8888
    self.layer[1].cfbar.modify {
      $0.raw.storage = UInt32(UInt(bitPattern: logoPixelDataStartPointer))
    }
    self.layer[1].cacr.modify { $0.raw.consta = 255 }
    self.layer[1].bfcr.modify { $0.raw.bf1 = 5 }
    self.layer[1].bfcr.modify { $0.raw.bf2 = 4 }
    self.layer[1].cfblr.modify {
      $0.raw.storage =
        UInt32(UInt32(Constants.pixelSize * Constants.layerWidth) << 16)
        | UInt32(Constants.pixelSize * Constants.layerWidth + 3)
    }
    self.layer[1].cfblnr.modify {
      $0.raw.cfblnbr = UInt32(Constants.layerHeight)
    }
    self.layer[1].cr.modify { $0.raw.len = 1 }

    self.srcr.modify { $0.raw.vbr = 1 }  // reload

    self.gcr.modify { $1.raw.ltdcen = 1 }
  }

  func set(layer: Int, position point: Point) {
    let i: Int =
      ((Constants.layerWidth + Constants.hbp + Constants.hsync - 1
        + point.x) << 16) | (Constants.hbp + Constants.hsync + point.x)
    self.layer[layer].whpcr.modify { $0.raw.storage = UInt32(i) }
    let j: Int =
      ((Constants.layerHeight + Constants.vsync + Constants.vbp - 1
        + point.y) << 16) | (Constants.vsync + Constants.vbp + point.y)
    self.layer[layer].wvpcr.modify { $0.raw.storage = UInt32(j) }
    self.srcr.modify { $0.raw.vbr = 1 }
  }

  func set(backgroundColor: Color) {
    self.bccr.modify {
      $0.raw.bcred = UInt32(backgroundColor.red)
      $0.raw.bcgreen = UInt32(backgroundColor.green)
      $0.raw.bcblue = UInt32(backgroundColor.blue)
    }
  }
}
