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

    # Prologue
    addi sp sp -48
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
    sw s9 40(sp)  # pointer to m0 row data
    sw s10 44(sp) # pointer to m1 col data


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

exit4:
    li a0 4
    j exit2


# int dot(int*, int*, int length, int stride1, int stride2);
# void matmul(int* m0, int m0_rows, int m0_cols, int* m1, int m1_rows, int m1_cols, int* d){
#       for (int i=0; i<m0_rows; ++i){
#           t0 = m0 + i * m0_cols;
#           for (int j = 0; j<m1_rows; ++j){
#               t1 = m1 + j; 
#               d[i*m0_cols + j] = dot(t0, t1, m0_rows, 1, m1_cols);
#           }
#       }            
# }

outer_loop_start:
    bge s7 s1 outer_loop_end # if i >= m0_rows then outer_loop_end
    mul t0 s7 s2  # t0 = i * m0_cols 
    slli t0 t0 2  # t0 = t0 * 4
    add s9 s0 t0  # s9 = arr1 + t0

    li s8 0       # j = 0
inner_loop_start:
    bge s8 s5 inner_loop_end  # j >= m1_cols then inner_loop_end
    slli t0 s8 2   # t0 = j * 4
    add s10 s3 t0  # s10 = arr2 + t0
    
    mv a0 s9  # m0
    mv a1 s10  # m1
    mv a2 s2  # length
    li a3 1   # stride1
    mv a4 s5  # stride2

    jal ra dot
    sw a0 0(s6)
    addi s6 s6 4

    addi s8 s8 1  # j++
    j inner_loop_start

inner_loop_end:
    addi s7 s7 1  # i++
    j outer_loop_start


outer_loop_end:

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
    lw s8 36(sp) 
    lw s9 40(sp)
    lw s10 44(sp)   
    addi sp sp 48
    
    ret