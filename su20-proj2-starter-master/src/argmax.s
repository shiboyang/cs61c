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
    # arg check
    li t0 1
    blt a1, t0, exit_1 # if a1 < t0 then exit_1
    

    # Prologue
    addi sp, sp, -24
    sw ra 0(sp)  # sp[0] = ra
    sw s0 4(sp)  # sp[1] = s0
    sw s1 8(sp)  # sp[2] = s1
    sw s2 12(sp) # sp[3] = s2 store the index
    sw s3 16(sp) # sp[4] = s3 
    sw s4 20(sp) # sp[5] = s4 


    mv s0 a0  # s0 = arr
    mv s1 a1  # s1 = length
    li s2 0   # i
    li s3 0   # the index of max value
    lw s4 0(s0) # the max number

loop_start:
    bge s2 s1 loop_end  # if i >= lenght then: loop_end
    slli t0 s2 2   # t0 = i * 4
    add t0 s0 t0  # t0 = arr + t0  
    lw t0 0(t0)    # arr[i]

    bge s4 t0 skip_update # if t0 >= s3 then skip_update
    mv s3 s2
    mv s4 t0
skip_update:
    addi s2 s2 1
    j loop_start

loop_end:
    mv a0 s3
    # Epilogue
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    addi sp sp 24
    
    ret

exit_1:
    li a1 7
    j exit2