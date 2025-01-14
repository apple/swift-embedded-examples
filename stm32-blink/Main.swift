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

enum GPIOBank: Int {
  case a, b, c, d, e, f, g, h, i, j, k
}
typealias GPIOPin = Int

// I1 pin on STM32F746 Discovery Board
//let ledConfig: (GPIOBank, GPIOPin) = (.i, 1)

// A5 aka "Arduino D13" pin on Nucleo-64 boards
let ledConfig: (GPIOBank, GPIOPin) = (.a, 5)

#if STM32F74_F75

typealias Board = STM32F746Board
enum STM32F746Board {
  static func initialize() {
    // (1) AHB1ENR[i] = 1 ... enable clock
    setRegisterBit(
      baseAddress: RCC.BaseAddress, offset: RCC.Offsets.AHB1ENR, bit: 8,
      value: 1)
    // (2) MODER[1] = 1 ... set mode to output
    setRegisterTwoBitField(
      baseAddress: GPIO.GPIOi_BaseAddress, offset: GPIO.Offsets.MODER,
      bitsStartingAt: 2, value: 1)
    // (3) OTYPER[1] = 0 ... output type is push-pull
    setRegisterBit(
      baseAddress: GPIO.GPIOi_BaseAddress, offset: GPIO.Offsets.OTYPER, bit: 1,
      value: 0)
    // (4) OSPEEDR[1] = 2 ... speed is high
    setRegisterTwoBitField(
      baseAddress: GPIO.GPIOi_BaseAddress, offset: GPIO.Offsets.OSPEEDR,
      bitsStartingAt: 2, value: 2)
    // (5) PUPDR[1] = 2 ... set pull to down
    setRegisterTwoBitField(
      baseAddress: GPIO.GPIOi_BaseAddress, offset: GPIO.Offsets.PUPDR,
      bitsStartingAt: 2, value: 2)

    ledOff()
  }

  static func ledOn() {
    // ODR[1] = 1
    setRegisterBit(
      baseAddress: GPIO.GPIOi_BaseAddress, offset: GPIO.Offsets.ODR, bit: 1,
      value: 1)
  }

  static func ledOff() {
    // ODR[1] = 0
    setRegisterBit(
      baseAddress: GPIO.GPIOi_BaseAddress, offset: GPIO.Offsets.ODR, bit: 1,
      value: 0)
  }

  static func delay(milliseconds: Int) {
    for _ in 0..<10_000 * milliseconds {
      nop()
    }
  }
}

#elseif STM32F1

typealias Board = STM32F1Board
enum STM32F1Board {
  static func initialize() {
    // (1) IOPENR[ledConfig.0] = 1 ... enable clock
    setRegisterBit(
      baseAddress: RCC.BaseAddress, offset: RCC.Offsets.APB2ENR, bit: RCC.APB2ENRBit(for: ledConfig.0),
      value: 1)
    // (2) MODE[1] = 0b11 ... set mode to output, high speed
    setRegisterTwoBitField(
      baseAddress: GPIO.GPIOBaseAddress(for: ledConfig.0), offset: GPIO.Offsets.CRL,
      bitsStartingAt: 4 * ledConfig.1, value: 3)
    // (3) CNF[1] = 0b00 ... general purpose, push-pull
    setRegisterTwoBitField(
      baseAddress: GPIO.GPIOBaseAddress(for: ledConfig.0), offset: GPIO.Offsets.CRL,
      bitsStartingAt: 4 * ledConfig.1 + 2, value: 0)

    ledOff()
  }

  static func ledOn() {
    // ODR[1] = 1
    setRegisterBit(
      baseAddress: GPIO.GPIOBaseAddress(for: ledConfig.0), offset: GPIO.Offsets.ODR, bit: ledConfig.1,
      value: 1)
  }

  static func ledOff() {
    // ODR[1] = 0
    setRegisterBit(
      baseAddress: GPIO.GPIOBaseAddress(for: ledConfig.0), offset: GPIO.Offsets.ODR, bit: ledConfig.1,
      value: 0)
  }

  static func delay(milliseconds: Int) {
    for _ in 0..<10_000 * milliseconds {
      nop()
    }
  }
}

#elseif STM32C0

typealias Board = STM32C0Board
enum STM32C0Board {
  static func initialize() {
    // (1) IOPENR[ledConfig.0] = 1 ... enable clock
    setRegisterBit(
      baseAddress: RCC.BaseAddress, offset: RCC.Offsets.IOPENR, bit: ledConfig.0.rawValue,
      value: 1)
    // (2) MODER[1] = 1 ... set mode to output
    setRegisterTwoBitField(
      baseAddress: GPIO.GPIOBaseAddress(for: ledConfig.0), offset: GPIO.Offsets.MODER,
      bitsStartingAt: 2 * ledConfig.1, value: 1)
    // (3) OTYPER[1] = 0 ... output type is push-pull
    setRegisterBit(
      baseAddress: GPIO.GPIOBaseAddress(for: ledConfig.0), offset: GPIO.Offsets.OTYPER, bit: ledConfig.1,
      value: 0)
    // (4) OSPEEDR[1] = 2 ... speed is high
    setRegisterTwoBitField(
      baseAddress: GPIO.GPIOBaseAddress(for: ledConfig.0), offset: GPIO.Offsets.OSPEEDR,
      bitsStartingAt: 2 * ledConfig.1, value: 2)
    // (5) PUPDR[1] = 2 ... set pull to down
    setRegisterTwoBitField(
      baseAddress: GPIO.GPIOBaseAddress(for: ledConfig.0), offset: GPIO.Offsets.PUPDR,
      bitsStartingAt: 2 * ledConfig.1, value: 2)

    ledOff()
  }

  static func ledOn() {
    // ODR[1] = 1
    setRegisterBit(
      baseAddress: GPIO.GPIOBaseAddress(for: ledConfig.0), offset: GPIO.Offsets.ODR, bit: ledConfig.1,
      value: 1)
  }

  static func ledOff() {
    // ODR[1] = 0
    setRegisterBit(
      baseAddress: GPIO.GPIOBaseAddress(for: ledConfig.0), offset: GPIO.Offsets.ODR, bit: ledConfig.1,
      value: 0)
  }

  static func delay(milliseconds: Int) {
    for _ in 0..<10_000 * milliseconds {
      nop()
    }
  }
}

#endif

@main
struct Main {
  static func main() {
    Board.initialize()

    while true {
      Board.ledOn()
      Board.delay(milliseconds: 100)
      Board.ledOff()
      Board.delay(milliseconds: 300)
    }
  }
}
