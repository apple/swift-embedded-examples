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

// Embedded Swift currently requires posix_memalign, but the Zephyr SDK is not
// set up correctly to provide it. Even though the symbol is found in picolibc,
// linking it causing other link-time failures. Let's simply stub it as we're
// not using any allocations in this example.
void posix_memalign() { __builtin_trap(); }
