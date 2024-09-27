; File-Name: main.asm
; Author: Dylan
; Date: 15/01/2023
; Type: 64-bit

section .bss

section .data
    %include "Libraries/Headers/lib_messages.inc"

section .text
    global _start

%include "Libraries/Text/lib_helper.asm"

_start:
    ; Create RAW socket for ICMP
    mov rax, sys_socket
    mov rdi, AF_INET
    mov rsi, SOCK_RAW
    mov rdx, IPPROTO_ICMP
    syscall
    fail_print_exit msg_sock_fail, msg_sock_succ
    mov r12, rax ; Store socket descriptor

    ; Prepare ICMP packet
    lea rdi, [packet]    ; rdi points to the start of the packet
    mov rsi, 8           ; Packet length (8 bytes)
    call calculate_checksum

    ; Send ICMP packet
    mov rax, sys_sendto
    mov rdi, r12          ; Socket descriptor
    lea rsi, [packet]     ; Packet buffer
    mov rdx, 8            ; Packet size
    mov r10, 0            ; Flags
    lea r8, [address]     ; Destination address struct
    mov r9, 16            ; Address struct size
    syscall
    fail_print_exit msg_send_fail, msg_send_succ
    
    ; Receive ICMP packet
    mov rax, sys_recvfrom
    mov rdi, r12          ; Socket descriptor
    lea rsi, [recv_buffer] ; Buffer for incoming packet
    mov rdx, 1024         ; Buffer size
    mov r10, 0            ; Flags
    mov r8, 0             ; No address buffer
    mov r9, 0             ; No address length
    syscall
    fail_print_exit msg_send_fail, msg_send_succ

    ; Check if the reply is an ICMP echo reply
    cmp byte [recv_buffer + 20], 0 ; Check for ICMP type 0 (Echo Reply)
    jne failure

    print_nl good
    exit 0

failure:
    print_nl bad
    exit 1

calculate_checksum:
    xor rax, rax               ; Clear rax for summing
    mov rsi, rdi               ; Address of the packet
    mov rcx, 4                 ; Length of the packet in words (8 bytes / 2 bytes per word)
sum_loop:
    lodsw                      ; Load word from [rsi] into ax, increment rsi by 2
    add rax, rax               ; Add the value to the checksum
    adc rax, 0                 ; Add with carry to include any overflow
    loop sum_loop
    not rax                    ; One's complement of the calculated checksum
    mov [rsi+2], ax            ; Store the checksum in the packet
    ret