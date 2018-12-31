# as template for baby os developement
.intel_syntax noprefix
.code16
.global _start
_start:
#code starts here

#include files here

#end code
end:
jmp	end
.fill 510-(.-_start)
.word 0x55AA
