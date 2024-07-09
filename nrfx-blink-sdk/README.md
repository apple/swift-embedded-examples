# nrfx-blink-sdk

This example demonstrates how to integrate with the Zephyr SDK via CMake and how to build a Swift firmware application on top of the SDK and the libraries from it. The example was tested on a nRF52840-DK board, but it should also work on other Zephyr-supported boards.

<img src="https://github.com/apple/swift-embedded-examples/assets/1186214/ae3ff153-dd33-4460-8a08-4eac442bf7b0">

## Requirements

- Download and install [Zephyr](https://docs.zephyrproject.org/latest/), and make sure you are set up for development with it, e.g. by following the [Zephyr Getting Started Guide](https://docs.zephyrproject.org/latest/develop/getting_started/index.html). In particular, you will need:
  - CMake, Ninja, and other build tools.
  - The West build system.
  - A Python virtualenv for Zephyr.
  - Zephyr SDK/toolchain.
  - Host flash/debug tools for the board you're using. For example, for the nRF52840-DK board you'll need the [nRF Command Line Tools](https://www.nordicsemi.com/Products/Development-tools/nrf-command-line-tools).

- Before trying to use Swift with the Zephyr SDK, make sure your environment works and can build the provided C/C++ sample projects, in particular:
  - Try building and running the "simple/blink" example from Zephyr written in C.

## Building

- Make sure you have a recent nightly Swift toolchain that has Embedded Swift support.
- Build the program in the Zephyr virtualenv, specify the nightly toolchain to be used via the `TOOLCHAINS` environment variable and the target board type via the `-DBOARD=...` CMake setting:
``` console
$ cd nrfx-blink-sdk
$ source ~/zephyrproject/.venv/bin/activate
(.venv) export TOOLCHAINS='<toolchain-name>'
(.venv) cmake -B build -G Ninja -DBOARD=nrf52840dk_nrf52840 -DUSE_CCACHE=0 .
(.venv) cmake --build build
```

## Running

- Connect the nRF52840-DK board over a USB cable to your Mac using the J-Link connector on the board.
- Use `nrfjprog` to upload the firmware and to run it:

```console
(.venv) nrfjprog --recover --program build/zephyr/zephyr.hex --verify
(.venv) nrfjprog --run
```

- The green LED should now be blinking in a pattern.
