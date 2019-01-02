#basic input output routines

scanf:
mov 	AH, 0x00
int 	0x16
mov	[key], AL
mov 	AH, 0x0E
int	0x10
jmp scanf
