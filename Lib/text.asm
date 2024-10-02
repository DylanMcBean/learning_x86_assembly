; Lib/text.asm
section .text

; Description:      Calculate the length of a null-terminated string
; Preset Registers: RSI: pointer to the string
; Set Registers:    RAX: length of the string
_strlen:
    xor     rax, rax
_strlen_loop:
    cmp     byte [rsi + rax], 0
    je      _strlen_end
    inc     rax
    jmp     _strlen_loop
_strlen_end:
    ret


; Description:      Calculate the length of a null-terminated string
; Preset Registers: RDI: pointer to the string
; Set Registers:    RAX: length of the string
_strlen2:
    push    rbx        ; Save registers
    push    rcx
    mov     rbx, rdi   ; Copy pointer to rbx
    xor     rax, rax   ; Clear rax
    mov     rcx, -1    ; Maximum number of bytes to compare
                       ; -1 meaning 2^64 - 1 bytes
    repne   scasb      ; while RDI != RAX(0), scan over string
    sub     rdi, rbx   ; Calculate length, end - start
    dec     rdi        ; Exclude null terminator
    mov     rax, rdi 
    pop     rcx        ; Restore registers
    pop     rbx
    ret