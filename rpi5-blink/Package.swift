// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "RPi5-Blink",
  platforms: [
    .macOS(.v14)
  ],
  products: [
    .library(
      name: "MainApp",
      type: .static,
      targets: ["MainApp"])
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-mmio.git",
      branch: "swift-embedded-examples")
  ],
  targets: [
    .target(
      name: "MainApp",
      dependencies: [
        .product(name: "MMIO", package: "swift-mmio")
      ],
      swiftSettings: [
        .enableExperimentalFeature("Embedded"),
        .unsafeFlags(["-Xfrontend", "-function-sections"]),
      ]
    ),
    .target(name: "Support"),

  ]
)
