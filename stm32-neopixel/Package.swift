// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "stm32-neopixel",
  platforms: [
    .macOS(.v10_15)
  ],
  products: [
    .executable(name: "Application", targets: ["Application"])
  ],
  dependencies: [
    .package(
      path: "/Users/rauhul/Developer/org.swift/swift-mmio")
      // url: "https://github.com/apple/swift-mmio", branch: "main")
  ],
  targets: [
    .executableTarget(
      name: "Application",
      dependencies: [
        .product(name: "MMIO", package: "swift-mmio"),
        "Support",
      ]),
    .target(name: "Support"),
  ])
