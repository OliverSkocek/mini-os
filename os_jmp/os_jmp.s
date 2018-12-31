# as template for baby os developement
.intel_syntax noprefix
.code16
.global _start
_start:
#code starts here
jmp	_start


#end code
.fill 510-(.-_start)
.word 0xAA55
