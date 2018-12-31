# as template for baby os developement
.intel_syntax noprefix
.code16
.global _start
_start:
mov	AH, 0x0E

mov	AL, data
int	0x10

mov	AL, [data]
int 	0x10

mov	AL, [0x7c1e]
int 	0x10

mov 	BX, data
add	BX,0x7C00
mov 	AL, [BX]
int	0x10

jump_here:
jmp	jump_here

data:
.byte 'X'
.fill 510-(.-_start)
.word 0x55AA
