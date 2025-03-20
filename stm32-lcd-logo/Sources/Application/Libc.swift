//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors.
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

@_silgen_name("memset")
func memset(_ dst: UnsafeMutableRawPointer, _ val: CInt, _ len: Int)
  -> UnsafeMutableRawPointer
{
  let dst = dst.bindMemory(to: UInt8.self, capacity: len)
  for i in 0..<len {
    dst[i] = UInt8(truncatingIfNeeded: val)
  }
  return UnsafeMutableRawPointer(dst)
}

@_silgen_name("memcpy")
func memcpy(_ dst: UnsafeMutableRawPointer, _ src: UnsafeRawPointer, _ len: Int)
  -> UnsafeMutableRawPointer
{
  let src = src.bindMemory(to: UInt8.self, capacity: len)
  let dst = dst.bindMemory(to: UInt8.self, capacity: len)
  for i in 0..<len {
    dst[i] = src[i]
  }
  return UnsafeMutableRawPointer(dst)
}
