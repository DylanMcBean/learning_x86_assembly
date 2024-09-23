; File-Name: main.asm
; Author: Dylan
; Date: 15/01/2023
; Type: 64-bit

section .data
    %include "Libraries/Headers/lib_messages.inc"

section .text
    global _start

%include "Libraries/Text/lib_helper.asm"

_start:
    print message
    print message2
    exit 0