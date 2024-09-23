;* Macro: print
;* Input: Value to be printed
;* Output: None
;* Description: This macro prints the given value on the console.
%macro print 1
    mov rsi, %1     ; Move the address of the message into RSI
    mov rdx, rsi    ; Copy the address to RDX for length calculation
    mov rcx, 0      ; Clear RCX, we'll use it to count the length
    %%length_calc:
        cmp byte [rdx + rcx], 0  ; Check if we've reached the null terminator
        je  %%done_length         ; If yes, jump to done
        inc rcx                   ; Otherwise, increment length counter
        jmp %%length_calc         ; Continue loop

    %%done_length:
    mov rdx, rcx    ; Length of the string
    mov rax, 1      ; Write syscall number
    mov rdi, 1      ; File descriptor 1 (stdout)
    syscall         ; Make the syscall
%endmacro

;* Macro: exit
;* Input: Exit code (status)
;* Output: None
;* Description: This macro will exit the program with the provided status code.
%macro exit 1
    mov rax, 60 ; Exit syscall number
    mov rdi, %1 ; Status code to be returned
    syscall     ; Make the syscall
%endmacro
