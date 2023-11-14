#!/bin/sh

set -vex

# Determine file paths
REPOROOT=$(git rev-parse --show-toplevel)
TOOLSROOT=$REPOROOT/Tools
SRCROOT=$REPOROOT/stm32-blink
BUILDROOT=$SRCROOT/.build

# Setup tools and build flags
TARGET=armv7-apple-none-macho

SWIFT_EXEC=${SWIFT_EXEC:-`xcrun -f swiftc`}
SWIFT_FLAGS="-target $TARGET -Osize -import-bridging-header $SRCROOT/BridgingHeader.h -wmo -enable-experimental-feature Embedded -Xcc -D__APPLE__ -Xcc -D__MACH__ -Xcc -ffreestanding"

CLANG_EXEC=${CLANG_EXEC:-`xcrun -f clang`}
CLANG_FLAGS="-target $TARGET -Oz"

LD_EXEC=${LD_EXEC:-$CLANG_EXEC}
LD_FLAGS="-target $TARGET -nostdlib -static -Wl,-e,_reset -dead_strip -Wl,-no_zero_fill_sections -Wl,-segalign,4 -Wl,-segaddr,__VECTORS,0x00200000 -Wl,-seg1addr,0x00200200 -Wl,-pagezero_size,0"

PYTHON_EXEC=${PYTHON_EXEC:-`xcrun -f python3`}
MACHO2BIN=$TOOLSROOT/macho2bin.py

# Create build directory
mkdir -p $BUILDROOT

# Build Swift sources
$SWIFT_EXEC $SWIFT_FLAGS -c $SRCROOT/*.swift -o $BUILDROOT/blink.o

# Build C sources
$CLANG_EXEC $CLANG_FLAGS -c $SRCROOT/Startup.c -o $BUILDROOT/Startup.o

# Link objects into executable
$LD_EXEC $LD_FLAGS $BUILDROOT/blink.o $BUILDROOT/Startup.o -o $BUILDROOT/blink

# Extract sections from executable into flashable binary
$PYTHON_EXEC $MACHO2BIN $BUILDROOT/blink $BUILDROOT/blink.bin --base-address 0x00200000 --segments '__TEXT,__DATA,__VECTORS'

# Echo final binary path
ls -al $BUILDROOT/blink.bin
