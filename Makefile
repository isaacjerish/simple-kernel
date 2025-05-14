AS = nasm
CC = gcc
LD = ld
ASFLAGS = -f elf32
CFLAGS = -m32 -ffreestanding -c -Wall -Wextra -O2 -g
LDFLAGS = -T src/link.ld -nostdlib -e start
BUILD_DIR = build
KASM_OBJ = $(BUILD_DIR)/kasm.o
KC_OBJ = $(BUILD_DIR)/kc.o
KERNEL = $(BUILD_DIR)/kernel
.PHONY: all clean run

all: $(KERNEL)
$(KERNEL): $(KASM_OBJ) $(KC_OBJ)
	@echo "LD - Linking object files to create $(KERNEL)"
	$(LD) $(LDFLAGS) -o $(KERNEL) $(KASM_OBJ) $(KC_OBJ)
	@echo "Kernel built successfully: $(KERNEL)"
$(KASM_OBJ): src/kernel.asm
	@mkdir -p $(BUILD_DIR) # Create build directory if it doesn't exist
	@echo "AS - Assembling src/kernel.asm to $(KASM_OBJ)"
	$(AS) $(ASFLAGS) src/kernel.asm -o $(KASM_OBJ)
$(KC_OBJ): src/kernel.c
	@mkdir -p $(BUILD_DIR) # Create build directory if it doesn't exist
	@echo "CC - Compiling src/kernel.c to $(KC_OBJ)"
	$(CC) $(CFLAGS) src/kernel.c -o $(KC_OBJ)
clean:
	@echo "Cleaning build directory..."
	rm -rf $(BUILD_DIR)
	@echo "Clean complete."
run: $(KERNEL)
	@echo "Running kernel with QEMU..."
	qemu-system-i386 -kernel $(KERNEL)

