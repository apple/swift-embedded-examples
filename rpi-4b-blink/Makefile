SWIFT_EXEC ?= $(shell if [ "$(shell uname)" = "Darwin" ]; then xcrun -f swift; else which swift; fi)
CLANG ?= $(shell if [ "$(shell uname)" = "Darwin" ]; then xcrun -f clang; else which clang; fi)
LLVM_OBJCOPY ?= $(shell if [ "$(shell uname)" = "Darwin" ]; then xcrun -f llvm-objcopy; else which llvm-objcopy; fi)

BUILDROOT := $(shell $(SWIFT_EXEC) build --triple aarch64-none-none-elf -Xswiftc -Xfrontend -Xswiftc -disable-stack-protector --show-bin-path)

.PHONY: all clean

all: kernel8.img

kernel8.img: kernel8.elf
	@echo "💾 Converting to binary kernel image with llvm-objcopy..."
	$(LLVM_OBJCOPY) -O binary kernel8.elf kernel8.img
	@echo ""
	@echo "🥳 Done! kernel8.img was saved to this directory."

kernel8.elf: $(BUILDROOT)/libMainApp.a $(BUILDROOT)/Support.build/boot.S.o link.ld
	@echo "🔗 Linking with clang..."
	$(CLANG) --target=aarch64-elf -o kernel8.elf $< $^ -fuse-ld=lld -nostdlib -Wl,--unresolved-symbols=ignore-in-object-files -Wl,-T ./link.ld
	@echo ""

$(BUILDROOT)/libMainApp.a $(BUILDROOT)/Support.build/boot.S.o: 
	@echo "🛠️  Building with Swift Package Manager..."
	$(SWIFT_EXEC) build --triple aarch64-none-none-elf -Xswiftc -Xfrontend -Xswiftc -disable-stack-protector
	@echo ""

clean:
	rm -rf kernel8.elf kernel8.img .build