#!/bin/bash

set -vex

# Determine file paths
REPOROOT=$(realpath -e -- $(dirname ${BASH_SOURCE[0]}))/..
TOOLSROOT="$REPOROOT/Tools"
SRCROOT="$REPOROOT/stm32-blink"
BUILDROOT="$SRCROOT/.build"

# Clean the build directory
rm -r $BUILDROOT || true

# Setup tools and build flags
TARGET=armv7em-none-none-eabi

SWIFT_EXEC=${SWIFT_EXEC:-$(which swiftc)}
SWIFT_FLAGS="-target $TARGET -Osize"
SWIFT_FLAGS+=" -import-bridging-header $SRCROOT/BridgingHeader.h -wmo -enable-experimental-feature Embedded"
SWIFT_FLAGS+=" -Xcc -D__APPLE__ -Xcc -D__MACH__ -Xcc -ffreestanding"
SWIFT_FLAGS+=" -Xfrontend -function-sections -DSTM32F1"

CLANG_EXEC=${CLANG_EXEC:-$(which clang)}
CLANG_FLAGS="-target $TARGET -Oz"

LD_EXEC=${LD_EXEC:-$CLANG_EXEC}
LD_FLAGS="-target $TARGET -fuse-ld=lld -nostdlib -static -Wl,-e,vector_table -Wl,--gc-sections -Wl,-T,$SRCROOT/elf-linkerscript.ld"

# Create build directory
mkdir -p "$BUILDROOT"

# Build Swift sources
"$SWIFT_EXEC" $SWIFT_FLAGS -c $SRCROOT/*.swift -o "$BUILDROOT/blink.o"

# Build C sources
"$CLANG_EXEC" $CLANG_FLAGS -c "$SRCROOT/Startup.c" -o "$BUILDROOT/Startup.o"

# Link objects into executable
"$LD_EXEC" $LD_FLAGS "$BUILDROOT/blink.o" "$BUILDROOT/Startup.o" -o "$BUILDROOT/blink.elf"

# Convert to Intel HEX for flashing
$TOOLSROOT/elf2hex.py "$BUILDROOT/blink.elf" "$BUILDROOT/blink.hex"
