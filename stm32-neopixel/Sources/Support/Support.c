//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2024 Apple Inc. and the Swift project authors.
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

#if defined(__arm__)

#include <stdint.h>
#include <stddef.h>

#define HEAP_SIZE (2 * 1024)

__attribute__((aligned(8)))
__attribute__((section("__DATA,__heap")))
char heap[HEAP_SIZE] = {};
size_t next_heap_index = 0;

void *calloc(size_t count, size_t size) {
  if (next_heap_index + count * size > HEAP_SIZE) __builtin_trap();
  void *p = &heap[next_heap_index];
  next_heap_index += count * size;
  return p;
}

int posix_memalign(void **memptr, size_t alignment, size_t size) {
  *memptr = calloc(size + alignment, 1);
  if (((uintptr_t)*memptr) % alignment == 0) return 0;
  *(uintptr_t *)memptr += alignment - ((uintptr_t)*memptr % alignment);
  return 0;
}

void free(void *ptr) {
  __builtin_trap();
  // never free
}

void *memset(void *b, int c, size_t len) {
  for (int i = 0; i < len; i++) {
    ((char *)b)[i] = c;
  }
  return b;
}

void *memcpy(void *restrict dst, const void *restrict src, size_t n) {
  for (int i = 0; i < n; i++) {
    ((char *)dst)[i] = ((char *)src)[i];
  }
  return dst;
}

void enableFaults() {
    uint32_t* shcsr = (uint32_t*)0xE000ED24;
    // Read SHCSR.
    // Set bits 16-18 to enable Memory, Bus, and Usage faults.
    // Write back the modified value to the SHCSR.
    *shcsr |= 0x7 << 16;
}

void enableFPU() {
    uint32_t* cpacr = (uint32_t*)0xE000ED88;
    // Read CPACR.
    // Set bits 20-23 to enable CP10 and CP11 coprocessors.
    // Write back the modified value to the CPACR.
    *cpacr |= 0xF << 20;
    // Wait for the coprocessors to become active.
    asm volatile("dsb");
    asm volatile("isb");
}

extern void reset(void);

void interrupt(void) {
  while (1) {}
}

__attribute((used)) __attribute((section("__VECTORS,__text")))
void *vector_table[114] = {
  (void *)0x2000fffc, // initial SP
  (void *)((uintptr_t)reset - (0x20010000 - 0x08000000)), // Reset

  (void *)((uintptr_t)interrupt - (0x20010000 - 0x08000000)), // NMI
  (void *)((uintptr_t)interrupt - (0x20010000 - 0x08000000)), // HardFault
  (void *)((uintptr_t)interrupt - (0x20010000 - 0x08000000)), // MemManage
  (void *)((uintptr_t)interrupt - (0x20010000 - 0x08000000)), // BusFault
  (void *)((uintptr_t)interrupt - (0x20010000 - 0x08000000)), // UsageFault
  
  0 // NULL for all the other handlers
};

#endif
