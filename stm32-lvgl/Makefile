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

# Paths
REPOROOT         := $(shell git rev-parse --show-toplevel)
TOOLSROOT        := $(REPOROOT)/Tools
TOOLSET          := $(PWD)/toolset.json
ELF2HEX          := $(TOOLSROOT)/elf2hex.py
SWIFT_BUILD      := swift build
NM               := nm
LLVM_TOOLCHAIN   := $(PWD)/llvm-toolchain

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
	@echo "checking dependencies..."

	# TODO: Check that we have swiftly and recent Swift main toolchain

	if [[ ! -d $(PWD)/lvgl ]]; then echo "\n  *** LVGL checkout not found, please run ./fetch-dependencies.sh\n" ; exit 1 ; fi
	if [[ ! -d $(PWD)/llvm-toolchain ]]; then echo "\n  *** LLVM toolchain checkout not found, please run ./fetch-dependencies.sh\n" ; exit 1 ; fi

	mkdir -p .build

	@echo "configuring LVGL..."
	cmake -B .build/lvgl -G Ninja ./lvgl \
        -DCMAKE_EXPORT_COMPILE_COMMANDS=On \
        -DTOOLCHAIN_PATH=$(LLVM_TOOLCHAIN) \
        -DCMAKE_TOOLCHAIN_FILE=../clang-arm-toolchain.cmake \
        -DLV_CONF_PATH=../Sources/CLVGL/include/lv_conf.h

	@echo "building LVGL..."
	cmake --build .build/lvgl
	
	@echo "building..."
	$(SWIFT_BUILD) \
		$(SWIFT_BUILD_ARGS) \
		--verbose

	@echo "disassembling..."
	$(LLVM_TOOLCHAIN)/bin/llvm-objdump --all-headers --disassemble --mcpu=cortex-m7 \
		$(BUILDROOT)/Application \
		| c++filt | swift demangle > $(BUILDROOT)/Application.disassembly

	@echo "extracting binary..."
	$(eval FLASH_DATA_START = `$(NM) -p $(BUILDROOT)/Application | grep __flash_data_start | cut -d' ' -f1`)
	@echo "   FLASH_DATA_START = 0x$(FLASH_DATA_START)"
	$(eval SRAM_DATA_START = `$(NM) -p $(BUILDROOT)/Application | grep __data_start | cut -d' ' -f1`)
	@echo "   SRAM_DATA_START = 0x$(SRAM_DATA_START)"
	$(eval FLASH_DATA_LEN = `$(NM) -p $(BUILDROOT)/Application | grep __flash_data_len | cut -d' ' -f1`)
	@echo "   FLASH_DATA_LEN = 0x$(FLASH_DATA_LEN)"
	$(ELF2HEX) \
		$(BUILDROOT)/Application $(BUILDROOT)/Application.hex --relocate "0x$(SRAM_DATA_START):0x$(FLASH_DATA_START)"
	ls -al $(BUILDROOT)/Application.hex
	@echo "\n   *** All done, build succeeded!\n"

flash:
	@echo "flashing..."
	st-flash --reset --format ihex write $(BUILDROOT)/Application.hex

.PHONY: clean
clean:
	@echo "cleaning..."
	@swift package clean
	@rm -rf .build
