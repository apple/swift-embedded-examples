// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "RP2040",
  products: [
    .library(name: "Blinky", type: .static, targets: ["Blinky"]),
  ],
  targets: [
    .target(name: "Blinky", dependencies: ["RP2040"]),
    .target(name: "Support"),
    .target(name: "RP2040", dependencies: ["Support"])
  ]
)
