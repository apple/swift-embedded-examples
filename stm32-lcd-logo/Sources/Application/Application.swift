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

let logoLayerSize = Size(width: 50, height: 50)
let displaySize = Size(
  width: STM32F746.LTDCConstants.displayWidth,
  height: STM32F746.LTDCConstants.displayHeight)

let ledPin = 1
let led = LED(pin: ledPin, port: gpioi)

@main
struct Application {

  mutating func run() {
    self.configureFlash()
    self.configureLED()
    STM32F746.configureLTCD()
    
    blink()

    var iteration = 0
    
    var logoPosition = Point(x: 100, y: 0)
    var logoDelta = Point(x: 1, y: 1)
    let maxLogoPosition = Point(
      x: displaySize.width - logoLayerSize.width,
      y: displaySize.height - logoLayerSize.height)

    var backgroundGray: UInt8 = 0
    var backgroundDelta: Int8 = 1

    while true {
      self.delay(milliseconds: 10)

      iteration += 1
      if iteration.isMultiple(of: 16) {
        self.blink()
      }

      if logoPosition.x <= 0 || logoPosition.x >= maxLogoPosition.x {
        logoDelta.x *= -1
      }

      if logoPosition.y <= 0 || logoPosition.y >= maxLogoPosition.y {
        logoDelta.y *= -1
      }

      logoPosition = logoPosition.offset(by: logoDelta)
      STM32F746.set(layer: 1, position: logoPosition)

      if backgroundGray == .min || backgroundGray == .max {
        backgroundDelta *= -1
      }

      backgroundGray = UInt8(Int16(backgroundGray) + Int16(backgroundDelta))
      STM32F746.set(backgroundColor: .gray(backgroundGray))
    }
  }

  func configureLED() {
    rcc.enableGPIOPortClock(.i)
    gpioi.configure(
      pin: ledPin,
      as: .init(
        mode: .output,
        outputType: .pushPull,
        outputSpeed: .high,
        pull: .down,
        alternateFunction: 0))
  }

  func blink() {
    led.on()
    self.delay(milliseconds: 10)
    led.off()
    self.delay(milliseconds: 20)
  }

  func delay(milliseconds: Int) {
    for _ in 0..<100_000 * milliseconds {
      nop()
    }
  }

  func configureFlash() {
    // FIXME: flashAcr.volatileStore(0x5)
    // Set FLASH_ACR to 0x5
    flash.acr.modify { $0.latency = .WS5 }
  }
}

extension Application {
  static func main() {
    var app = Application()
    app.run()
  }
}