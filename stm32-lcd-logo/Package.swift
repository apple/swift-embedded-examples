// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "stm32-lcd-logo",
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
    // --input Tools/SVDs/stm32f7x6.patched.svd \
    // --output stm32-lcd-logo/Sources/STM32F7x6 \
    // --peripherals FLASH GPIOA GPIOB GPIOC GPIOD GPIOE GPIOF GPIOG GPIOH GPIOI GPIOJ GPIOK LTDC RCC
    .executableTarget(
      name: "Application",
      dependencies: [
        .product(name: "MMIO", package: "swift-mmio"),
        "Support",
      ]),
    .target(name: "Support"),
  ])
