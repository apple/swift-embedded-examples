# pico-w-btspeaker

## Requirements

## Building

```bash
$ cd pico-w-btspeaker
$ export TOOLCHAINS='<toolchain-identifier>'
$ export PICO_BOARD=pico_w
$ export PICO_SDK_PATH='<path-to-your-pico-sdk>'
$ export PICO_TOOLCHAIN_PATH='<path-to-the-arm-toolchain>'
$ cmake -B build -G Ninja .
$ cmake --build build
```

## Flashing and running using a debug probe

```bash
$ openocd -f interface/cmsis-dap.cfg -f target/rp2040.cfg -c "adapter speed 5000" -c "program build/app.elf verify reset exit"
```

## Monitoring UART

```bash
$ screen /dev/cu.usbmodem<...> 115200
```

or your favorite serial port monitoring program.
