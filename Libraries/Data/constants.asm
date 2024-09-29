; File: Libraries/Data/constants.asm
section .data

; System call constants
SYS_READ    equ 0
SYS_WRITE   equ 1
SYS_OPEN    equ 2
SYS_CLOSE   equ 3
SYS_LSEEK   equ 8
SYS_SEND    equ 44
SYS_EXIT    equ 60

; File access constants
O_RDONLY    equ 0           ; Open for reading only
O_WRONLY    equ 1           ; Open for writing only
O_RDWR      equ 2           ; Open for reading and writing

; File creation and status flags
O_CREAT     equ 00000100    ; Create file if it doesn't exist
O_EXCL      equ 00000200    ; Fail if file already exists
O_NOCTTY    equ 00000400    ; Don't assign controlling terminal
O_TRUNC     equ 00001000    ; Truncate file to length 0
O_APPEND    equ 00002000    ; Append to file
O_NONBLOCK  equ 00004000    ; Non-blocking I/O
O_DSYNC     equ 00010000    ; Write data to disk before returning
O_ASYNC     equ 00020000    ; Asynchronous I/O
O_SYNC      equ 00100000    ; Synchronous writes
O_DIRECTORY equ 00200000    ; Fail if not a directory
O_NOFOLLOW  equ 00400000    ; Don't follow symlinks
O_CLOEXEC   equ 02000000    ; Close file descriptor on execve
O_TMPFILE   equ 20200000    ; Create an unnamed temporary file

; File permissions
S_IXOTH     equ 0001        ; Execute by others
S_IWOTH     equ 0002        ; Write by others
S_IROTH     equ 0004        ; Read by others
S_IRWXO     equ 0007        ; All by others
S_IXGRP     equ 0010        ; Execute by group
S_IWGRP     equ 0020        ; Write by group
S_IRGRP     equ 0040        ; Read by group
S_IRWXG     equ 0070        ; All by group
S_IXUSR     equ 0100        ; Execute by owner
S_IWUSR     equ 0200        ; Write by owner
S_IRUSR     equ 0400        ; Read by owner
S_IRWXU     equ 0700        ; All by owner
S_ISVTX     equ 1000        ; Sticky bit, save swapped text
S_ISGID     equ 2000        ; Set GID
S_ISUID     equ 4000        ; Set UID

; Standard output constant
STDOUT      equ 1