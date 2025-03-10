// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "stm32-uart-echo",
  platforms: [
    .macOS(.v10_15),
  ],
  products: [
    .executable(name: "Application", targets: ["Application"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-mmio", branch: "main")
  ],
  targets: [
    // SVD2Swift \
    // --input ../Tools/SVDs/stm32f7x6.patched.svd \
    // --output Sources/Application/Registers \
    // --indentation-width 2 \
    // --peripherals GPIOA GPIOB RCC USART1
    .executableTarget(
      name: "Application",
      dependencies: [
        .product(name: "MMIO", package: "swift-mmio"),
        "Support",
      ]),
    .target(name: "Support"),
  ])
