; File: Hello World/main.asm
%include "Libraries/Data/constants.asm"
%include "Libraries/Data/variables.asm"
%include "Libraries/Text/file_api.asm"
%include "Libraries/Text/functions.asm"

section .text
    global _start

_start:
    mov rdi, file_path          
    mov rsi, O_CREAT | O_WRONLY
    mov rdx, S_IWUSR | S_IRUSR
    call file_open              
    mov rbx, rax        ; Save file descriptor

    mov rsi, hello_msg
    call strlen
    mov rdx, rax
    mov rdi, rbx
    mov rsi, hello_msg
    call file_write

    mov rdi, rbx
    call file_close

    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall