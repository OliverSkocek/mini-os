# as template for baby os developement
.intel_syntax noprefix
.code16
.global _start
_start:
#code starts here

mov 	BX, offset here
call	print

mov	BX, offset here
mov 	CX, offset data
call 	print_hex

call	scanf

jmp 	end

here:
.string	"zu mami os"

#include files here
.include "print.s"
.include "print_hex.s"
.include "hex_trans.s"
.include "io.s"
#end code
end:
jmp	end
data:
key:
.fill 510-(.-_start)
.word 0x55AA
