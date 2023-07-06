.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================
# if(a1 < 1) exit(8);
# while(a1 != 0){
#     --a1;
#     if(*a0 < 0) *a0 = 0;
#     ++a0;
#     a1--;
# }


relu:
    # Prologue
    addi sp, sp, -16
    sw s0, 0(sp) # sp[0] = s0
    sw s1, 4(sp) # sp[1] = s1
    sw s2, 8(sp) # sp[2] = s2
    sw ra, 12(sp)

    mv s0, a0  # s0 = *arr
    mv s1, a1  # s1 = length
    li s2, 1   # s2 = 1


loop_start:
    bge s1, s2, loop_continue  # s1 >= 1
    li a1, 8 # exit with error code 8
    j exit2  # j

loop_continue:
    addi s1, s1, -1
    lw t0, 0(s0)
    mv a0, t0
    jal ra, max
    sw a0, 0(s0)
    addi s0, s0, 4
    beq s1, x0, loop_end
    j loop_continue

max:
    bge a0, x0, else # if a0 >= 0 then target
    li a0, 0
    ret
else:
    ret

loop_end:
    # Epilogue
    lw ra, 12(sp)
    lw s2, 8(sp)
    lw s1, 4(sp)
    lw s0, 0(sp)
    addi sp, sp, 16

	ret

    

