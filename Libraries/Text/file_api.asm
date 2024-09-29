; File: Libraries/Text/file_api.asm
section .text
; TODO - Add error handling
file_open:
    ; rdi - const char* pathname
    ; rsi - int flags
    ; rdx - int mode (required if O_CREAT is used in flags)
    mov rax, SYS_OPEN
    syscall
    ret

file_read:
    ; rdi - int fd
    ; rsi - void* buf
    ; rdx - size_t count
    mov rax, SYS_READ
    syscall
    ret

file_write:
    ; rdi - int fd
    ; rsi - const void* buf
    ; rdx - size_t count
    mov rax, SYS_WRITE
    syscall
    ret

file_close:
    ; rdi - int fd
    mov rax, SYS_CLOSE
    syscall
    ret

file_seek:
    ; rdi - int fd
    ; rsi - off_t offset
    ; rdx - int whence
    mov rax, SYS_LSEEK
    syscall
    ret