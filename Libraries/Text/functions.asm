; File: Libraries/Text/functions.asm
section .text

strlen:
    xor rax, rax
    strlen_loop:
        cmp byte [rsi + rax], 0
        je  strlen_exit
        inc rax
        jmp strlen_loop
    strlen_exit:
        ret

print_str:
    call strlen
    mov rdx, rax
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    syscall
    ret