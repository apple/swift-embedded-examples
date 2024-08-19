##===----------------------------------------------------------------------===##
##
## This source file is part of the Swift open source project
##
## Copyright (c) 2024 Apple Inc. and the Swift project authors.
## Licensed under Apache License v2.0 with Runtime Library Exception
##
## See https://swift.org/LICENSE.txt for license information
##
##===----------------------------------------------------------------------===##

# Determine file paths
REPOROOT := $(shell git rev-parse --show-toplevel)
TOOLSROOT := $(REPOROOT)/Tools
SRCROOT := $(REPOROOT)/pico2-neopixel
BUILDROOT := $(SRCROOT)/.build/release

# Setup tools and build flags
ARCH := armv7em
# TARGET := $(ARCH)-none-none-eabi
TARGET := $(ARCH)-apple-none-macho

ifndef TOOLCHAINS
$(error 'Set "TOOLCHAINS" environment variable before running make')
endif

.PHONY: build
build:
	@echo "compiling..."
	swift build \
		--configuration release \
		--triple $(TARGET) \
		-Xcc -D__APPLE__ -Xcc -D__MACH__ \
		-Xswiftc -Xfrontend -Xswiftc -disable-stack-protector

	@echo "linking..."
	clang \
		$(BUILDROOT)/libApplication.a \
		$(BUILDROOT)/Support.build/{Support.c,crt0.S}.o \
		-o $(BUILDROOT)/Application \
		-target $(TARGET) \
		-dead_strip \
		-static \
		-Wl,-e,_reset \
		-Wl,-map,$(BUILDROOT)/Application.mangled.map \
		-Wl,-no_zero_fill_sections \
		-Wl,-segalign,4 \
		-Wl,-segaddr,__VECTORS,0x20000000 \
		-Wl,-segaddr,__RESET,0x20000200 \
		-Wl,-seg1addr,0x20000300 \
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
	python3 $(TOOLSROOT)/macho2uf2.py \
		$(BUILDROOT)/Application \
		$(BUILDROOT)/Application.uf2 \
		--pico-family rp2350 \
		--base-address 0x20000000 \
		--segments '__TEXT,__DATA,__VECTORS,__RESET'

	@echo "final image..."
	@ls $(BUILDROOT)/Application.uf2

.PHONY: clean
clean:
	@echo "cleaning..."
	@swift package clean
	@rm -rf .build
