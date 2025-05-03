load("@rules_swift//swift:swift_binary.bzl", "swift_binary")

# FIXME: on macos $(swiftly use --print-location)/Info.plist BundleID -> --action_env=TOOLCHAINS=<>

swift_binary(
    name = "cli",
    srcs = ["CLI.swift"],
    copts = [
        "-enable-experimental-feature", "Embedded",
        "-whole-module-optimization",
    ],
)
