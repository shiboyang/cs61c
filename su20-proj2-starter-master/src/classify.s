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
    li t0 4
    bne a0 t0 exit_49

    addi sp sp ?
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)

    sw s4 20(sp)
    sw s5 24(sp)

    sw s6 28(sp)
    sw s7 32(sp)


    addi a1 a1 4
    lw s0 a1  # s0 = argv[1] m0 file path
    addi a1 a1 4
    lw s1 a1  # s1 = argv[2] m1 file path
    addi a1 a1 4
    lw s2 a1  # s2 = argv[3] input file path
    addi a1 a1 4
    lw s3 a1  # s3 = argv[4] output file path

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
    mv s8 a0  # used to m1 rows and cols

    mv a0 s2
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
    mv a0 s5
    lw a1 0(s4)
    lw a2 4(s4)

    mv a3 s9
    lw a4 0(s8)
    lw a5 4(s8)

    mul t0 a1 a5  # calculate the number of element of d
    mv a0 t0
    jal ra malloc
    mv s10 a0    # pointer to d
    mv a6 s10 
    jal ra matmul # *s10 = mutmul(m0, inplut)

    # relu
    mv a0 s10
    lw t0 0(s4)
    lw t1 4(s8)
    mul a1 t0 t1
    jal ra relu

    # m1 @ relu(d)
    mv a0 s7
    lw a1 0(s6)
    lw a2 4(s6)

    mv a3 s10
    lw a4 0(s4)
    lw a5 4(s8)

    mul t0 a1 a5  # calculate the number of element of d
    mv a0 t0
    jal ra malloc
    mv s11 a0    # pointer to d
    mv a6 s11 
    jal ra matmul # *s11 = mutmul(m1, relu(d))


    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix





    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax




    # Print classification
    



    # Print newline afterwards for clarity




    ret


exit_49:
    li a1 49
    j exit2