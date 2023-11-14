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

extension UnsafeMutablePointer where Pointee == UInt32 {
    func volatileLoad() -> Pointee {
        return volatile_load_uint32_t(self)
    }

    func volatileStore(_ value: Pointee) {
        volatile_store_uint32_t(self, value)
    }
}
