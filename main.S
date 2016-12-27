
@ Make glibc symbols visible.
.extern printf, scanf

.data
    fmt: .asciz "Count: %d\n"
    sfmt: .asciz "%d"
    zero: .word 0
    input_val: .word 0

.text
.global main

exit:
    mov r0, #0
    mov r7, #1
    swi 0

main:

    @ read input integer from stdin
    @ r0 is the first argument.
    @ r2 is the second, up to r3
    @ additional args go on stack
    ldr r0, =sfmt
    ldr r1, =input_val
    bl scanf
			
    @ set r4 and r5 to input_val addr and value
    @ in preparation for loop
    ldr r5, =input_val
    ldr r4, [r5]

    ldr r7, =zero
    ldr r6, [r7]

@ Start of loop.
.loop:

    @ print current count
    ldr r0, =fmt
    ldr r1, [r7]
    bl printf

    @ decrement and then compare to 0
    add r6, #1
    @ store in memory for next loop
    str r6, [r7]

    @ have we reached 0 yet?
    cmp r6, r4
    
    @ if >=0, loop again
    blt .loop
		
    b exit
