# Bringing Embedded Swift to a new platform

Implement the small set of runtime entry points that Embedded Swift expects from any platform, hosted or baremetal.

## Overview

A _platform_  is anything from a couple of hand-written functions in a single-file baremetal program, up to a full SDK or RTOS. What every platform has in common is that it supplies the low-level functions that the Embedded Swift compiler and standard library call into whenever a program uses a feature that needs help from the outside world, such as allocating memory, calling `print()`, or creating a `Mutex`.

If your target already has these functions available, either because it exposes an existing C SDK or because your toolchain already ships a matching shim (see "Reuse the built-in shims" below), see <doc:IntegratingWithPlatforms> and <doc:Baremetal> instead: they describe how to connect Swift code to an *existing* SDK, or how to write the startup code and register access for a *specific* board, on top of the layer described here.

Recent Swift toolchains formalize this contract as the Embedded Swift Platform Abstraction Layer, declared in [EmbeddedPlatform.h](https://github.com/swiftlang/swift/blob/main/stdlib/public/EmbeddedPlatform/swift/EmbeddedPlatform.h). Every function declared in that header file matches the signature of a familiar POSIX function, so on a POSIX-like platform many of these can be one-line pass-throughs. None of them are required unconditionally. The linker only pulls in the ones your program actually exercises, so a program that never allocates on the heap doesn't need `_swift_allocate`, and a program that never creates a mutex doesn't need those functions.

## Reuse the built-in shims

Because every entry point is just a function with a specified signature, you rarely need to write all of them from scratch. The Swift repository ships several ready-made shims under [`stdlib/public/EmbeddedPlatform`](https://github.com/swiftlang/swift/tree/main/stdlib/public/EmbeddedPlatform) that you can link directly (where your toolchain provides prebuilt libraries for your target) or copy as a starting point:

- [EmbeddedPlatformPOSIX.swift](https://github.com/swiftlang/swift/tree/main/stdlib/public/EmbeddedPlatform/EmbeddedPlatformPOSIX.swift) (`swiftEmbeddedPlatformPOSIX`) implements allocation, randomness, console output, and exit on top of `posix_memalign`, `arc4random_buf`, `putchar`, and `exit`. These are a good fit for any platform with a POSIX-like libc.
- [EmbeddedPlatformSingleThreaded.swift](https://github.com/swiftlang/swift/tree/main/stdlib/public/EmbeddedPlatform/EmbeddedPlatformSingleThreaded.swift) (`swiftEmbeddedPlatformSingleThreaded`) implements the mutex and thread-local-storage functions with a simple lock-count check and a fixed-size array, with no real locking — correct as long as your program never runs on more than one core and never gets preempted mid-critical-section.
- [EmbeddedPlatformMultiThreadedPOSIX.c](https://github.com/swiftlang/swift/tree/main/stdlib/public/EmbeddedPlatform/EmbeddedPlatformMultiThreadedPOSIX.c) (`swiftEmbeddedPlatformMultiThreadedPOSIX`) implements the mutex and thread-local-storage functions on top of `pthread_mutex_t` and `pthread_key_t`, for platforms with a real pthreads implementation.
- [EmbeddedPlatformMultiThreadedDarwin.c](https://github.com/swiftlang/swift/tree/main/stdlib/public/EmbeddedPlatform/EmbeddedPlatformMultiThreadedDarwin.c) (`swiftEmbeddedPlatformMultiThreadedDarwin`) implements the mutex functions on top of `os_unfair_lock` (falling back to a `pthread_mutex_t` for the recursive case), for Darwin targets.

These pieces are independent, so you can mix and match. For example, if your platform has a POSIX-ish libc but no real concurrency, link the POSIX shim for allocation and printing together with the single-threaded shim for mutexes and thread-local storage. If your toolchain ships prebuilt versions of these libraries for your target, this is as simple as adding them to your link line (e.g. `-lswiftEmbeddedPlatformPOSIX -lswiftEmbeddedPlatformSingleThreaded`); check your toolchain's library search path for the exact names and availability.

It's only if your platform doesn't fit any of these shims — because it lacks a POSIX-like libc, or needs a threading model none of them cover — that you need to implement the entry points yourself, as described in the rest of this article.

## Implement entry points in C or in Swift

You can implement any of these functions in C. Define a function matching the declaration in `EmbeddedPlatform.h` and link it into your firmware, the same way you would provide any other C symbol the linker asks for.

You can also implement them directly in Swift, using the `@implementation @c` attribute so the C header stays the single source of truth for the signature, instead of hand-declaring an `@_extern(c:)` twin of it:

```swift
// -import-bridging-header path/to/EmbeddedPlatform.h
// -enable-experimental-feature Extern -enable-experimental-feature AllowRuntimeSymbolDeclarations

@export(interface)
@implementation @c
public func _swift_exit(_ code: Int) {
  while true {}
}
```

`@export(interface)` gives the function a single, externally visible definition, which is what lets the separately-compiled standard library link against it by symbol name.

## Provide memory allocation

`_swift_allocate(alignment:size:flags:)` and `_swift_deallocate(pointer:alignment:size:flags:)` back every heap allocation Embedded Swift performs implicitly: class instances, copy-on-write buffers for `Array`/`Dictionary`/`Set`/`String`, and explicit calls like `UnsafeMutablePointer.allocate`. A `SWIFT_ALLOC_ZERO_MEMORY` flag asks for zeroed memory, similar to `calloc`. `_swift_typedAllocate` is only needed if you enable the `TypedAllocation` feature; otherwise it can simply forward to `_swift_allocate`.

```c
void *_swift_allocate(size_t alignment, size_t size, swift_alloc_flags_t flags) {
  void *ptr = NULL;
  if (posix_memalign(&ptr, alignment, size) != 0) return NULL;
  if (flags & SWIFT_ALLOC_ZERO_MEMORY) memset(ptr, 0, size);
  return ptr;
}

void _swift_deallocate(void *ptr, size_t alignment, size_t size, swift_dealloc_flags_t flags) {
  free(ptr);
}
```

## Provide console output

`_swift_writeToStandardOutput(chars:count:)` is only needed if you use `print()` or `debugPrint()`. It receives a buffer of UTF-8 code points (not null-terminated) and should return the number of bytes written.

```c
size_t _swift_writeToStandardOutput(const unsigned char *chars, size_t count) {
  for (size_t i = 0; i < count; i++) putchar(chars[i]);
  return count;
}
```

## Provide randomness

`_swift_generateRandom(buffer:nbytes:)` is only needed if your program uses `SystemRandomNumberGenerator`, the default random source behind `shuffle()` and friends. It's encouraged to use a cryptographically secure source but isn't required to; it can typically forward to a hardware RNG or `arc4random_buf` where available.

`_swift_generateRandomHashSeed(buffer:nbytes:)` is a separate entry point that seeds the hashing used by `Set` and `Dictionary`. It doesn't need to be cryptographically secure, and can even return a fixed value if you want deterministic hashing.

## Provide mutexes

`_swift_mutex_init`, `_swift_mutex_destroy`, `_swift_mutex_lock`, `_swift_mutex_unlock`, and `_swift_mutex_tryLock` are only needed if you use `Synchronization.Mutex`. The caller allocates the storage for you — at least `EMBEDDED_SWIFT_MUTEX_NUM_WORDS` pointer-sized words (8 by default; override with `-Xcc -DEMBEDDED_SWIFT_MUTEX_NUM_WORDS=<n>` if your mutex representation needs more) — and hands it to `_swift_mutex_init` along with a `.checked` flag to opt into misuse diagnostics.

A separate `_swift_mutexRecursive_init`, `_swift_mutexRecursive_destroy`, `_swift_mutexRecursive_lock`, and `_swift_mutexRecursive_unlock` family backs reentrant locking, i.e. a mutex that the same execution context can acquire more than once without deadlocking. Its storage is sized independently, by `EMBEDDED_SWIFT_MUTEX_RECURSIVE_NUM_WORDS`. `Synchronization.Mutex` only needs the non-recursive family; the recursive functions are currently used internally by the Concurrency library, so you can skip them unless you're also bringing up Concurrency support.

If your program is single-threaded and never preempted, you don't need a real lock at all: it's enough to track whether the mutex is currently held and trap on misuse, which is exactly what the standard library's single-threaded shim does. If you do have real concurrency, implement these on top of whatever your platform provides — a hardware spinlock, an RTOS mutex, or `pthread_mutex_t` on a POSIX-like target.

## Provide thread-local storage

`_swift_tls_init`, `_swift_tls_get`, and `_swift_tls_set` give the runtime a small, fixed set of thread-local storage slots — `SWIFT_TLS_KEY_COUNT` of them — used internally for things like exclusivity checking (when the compiler is built with `-enforce-exclusivity=checked`), Concurrency's task-local values, and other runtime bookkeeping. The key values are dense in the range `[0, SWIFT_TLS_KEY_COUNT)`, so you can use them directly as array indices. `_swift_thread_isMain` reports whether the calling execution context is the platform's designated main thread.

On a single-threaded platform, storage for these keys can just be a fixed-size array of pointers, since there's only ever one execution context. On a multi-threaded platform, back them with real thread-local storage, e.g. `pthread_key_t` together with `pthread_getspecific`/`pthread_setspecific` on a POSIX-like target.

## Provide exiting

`_swift_exit(code:)` terminates the program and must not return. On a hosted platform this is a direct call to `exit()`; on baremetal it's usually an infinite loop or a reset.

## Check the platform layer version

The standard library itself exposes `swift_getPlatformLayerVersion(major:minor:)`, which reports the `EMBEDDED_SWIFT_PLATFORM_VERSION_MAJOR`/`MINOR` that it was built expecting. Call it from your own startup code to confirm the linked standard library agrees with the header version you built your shims against. A mismatched major version means the ABI of these entry points has changed and your shims need updating:

```swift
var major = 0
var minor = 0
swift_getPlatformLayerVersion(&major, &minor)
precondition(major == EMBEDDED_SWIFT_PLATFORM_VERSION_MAJOR)
```
