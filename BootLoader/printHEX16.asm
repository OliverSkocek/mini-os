# Oliver's BIOS dependent print hex function
print_hex:

pusha
mov     CX, HexData

loop_hex:
mov 	DL, [BX]
cmp	    DL, 0x00
jne	    callhex
jmp 	prep_print

callhex:
call	hex_trans
xchg	CX, BX
mov	    [BX], DH
inc 	BX
mov	    [BX], DL
inc 	BX
xchg	CX, BX
inc	    BX
jmp	    loop_hex

prep_print:
mov 	BX, CX
call	print16
popa

print_hex_end:
ret

hex_trans:
mov 	DH, DL
and	    DH, 0xF0
and	    DL, 0x0F
shr	    DH, 4

mov 	AL, DL
call	g0
mov	    DL, AL
mov	    AL, DH
call	g0
mov	    DH, AL
ret

g0:
cmp 	AL, 0x09
jle	    g1
jg	    g2

g1:
add	    AL, 0x30
ret

g2:
sub	    AL, 0x0A
add	    AL, 0x41
ret

;DataSection
HexData:
db 0x00