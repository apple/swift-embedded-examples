// swift-tools-version: 6.0

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
    .package(url: "https://github.com/apple/swift-mmio", branch: "main")
  ],
  targets: [
    // SVD2Swift \
    // -i ../Tools/SVDs/stm32f7x6.patched.svd \
    // -o Sources/Application/Registers \
    // --indentation-width 2 \
    // -p DMA1 DMA2 GPIOA GPIOB GPIOI RCC SPI1 SPI2 USART1
    .executableTarget(
      name: "Application",
      dependencies: [
        .product(name: "MMIO", package: "swift-mmio"),
        "Support",
      ]),
    .target(name: "Support"),
  ])
