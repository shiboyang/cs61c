.import ../../src/write_matrix.s
.import ../../src/utils.s

.data
m0: .word 1, 2, 3, 0, 0, 0, 7, 8, 9 # MAKE CHANGES HERE TO TEST DIFFERENT MATRICES
file_path: .asciiz "outputs/test_write_matrix/student_write_outputs.bin"

.text
main:
    # Write the matrix to a file
    la a0 file_path
    la a1 m0
    li a2 3
    li a3 3
    jal ra write_matrix


    # Exit the program
    jal exit