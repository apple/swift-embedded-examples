#! /usr/bin/env -S uv run --script

# /// script
# dependencies = [
#   "pyelftools==0.31",
# ]
# ///

# This source file is part of the Swift open source project
#
# Copyright (c) 2023 Apple Inc. and the Swift project authors.
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See https://swift.org/LICENSE.txt for license information

#
# elf2hex -- Converts a statically-linked ELF executable into an "Intel HEX"
# file format suitable for flashing onto some embedded devices.
#
# Usage:
#   $ elf2hex.py <input> <output> [--symbol-map <output>]
#
# Example:
#   $ elf2hex.py ./blink ./blink.hex --symbol-map ./blink.symbols
#

import argparse
import json
import pathlib

import elftools.elf.elffile


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('input')
    parser.add_argument('output')
    parser.add_argument('--symbol-map')
    args = parser.parse_args()

    inf = open(args.input, "rb")
    outf = open(args.output, "wb")

    def emitrecord(record):
        checksum = 0
        pos = 0
        while pos < len(record):
            checksum = (checksum + int(record[pos:pos + 2], 16)) % 256
            pos += 2
        checksum = (256 - checksum) % 256
        outf.write((":" + record + f"{checksum:02X}" + "\n").encode())

    def emit(vmaddr, data):
        pos = 0
        while pos < len(data):
            chunklen = min(16, len(data) - pos)
            chunk = data[pos:pos + chunklen]
            chunkhex = chunk.hex().upper()

            assert vmaddr < 0x100000000, f"vmaddr: {vmaddr:x}"
            vmaddr_high = (vmaddr >> 16) & 0xffff
            recordtype = "04"  # Extended Linear Address
            emitrecord(f"{2:02X}{0:04X}{recordtype}{vmaddr_high:04X}")

            vmaddr_low = vmaddr & 0xffff
            recordtype = "00"  # Data
            emitrecord(f"{chunklen:02X}{vmaddr_low:04X}{recordtype}{chunkhex}")

            pos += chunklen
            vmaddr += chunklen

    elffile = elftools.elf.elffile.ELFFile(inf)
    for segment in elffile.iter_segments():
        if segment.header.p_type != "PT_LOAD":
            continue
        vmaddr = segment.header.p_paddr
        data = segment.data()
        emit(segment.header.p_paddr, data)

    chunklen = 0
    vmaddr = 0
    recordtype = "01"  # EOF
    emitrecord(f"{chunklen:02X}{vmaddr:04X}{recordtype}")

    symbol_map = {}
    symtab_section = elffile.get_section_by_name(".symtab")
    for s in symtab_section.iter_symbols():
        if s.entry.st_info.type not in ["STT_FUNC", "STT_NOTYPE"]:
            continue
        if s.entry.st_shndx == "SHN_ABS":
            continue
        if s.name == "":
            continue
        symbol_map[s.name] = s.entry.st_value

    if args.symbol_map is not None:
        pathlib.Path(args.symbol_map).write_text(json.dumps(symbol_map))

    inf.close()
    outf.close()


if __name__ == '__main__':
    main()
