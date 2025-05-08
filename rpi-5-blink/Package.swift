// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "RPi5-Blink",
  platforms: [
    .macOS(.v14)
  ],
  products: [
    .executable(name: "Application", targets: ["Application"])
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-mmio.git",
      branch: "swift-embedded-examples")
  ],
  targets: [
    .executableTarget(
      name: "Application",
      dependencies: [
        .product(name: "MMIO", package: "swift-mmio")
      ]),
    .target(name: "Support"),
  ]
)
