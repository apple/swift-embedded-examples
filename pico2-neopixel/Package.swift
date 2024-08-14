// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "pico2-neopixel",
  platforms: [
    .macOS(.v14),
  ],
  products: [
    .library(name: "Application", type: .static, targets: ["Application"]),
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-mmio.git",
      branch: "swift-embedded-examples"),
  ],
  targets: [
    .target(
      name: "Application",
      dependencies: ["RP2350", "Support"],
      swiftSettings: [
        .enableExperimentalFeature("Embedded"),
        .unsafeFlags(["-Xfrontend", "-function-sections"])
      ]),
    .target(
      name: "RP2350",
      dependencies: [
        .product(name: "MMIO", package: "swift-mmio")
      ],
      swiftSettings: [
        .enableExperimentalFeature("Embedded")
      ],
      plugins: [
        .plugin(name: "SVD2SwiftPlugin", package: "swift-mmio")
      ]),
    .target(name: "Support"),
  ],
  swiftLanguageVersions: [.v5])
