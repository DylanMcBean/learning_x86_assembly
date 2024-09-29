; Lib/text.asm
section .text

; Description:      Calculate the length of a null-terminated string
; Preset Registers: RSI: pointer to the string
; Set Registers:    RAX: length of the string
strlen:
    xor     rax, rax
strlen_loop:
    cmp     byte [rsi + rax], 0
    jne     strlen_continue
    ret
strlen_continue:
    inc     rax
    jmp     strlen_loop