.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
#
# If the length of the vector is less than 1, 
# this function exits with error code 5.
# If the stride of either vector is less than 1,
# this function exits with error code 6.
# =======================================================
dot:

    # Prologue
    addi sp sp -36
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)
    sw s4 20(sp)
    sw s5 24(sp)
    sw s6 28(sp)
    sw s7 32(sp)

    mv s0 a0  # s0 = arr1
    mv s1 a1  # s1 = arr2
    mv s2 a2  # s2 = length
    mv s3 a3  # s3 = stride of arr1
    mv s4 a4  # s4 = stride of arr2
    li s5 1   # const int 1
    li s6 0   # result 
    li s7 0   # index

loop_start:
    blt s2 s5 exit5
    blt s3 s5 exit6
    blt s4 s5 exit6
    j loop_continue  # jump to continue

exit5:
    li a0 5
    j exit2
exit6:
    li a0 6
    j exit2


loop_continue:
    bge s7 s2 loop_end  # if index >= length then: loop_end
    mul t0 s7 s3   # t0 = i * stride1
    slli t0 t0 2   # t0 = t0 * 4
    add t0 s0 t0   # t0 = arr1 + t0
    lw t1 0(t0)    # t1 = *t0

    mul t0 s7 s4   # t0 = i * stride2
    slli t0 t0 2   # t0 = t0 * 4
    add t0 s1 t0   # t0 = arr2 + t0
    lw t2 0(t0)    # t2 = *t0

    mul t0 t1 t2   # t0 = t1 * t2
    add s6 s6 t0   # result += t0

    addi s7 s7 1   # index++
    j loop_continue

loop_end:
    mv a0 s6

    # Epilogue
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    lw s5 24(sp)
    lw s6 28(sp)
    lw s7 32(sp)
    addi sp sp 36
    
    ret