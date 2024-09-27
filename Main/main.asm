; File-Name: main.asm
; Author: Dylan
; Date: 15/01/2023
; Type: 64-bit

section .bss
    int2str_buff resb 20  ; Buffer for integer to string conversion
    stat_buffer resb 144  ; Buffer to hold the stat structure (144 bytes)
    file_buffer resb 1024 ; Buffer to hold the file data
    fd resq 1             ; File descriptor
    file_size resq 1      ; File size

section .data
    %include "Libraries/Headers/lib_messages.inc"

section .text
    global _start

%include "Libraries/Text/lib_helper.asm"

_start:
    open file1
    mov [fd], rax

    convert_int_to_string rax, int2str_buff
    print message1
    print_nl int2str_buff
 
    mov rbx, [fd]
    get_file_size rbx
    mov [file_size], rdi

    convert_int_to_string rax, int2str_buff
    print message2
    print_nl int2str_buff

    read [fd], file_buffer, [file_size]
    convert_int_to_string rax, int2str_buff 

    print message3
    print_nl file_buffer

    print message4
    print_nl int2str_buff

    close [fd]
    exit 0