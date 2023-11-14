// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "stm32-uart-echo",
  platforms: [
    .macOS(.v10_15),
  ],
  products: [
      .library(name: "Application", type: .static, targets: ["Application"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-mmio", branch: "swift-embedded-examples"),
  ],
  targets: [
    .target(
      name: "Application",
      dependencies: [
        .product(name: "MMIO", package: "swift-mmio"),
        "Support",
      ],
      swiftSettings: [
        .enableExperimentalFeature("Embedded"),
      ]),
    .target(name: "Support"),
  ])
