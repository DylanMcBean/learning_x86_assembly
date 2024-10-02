; main.asm
%include "Lib/file.asm"
%include "Lib/text.asm"
%include "Lib/data.asm"

section .text
global _start

_start:
    ; Open Source File
    mov     rdi, file_path                  ; File path
    mov     rsi, O_RDONLY                   ; Read only
    call    _file_open
    mov     r8, rax                         ; Save file descriptor
    mov     rdi, r8                         ; File descriptor
    call    _file_fstat

    ; Open Destination File
    mov     rdi, file_path2                 ; File path
    mov     rsi, O_WRONLY | O_CREAT          ; Write only, create if not exist
    mov     rdx, S_IWUSR | S_IRUSR           ; File permissions
    call    _file_open
    mov     r9, rax                         ; Save file descriptor

    ; copy file
    mov     rdi, r9                         ; Destination file descriptor
    mov     rsi, r8                         ; Source file descriptor
    mov     rdx, 0                          ; Offset
    mov     r10, [file_stat_buffer + 64]    ; Number of bytes to copy
    call    _file_sendfile

    ; Exit program
    mov     rax, SYS_EXIT                   ; System call number for exit
    xor     rdi, rdi                        ; Exit code 0
    syscall