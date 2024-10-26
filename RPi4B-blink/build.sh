#!/bin/sh

SWIFT_EXEC=${SWIFT_EXEC:-`xcrun -f swift`}
CLANG=${CLANG:-`xcrun -f clang`}
LLVM_OBJCOPY=/opt/homebrew/opt/llvm@17/bin/llvm-objcopy #${LLVM_OBJCOPY:-`xcrun -f llvm-objcopy`}

echo "🛠️  Building with Swift Package Manager... "

# Build the Swift package and get the path to the build directory
BUILDROOT=$($SWIFT_EXEC build --triple aarch64-none-none-elf -Xcc -D__APPLE__ -Xcc -D__MACH__ -Xswiftc -Xfrontend -Xswiftc -disable-stack-protector --show-bin-path)

echo "🔗 Linking with clang..."

$CLANG --target=aarch64-elf -o kernel8.elf "$BUILDROOT/libMainApp.a" "$BUILDROOT/Support.build/boot.S.o" -fuse-ld=lld -nostdlib -Wl,--unresolved-symbols=ignore-in-object-files -Wl,-T ./link.ld

echo "💾 Converting to binary kernel image with llvm-objcopy..."

$LLVM_OBJCOPY -O binary kernel8.elf kernel8.img

echo ""
echo "🥳 Done! kernel8.img was saved to this directory."

