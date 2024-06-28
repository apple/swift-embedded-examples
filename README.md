# Embedded Swift Example Projects

This repository is a set of demonstration projects of **Embedded Swift**. Embedded Swift is a compilation and language mode that enables development of baremetal, embedded and standalone software in Swift. To learn more, see:

- [Blog post introducing this repository](https://www.swift.org/blog/embedded-swift-examples/)
- [Swift forums thread about this repository](https://forums.swift.org/t/embedded-swift-example-projects-for-arm-and-risc-v-microcontrollers/71066)
- [Discussions about Embedded Swift on the Swift forums](https://forums.swift.org/t/embedded-swift/67057)
- [Embedded Swift Vision Document](https://github.com/apple/swift-evolution/blob/main/visions/embedded-swift.md)
- [Documentation for Embedded Swift](https://github.com/apple/swift/tree/main/docs/EmbeddedSwift)

> [!WARNING]
> Embedded Swift is experimental. Some information on this page might be out of date with latest development.

> [!IMPORTANT]  
> Use the latest downloadable 'main' [Development Snapshot](https://www.swift.org/install/macos/#development-snapshots) from swift.org to use Embedded Swift. Public releases of Swift do not yet support Embedded Swift.

> [!NOTE]  
> This repository contains code that is not continuously developed, instead it's presented "as is" for educational and demonstrational purposes. Making major improvements to existing examples is discouraged, but additions of new examples is welcome.

## Catalog of Examples

| Name | Platform | Description | Photo |
| ---- | -------- | ----------- | ----- |
| [stm32-blink](./stm32-blink) | STM32F746G-DISCO | Baremetal program that blinks an LED repeatedly. Does not use any vendor SDKs or external toolchains. | <img width="300" src="https://raw.githubusercontent.com/kubamracek/swift-evolution/branch/assets/stm32-blink.jpg"> |
| [stm32-lcd-logo](./stm32-lcd-logo) | STM32F746G-DISCO | Sets up layers on the built-in LCD and animates them in a loop. Does not use any vendor SDKs or external toolchains. | <img width="300" src="https://raw.githubusercontent.com/kubamracek/swift-evolution/branch/assets/stm32-lcd-logo.jpg"> |
| [stm32-neopixel](./stm32-neopixel) | STM32F746G-DISCO | Uses SPI to program a NeoPixel LED strip. Does not use any vendor SDKs or external toolchains. | <img width="300" src="https://raw.githubusercontent.com/kubamracek/swift-evolution/branch/assets/stm32-led.jpg"> |
| [stm32-uart-echo](./stm32-uart-echo) | STM32F746G-DISCO | Uses UART to implement a simple "echo" firmware. Does not use any vendor SDKs or external toolchains. | <img width="300" src="https://raw.githubusercontent.com/kubamracek/swift-evolution/branch/assets/stm32-uart-echo.png">|
| [pico-blink](./pico-blink) | Raspberry Pi Pico | Baremetal program that blinks an LED repeatedly. Does not use any vendor SDKs or external toolchains. | <img width="300" src="https://raw.githubusercontent.com/kubamracek/swift-evolution/branch/assets/pico-blink.jpg"> |
| [pico-blink-sdk](./pico-blink-sdk) | Raspberry Pi Pico | Baremetal program that blinks an LED repeatedly. Demonstrates how to use code and libraries from the Pico SDK and add Swift code on top of it. | <img width="300" src="https://raw.githubusercontent.com/kubamracek/swift-evolution/branch/assets/pico-blink-sdl.jpg"> |
| [pico-w-blink-sdk](./pico-w-blink-sdk) | Raspberry Pi Pico W | Baremetal program that blinks an LED to signal 'SOS' in Morse code. Demonstrates how to use code and libraries from the Pico SDK and add Swift code on top of it. | <img width="300" src="https://github.com/apple/swift-embedded-examples/assets/26223064/a4949a2e-1887-4325-8f5f-a681963c93d7"> |
| [nrfx-blink-sdk](./nrfx-blink-sdk) | nRF52840-DK | Baremetal program that blinks an LED repeatedly. Demonstrates how to use code and libraries from the Zephyr SDK and add Swift code on top of it. | <img width="300" src="https://raw.githubusercontent.com/kubamracek/swift-evolution/branch/assets/nrfx-blink-sdk.jpeg"> |
| [esp32-led-strip-sdk](./esp32-led-strip-sdk) | ESP32-C6-DevKitC-1 | Demonstrates how to integrate with ESP-IDF SDK and use Swift to control the LED strip library from the SDK. | <img width="300" src="https://raw.githubusercontent.com/kubamracek/swift-evolution/branch/assets/esp32-led-strip-sdk.jpg"> |
| [esp32-led-blink-sdk](./esp32-led-blink-sdk) | ESP32-C6-Bug | Demonstrates how to integrate with ESP-IDF SDK and use Swift to control the standard LED from the SDK. | <img width="300" src="esp32-led-blink-sdk/assets/images/ledon.jpg"> |


Note that the SDK integration examples (Pico SDK, Zephyr SDK, etc.) are not recommendations or endorsement, the same is true for build system choice (Make, CMake, SwiftPM, shell scripts). Embedded Swift aims to be versatile and to allow for integration into more existing SDKs and build systems, and the example projects are merely showing the possibilities.

## Community Examples

<!-- Please keep this list sorted by "Board" then "Name" -->

| Name | Platform | Description |
| ---- | -------- | ----------- |
| [swift-matter-examples](https://github.com/apple/swift-matter-examples) | ESP32 | An Embedded Swift Matter application running on ESP32-C6. |
| [swift-flipperzero-hello](https://github.com/Sameesunkaria/swift-flipperzero-hello) | Flipper Zero | A demonstration of running Swift apps on the Flipper Zero. |
| [PlaydateKit](https://github.com/finnvoor/PlaydateKit) | Playdate | A full featured framework for building Playdate games using Embedded Swift. |
| [swift-playdate-examples](https://github.com/apple/swift-playdate-examples) | Playdate | An Embedded Swift game running on Playdate by Panic. |
| [swift-for-wasm-examples](https://github.com/apple/swift-for-wasm-examples) | Web | A "Swift Audio Workstation" example built with Swift for WebAssembly running in the browser using Embedded Swift. |

Please note that the presence of community repositories and devices in this list does not constitute a recommendation or endorsement. If there's a project you'd like to see included here, please [submit an issue](https://github.com/apple/swift-embedded-examples/issues/new) with the details.

## Contributing to this repository

### Code of Conduct

Like all Swift.org projects, we would like these Embedded Swift example projects to foster a diverse and friendly community. We expect contributors to adhere to the [Swift.org Code of Conduct](https://swift.org/code-of-conduct/).

### Contact information

The current code owners of this repository are Kuba Mracek ([@kubamracek](https://github.com/kubamracek)) and Rauhul Varma ([@rauhul](https://github.com/rauhul)). You can contact them on the Swift forums via the handles [@kubamracek](https://forums.swift.org/u/kubamracek/summary) and [@rauhul](https://forums.swift.org/u/rauhul/summary).

In case of moderation issues, you can also directly contact a member of the [Swift Core Team](https://swift.org/community/#community-structure).
