# Embedded Swift Example Projects

This repository is a set of demonstration projects of **Embedded Swift**. Embedded Swift is a compilation and language mode that enables development of baremetal, embedded and standalone software in Swift. To learn more, see:

- [Blog post introducing this repository](https://www.swift.org/blog/embedded-swift-examples/)
- [Swift forums thread about this repository](https://forums.swift.org/t/embedded-swift-example-projects-for-arm-and-risc-v-microcontrollers/71066)
- [Discussions about Embedded Swift on the Swift forums](https://forums.swift.org/t/embedded-swift/67057)
- [Embedded Swift Vision Document](https://github.com/apple/swift-evolution/blob/main/visions/embedded-swift.md)
- [Documentation for Embedded Swift](https://github.com/apple/swift/tree/main/docs/EmbeddedSwift)

> [!WARNING]
> Embedded Swift is experimental. Some information on this page might be out of date with latest development.

## Building the examples

Each example in this repository contains build and deployment instructions, however there are a couple common steps needed for many of the examples included below:

1. Install the latest downloadable 'main' [Development Snapshot](https://www.swift.org/install/macos/#development-snapshots) from swift.org to use Embedded Swift. Public releases of Swift do not yet support Embedded Swift.
	
  You can follow the [tutorial here](https://apple.github.io/swift-matter-examples/tutorials/swiftmatterexamples/setup-macos/) for instructions on installing and using nighly Swift toolchains.

2. Install the Python3 dependencies listed in `requirements.txt`.

  ```console
  $ cd swift-embedded-examples
  $ python3 -m venv .venv
  $ source .venv/bin/activate
  $ python3 -m pip install -r Tools/requirements.txt
  ```

## Catalog of Examples

| Name | Platform | SDK | Description | Photo |
| ---- | -------- | --- | ----------- | ----- |
| [esp32-led-blink-sdk](./esp32-led-blink-sdk) | ESP32-C6-Bug | ESP-IDF SDK | Blink an LED repeatedly with Swift & the ESP-IDF. | <img width="300" src="esp32-led-blink-sdk/assets/images/ledon.jpg"> |
| [esp32-led-strip-sdk](./esp32-led-strip-sdk) | ESP32-C6-DevKitC-1 | ESP-IDF SDK | Control NeoPixel LEDs with Swift & the ESP-IDF. | <img width="300" src="https://github.com/apple/swift-embedded-examples/assets/1186214/15f8a3e0-953e-426d-ad2d-3902baf859be"> |
| [nrfx-blink-sdk](./nrfx-blink-sdk) | nRF52840-DK | Zephyr SDK | Blink an LED repeatedly with Swift & Zephyr. | <img width="300" src="https://github.com/apple/swift-embedded-examples/assets/1186214/ae3ff153-dd33-4460-8a08-4eac442bf7b0"> |
| [nuttx-riscv-blink](./nuttx-riscv-blink) | QEMU | NuttX | Blink a virualized led in QEMU using the Apache NuttX RTOS | |
| [pico-blink-sdk](./pico-blink-sdk) | Raspberry Pi Pico, Pico 2 | Pico SDK | Blink an LED repeatedly with Swift & the Pico SDK. | <img width="300" src="https://github.com/apple/swift-embedded-examples/assets/1186214/f2c45c18-f9a4-48b4-a941-1298ecc942cb"> |
| [pico-blink](./pico-blink) | Raspberry Pi Pico | None  | Blink an LED repeatedly. | <img width="300" src="https://github.com/apple/swift-embedded-examples/assets/1186214/f2c45c18-f9a4-48b4-a941-1298ecc942cb"> |
| [pico-w-blink-sdk](./pico-w-blink-sdk) | Raspberry Pi Pico W | Pico SDK | Blink an LED to signal 'SOS' in Morse code repeatedly with Swift & the Pico SDK. | <img width="300" src="https://github.com/apple/swift-embedded-examples/assets/26223064/a4949a2e-1887-4325-8f5f-a681963c93d7"> |
| [harmony](./harmony) | Raspberry Pi Pico W | Pico SDK | A bluetooth speaker and ferrofluidic music visualizer. Firmware, Electrical, and Mechanical designs fully available. | <img width="300" src="harmony/assets/harmony.jpeg"> |
| [pico2-neopixel](./pico2-neopixel) | Raspberry Pi Pico 2 | None | Control Neopixel LEDs using the RP2350 PIO. | <img width="300" src="pico2-neopixel/assets/images/example.jpg"> |
| [rpi4b-blink](./rpi4b-blink) | Raspberry Pi 4B | None | Blink the Pi's status green LED repeatedly using Swift MMIO. | <img width="300" src="rpi4b-blink/assets/rpi4.png"> |
| [rpi5-blink](./rpi5-blink) | Raspberry Pi 5 | None | Blink the Pi's status green LED repeatedly with Swift MMIO. | <img width="300" src="rpi5-blink/assets/raspi5.png"> |
| [stm32-blink](./stm32-blink) | STM32F746G-DISCO | None | Blink an LED repeatedly. | <img width="300" src="https://github.com/apple/swift-embedded-examples/assets/1186214/739e98fd-a438-4a64-a7aa-9dddee25034b"> |
| [stm32-lcd-logo](./stm32-lcd-logo) | STM32F746G-DISCO | None | Animate the Swift Logo on the built-in LCD. | <img width="300" src="https://github.com/apple/swift-embedded-examples/assets/1186214/9e117d81-e808-493e-a20c-7284ea630f37"> |
| [stm32-neopixel](./stm32-neopixel) | STM32F746G-DISCO | None | Control NeoPixel LEDs using SPI. | <img width="300" src="https://github.com/apple/swift-embedded-examples/assets/1186214/9c5d8f74-f8aa-4632-831e-212a3e35e75a"> |
| [stm32-uart-echo](./stm32-uart-echo) | STM32F746G-DISCO | None | Echo user input using UART. | <img width="300" src="https://github.com/apple/swift-embedded-examples/assets/1186214/97d3c465-9a07-4b86-9654-0c2aaaa43b3d">|

Note that the SDK integration examples (Pico SDK, Zephyr SDK, etc.) are not recommendations or endorsement, the same is true for build system choice (Make, CMake, SwiftPM, shell scripts). Embedded Swift aims to be versatile and allowing integration into existing SDKs and build systems, and the example projects show some of the possibilities.

## Community Examples

> [!WARNING]
> Community projects linked here are not officially supported by our team. They may not always be compatible with the latest nightly Swift toolchain builds.

<!-- Please keep this list sorted by "Board" then "Name" -->

| Name | Platform | Description |
| ---- | -------- | ----------- |
| [swift-matter-examples](https://github.com/apple/swift-matter-examples) | ESP32 | An Embedded Swift Matter application running on ESP32-C6. |
| [swift-flipperzero-hello](https://github.com/Sameesunkaria/swift-flipperzero-hello) | Flipper Zero | A demonstration of running Swift apps on the Flipper Zero. |
| [EmbeddedSwift nRF52 Examples](https://github.com/nelcea/EmbeddedSwift-nRF52-Examples) | nRF52840 (Development Kit) | A collection of examples using Embedded Swift on top of nRF Connect SDK (Zephyr). |
| [Swatak](https://github.com/nelcea/EmbeddedSwift-nRF52-Swatak) | nRF52840 (Seeed Studio XIAO) | A reaction time game inspired by BATAK© boards, implemented in Embedded Swift using nRF Connect SDK. |
| [swift-picosystem-example](https://github.com/jerrodputman/swift-picosystem-example) | PicoSystem | An Embedded Swift demo running on the Pimoroni PicoSystem |
| [PlaydateKit](https://github.com/finnvoor/PlaydateKit) | Playdate | A full featured framework for building Playdate games using Embedded Swift. |
| [swift-playdate-examples](https://github.com/apple/swift-playdate-examples) | Playdate | An Embedded Swift game running on Playdate by Panic. |
| [swift-stm32c011-examples](https://github.com/xtremekforever/swift-stm32c011-examples) | STM32 | Examples of running Embedded Swift on the STM32C011, which is a tiny MCU with only 6KB of SRAM and 32KB of flash. |
| [swift-for-wasm-examples](https://github.com/apple/swift-for-wasm-examples) | Web | A "Swift Audio Workstation" example built with Swift for WebAssembly running in the browser using Embedded Swift. |

Please note that the presence of community repositories and devices in this list does not constitute a recommendation or endorsement. If there's a project you'd like to see included here, please [submit an issue](https://github.com/apple/swift-embedded-examples/issues/new) with the details.

## Contributing to this repository

This repository contains code that is not continuously developed, instead it's presented "as is" for educational and demonstrational purposes. Making major improvements to existing examples is discouraged, but additions of new examples is welcome.

### Code of Conduct

Like all Swift.org projects, we would like these Embedded Swift example projects to foster a diverse and friendly community. We expect contributors to adhere to the [Swift.org Code of Conduct](https://swift.org/code-of-conduct/).

### Contact information

The current code owners of this repository are Kuba Mracek ([@kubamracek](https://github.com/kubamracek)) and Rauhul Varma ([@rauhul](https://github.com/rauhul)). You can contact them on the Swift forums via the handles [@kubamracek](https://forums.swift.org/u/kubamracek/summary) and [@rauhul](https://forums.swift.org/u/rauhul/summary).

In case of moderation issues, you can also directly contact a member of the [Swift Core Team](https://swift.org/community/#community-structure).
