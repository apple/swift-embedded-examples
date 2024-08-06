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

#include <stdlib.h>
#include <errno.h>

void *aligned_alloc(size_t alignment, size_t size);

// Embedded Swift currently requires posix_memalign, but the C libraries in the
// Zephyr SDK do not provide it. Let's implement it and forward the calls to
// aligned_alloc(3).
int
posix_memalign(void **memptr, size_t alignment, size_t size)
{
  void *p = aligned_alloc(alignment, size);
  if (p) {
    *memptr = p;
    return 0;
  }

  return errno;
}
