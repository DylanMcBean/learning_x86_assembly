; File-Name: main.asm
; Author: Dylan Mcbean
; Date: 15/01/2023
; Type: 64-bit

section .data
    message: db "Hello, World!", 0xA
    message_length equ $-message ; get length of string `message`

section .text
    global _start

_start:
    mov rax, 0x1            ; Write (int fd, cont void *buf, size_t count);
    mov rdi, 0x1            ; fd
    mov rsi, message        ; buf
    mov rdx, message_length ; count
    syscall                 ; call

    mov rax, 60 ; Exit (int status)
    mov rdi, 0  ; status
    syscall     ; call