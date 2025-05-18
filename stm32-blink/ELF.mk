##===----------------------------------------------------------------------===##
##
## This source file is part of the Swift open source project
##
## Copyright (c) 2025 Apple Inc. and the Swift project authors.
## Licensed under Apache License v2.0 with Runtime Library Exception
##
## See https://swift.org/LICENSE.txt for license information
##
##===----------------------------------------------------------------------===##

# Paths
REPOROOT         := $(shell git rev-parse --show-toplevel)
TOOLSROOT        := $(REPOROOT)/Tools
TOOLSET          := $(TOOLSROOT)/Toolsets/stm32f74x-elf.json
ELF2HEX          := $(TOOLSROOT)/elf2hex.py
SWIFT_BUILD      := swift build

# Flags
ARCH             := armv7em
TARGET           := $(ARCH)-none-none-eabi
SWIFT_BUILD_ARGS := \
	--configuration release \
	--triple $(TARGET) \
	--toolset $(TOOLSET) \
	--disable-local-rpath
BUILDROOT        := $(shell $(SWIFT_BUILD) $(SWIFT_BUILD_ARGS) --show-bin-path)

.PHONY: build
build:
	@echo "building..."
	$(SWIFT_BUILD) \
		$(SWIFT_BUILD_ARGS) \
		-Xlinker -map -Xlinker $(BUILDROOT)/Application.mangled.map \
		--verbose

	# @echo "demangling linker map..."
	# cat $(BUILDROOT)/Application.mangled.map \
	# 	| c++filt | swift demangle > $(BUILDROOT)/Application.map

	# @echo "disassembling..."
	# otool \
	# 	-arch $(ARCH) -v -V -d -t \
	# 	$(BUILDROOT)/Application \
	# 	| c++filt | swift demangle > $(BUILDROOT)/Application.disassembly

	@echo "extracting binary..."
	$(ELF2HEX) \
		$(BUILDROOT)/Application \
		$(BUILDROOT)/Application.hex

.PHONY: clean
clean:
	@echo "cleaning..."
	@swift package clean
	@rm -rf .build
