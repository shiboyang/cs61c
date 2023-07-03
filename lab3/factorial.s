.globl factorial

.data
n.: word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    addi sp, sp, -8
    sw s0, 0(sp)  # store s0 registor
    sw s1, 4(sp)  # store s1 registor

    mv s0, a0
    li s1, 1
loop: 
    beq s0, x0, Exit
    mul s1, s1, s0
    addi s0, s0, -1
    j loop 
Exit:
    mv a0, s1
    
    lw s0, 0(sp)  # restore s0
    lw s1, 4(sp)  # restore s1
    addi sp, sp, 8
    jr ra







    

