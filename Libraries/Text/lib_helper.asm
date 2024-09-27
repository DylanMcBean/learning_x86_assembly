; Macro: check if failed / print / exit
; Input: Message to print if failed
; Input: Message to print if not failed
; Input: Exit code
%macro fail_print_exit 2
    push rax
    test rax, rax
    jns %%no_fail
    print_nl %1
    pop rbx
    exit rbx
    %%no_fail:
    pop rax
    print_nl %2
%endmacro

; Macro: print_newline
; Input: Value to be printed
%macro print_nl 1
    print %1
    print new_line
%endmacro

; Macro: print
; Input: Value to be printed
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
    mov rdx, rcx        ; Length of the string
    mov rax, sys_write
    mov rdi, stdout
    syscall
%endmacro

; Macro: convert int to string
; Input: Integer value
; Input: Buffer to store the string
%macro convert_int_to_string 2
    mov rsi, %2     ; Move the address of the buffer into RSI
    mov rcx, 0      ; Clear RCX, we'll use it to count the length
    mov rax, %1     ; Move the integer value into RAX
    mov rbx, 10     ; Base 10 for decimal conversion

    ; Check for negative numbers
    cmp rax, 0
    jge %%convert_loop       ; If positive, jump to convert loop
    
    ; Handle negative numbers
    mov byte [rsi], '-'      ; Add the negative sign to the buffer
    inc rsi                 ; Move to the next position in the buffer
    inc rcx                 ; Increment the length counter
    neg rax                 ; Negate the number to make it positive

    %%convert_loop:
        xor rdx, rdx            ; Clear RDX for division
        div rbx                 ; Divide RAX by 10
        add dl, '0'             ; Convert remainder to ASCII
        push rdx                ; Push the remainder to the stack
        inc rcx                 ; Increment the length counter
        test rax, rax           ; Check if RAX is zero
        jnz %%convert_loop      ; If not, continue the loop

    %%pop_loop:
        pop rdx                 ; Pop the remainder from the stack
        mov [rsi], dl           ; Move the ASCII character to the buffer
        inc rsi                 ; Move to the next position in the buffer
        loop %%pop_loop         ; Continue until all characters are popped

    mov byte [rsi], 0          ; Null-terminate the string
%endmacro

; Macro: get FILE descriptor
; Input: File name
; Output: File descriptor
%macro open 1
    mov rax, sys_open
    mov rdi, %1 ; File name
    mov rsi, 0  ; Read-only mode
    syscall
%endmacro

; Macro: close FILE descriptor
; Input: File descriptor
%macro close 1
    mov rax, sys_close
    mov rdi, %1
    syscall
%endmacro

; Macro: read FILE descriptor
; Input: File descriptor
; Input: Buffer to store the data
; Input: Number of bytes to read
; Output: Number of bytes read
%macro read 3
    mov rax, sys_read
    mov rdi, %1
    mov rsi, %2
    mov rdx, %3
    syscall
%endmacro 

; Macro: get FILE size
; Input: File descriptor
; Output: File size
%macro get_file_size 1
    lea rsi, [stat_buffer]    ; Load the address of the stat structure
    mov rdi, %1               ; File descriptor
    mov rax, sys_fstat
    syscall                   ; Perform syscall
    mov rax, [rsi + 48]       ; Load the file size from offset 48 (st_size)
    mov rdi, rax              ; Move file size into RDI to return
%endmacro

; Macro: exit
; Input: Exit code (status)
%macro exit 1
    mov rax, sys_exit
    mov rdi, %1
    syscall
%endmacro