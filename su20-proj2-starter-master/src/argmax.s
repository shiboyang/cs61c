.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
#
# If the length of the vector is less than 1, 
# this function exits with error code 7.
# =================================================================
argmax:

    # Prologue
    addi sp, sp, -28
    sw ra 0(sp)  # sp[0] = ra
    sw s0 4(sp)  # sp[1] = s0
    sw s1 8(sp)  # sp[2] = s1
    sw s2 12(sp) # sp[3] = s2 store the index
    sw s3 16(sp) # sp[4] = s3 sotre the maximum.
    sw s4 20(sp) # sp[5] = s4 const int 1
    sw s5 24(sp) # sp[6] = s5 store current index

    mv s0 a0  # s0 = arr
    mv s1 a1  # s1 = length
    li s2 0   # s2 = 0
    li s3 0   # s3 = 0
    li s4 1   # s4 = 1
    li s5 0   # s5 = 0

loop_start:
    bgt s1, s4, loop_continue # if length > 1 then target
    li a1 7
    j exit2

loop_continue:
    addi s1 s1 -1  # length--
    lw t0 0(s0)       # t0 = *arr
    bgt s3 t0 then  # if maximum > t0, skip else {index = current_index, maximum = t0}
    mv s2 s5
    mv s3 t0

then:
    beq s1 x0 loop_end # if s0 == x0 then loop_end
    addi s0 s0 4
    addi s5 s5 1
    j loop_continue


loop_end:
    mv a0 s2
    # Epilogue
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    lw s5 24(sp)
    addi sp sp 28
    
    ret