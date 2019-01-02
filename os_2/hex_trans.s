# transform byte into hex
# input: DL
# output: DH,DL
hex_trans:
mov 	DH, DL
and	DH, 0xF0
and	DL, 0x0F
shr	DH, 4

mov 	AL, DL
call	g0	
mov	DL, AL
mov	AL, DH
call	g0
mov	DH, AL
ret

g0:
cmp 	AL, 0x09
jle	g1
jg	g2  			

g1:
add	AL, 0x30 
ret

g2:
sub	AL, 0x0A
add	AL, 0x41
ret
