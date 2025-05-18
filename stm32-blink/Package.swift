// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "stm32-blink",
  products: [
    .executable(name: "Application", targets: ["Application"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-mmio", branch: "main")
  ],
  targets: [
    .executableTarget(
      name: "Application",
      dependencies: ["STM32F7X6", "Support"]),
    // SVD2Swift \
    // --input ../Tools/SVDs/stm32f7x6.patched.svd \
    // --output Sources/Application/Registers \
    // --access-level public \
    // --indentation-width 2 \
    // --peripherals GPIOA GPIOI RCC
    .target(
      name: "STM32F7X6",
      dependencies: [
        .product(name: "MMIO", package: "swift-mmio")
      ],
      plugins: [
        // Plugin disabled because SwiftPM is slow.
        // .plugin(name: "SVD2SwiftPlugin", package: "swift-mmio")
      ]),
    .target(name: "Support"),
  ],
  swiftLanguageModes: [.v5])
