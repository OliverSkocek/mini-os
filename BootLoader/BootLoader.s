# Bootloader
.intel_syntax noprefix
.code16
.global _start
_start:
#code starts here

mov     BX, 0x7C00                          # setup gdt_start
add     BX, offset gdt_start
mov     [setup_gdt_address], BX
mov 	BX, offset boot_string              # print boot string
call	print
                                            # load kernel from disk to 0x100000
                                            #TODO
                                            # setup 32 bit protected mode and switch
cli
lgdt    [gdt_descriptor]
mov     EAX, CR0
or      EAX, 0x1
mov     CR0, EAX

jmp     0x08:0x100000

.code32

#include files here

#end code
end:
jmp	end

#data goes here
boot_string:
.string "Bootloader is starting..."

gdt_descriptor:
.word (offset gdt_end) - (offset gdt_start) - 1
.word 0x0000
setup_gdt_address:
.word 0x0000

gdt_start:
    NULL_Descriptor:
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
    CODE:
        .word 0011110100001000b
        .word 0x0000
        .byte 0x00
        .byte 10011010b
        .byte 11000000b
        .byte 0x00
    DATA:
        .word 0011110100001000b
        .word 1001000000000000b
        .byte 11010000b
        .byte 10010010b
        .byte 11000000b
        .byte 00000011b
    HEAP:
        .word 0011110100001000b
        .word 0010000000000000b
        .byte 10100001b
        .byte 10010010b
        .byte 11000000b
        .byte 00000111b
gdt_end:


#00000011110100001001000000000000b
.fill 510-(.-_start)
.word 0x55AA
