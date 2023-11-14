#!/usr/bin/env python3 -u -tt

# This source file is part of the Swift open source project
#
# Copyright (c) 2023 Apple Inc. and the Swift project authors.
# Licensed under Apache License v2.0 with Runtime Library Exception
#
# See https://swift.org/LICENSE.txt for license information

#
# macho2uf2 -- Converts a statically-linked executable Mach-O into a flat "UF2" file suitable for flashing as a single
# contiguous blob onto some embedded devices, in particular Raspberry Pi Pico (W). Note that the UF2 format allows for
# discontiguous memory regions, but this utility does not support that.
#
# Usage:
#   $ macho2uf2.py <input> <output> --base-address <base-address> --segments <segment-list>
#
# Example:
#   $ macho2uf2.py ./blink ./blink.uf2 --base-address 0x00200000 --segments '__TEXT,__DATA,__VECTORS'
#
# Requirements and notes:
#   * The output UF2 file is a flat contiguous representation of the segments (--segments) based on their VM addresses.
#   * The UF2 file's first byte corresponds to the specified base address (--base-address).
#   * Any gaps between segments are filled with zero bytes.
#   * Because of that, you want the input Mach-O to have all segments "close", and not have gaps.
#

import argparse
import os
import subprocess
import struct
from macholib import MachO
from macholib import mach_o

MY_DIR = os.path.dirname(os.path.abspath(__file__))

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('input')
    parser.add_argument('output')
    parser.add_argument('--base-address', required=True)
    parser.add_argument('--segments', required=True)    
    args = parser.parse_args()
    args.base_address = int(args.base_address, 16)
    args.segments = args.segments.split(",")

    subprocess.check_call([MY_DIR + "/macho2bin.py", args.input, args.input + ".bin", "--base-address", "0x%08x" % args.base_address, "--segments", ",".join(args.segments)])

    output = b''
    total_size = os.stat(args.input + ".bin").st_size
    num_blocks = (total_size + 255) // 256
    vmaddr = args.base_address
    with open(args.input + ".bin", "rb") as f:
        block_number = 0
        while True:
            block = f.read(256)
            if len(block) == 0:
                break
            if len(block) < 256:
                block += b'\0' * (256 - len(block))
            
            # UF2_Block header
            output += struct.pack("<I", 0x0A324655) # magicStart0
            output += struct.pack("<I", 0x9E5D5157) # magicStart1
            output += struct.pack("<I", 0x2000) # flags: familyID present
            output += struct.pack("<I", vmaddr) # targetAddr
            output += struct.pack("<I", 256) # payloadSize
            output += struct.pack("<I", block_number) # blockNo
            output += struct.pack("<I", num_blocks) # numBlocks
            output += struct.pack("<I", 0xE48BFF56) # fileSize / familyID: rp2040 family ID

            # Data
            if len(block) < 476:
                block += b'\0' * (476 - len(block))
            output += block

            # UF2_Block footer
            output += struct.pack("<I", 0x0AB16F30) # magicEnd

            block_number += 1
            vmaddr += 256

    with open(args.output, "wb") as f:
        f.write(output)
            
    print(f"Produced {args.output} with total size {len(output)} (0x{len(output):0x}) bytes, payload size {total_size} (0x{total_size:0x}) bytes")

if __name__ == '__main__':
    main()
