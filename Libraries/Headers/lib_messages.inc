; SYSCALL Numbers https://filippo.io/linux-syscall-table/
sys_read     equ 0 ;
sys_write    equ 1 ;
sys_open     equ 2 ;
sys_close    equ 3 ;
sys_fstat    equ 5 ;
sys_socket   equ 41 ;
sys_sendto   equ 44 ;
sys_recvfrom equ 45 ;
sys_exit     equ 60 ;

; File Modes
stdout equ 1 ;

; Socket Constants
AF_INET equ 2 ;

; Socket Types
SOCK_RAW equ 3 ;

; Socket Protocols
IPPROTO_ICMP equ 1 ;
IPPROTO_TCP  equ 6 ;
IPPROTO_UDP  equ 17 ;

; Strings
message1: db "File Descriptor: ", 0 ;
message2: db "File Size: ", 0 ;
message3: db "File Content: ", 0 ;
message4: db "Bytes Read: ", 0 ;

msg_sock_fail: db "Socket creation failed", 0 ;
msg_sock_succ: db "Socket created successfully", 0 ;

msg_send_fail: db "Sendto failed", 0 ;
msg_send_succ: db "Sendto successful", 0 ;

msg_recv_fail: db "Recvfrom failed", 0 ;
msg_recv_succ: db "Recvfrom successful", 0 ;

new_line: db 10, 0 ;
file1: db "./test.txt", 0 ;

; Address structure
address:
    dw 2            ; AF_INET
    dw 0            ; Port number (0 for ICMP)
    db 1, 1, 1, 1   ; IP address 1.1.1.1
    dq 0            ; Padding (sin_zero)

; ICMP Packet
packet:
    db 8  ; Type: Echo request
    db 0  ; Code: 0
checksum:
    dw 0xF7FE  ; Checksum (to be calculated)
    dw 0  ; Identifier
    dw 1  ; Sequence number

; Receive buffer
recv_buffer:
    times 1024 db 0ffh

; Messages
good: db "good", 0
bad: db "bad", 0
