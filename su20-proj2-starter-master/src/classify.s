.globl classify

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # 
    # If there are an incorrect number of command line args,
    # this function returns with exit code 49.
    #
    # Usage:
    #   main.s -m -1 <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>
    li t0 5
    bne a0 t0 exit_49

    # prologue
    addi sp sp -52
    sw ra 0(sp)  
    sw s0 4(sp)  # argv[1] m0 filepath
    sw s1 8(sp)  # argv[2] m1 filepath
    sw s2 12(sp) # argv[3] input filepath
    sw s3 16(sp) # argv[4] output filepath
    sw s4 20(sp) # pointer to m0 rows and cols
    sw s5 24(sp) # pointer to m0 data
    sw s6 28(sp) # pointer to m1 rows and cols
    sw s7 32(sp) # pointer to m1 data
    sw s8 36(sp) # pointer to intput rows and cols
    sw s9 40(sp) # pointer to input data
    sw s10 44(sp) # pointer to d, relu(d)
    sw s11 48(sp) # pointer to output

    lw s0 4(a1)   # s0 = argv[1] m0 file path
    lw s1 8(a1)   # s1 = argv[2] m1 file path
    lw s2 12(a1)  # s2 = argv[3] input file path
    lw s3 16(a1)  # s3 = argv[4] output file path


     # debug
    # mv a1 s0
    # jal ra print_str
    # mv a1 s1
    # jal ra print_str
    # mv a1 s2
    # jal ra print_str
    # mv a1 s3
    # jal ra print_str

	# =====================================
    # LOAD MATRICES
    # =====================================
    

    # Load pretrained m0
    li a0 8
    jal ra malloc
    mv s4 a0  # used to m0 rows and cols

    mv a0 s0
    mv a1 s4
    addi t0 a1 4
    mv a2 t0
    jal ra read_matrix
    mv s5 a0  # s5 pointer to m0


    # Load pretrained m1
    li a0 8
    jal ra malloc
    mv s6 a0  # used to m1 rows and cols

    mv a0 s1
    mv a1 s6
    addi t0 s6 4
    mv a2 t0
    jal ra read_matrix
    mv s7 a0  # pointer to m1


    # Load input matrix
    li a0 8
    jal ra malloc
    mv s8 a0  # used to inputs rows and cols

    mv a0 s2  # input filepath
    mv a1 s8
    addi t0 s8 4
    mv a2 t0
    jal ra read_matrix
    mv s9 a0  # pointer to input 



    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)

    # m0 @ input
    
    # calculate the number of element of result
    lw t0 0(s4)
    lw t1 4(s8)
    mul t0 t1 t0
    slli a0 t0 2  # num * 4  
    jal ra malloc
    mv s10 a0    # pointer to d

    mv a0 s5  # m0
    lw a1 0(s4)
    lw a2 4(s4)

    mv a3 s9  # input
    lw a4 0(s8)
    lw a5 4(s8)

    mv a6 s10 
    jal ra matmul # *s10 = mutmul(m0, inplut)

    # relu
    mv a0 s10  # d
    lw t0 0(s4)
    lw t1 4(s8)
    mul a1 t0 t1
    jal ra relu

    # m1 @ relu(d)
    # calculate the number of element of d
    lw t0 0(s6)
    lw t1 4(s8)
    mul t0 t0 t1
    slli a0 t0 2  
    jal ra malloc
    mv s11 a0    # pointer to output

    mv a0 s7  # m1
    lw a1 0(s6)
    lw a2 4(s6)

    mv a3 s10
    lw a4 0(s4)
    lw a5 4(s8)

    mv a6 s11 
    jal ra matmul # *s11 = mutmul(m1, relu(d))


    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    mv a0 s3    # output filepath 
    mv a1 s11   # pointer to array
    lw a2 0(s6) # rows
    lw a3 4(s8) # cols
    jal ra write_matrix



    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    lw t0 0(s6)
    lw t1 4(s8)
    mul t2 t0 t1
    mv a0 s11
    mv a1 t2
    jal ra argmax
    mv t0 a0


    # Print classification
    mv a1 t0
    jal ra print_int



    # Print newline afterwards for clarity
    li a1 '\n'
    jal ra print_char


    # free
    mv a0 s4
    jal ra free
    mv a0 s5
    jal ra free
    mv a0 s6
    jal ra free
    mv a0 s7
    jal ra free
    mv a0 s8 
    jal ra free
    mv a0 s9 
    jal ra free
    mv a0 s10
    jal ra free
    mv a0 s11
    jal ra free

    # epilogue
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
    lw s11 48(sp)
    addi sp sp 52

    ret


exit_49:
    li a1 49
    j exit2
