; Oliver's BIOS dependent print function
; function prints string until it finds string terminus zero,
; Address of first character in string will be found in BX
print16:

pusha
mov	AH, 0x0E

loop_print_16:
mov 	AL, [BX]
cmp	    AL, 0x00
je	    print16_end
int	    0x10
inc	    BX
jmp	    loop_print_16

print16_end:
mov 	AL, 0x0A
int	    0x10
mov	    AL, 0x0D
int 	0x10

popa
ret
