.global puts
.global gets
.global atoi
.global itoa
.global exit
.global linked_list_search



puts:
    addi sp, sp, -4
    sw a0, (sp)
    mv a1, a0
    0:
        li t0, 0
        lbu t1, (a1)
        beq t0, t1, 1f
            li a0, 1
            li a2, 1
            li a7, 64
            ecall
            addi a1, a1, 1
            j 0b
    1:
    li t0, '\n'
    sb t0, (a1)
    li a0, 1
    li a2, 1
    li a7, 64
    ecall
    lw a0, (sp)
    addi sp, sp, 4
    ret

gets:
    addi sp, sp, -4
    sw a0, (sp)
    mv a3, a0
    addi sp, sp, -4
    0:
        li a0, 0
        mv a1, sp
        li a2, 1
        li a7, 63
        ecall
        li t0, '\n'
        lb t1, (a1)
        beq t0, t1, 0f
            sb t1, (a3)
            addi a3, a3, 1
            j 0b
        0:
        li t0, 0
        sb t0, (a3)
        addi sp, sp, 4
        sb t0, (a3)
        lw a0, (sp)
        addi sp, sp, 4
    ret


atoi:
    li t1, 1
    mv t0, a0
    li a0, 0
    li t2, '-'
    lbu t3, (t0)
    bne t2, t3, 1f
        li t1, -1
        addi t0, t0, 1
        j 0f
    1:
    li t2, '+'
    bne t2, t3, 0f
        li t1, 1
        addi t0, t0, 1
    0:
        lbu t2, (t0)
        beq t2, zero, 0f
            addi t2, t2, -48
            mul a0, a0, t3
            add a0, a0, t2
            li t3, 10

            addi t0, t0, 1
            j 0b

    0:
    mul a0, a0, t1
    ret


itoa:
    li t1, 10
    mv t0, a1
    bne a2, t1, 0f
    # base 10
        bge a0, zero, 1f
            li t1, -1
            mul a0, a0, t1
            li t2, '-'
            sb t2, (t0)
            addi t0, t0, 1
        1:
        li t2, 0    # contador de dígitos
        mv t3, a0   # valor temporário para contar dígitos
        2:
            beq t3, zero, 2f
                div t3, t3, a2
                addi t2, t2, 1
                j 2b
        2:
        bne a0, zero, 2f
            li t2, 1
        2:
        li t3, 1
        li t4, 1
        1:
            beq t4, t2, 1f
                mul t3, t3, a2
                addi t4, t4, 1
                j 1b
        1:
        beq t3, zero, 1f
            div t2, a0, t3

            mv t4, t2
            addi t4, t4, 48
            sb t4, (t0)
            addi t0, t0, 1

            mul t2, t2, t3
            sub a0, a0, t2

            divu t3, t3, a2

            j 1b
        1:
        sb zero, (t0)
        j 4f
    0:
    # base 16
        li t2, 0
        mv t3, a0
        1:
        beq t3, zero, 1f
            div t3, t3, a2
            addi t2, t2, 1
            j 1b
        1:
        bne a0, zero, 1f
            li t2, 1
        1:

        li t3, 1
        li t4, 1
        1:
            beq t4, t2, 1f
                mul t3, t3, a2
                addi t4, t4, 1
                j 1b
        1:
        beq t3, zero, 1f
            div t2, a0, t3

            mv t4, t2
            addi t4, t4, 48
            li t5, 58
            blt t4, t5, 2f
                addi t4, t4, 7
            2:
            sb t4, (t0)
            addi t0, t0, 1

            mul t2, t2, t3
            sub a0, a0, t2

            divu t3, t3, a2

            j 1b
        1:
        sb zero, (t0)
    4:
    mv a0, a1
    ret


exit:
    li a0, 0
    li a7, 93
    ecall
    ret

linked_list_search:
    li t0, 0
    0:
        lw t1, 0(a0)
        lw t2, 4(a0)
        add t3, t1, t2
        beq a1, t3, 0f
            addi t0, t0, 1
            lw a0, 8(a0)
            bne a0, zero, 0b
                li t0, -1
    0:
    mv a0, t0
    ret