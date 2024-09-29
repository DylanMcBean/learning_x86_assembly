; Lib/file.asm
section .data

%define O_WRONLY   0x001                    ; Open for writing only
%define O_CREAT    0x040                    ; Create file if it doesn't exist
%define S_IWUSR    0x080                    ; Write permission, owner
%define S_IRUSR    0x100                    ; Read permission, owner

%define SYS_READ   0
%define SYS_WRITE  1
%define SYS_OPEN   2
%define SYS_CLOSE  3
%define SYS_LSEEK  8
%define SYS_EXIT   60

section .text

; Description:      Open a file
; Preset Registers: RDI: pathname, RSI: flags, RDX: mode 
; Set Registers:    RAX: file descriptor
file_open:
    mov     rax, SYS_OPEN
    syscall
    ret

; Description:      Read from an open file
; Preset Registers: RDI: file descriptor, RSI: buffer, RDX: count
; Set Registers:    RAX: number of bytes read
file_read:
    mov     rax, SYS_READ
    syscall
    ret

; Description:      Write data to a file descriptor
; Preset Registers: RDI: file descriptor, RSI: buffer, RDX: length
; Set Registers:    RAX: number of bytes written
file_write:
    mov     rax, SYS_WRITE
    syscall
    ret

; Description:      Close an open file
; Preset Registers: RDI: file descriptor
; Set Registers:    None
file_close:
    mov     rax, SYS_CLOSE
    syscall
    ret

; Description:      Move the file pointer
; Preset Registers: RDI: file descriptor, RSI: offset, RDX: whence
; Set Registers:    RAX: resulting file offset
file_seek:
    mov     rax, SYS_LSEEK
    syscall
    ret