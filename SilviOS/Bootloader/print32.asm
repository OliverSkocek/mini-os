; 32-bit print function

print32:

pusha
mov	AH, 0x00

loop_print_32:
mov 	AL, [BX]
cmp	    AL, 0x00
je	    print32_end
call    display32
inc	    BX
jmp	    loop_print_32

print32_end:
mov 	AL, 0x0A
call    display32
mov	    AL, 0x0D
call    display32

popa
ret