AS = nasm
CC = i686-elf-gcc
LD = i686-elf-ld

ASFLAGS = -f elf32
CFLAGS = -m32 -ffreestanding -c -Wall -Wextra -O2 -g -fno-stack-protector
LINKER_SCRIPT = src/link.ld
LDFLAGS = -T $(LINKER_SCRIPT) -nostdlib -e start

BUILD_DIR = build
KASM_OBJ = $(BUILD_DIR)/kasm.o
KC_OBJ = $(BUILD_DIR)/kc.o
KERNEL = $(BUILD_DIR)/kernel

.PHONY: all clean run

all: $(KERNEL)

$(KERNEL): $(KASM_OBJ) $(KC_OBJ) $(LINKER_SCRIPT)
	$(LD) $(LDFLAGS) -o $(KERNEL) $(KASM_OBJ) $(KC_OBJ)

$(KASM_OBJ): src/kernel.asm
	@mkdir -p $(BUILD_DIR)
	$(AS) $(ASFLAGS) $< -o $@

$(KC_OBJ): src/kernel.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -rf $(BUILD_DIR)

run: $(KERNEL)
	qemu-system-i386 -kernel $(KERNEL)
