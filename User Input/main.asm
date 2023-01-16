; File-Name: main.asm
; Author: Dylan McBean
; Date: 16/01/2023
; Type: 64-bit

section .data
    message_1: db "What is your name: "
    message_1_len: equ $ - message_1
    message_2: db "Hello, "
    message_2_len: equ $ - message_2

section .bss
    user_name resb 16 ; reserving 16 bytes for `user_name` variable

section .text
    global _start

_start:
    ; examples of calling functions
    call write_m1
    call read_input
    call write_m2
    call write_name
    call exit

write_m1:
    ; Write message_1 to stdout
    mov rax, 1              ; Write (int fd, const void *buf, size_t count);
    mov rdi, 1              ; fd - 1, stdout
    mov rsi, message_1      ; buf
    mov rdx, message_1_len  ; count
    syscall                 ; call
    ret                     ; return

read_input:
    ; Read user input from stdin
    mov rax, 0          ; Read (int fd, void *buf, size_t count);
    mov rdi, 0          ; fd - 0, stdin
    mov rsi, user_name  ; buf
    mov rdx, 16         ; count
    syscall             ; call
    ret                 ; return

write_m2:
    ; Write message_2 to stdout
    mov rax, 1              ; Write (int fd, const void *buf, size_t count);
    mov rdi, 1              ; fd - 1, stdout
    mov rsi, message_2      ; buf
    mov rdx, message_2_len  ; count
    syscall                 ; call
    ret                     ; return

write_name:
    ; Write user_name to stdout
    mov rax, 1          ; Write (int fd, const void *buf, size_t count);
    mov rdi, 1          ; fd - 1, stdout
    mov rsi, user_name  ; buf
    mov rdx, 16         ; count
    syscall             ; call
    ret                 ; return

exit:
    mov rax, 60 ; Exit (int status)
    mov rdi, 0  ; status
    syscall     ; call