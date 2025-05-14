# My First Kernel

A simple "Hello World" kernel for the x86 architecture. This project is part of my journey into operating system development.

## Goal

The kernel will:
1.  Be bootable via GRUB (or QEMU directly).
2.  Initialize 32-bit protected mode (handled by GRUB in this case).
3.  Clear the screen.
4.  Print a message to the screen.
5.  Halt the CPU.

## Prerequisites

* Linux environment
* NASM assembler
* GCC (for 32-bit i386 target)
* ld (GNU Linker)
* QEMU (for testing): `qemu-system-i386`
* (Optional) GRUB for booting on a VM or bare metal
