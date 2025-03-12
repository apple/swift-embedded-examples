struct LED {
  var pin: Int
  var port: GPIOA

  func on() {
    self.port.set(pin: self.pin, to: true)
  }

  func off() {
    self.port.set(pin: self.pin, to: false)
  }
}
