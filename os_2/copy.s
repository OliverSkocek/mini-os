# copy file
# AX contains source
# BX contains target
# CX contains length
pusha
copy_loop:
mov 	DX, [AX]
inc	AX
mov	[BX], DX
inc 	BX
dec	CX
jnz copy_loop
popa
ret
