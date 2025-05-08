import MMIO

@Register(bitWidth: 32)
struct GIOIODIR {
  @ReadWrite(bits: 9..<10, as: Bool.self)
  var direction: DIRECTION
}

@Register(bitWidth: 32)
struct GIODATA {
  @ReadWrite(bits: 9..<10, as: Bool.self)
  var value: VALUE
}

@RegisterBlock
struct GPIO {
  @RegisterBlock(offset: 0x00008)
  var gioiodir: Register<GIOIODIR>
  @RegisterBlock(offset: 0x00004)
  var giodata: Register<GIODATA>
}

let gpio = GPIO(unsafeAddress: 0x10_7d51_7c00)

func setLedOutput() {
  gpio.gioiodir.modify {
    $0.direction = false  // 0 is output, 1 is input
  }
}

func ledOn() {
  gpio.giodata.modify {
    $0.value = true  // pin on
  }
}

func ledOff() {
  gpio.giodata.modify {
    $0.value = false  // pin off
  }
}

@main
struct Application {
  static func main() {
    setLedOutput()
    while true {
      ledOn()
      for _ in 1..<100000 {}  // just a delay
      ledOff()
      for _ in 1..<100000 {}  // just a delay
    }
  }
}
