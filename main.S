
@ Make glibc symbols visible.
.extern printf, scanf, puts

.data
    fmt: .asciz "Loops left: %d\n"
    loop_string: .asciz "Loop it\n"
    sfmt: .asciz "%d"
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

    @ subtract out 1 
    @ so we can use 0-indexed counting
    sub r4, #1
    str r4, [r5]

@ Start of loop.
.loop:

    @ print current count
    ldr r0, =fmt
    ldr r1, [r5]
    bl printf

    @ decrement and then compare to 0
    sub r4, #1
    @ store in memory for next loop
    str r4, [r5]

    @ have we reached 0 yet?
    cmp r4, #0
    
    @ if >=0, loop again
    bge .loop
		
    b exit
