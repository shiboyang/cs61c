.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   The order of error codes (checked from top to bottom):
#   If the dimensions of m0 do not make sense, 
#   this function exits with exit code 2.
#   If the dimensions of m1 do not make sense, 
#   this function exits with exit code 3.
#   If the dimensions don't match, 
#   this function exits with exit code 4.
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# =======================================================
matmul:

    # Error checks
    bne a2 a4 exit4  # if a2 != a4 exit(4)

    j then:

exit4:
    li a0 4
    j exit2


then:
    # Prologue
    addi sp sp -?
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)
    sw s4 20(sp)
    sw s5 24(sp)
    sw s6 28(sp)
    sw s7 32(sp)
    sw s8 36(sp)


    mv s0 a0  # s0 = arr1
    mv s1 a1  # s1 = rows of arr1
    mv s2 a2  # s2 = cols of arr1
    mv s3 a3  # s3 = arr2
    mv s4 a4  # s4 = rows of arr2
    mv s5 a5  # s5 = cols of arr2
    mv s6 a6  # s6 = d
    li s7 0   # i the rows index of d
    li s8 0   # j the cols index of d

    j outer_loop_start


# for(int i=0; i<rows; ++i){
#     
#     for(int j=0; j<cols; ++j){
#               
#    }
#}


outer_loop_start:
    bge s7 s1 outer_loop_end # if s7 >= rows then outer_loop_end
    mul t0 s7 a2  # t0 = i * cols 
    slli t0 t0 2  # t0 = t0 * 4
    add t1 t0   
    li s8 0
inner_loop_start:
    bge s8 s5 inner_loop_end
    








inner_loop_end:




outer_loop_end:


    # Epilogue
    
    
    ret