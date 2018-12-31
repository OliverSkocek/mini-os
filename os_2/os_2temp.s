# as template for baby os developement
.intel_syntax noprefix
.code16
.global _start
_start:
#code starts here
mov 	AH, 0x0E
mov	BX,boot_string

mov	AL, '1'
int	0x10
mov	AL, [BX]
int	0x10

mov	AL, '2'
int	0x10
add	BX, 0x7C00
mov 	AL, [BX]
int	0x10
mov	BX, boot_string
mov	AL, '3'
int	0x10
mov	BX, 0x7C0
mov 	DS, BX
mov 	AL, [BX]
int	0x10

end:
jmp	end
#includes here:

boot_string:
.byte 'X' 
.byte 0x0
.byte 'Y'
#end code
.fill 510-(.-_start)
.word 0x55AA
