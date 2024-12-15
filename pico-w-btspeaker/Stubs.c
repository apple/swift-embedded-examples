#include <stdlib.h>
#include <stdint.h>
#include <errno.h>

// Embedded Swift currently requires posix_memalign, but the C libraries in the
// Pico SDK do not provide it. Let's implement it and forward the calls to
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
