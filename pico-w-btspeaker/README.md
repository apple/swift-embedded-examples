# pico-w-btspeaker

## Requirements

- macOS
- Recent nightly "main" (not the release version) Swift toolchain from swift.org/download
- Pico SDK 2.1+ (`git clone https://github.com/raspberrypi/pico-sdk.git`)
- GNU ARM toolchain (download from https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads, look for "arm-gnu-toolchain-14.2.rel1-darwin-x86_64-arm-none-eabi.tar.xz")
- CMake
- Ninja
- At least CommandLineTools, but full Xcode is better
- OpenOCD (`brew install openocd`)
- Optional: Minicom (`brew install openocd`)

## Pico setup for development

```

                                           ┌────────────────
                                           │ ┌──────────────  --> USB to computer
                                           │ │                           
                                           │ │                           
                                           │ │                           
                                           │ │                           
                                           │ │                           
                                           │ │                           
            ┌───┐                         ┌┴─┴┐                          
         ┌──┴───┴───┐                  ┌──┴───┴──┐                       
     Ut ─┤1         ├─                ─┤1        ├─                      
     Ur ─┤2         ├─ V+             ─┤2        ├─ V+                     
     Ug ─┤3         ├─ Vg             ─┤3        ├─ Vg                     
        ─┤4         ├─             D1 ─┤4        ├─                      
        ─┤5         ├─             D3 ─┤5        ├─                      
        ─┤6         ├─             Ur ─┤6        ├─                      
        ─┤7         ├─             Ut ─┤7        ├─                      
        ─┤8         ├─                ─┤8        ├─                      
        ─┤9[D1DgD3] ├─                ─┤9        ├─                      
        ─┤10        ├─                ─┤10       ├─                      
        ─┤...       ├─                ─┤...      ├─                      
        ─┤...       ├─                ─┤...      ├─                      
        ─┤20        ├─                ─┤20       ├─                      
         └──────────┘                  └─────────┘                       

           "target"                   "debugprobe"
            Pico W                     Pico/Pico2 with debugprobe firmware flashed

- Vg, Ug, Dg are all connected to ground

```

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
$ minicom -D /dev/cu.usbmodem<number>
```

or your favorite serial port monitoring program.
