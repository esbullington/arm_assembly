
@ Make glibc symbols visible.
.extern printf, scanf, puts

.data
    msg: .asciz "Even number"
    otherwise: .asciz "Odd number"
    sfmt: .asciz "%d"
    input_val: .word 0
    two: .word 2

.text
.global main

exit:
    mov r0, #0
    mov r7, #1
    swi 0

modulus:
		@ modulus:
		@ Precondition: R0 % R1 is the required computation
		@ Postcondition: R0 has the result of R0 % R1
    push    {r4, lr}
		udiv r2, r0, r1
		mls  r0, r1, r2, r0
    pop     {r4, pc}

main:
    @ r0 is the first argument.
    @ r2 is the second, up to r3
    @ additional args go on stack
    ldr r0, =sfmt
    ldr r1, =input_val
    bl scanf

    ldr r4, =input_val
    ldr r5, =two

    ldr r0, [r4] 
		ldr r1, [r5]
		bl modulus

    cmp r0, #0
    beq .Is_even
    
    ldr r0, =otherwise
    bl puts
    b exit

.Is_even:
    ldr r0, =msg
    bl puts
    b exit
