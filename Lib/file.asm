; Lib/file.asm
section .data

%define O_RDONLY   0x000                    ; Open for reading only
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
%define SYS_RENAME 82
%define SYS_UNLINK 87

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

; Description:      Copy a file
; Preset Registers: RDI: old pathname, RSI: new pathname
; Set Registers:    RAX: 0 on success, -1 on error
_file_copy:
    ; open source file in read oonly mode
    ; create destination file in write only mode
    ; read <buffer_size> from source file too buffer
    ; check if read was successful
    ;     success: push result too stack (needed for later)
    ;     error: break
    ; write buffer<result> to destination file
    ; pop result from read, check if size of buffer
    ;   if not equal to buffer_size && not negative, we have read all of file
    ;   if equal to buffer_size, still more of file to read, loop back too read
    ; close source file
    ; close destination file

    ; open source file
    push   rsi ; save destination file path
    mov    rsi, O_RDONLY
    call   _file_open
    mov    r8, rax ; save source file descriptor

    ; create destination file
    pop    rdi ; restore destination file path
    mov    rsi, O_CREAT | O_WRONLY
    mov    rdx, S_IRUSR | S_IWUSR
    call   _file_open
    mov    r9, rax ; save destination file descriptor

_file_copy_loop:
    ; read from source file
    mov    rdi, r8 ; source file descriptor
    mov    rsi, file_buffer
    mov    rdx, FILE_BUFFER_SIZE
    call   _file_read
    ; skip error checkign just now ;)
    push   rax ; save result of read

    ; write to destination file
    mov    rdi, r9 ; destination file descriptor
    mov    rsi, file_buffer
    mov    rdx, rax ; number of bytes read
    call   _file_write

    ; check if we have read all of the file
    pop    rax ; restore result of read
    cmp    rax, FILE_BUFFER_SIZE
    je     _file_copy_loop

    ; close files
    mov    rdi, r8
    call   _file_close

    mov    rdi, r9
    call   _file_close

    ret

section .bss
    file_buffer resb 1024