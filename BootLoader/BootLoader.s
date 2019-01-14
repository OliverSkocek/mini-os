# Bootloader
[org 0x7C00]
[bits 16]
#code starts here

mov     BX, 0x7C00                          # setup gdt_start
add     BX, gdt_start
mov     [setup_gdt_address], BX
mov 	BX, boot_string              # print boot string
call	print
                                            # load kernel from disk to 0x100000
                                            #TODO
                                            # setup 32 bit protected mode and switch
cli
lgdt    [gdt_descriptor]
mov     EAX, CR0
or      EAX, 0x1
mov     CR0, EAX

mov     AX, 0x7C00
add     AX, start32
jmp     0x08:AX

[code 32]
start32:                                    # Setup Stack


#include files here
%include "print.s"
%include "copy.s"

#end code
end:
jmp	end

#data goes here
boot_string:
db "Bootloader is starting...", 0

gdt_descriptor:
dw (offset gdt_end) - (offset gdt_start) - 1
dw 0x0000
setup_gdt_address:
dw 0x0000

gdt_start:
    NULL_Descriptor:
        dw 0x0000
        dw 0x0000
        dw 0x0000
        dw 0x0000
    CODE:
        dw 0011110100001000b
        dw 0x0000
        db 0x00
        db 10011010b
        db 11000000b
        db 0x00
    DATA:
        dw 0011110100001000b
        dw 1001000000000000b
        db 11010000b
        db 10010010b
        db 11000000b
        db 00000011b
    HEAP:
        dw 0011110100001000b
        dw 0010000000000000b
        db 10100001b
        db 10010010b
        db 11000000b
        db 00000111b
gdt_end:


#00000011110100001001000000000000b
times 510-($-_start) db 0x00
dw 0x55AA
