; Bootloader
[org 0x7C00]
[bits 16]
#code starts here
start:
mov     [BootDrive], DL

mov 	BX, boot_string              ; print boot string
call	print

mov     BP, 0x7FFF                          ; setup stack
mov     SP, BP

                                            ; load kernel from disk to 0x8000
mov     BX, 0x0800
mov     ES, BX
mov     BX, 0x0000
mov     DL, [BootDrive]
mov     DH, 16                              ; Load 16 sectors
call    CopyFromDisk16
                                            ; TODO check if data loaded correctly
                                            ; setup 32 bit protected mode and switch
cli
lgdt    [gdt_descriptor]
mov     EAX, CR0
or      EAX, 0x1
mov     CR0, EAX

jmp     CODE:start32


[code 32]
start32:                                    ; Enter protected mode
mov     AX, DATA                            ; Setup Stack
mov     DS, AX
mov     SS, AX
mov     ES, AX
mov     FS, AX
mov     GS, AX
mov     AX, CODE
mov     CS, AX

mov     EBP, 0b0011110100000111
mov     ESP, EBP




;include files here
%include "print16.s"
%include "CopyFromDisk16.s"

;end code
end:
jmp	end

;data goes here
boot_string:
db "Bootloader is starting...", 0
BootDrive:
bd 0x00


gdt_descriptor:
dw (offset gdt_end) - (offset gdt_start) - 1
dd gdt_start

gdt_start:
    NULL_Descriptor:
        dw 0x0000
        dw 0x0000
        dw 0x0000
        dw 0x0000
    SYSTEMCODE:
        dw 0xFFFF
        dw 0x0000
        db 0x00
        db 0b10011010
        db 0b11001111
        db 0x00
    SYSTEMDATA:
        dw 0xFFFF
        dw 0x0000
        db 0x00
        db 0b10010010
        db 0b11001111
        db 0x00
gdt_end:
db "checked!", 0

DATA_SEG equ DATA - gdt_start
CODE_SEG equ CODE - gdt_start

times 510-($-start) db 0x00
dw 0x55AA
