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
/*
a1--;
if(a1 < 1) return 8;
while(a1 >= 0){
    if(*a0 < 0) *a0 = 0;
    ++a0;
    a1--;
}
*/

relu:
    # Prologue
    addi sp, sp, -16
    sw s0, 0(sp) # sp[0] = s0
    sw s1, 4(sp) # sp[1] = s1
    sw s2, 8(sp) # sp[2] = s2
    sw ra, 12(sp)

    mv s0, a0
    mv s1, a2
    li s2, -1
    li t0, 1


loop_start:
    addi s1, s1, -1
    bge x0, s1, loop_continue # if x0 >= s1 then loop_continue    
    addi a0, x0, 8 # exit with error code 8

loop_continue:
    lw t1, 0(s0)
    add a0, t1
    j max
    sw a0, 0(s0)
    addi s1, s1, -1
    addi s0, s0, 4
    beq s1, s2, loop_end

max:
    bge a0, x0, ra # if t0 >= t1 then target
    add a0, x0
    jr ra

loop_end:


    # Epilogue

    
	ret

    