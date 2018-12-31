# as template for baby os developement
.intel_syntax noprefix
.code16
.global _start
_start:
#code starts here

mov 	BX, offset here
call	print

here:
.string	"zu mami os"

#include files here
.include "print.s"

#end code
end:
jmp	end
.fill 510-(.-_start)
.word 0x55AA
