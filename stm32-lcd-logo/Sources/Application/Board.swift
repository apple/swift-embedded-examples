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

struct STM32F746Board {
  var led: HALGPIO<STM32F746>

  init() {
    // Configure LED on I1
    STM32F746.enableGPIOPortClock(.i)
    led = HALGPIO<STM32F746>(pin: .init(port: .i, number: 1))
    led.configure(
      configuration: .init(
        mode: .output, outputType: .pushPull, outputSpeed: .high, pull: .down,
        alternateFunction: .none, activeHigh: true))
    led.deassert()

    STM32F746.initializeLTCD()

    STM32F746.configureFlash()

    STM32F746.configureLTCD()
  }

  mutating func ledOn() {
    led.assert()
  }

  mutating func ledOff() {
    led.deassert()
  }

  mutating func delay(milliseconds: Int) {
    for _ in 0..<100_000 * milliseconds {
      nop()
    }
  }

  mutating func moveLogo(to point: Point) {
    STM32F746.setLayer2Position(point)
  }

  mutating func setBackgroundColor(color: Color) {
    STM32F746.setBackgroundColor(color)
  }

  var displaySize: Size {
    Size(
      width: STM32F746.LTDCConstants.displayWidth,
      height: STM32F746.LTDCConstants.displayHeight)
  }

  var logoLayerSize: Size {
    Size(width: 50, height: 50)
  }
}

struct Point {
  var x, y: Int

  func offset(by: Point) -> Point {
    Point(x: x + by.x, y: y + by.y)
  }
}

struct Size {
  var width, height: Int
}

struct Color {
  var r, g, b: Int
}
