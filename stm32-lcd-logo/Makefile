##===----------------------------------------------------------------------===##
##
## This source file is part of the Swift open source project
##
## Copyright (c) 2023 Apple Inc. and the Swift project authors.
## Licensed under Apache License v2.0 with Runtime Library Exception
##
## See https://swift.org/LICENSE.txt for license information
##
##===----------------------------------------------------------------------===##

# Determine file paths
REPOROOT := $(shell git rev-parse --show-toplevel)
TOOLSROOT := $(REPOROOT)/Tools
SRCROOT := $(REPOROOT)/stm32-lcd-logo
BUILDROOT := $(SRCROOT)/.build

# Setup tools and build flags
TARGET := armv7-apple-none-macho
BASEADDRESS := 0x00200000

SWIFT_EXEC := $(shell xcrun -f swiftc)
SWIFT_FLAGS := -target $(TARGET) -Osize -import-bridging-header $(SRCROOT)/Support/BridgingHeader.h -wmo -enable-experimental-feature Embedded -Xcc -D__APPLE__ -Xcc -D__MACH__ -Xcc -ffreestanding

CLANG_EXEC := $(shell xcrun -f clang)
CLANG_FLAGS := -target $(TARGET) -Oz

LD_EXEC := $(CLANG_EXEC)
LD_FLAGS := -target $(TARGET) -static -Wl,-e,_reset -dead_strip -Wl,-no_zero_fill_sections -Wl,-segalign,4 -Wl,-segaddr,__VECTORS,0x00200000 -Wl,-seg1addr,0x00200200 -Wl,-pagezero_size,0

PYTHON_EXEC := $(shell xcrun -f python3)
MACHO2BIN := $(TOOLSROOT)/macho2bin.py

.PHONY: all
all: $(BUILDROOT)/lcd-logo.bin

$(BUILDROOT):
	# Create build directory
	mkdir -p $(BUILDROOT)

$(BUILDROOT)/lcd-logo.o: $(SRCROOT)/Main.swift $(SRCROOT)/Support/*.swift | $(BUILDROOT)
	# Build Swift sources
	$(SWIFT_EXEC) $(SWIFT_FLAGS) -c $^ -o $@

$(BUILDROOT)/Startup.o: $(SRCROOT)/Support/Startup.c | $(BUILDROOT)
	# Build C sources
	$(CLANG_EXEC) $(CLANG_FLAGS) -c $^ -o $@

$(BUILDROOT)/PixelData.o: $(SRCROOT)/Support/PixelData.c | $(BUILDROOT)
	# Build C sources
	$(CLANG_EXEC) $(CLANG_FLAGS) -c $^ -o $@

$(BUILDROOT)/lcd-logo: $(BUILDROOT)/lcd-logo.o $(BUILDROOT)/Startup.o $(BUILDROOT)/PixelData.o
	# Link objects into executable
	$(LD_EXEC) $(LD_FLAGS) $^ -o $@

$(BUILDROOT)/lcd-logo.bin: $(BUILDROOT)/lcd-logo
	# Extract sections from executable into flashable binary
	$(PYTHON_EXEC) $(MACHO2BIN) $^ $@ --base-address 0x00200000 --segments '__TEXT,__DATA,__VECTORS'	
	# Echo final binary path
	ls -al $(BUILDROOT)/lcd-logo.bin
