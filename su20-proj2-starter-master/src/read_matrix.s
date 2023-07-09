#define file_r 0
#define file_w 1
#define file_a 2

.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
#
# If you receive an fopen error or eof, 
# this function exits with error code 50.
# If you receive an fread error or eof,
# this function exits with error code 51.
# If you receive an fclose error or eof,
# this function exits with error code 52.
# ==============================================================================
read_matrix:
    # Prologue
    addi sp sp -36
    sw ra 0(sp)
    sw s0 4(sp)  # a0
    sw s1 8(sp)  # a1
    sw s2 12(sp) # a2
    sw s3 16(sp) # file descriptor
    sw s4 20(sp) # const int -1
    sw s5 24(sp) # the total of bytes
    sw s6 28(sp) # i = 0
    sw s7 32(sp) # the pointer to the matrix

    mv s0 a0  # the pointer to filepath
    mv s1 a1  # point to rows 
    mv s2 a2  # point to cols

    # open file
    mv a1 s0
    li a2 file_r
    jal ra fopen
    beq a0 s4 exit_50
    mv s3 a0

    # read file
    # load the # of rows
    mv a1 s3
    mv a2 s1
    li a3 4
    jal ra fread
    li t0 4
    bne a0 t0 exit_51
    # load the # of cols
    mv a1 s3
    mv a2 s2
    li a3 4
    jal ra fread
    li t0 4
    bne a0 t0 exit_51

    # calculate the number of size to allocate
    lw t0 0(s1)  # t0 = rows
    lw t1 0(s2)  # t1 = cols
    mul s5 t0 t1 # s5 = rows * cols
    slli t0 s5 2
    mv a0 t0
    jal ra malloc
    mv s7 a0     # s7 pointe to the malloced memory

    li s6 0
for:
    bge s6 s5 for_done  # if i >= rows * cols then: for_done
    mv a1 s3
    mv a2 s7
    li a3 4
    jal ra fread
    li t0 4
    bne a0 t0 exit_51
    addi s6 s6 1
    addi s7 s7 4
    j for

for_done:
    
    # close file
    mv a1 s3
    jal ra fclose

    # set reture value
    slli t0 s5 2
    neg t0 t0
    
    add a0 s7 t0 

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

exit_50:
    li a1 50
    j exit2

exit_51:
    li a1 51
    j exit2

exit_52:
    li a1 52
    j exit2
