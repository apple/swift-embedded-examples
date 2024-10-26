# RPi4B-blink

`[TBA: image here]`

## Requirements

- A Raspberry Pi 4B board
- An SD Card, with a Raspberry Pi OS installed (this way, we don't need to create the configuration files from scratch). You may backup `kernel8.img` and `config.txt` if you need the Linux install later, since we will change these files.

## How to build and run this example:

- Make sure you have a recent nightly Swift toolchain that has Embedded Swift support.
- Build the program, then copy the kernel image to the SD card.
``` console
$ cd RPi4B-blink
$ export TOOLCHAINS='<toolchain-identifier>' # Your Swift nightly toolchain identifier
$ chmod u+x ./build.sh # make build script executable
$ ./build.sh
$ cp .build/kernel8.img /Volumes/bootfs
```
- Place the SD card in your Raspberry Pi 4B, and connect it to power.
- After the boot sequence, the green (ACT) led will start blinking in a regular pattern.

