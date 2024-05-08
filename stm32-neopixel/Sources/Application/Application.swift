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

@main
public struct Application {
  public static func main() {
#if arch(arm)
    enableFaults()
    enableFPU()
#endif

    // MARK: Clock configuration
    // Disable PLL.
    rcc.cr.modify { $1.raw.pllon = 0 }

    // Configure UART to always use HSI.
    rcc.dkcfgr2.modify { $0.raw.usart1sel = 0b10 }

    // Configure PLL to convert the 16MHz HSI to a 12.8MHz SYSCLK.
    // HSI is measured to be closer to 16.6Mhz on my device.
    // The SPI bus must run at 6.4MHz which is achieved with a /2 prescalar.
    let pllM: UInt8 = 10
    let pllN: UInt8 = 64
    let pllP: UInt8 = 0b11 // maps to 8
    // ((16MHz / M) * N) / P = 12.8MHz

    rcc.pllcfgr.modify { rw in
      // Clear all non-reserved registers.
      rw.raw.storage &= 0b1111_0000_1011_1100__1000_0000_0000_0000
      rw.raw.storage |= UInt32(pllM) << 0 // Set M constant
      rw.raw.storage |= UInt32(pllN) << 6 // Set N constant
      rw.raw.storage |= UInt32(pllP) << 16 // Set P constant
      rw.raw.storage |= UInt32(0) << 22 // Select HSI PLL Source
    }

    // Enable the PLL clock and wait for ready.
    rcc.cr.modify { $1.raw.pllon = 1 }
    while rcc.cr.read().raw.pllrdy != 1 { }

    // Change the SYSCLK mux to select the PLL clock and wait for ready.
    rcc.cfgr.modify { _, w in
      w.raw.sw0 = 0 // Select PLL clock low.
      w.raw.sw1 = 1 // Select PLL clock high.
      w.raw.hpre = 0 // system clock not divided
      w.raw.ppre1 = 0 // AHB clock not divided
      w.raw.ppre2 = 0 // AHB clock not divided
    }

    while true {
      let cfgr = rcc.cfgr.read().raw
      if cfgr.sws0 == 0 && cfgr.sws1 == 1 { break }
    }

    // DMA
    rcc.ahb1enr.modify { $0.raw.dma1en = 1 }
    // GPIO
    rcc.ahb1enr.modify { rw in
      rw.raw.gpioaen = 1
      rw.raw.gpioben = 1
      rw.raw.gpioien = 1
    }
    // SPI
    rcc.apb1enr.modify { $0.raw.spi2en = 1 }
    // UART
    rcc.apb2enr.modify { $0.raw.usart1en = 1 }

    // MARK: Peripheral Configuration
    // GPIO - SPI pin configuration
    gpiob.configure(
      pin: 15,
      as: .init(
        mode: .alternateFunction,
        outputType: .pushPull,
        outputSpeed: .max,
        pull: .none,
        alternateFunction: 5))
    gpioi.configure(
      pin: 1,
      as: .init(
        mode: .alternateFunction,
        outputType: .pushPull,
        outputSpeed: .max,
        pull: .none,
        alternateFunction: 5))

    // GPIO - UART pin configuration
    gpioa.configure(
      pin: 9,
      as: .init(
        mode: .alternateFunction,
        outputType: .pushPull,
        outputSpeed: .low,
        pull: .none,
        alternateFunction: 7))
    gpiob.configure(
      pin: 7,
      as: .init(
        mode: .alternateFunction,
        outputType: .pushPull,
        outputSpeed: .low,
        pull: .none,
        alternateFunction: 7))

    // UART configuration
    usart1.brr.modify { $0.raw.storage = 16000000/115200 }
    usart1.cr1.modify { rw in
      rw.raw.ue = 1
      rw.raw.re = 1
      rw.raw.te = 1
    }

    // MARK: Main loop
    print("Hello Swift!")
    var neoPixel = SPINeoPixel(dma: dma1, spi: spi2, pixelCount: 60)
    while true {
      neoPixel.rainbow()
      neoPixel.draw()
    }
  }
}

@_cdecl("Default_Handler")
public func defaultHandler() {
  while true { }
}

@_cdecl("putchar")
public func putchar(_ value: CInt) -> CInt {
  while usart1.isr.read().raw.txe == 0 { }
  usart1.tdr.modify { $0.raw.tdr_field = UInt32(value) }
  while usart1.isr.read().raw.txe == 0 { }
  return 0
}
