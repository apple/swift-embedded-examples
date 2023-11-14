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

class PixelBuffer {
  let buffer: UnsafeMutableBufferPointer<SPINeoPixelGRB64Pixel>

  init(count: Int) {
    self.buffer = .allocate(capacity: count)
    self.buffer.initialize(repeating: .reset)
  }

  deinit {
    self.buffer.deallocate()
  }
}

struct SPINeoPixel {
  var dma: DMA1
  var spi: SPI2
  var pixels: PixelBuffer
  var base: UInt8 = 0

  init(
    dma: DMA1,
    spi: SPI2,
    pixelCount: Int
  ) {
    precondition(MemoryLayout<SPINeoPixelGRB64Pixel>.size == 24)
    precondition(MemoryLayout<SPINeoPixelGRB64Pixel>.stride == 24)
    self.dma = dma
    self.spi = spi
    self.pixels = PixelBuffer(count: pixelCount)
  }
}

extension SPINeoPixel {
  @inline(never)
  mutating func clear() {
    let rgb = RGB8Pixel(red: 0, green: 0, blue: 0)
    let pixel = SPINeoPixelGRB64Pixel(rgb)
    for index in self.pixels.buffer.indices {
      self.pixels.buffer[index] = pixel
    }
  }

  @inline(never)
  mutating func rainbow() {
    var hsv = HSV8Pixel(hue: self.base, saturation: 255, value: 255)
    for index in self.pixels.buffer.indices {
      hsv.hue &+= 1
      let rgb = RGB8Pixel(hsv)
      self.pixels.buffer[index] = SPINeoPixelGRB64Pixel(rgb.gammaCorrected)
    }
    self.base &+= 1
  }

