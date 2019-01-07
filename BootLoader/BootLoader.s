# Bootloader
.intel_syntax noprefix
.code16
.global _start
_start:
#code starts here

mov 	BX, offset boot_string
call	print
                                            # load kernel from disk to 0x100000
                                            #TODO
                                            # setup 32 bit protected mode and switch
cli
lgdt    [gdt_descriptor]
mov     EAX, CR0
or      EAX, 0x1
mov     CR0, EAX

.code32

#include files here

#end code
end:
jmp	end
#data goes here
gdt_descriptor:
                                            #TODO
boot_string:
.string "Bootloader is starting..."
.fill 510-(.-_start)
.word 0x55AA
