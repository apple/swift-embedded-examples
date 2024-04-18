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
SRCROOT := $(REPOROOT)/stm32-uart-echo
BUILDROOT := $(SRCROOT)/.build/release

# Setup tools and build flags
ARCH := armv7em
TARGET := $(ARCH)-apple-none-macho
VECTORS_ADDRESS=-0x00200000

SWIFT_BUILD := $(shell xcrun -f swift-build)
MACHO2BIN := $(SRCROOT)/../Tools/macho2bin.py

.PHONY: build
build:
	@echo "compiling..."
	$(SWIFT_BUILD) \
		--configuration release \
		--verbose \
		--triple $(TARGET) \
		-Xcc -D__APPLE__ -Xcc -D__MACH__ \
		-Xswiftc -Xfrontend -Xswiftc -disable-stack-protector

	@echo "linking..."
	clang .build/release/libApplication.a -o .build/release/Application \
		-arch $(ARCH) \
		-dead_strip \
		-static \
		-Wl,-e,_reset \
		-Wl,-map,$(BUILDROOT)/Application.mangled.map \
		-Wl,-no_zero_fill_sections \
		-Wl,-segalign,4 \
		-Wl,-segaddr,__VECTORS,0x20010000 \
		-Wl,-seg1addr,0x20010200 \
		-Wl,-pagezero_size,0

	@echo "demangling linker map..."
	cat $(BUILDROOT)/Application.mangled.map \
		| c++filt | swift demangle > $(BUILDROOT)/Application.map

	@echo "disassembling..."
	otool \
		-arch $(ARCH) -v -V -d -t \
		$(BUILDROOT)/Application \
		| c++filt | swift demangle > $(BUILDROOT)/Application.disassembly

	@echo "extracting binary..."
	$(MACHO2BIN) \
		$(BUILDROOT)/Application $(BUILDROOT)/Application.bin --base-address 0x20010000 --segments '__TEXT,__DATA,__VECTORS'

.PHONY: clean
clean:
	@echo "cleaning..."
	@swift package clean
	@rm -rf .build
