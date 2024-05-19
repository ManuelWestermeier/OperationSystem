#!/bin/bash

# Toolchain
CC=gcc
LD=ld
AS=nasm

# Flags
CFLAGS="-m32 -ffreestanding -O2 -Wall -Wextra"
LDFLAGS="-m elf_i386 -T linker.ld"
ASFLAGS="-f elf32"

# Create necessary directories
mkdir -p iso/boot/grub

# Assemble the kernel entry
$AS $ASFLAGS -o kernel/kernel_entry.o kernel/kernel_entry.asm

# Compile the kernel
$CC $CFLAGS -c -o kernel/kernel.o kernel/kernel.cpp

# Link the kernel
$LD $LDFLAGS -o kernel.bin kernel/kernel_entry.o kernel/kernel.o

# Copy kernel and GRUB config to ISO directory
cp kernel.bin iso/boot/
cp boot/grub.cfg iso/boot/grub/

# Create the bootable ISO
grub-mkrescue -o MyOS.iso iso

# Clean up object files
rm kernel/*.o

echo "Build complete. ISO image is MyOS.iso"

clear

qemu-system-i386 -cdrom MyOS.iso