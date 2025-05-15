# My First Simple Kernel

A "Hello, World!" style kernel for the x86 architecture. This project is an exploration into the fundamentals of operating system development.

## Project Goal

The primary goal of this initial kernel is to:
1.  Be successfully loaded by a bootloader (or directly by QEMU).
2.  Take control of the CPU after the boot process.
3.  Perform a basic direct hardware interaction: clear the screen and display a message by writing to video memory.
4.  Halt the CPU.

This project serves as a foundational step in understanding how software interacts with bare metal hardware.

## Core Concepts & Technologies

This project involves and explores several key technical areas:

* **Target Architecture:** x86 (32-bit, i386/i686)
* **Boot Process:** Understanding how a computer starts and hands off control to a kernel.
    * **Multiboot Specification:** Adhering to this standard allows bootloaders like GRUB to load our kernel.
* **Assembly Language (NASM):** Used for the initial entry point, setting up the stack, and fulfilling Multiboot requirements.
    * `kernel.asm`: Contains the boot-time assembly code.
* **C Language (Freestanding):** Used for the main kernel logic.
    * `kernel.c`: Contains the C code to clear the screen and print a message.
    * **Direct Memory Access:** Writing directly to video memory (`0xb8000`) for screen output.
* **Cross-Compilation:** Building the kernel on a host system (macOS) for a different target system (i686-elf).
    * **Toolchain:** `i686-elf-gcc`, `i686-elf-ld`, `nasm`.
* **Linker Scripts (`link.ld`):** Precisely controlling the memory layout of the final kernel executable, including:
    * Setting the load address (e.g., `0x100000`).
    * Defining the entry point.
    * Arranging code (`.text`), data (`.data`), and BSS (`.bss`) sections.
* **Build Automation (Makefile):** Streamlining the compilation and linking process.
* **Emulation (QEMU):** Safely testing the kernel in a simulated PC environment (`qemu-system-i386`).
* **Operating System Fundamentals:** Gaining insight into how an OS starts and interacts with hardware at the lowest level.

## Build Instructions

Ensure you have the `i686-elf` cross-compiler toolchain (including `i686-elf-gcc`, `i686-elf-ld`) and `nasm` installed and in your system's PATH.

1.  **Clone the repository (if you haven't already):**
    ```bash
    git clone <your-repo-url>
    cd <your-repo-name>
    ```
2.  **Build the kernel:**
    ```bash
    make
    ```
    This will compile the assembly and C source files and link them to produce the `build/kernel` executable.

3.  **Clean build artifacts:**
    ```bash
    make clean
    ```

## Running the Kernel

The kernel can be run using QEMU:

```bash
make run
```
This command will build the kernel (if necessary) and then launch it in the `qemu-system-i386` emulator.

## Next Steps (Following the Tutorial Series)

This "Hello, World!" kernel is just the beginning. Future enhancements based on typical kernel tutorial progressions might include:
* Reading keyboard input.
* More advanced screen output functions.
* Interrupt Handling (IDT, ISRs, IRQs).
* Timers.
* Basic memory management.
* Simple process scheduling.

---

