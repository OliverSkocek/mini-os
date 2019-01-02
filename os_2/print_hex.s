# Oliver's BIOS dependent print hex function
print_hex:

pusha

loop_hex:
mov 	DL, [BX]
cmp	DL, 0x00
jne	callhex	
jmp 	prep_print
callhex:
call	hex_trans
xchg	CX, BX
mov	[BX], DH
inc 	BX
mov	[BX], DL
inc 	BX
xchg	CX, BX
inc	BX
jmp	loop_hex
prep_print:
popa

mov 	BX, CX
call	print

print_hex_end:
ret
