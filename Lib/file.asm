; Lib/file.asm
section .data

%define O_RDONLY        0x000               ; Open for reading only
%define O_WRONLY        0x001               ; Open for writing only
%define O_CREAT         0x040               ; Create file if it doesn't exist
%define S_IWUSR         0x080               ; Write permission, owner
%define S_IRUSR         0x100               ; Read permission, owner

%define SYS_READ        0
%define SYS_WRITE       1
%define SYS_OPEN        2
%define SYS_CLOSE       3
%define SYS_STAT        4
%define SYS_FSTAT       5
%define SYS_LSEEK       8
%define SYS_SENDFILE    40
%define SYS_EXIT        60
%define SYS_RENAME      82
%define SYS_UNLINK      87

%define FILE_BUFFER_SIZE 1024

section .text

; Description:      Open a file
; Preset Registers: RDI: pathname, RSI: flags, RDX: mode 
; Set Registers:    RAX: file descriptor, -1 on error
_file_open:
    mov     rax, SYS_OPEN
    syscall
    ret

; Description:      Read from an open file
; Preset Registers: RDI: file descriptor, RSI: buffer, RDX: count
; Set Registers:    RAX: number of bytes read, -1 on error
_file_read:
    mov     rax, SYS_READ
    syscall
    ret

; Description:      Write data to a file descriptor
; Preset Registers: RDI: file descriptor, RSI: buffer, RDX: length
; Set Registers:    RAX: number of bytes written, -1 on error
_file_write:
    mov     rax, SYS_WRITE
    syscall
    ret

; Description:      Close an open file
; Preset Registers: RDI: file descriptor
; Set Registers:    RAX: 0 on success, -1 on error
_file_close:
    mov     rax, SYS_CLOSE
    syscall
    ret

; Description:      Get file stat
; Preset Registers: RDI: pathname
; Set Registers:    RAX: 0 on success, -1 on error
_file_stat:
    mov     rax, SYS_STAT
    mov     rsi, file_stat_buffer
    syscall
    ret

; Description:      Get file stat
; Preset Registers: RDI: file descriptor
; Set Registers:    RAX: 0 on success, -1 on error
_file_fstat:
    mov     rax, SYS_FSTAT
    mov     rsi, file_stat_buffer
    syscall
    ret

; Description:      Move the file pointer
; Preset Registers: RDI: file descriptor, RSI: offset, RDX: whence
; Set Registers:    RAX: resulting file offset, -1 on error
_file_seek:
    mov     rax, SYS_LSEEK
    syscall
    ret

; Description:      Delete / Unlink a file
; Preset Registers: RDI: pathname
; Set Registers:    RAX: 0 on success, -1 on error
_file_unlink:
    mov     rax, SYS_UNLINK
    syscall
    ret

; Description:      Move / Rename a file
; Preset Registers: RDI: old pathname, RSI: new pathname
; Set Registers:    RAX: 0 on success, -1 on error
_file_rename:
    mov     rax, SYS_RENAME
    syscall
    ret

; Description:      Send / Copy a file
; Preset Registers: RDI: old pathname, RSI: new pathname, RDX: offset, r10: count
; Set Registers:    RAX: 0 on success, -1 on error
_file_sendfile:
    mov     rax, SYS_SENDFILE
    syscall
    ret

section .bss
    file_buffer resb 1024
    file_stat_buffer resb 144