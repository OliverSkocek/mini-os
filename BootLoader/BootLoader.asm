; Bootloader!
;
[org 0x7C00]

[bits 16]
;16-bit code starts here
start:
mov     [BootDrive], DL

mov 	BX, boot_string                     ; print boot string
call	print16

mov     AX, 0x2401
int     0x15                                ; un fuck A20 bit

mov     AX, 0x3
int     0x10                                ; set vga text mode 3

mov     BP, 0x7FFF                          ; setup stack
mov     SP, BP

mov 	BX, kernel_message
call    print16
                                            ; load kernel from disk to 0x8000
mov     BX, 0x0800
mov     ES, BX
mov     BX, 0x0000
mov     DL, [BootDrive]
mov     DH, 16                              ; Load 16 sectors
call    CopyFromDisk16

mov     BX, kernel_complete
call    print16
                                            ; TODO check if data loaded correctly
                                            ; setup 32 bit protected mode and switch
cli
lgdt    [gdt_descriptor]
mov     EAX, CR0
or      EAX, 0x1
mov     CR0, EAX

jmp     CODE_SEG:start32                    ; cleans cache and sets CS
;mov     BX, switch32_message
;call    print16

;include 16-bit files here
%include "print16.asm"
%include "CopyFromDisk16.asm"

[bits 32]
;32-bit code starts here
start32:                                    ; Enter protected mode
mov     AX, DATA_SEG                            ; Setup Stack
mov     DS, AX
mov     SS, AX
mov     ES, AX
mov     FS, AX
mov     GS, AX

mov     EBP, 0xFFFFFF
mov     ESP, EBP

;mov     BX, switch_complete
;call    print16


;include 32-bit files here


;end code
end:
jmp	    $

;data goes here
boot_string:
db "Bootloader is starting...", 0
kernel_message:
db "Kernel is being copied...", 0
kernel_complete:
db "Kernel copied!", 0
switch32_message:
db "Switching to protected mode:", 0
switch_complete:
db "Switch is complete", 0
BootDrive:
db 0x00


gdt_descriptor:
dw gdt_end - gdt_start - 1
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

DATA_SEG equ SYSTEMDATA - gdt_start
CODE_SEG equ SYSTEMCODE - gdt_start

times 510-($-start) db 0x00
dw 0x55AA

