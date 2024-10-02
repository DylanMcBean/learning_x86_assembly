; main.asm
%include "Lib/file.asm"
%include "Lib/text.asm"
%include "Lib/data.asm"

section .text
global _start

_start:
    mov     rdi, file_path
    mov     rsi, file_path2
    call    _file_copy

    ; Exit program
    mov     rax, SYS_EXIT                   ; System call number for exit
    xor     rdi, rdi                        ; Exit code 0
    syscall