  @inline(never)
  mutating func draw() {
    let memory = UInt32(UInt(bitPattern: self.pixels.buffer.baseAddress!))
    let peripheral = UInt32(spi.dr.unsafeAddress)
    let count = UInt32(self.pixels.buffer.count * MemoryLayout<SPINeoPixelGRB64Pixel>.size)

    self.dma.s4cr.modify { rw in
      rw.raw.chsel = 0     // Set the DMA channel to 0 (spi tx).
      rw.raw.pfctrl = 0    // Set the DMA as the flow controller.
      rw.raw.pl = 0b11     // Set the stream priority to Very High.
      rw.raw.dir = 0b01    // Set memory to peripheral transfer direction.
      rw.raw.pinc = 0      // Set peripheral to fixed (no-increment) mode.
      rw.raw.minc = 1      // Set memory to incremented mode.
      rw.raw.pburst = 0b00 // Set peripheral to single transaction mode.
      rw.raw.mburst = 0b00 // Set memory to single transaction mode.
      rw.raw.psize = 0b00  // Set peripheral data width to 8 bit.
      rw.raw.msize = 0b00  // Set memory data width to 8 bit.
      rw.raw.circ = 0      // Disable circular mode.
      rw.raw.dbm = 0       // Disable double buffer mode.
      rw.raw.tcie = 1      // Enable transfer complete interrupt.
      rw.raw.htie = 1      // Enable half transfer interrupt.
      rw.raw.teie = 1      // Enable transfer error interrupt.
      rw.raw.dmeie = 1     // Enable direct mode error interrupt.
    }

    // Set the total number of data items to the buffer size.
    self.dma.s4ndtr.modify { $0.raw.ndt = UInt32(count) }

    // Set the destination peripheral port address to the spi data port.
    self.dma.s4par.modify { $0.raw.pa = peripheral }

    // Set the source memory address to the buffer's base.
    self.dma.s4m0ar.modify { $0.raw.m0a = memory }

    // Clear the second memory address as double buffering mode is disabled.
    self.dma.s4m1ar.modify { $0.raw.m1a = 0 }

    self.dma.s4fcr.modify { _, w in
      w.raw.feie = 1     // Enable FIFO error interrupt.
      w.raw.dmdis = 0    // Enable direct mode (double negative).
      w.raw.fth = 0b00   // Reset FIFO threshold (no effect in direct mode).
    }

    self.dma.hifcr.modify { rw in
      rw.raw.ctcif4 = 1   // Clear transfer complete interrupt flag.
      rw.raw.chtif4 = 1   // Clear half transfer interrupt flag.
      rw.raw.cteif4 = 1   // Clear transfer error interrupt flag.
      rw.raw.cdmeif4 = 1  // Clear direct mode error interrupt flag.
      rw.raw.cfeif4 = 1   // Clear FIFO error interrupt flag.
    }

    self.spi.cr1.modify { rw in
      rw.raw.bidimode = 0 // Set full duplex.
      rw.raw.bidioe = 0
      rw.raw.crcen = 0    // Disable hardware crc.
      rw.raw.crcnext = 0
      rw.raw.crcl = 0
      rw.raw.rxonly = 0   // Set full duplex.
      rw.raw.ssm = 1      // FIXME: understand this Disable software slave management and select.
      rw.raw.ssi = 1
      rw.raw.lsbfirst = 0 // Set data MSB first.
      rw.raw.br = 0b000   // Set Baud Rate as Fpclk/2.
      rw.raw.mstr = 1     // Set Master mode.
      rw.raw.cpol = 0     // Set active high logic.
      rw.raw.cpha = 1     // FIXME: understand this Set trailing edge logic.
    }

    // Write to SPI_CR2 register:
    // a) Configure the DS[3:0] bits to select the data length for the transfer.
    // b) Configure SSOE (Notes: 1 & 2 & 3).
    // c) Set the FRF bit if the TI protocol is required (keep NSSP bit cleared in TI mode).
    // d) Set the NSSP bit if the NSS pulse mode between two data units is required (keep
    // CHPA and TI bits cleared in NSSP mode).
    // e) Configure the FRXTH bit. The RXFIFO threshold must be aligned to the read
    // access size for the SPIx_DR register.
    // f) Initialize LDMA_TX and LDMA_RX bits if DMA is used in packed mode.

    self.spi.cr2.modify { rw in
      rw.raw.ldma_tx = 0 // Reset dma transmission length.
      rw.raw.ldma_rx = 0 // Reset dma reception length.
      rw.raw.frxth = 1   // Set RXNE if FIFO <8 bits.
      rw.raw.ds = 0b0111 // Set Data size to 8 bit.
      rw.raw.txeie = 1   // Enable tx buffer empty interrupt.
      rw.raw.rxneie = 1  // Enable rx not buffer empty interrupt.
      rw.raw.errie = 1   // Enable error interrupt.
      rw.raw.frf = 0     // Reset frame format (i2s).
      // rw.raw.nssp = 0    // FIXME: understand this Disable NSS pulse management.
      // rw.raw.ssoe = 0    // FIXME: understand this Disable slave select.
      rw.raw.txdmaen = 1 // Enable tx dma.
      rw.raw.rxdmaen = 0 // Disable rx dma.
    }

    // Activate the stream.
    self.dma.s4cr.modify { $0.raw.en = 1 }

    // Activate the SPI peripheral
    self.spi.cr1.modify { $0.raw.spe = 1 }

    func wait() -> Bool {
      while true {
        let hisr = self.dma.hisr.read().raw
        if hisr.tcif4 == 1 { return true }
        if hisr.teif4 == 1 { return false }
        if hisr.dmeif4 == 1 { return false }
        if hisr.feif4 == 1 { return false }
      }
    }

    _ = wait()

    // Wait until no more data to transmit.
    while self.spi.sr.read().raw.ftlvl != 0b00 { }
    // Wait until the last data frame is processed.
    while self.spi.sr.read().raw.bsy != 0 { }
    // Disable the SPI peripheral.
    self.spi.cr1.modify { $0.raw.spe = 0 }
    // Don't wait until the read data is received since the NeoPixel is not
    // a real SPI device. This will lead to overrun errors but they can be
    // safely ignored.
    // while self.spi.sr.read().raw.frlvl != 0b00 { }

    // Disable any existing DMA transfer on stream 0.
    self.dma.s4cr.modify { $0.raw.en = 0 }
    // Wait for the DMA stream to actually shutdown.
    while self.dma.s4cr.read().raw.en != 0 { }
  }
}
