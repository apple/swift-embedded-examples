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

OBJECT_FILE_FORMAT ?= MachO
ifeq ($(OBJECT_FILE_FORMAT),MachO)
	include MachO.mk
else ifeq ($(OBJECT_FILE_FORMAT),ELF)
	include ELF.mk
else
	$(error Invalid OBJECT_FILE_FORMAT: $(OBJECT_FILE_FORMAT). Must be 'MachO' or 'ELF')
endif
