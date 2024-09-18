.global _start
 
raiz: # parâmetros em a0, retorno em a0
    li a1, 0
    li t2, 2
    mv t0, a0

    div a0, t0, t2
    div t6, t0, a0
    add t1, a0, t6
    div a0, t1, t2


    enquanto:
        li t1, 21
        li t2, 2
        bge a1, t1, cont

        # t0 = y, t1 = contador do laço
        div t6, t0, a0
        add t3, a0 , t6
        div a0, t3, t2

        addi a1, a1, 1
        j enquanto
    cont:

    ret

read: # size em a2
    li a0, 0
    la a1, input
    li a7, 63
    ecall
    ret

write: # size em a2
    li a0, 1
    la a1, output
    li a7, 64
    ecall
    ret

charint:
    li t1, 10
    li t2, 2
    li t4, 0

    lbu t3, 1(a1)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    lbu t3, 2(a1)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    lbu t3, 3(a1)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    lbu t3, 4(a1)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    lbu t3, 0(a1)
    mv a0, t4
    li t2, 45
    bne t3, t2, pula
    li t3, -1
    mul a0, a0, t3
    pula:
    ret


ucharint:
    li t1, 10
    li t2, 2
    li t4, 0

    lbu t3, 0(a1)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    lbu t3, 1(a1)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    lbu t3, 2(a1)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    lbu t3, 3(a1)
    addi t3, t3, -48
    add a0, t4, t3

    ret


distancia: # a0 = Tr, a1 = Tx (satélite), ret em a1
    mv t0, a1
    li t1, -1
    #li t2, 0.1
    mul t0, t0, t1 # t1 = -Tx
    add a1, a0, t0 # a1 = Tr - Tx 
    #mul a1, a1, t2 # a1 = a1/10
    ret


_start:
# leitura primeira linha
    li a2, 5
    jal read
    jal charint
    sw a0, Yb, t0

    li a2, 1
    jal read

    li a2, 5
    jal read
    jal charint
    sw a0, Xc, t0

    li a2, 1
    jal read

# leitura segunda linha
    li a2, 4
    jal read
    jal ucharint
    sw a0, Da, t0

    li a2, 1
    jal read

    li a2, 4
    jal read
    jal ucharint
    sw a0, Db, t0

    li a2, 1
    jal read

    li a2, 4
    jal read
    jal ucharint
    sw a0, Dc, t0

    li a2, 1
    jal read

    li a2, 4
    jal read
    jal ucharint
    sw a0, Tr, t0
                                        # testado até aqui
# calculo da distância de cada satélite
    lw a0, Tr
    lw a1, Da
    jal distancia
    sw a1, Da, t0

    lw a0, Tr
    lw a1, Db
    jal distancia
    sw a1, Db, t0

    lw a0, Tr
    lw a1, Dc
    jal distancia
    sw a1, Dc, t0

# calculo da distância Y
    lw a1, Da
    lw a2, Db
    lw a4, Yb

    mul t0, a1, a1 # t0 = a1^2
    mul t1, a2, a2 # t1 = t1^2
    li t2, -1
    mul t1, t1, t2 # t1 *= -1
    mul t2, a4, a4 # t3 = a4^2

    add t0, t0, t1
    add t0, t0, t2
    li t2, 2
    mul t1, a4, t2
    div t1, t0, t1

    sw t1, Y, t0

# calculo da distância X
    lw a0, Da
    lw a1, Y
    li t1, -1
    mul a1, a1, t1
    add a0, a0, a1
    jal raiz
    sw a0, X, t0

# conferindo o sinal de X




.data

input: .skip 0xa
output: .skip 0xa

.bss

X: .skip 0x5
Y: .skip 0x5
Yb: .skip 0x5
Xc: .skip 0x5
Da: .skip 0x5
Db: .skip 0x5
Dc: .skip 0x5
Tr: .skip 0x5 
