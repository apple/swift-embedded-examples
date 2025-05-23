# Try out Embedded Swift on macOS

Tutorial for building a simple program for your host OS with Embedded Swift

## Overview

While desktop operating systems like macOS and Linux are not the typical targets for Embedded Swift, you **absolutely can** build code for them using the Embedded Swift mode. This is useful for experimentation, trying out Embedded Swift, or to be able to iterate fast on an idea for some code that doesn't really need the physical device to work.

The simplest program in Embedded Swift can just be a regular "Hello, World":

```swift
// HelloEmbedded.swift
print("Hello, Embedded Swift 😊")
```

And building it into an executable can be done by calling the `swiftc` compiler directly, but we'll want to add flags to enable Embedded Swift, and also Whole Module Optimization.

```shell
$ swiftc HelloEmbedded.swift -o HelloEmbedded -enable-experimental-feature Embedded -wmo
```

This will produce a regular executable binary, but notice that it's very small in size and that it also *does not actually depend on the Swift runtime in the OS* (all Embedded Swift binaries carry their runtime+stdlib dependencies within):

```shell
$ ls -al
-rwxr-xr-x    1 kuba  staff    18K May 16 17:19 HelloEmbedded*
-rw-r--r--    1 kuba  staff    59B May 16 17:16 HelloEmbedded.swift
$ otool -L HelloEmbedded
HelloEmbedded:
  /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1000.0.0)
```

Let's run it:

```shell
$ ./HelloEmbedded
Hello, Embedded Swift 😊
```

Hooray! Our first *host-side* Embedded Swift program is working!

## Where to go next

- The [Embedded Swift Vision Document](https://github.com/swiftlang/swift-evolution/blob/main/visions/embedded-swift.md) will give you an overview of the approaches and goals of Embedded Swift, and also what exactly is in the Embedded Swift language subset.
- The [collection of Embedded Swift example projects](https://github.com/apple/swift-embedded-examples) on GitHub shows on which embedded devices can Swift work today, and the examples can also be used as templates for your own projects.
- The [Embedded Swift User Manual](https://github.com/swiftlang/swift/blob/main/docs/EmbeddedSwift/UserManual.md) describes how to use the Embedded Swift compilation mode and how to interact with the compiler.
- The [Tools page](https://www.swift.org/tools/#editors) has guides for setting up Swift integration in your editor to enable features like indexing, autocomplete, jump-to-definition, and others.
- The [Swift forums](https://forums.swift.org/) are the best place to ask questions, give feedback or share your cool projects.
