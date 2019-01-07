# Oliver's BIOS dependent print function
# function prints string until it finds string terminus zero,
# Address of first character in string will be found in BX
print:

pusha
mov	AH, 0x0E

loop:
mov 	AL, [BX]
cmp	AL, 0x00
je	print_end
int	0x10
inc	BX
jmp	loop

print_end:
mov 	AL, 0x0A
int	0x10
mov	AL, 0x0D
int 	0x10

popa
ret
