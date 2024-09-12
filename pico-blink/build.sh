#!/bin/sh

set -vex

# Either rp2040 or rp2350
PICO_FAMILY=rp2040

# Determine file paths
REPOROOT=$(git rev-parse --show-toplevel)
TOOLSROOT=$REPOROOT/Tools

# Setup tools and build flags
SWIFT_EXEC=${SWIFT_EXEC:-`xcrun -f swift`}
CLANG=${CLANG:-`xcrun -f clang`}
SWIFT_FLAGS="-enable-experimental-feature Embedded -disable-stack-protector"
CLANG_FLAGS="-D__MACH__ -ffreestanding -mcpu=cortex-m0plus -mthumb"
LD_FLAGS="-static -Wl,-e,_reset -dead_strip -Wl,-no_zero_fill_sections -Wl,-segalign,4 -Wl,-segaddr,__RESET,0x20000000 -Wl,-segaddr,__VECTORS,0x20000100 -Wl,-seg1addr,0x20000200 -Wl,-pagezero_size,0"

SWIFT_BUILD_FLAGS="--triple armv6m-apple-none-macho --configuration release --verbose"
for SWIFT_FLAG in $SWIFT_FLAGS; do
	SWIFT_BUILD_FLAGS+=" -Xswiftc $SWIFT_FLAG"
done

for CLANG_FLAG in $CLANG_FLAGS; do
	SWIFT_BUILD_FLAGS+=" -Xcc $CLANG_FLAG"
done

PYTHON_EXEC=${PYTHON_EXEC:-`xcrun -f python3`}
MACHO2UF2=$TOOLSROOT/macho2uf2.py

# Build with Swift package manager
$SWIFT_EXEC build $SWIFT_BUILD_FLAGS

# Get the output directory
BUILDROOT=$($SWIFT_EXEC build $SWIFT_BUILD_FLAGS --show-bin-path)

# Link
$CLANG .build/release/Support.build/{Support.c,crt0.S}.o .build/release/Blinky.build/*.o -target armv6m-apple-none-macho -o $BUILDROOT/blinky $LD_FLAGS

# Extract sections from executable into flashable binary
$PYTHON_EXEC $MACHO2UF2 --pico-family $PICO_FAMILY $BUILDROOT/blinky $BUILDROOT/blinky.uf2 --base-address 0x20000000 --segments '__TEXT,__DATA,__VECTORS,__RESET'

# Echo final binary path
ls -al $BUILDROOT/blinky.uf2
