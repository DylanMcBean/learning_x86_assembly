; main.asm
%include "Lib/file.asm"
%include "Lib/text.asm"
%include "Lib/data.asm"

section .text
global _start

_start:
    ; Create a file
    mov     rdi, file_path                  ; RDI: pointer to file path
    mov     rsi, O_CREAT | O_WRONLY         ; RSI: flags
    mov     rdx, S_IRUSR | S_IWUSR          ; RDX: mode
    call    file_open                       ; RAX: file descriptor
    mov     rbx, rax                        ; Save file descriptor

    ; Write message too file
    mov     rsi, hello_msg                  ; RSI: pointer to string
    call    strlen                          ; RAX: length
    mov     rdx, rax                        ; RDX: length
    mov     rdi, rbx                        ; RDI: file descriptor
    mov     rsi, hello_msg                  ; RSI: pointer to string
    call    file_write                      ; Write to file

    ; Close the file
    mov     rdi, rbx                        ; RDI: file descriptor
    call    file_close

    ; Exit program
    mov     rax, SYS_EXIT                   ; System call number for exit
    xor     rdi, rdi                        ; Exit code 0
    syscall