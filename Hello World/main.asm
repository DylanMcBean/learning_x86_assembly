; File-Name: main.asm
; Author: Dylan McBean
; Date: 15/01/2023
; Type: 64-bit

section .data
    message: db "Hello, World!", 0xA
    message_length: equ $-message ; get length of string `message`

section .text
    global _start ; where is the start of the program

_start:
    mov rax, 1              ; Write (int fd, const void *buf, size_t count);
    mov rdi, 1              ; fd - 1, stdout
    mov rsi, message        ; buf
    mov rdx, message_length ; count
    syscall                 ; call

    mov rax, 60 ; Exit (int status)
    mov rdi, 0  ; status
    syscall     ; call
