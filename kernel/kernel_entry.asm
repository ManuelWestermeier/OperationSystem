[BITS 32]
[GLOBAL start]
[EXTERN kernel_main]

SECTION .multiboot
    align 4
    dd 0x1BADB002             ; magic number
    dd 0                     ; flags
    dd - (0x1BADB002 + 0)    ; checksum

SECTION .text
start:
    ; Set up the stack
    mov esp, stack_space + stack_size
    call kernel_main

    ; Infinite loop to halt the CPU
.hang:
    cli
    hlt
    jmp .hang

SECTION .bss
ALIGN 16
stack_space:
    resb 8192 ; 8 KB for stack
stack_size equ $ - stack_space
