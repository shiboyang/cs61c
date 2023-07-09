#define file_r 0
#define file_w 1
.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
#   If any file operation fails or doesn't write the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
#
# If you receive an fopen error or eof, 
# this function exits with error code 53.
# If you receive an fwrite error or eof,
# this function exits with error code 54.
# If you receive an fclose error or eof,
# this function exits with error code 55.
# ==============================================================================
write_matrix:

    # Prologue
    addi sp sp -40
    sw ra 0(sp)
    sw a0 4(sp)
    sw s0 8(sp)
    sw s1 12(sp)
    sw s2 16(sp)
    sw s3 20(sp)
    sw s4 24(sp)  # stroe the # of element
    sw s5 28(sp)  # const int 1
    sw s6 32(sp)  # file descriptor
    sw s7 36(sp)  # the index of i

 

    mv s0 a0  # the pointer to filepath
    mv s1 a1  # the pointer to matrix
    mv s2 s2  # rows
    mv s3 a3  # cols
    li s5 -1


    # open file
    mv a1 s0
    mv a2 file_w
    jal ra fopen
    beq a0 s5 exit_53 # if a0 == -1 then: exit_53
    mv s6 a0

    # write the rows into file
    mv a1 s6
    la a2 s2
    li a3 1
    li a4 4
    jal ra fwrite
    li t0 1
    bne a0 t0 exit_54

    # write the cols into file
    mv a1 s6
    la a2 s3
    li a3 1
    li a4 4
    jal ra fwrite
    li t0 1
    bne a0 t0 exit_54

    # write the data
    mul s4 s2 s3
    li s7 0
for:
    bge s7, s4, for_done # if i >= rows * cols then for_done
    mv a1 s6
    mv a2 s1
    li a3 1
    li a4 4
    jal ra fwrite
    li t0 1
    bne a0 t0 exit_1

    addi s7 s7 1
    addi s1 s1 4
    j for

forA_done:

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
    addi sp sp 40

    ret



exit_53:
    li a1 53
    j exit2

exit_54:
    li a1 54
    j exit2
exit_55:
    li a1 55
    j exit2

exit_1:
    li a1 1
    j exit2