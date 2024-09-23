.global _start

_start:
# primeira parte: encoding
    li a0, 0
    la a1, input1
    li a2, 5
    li a7, 63
    ecall
    mv a0, a1

    lbu a1, 0(a0)
    addi a1, a1, -48

    lbu a2, 1(a0)
    addi a2, a2, -48

    lbu a3, 2(a0)
    addi a3, a3, -48

    lbu a4, 3(a0)
    addi a4, a4, -48

    # a5 <= p1 -> d1 d2 d4
    li a5, 1
    li t0, 0
    add t0, a1, a2
    add t0, t0, a4

    li t1, 2
    bne t0, t1, pula01
        li a5, 0
    pula01:
    bne t0, x0, pula011
        li a5, 0
    pula011:

    # a6 <= p2 -> d1 d3 d4
    li a6, 1
    li t0, 0
    add t0, a1, a3
    add t0, t0, a4

    li t1, 2
    bne t0, t1, pula02
        li a6, 0
    pula02:
    bne t0, x0, pula012
        li a6, 0
    pula012:

    # a7 <= p3 -> d2 d3 d4
    li a7, 1
    li t0, 0
    add t0, a2, a3
    add t0, t0, a4

    li t1, 2
    bne t0, t1, pula03
        li a7, 0
    pula03:
    bne t0, x0, pula013
        li a7, 0
    pula013:

    # print (a5 a6 a1->a0 a7 a2 a3 a4)
    mv a0, a1
    la a1, encoded

    addi a0, a0, 48
    addi a2, a2, 48
    addi a3, a3, 48
    addi a4, a4, 48
    addi a5, a5, 48
    addi a6, a6, 48
    addi a7, a7, 48

    sb a5, 0(a1)
    sb a6, 1(a1)
    sb a0, 2(a1)
    sb a7, 3(a1)
    sb a2, 4(a1)
    sb a3, 5(a1)
    sb a4, 6(a1)
    li t0, '\n'
    sb t0, 7(a1)

    li a0, 1
    li a2, 8
    la a1, encoded
    li a7, 64
    ecall

# segunda parte: decoding

    li a0, 0
    la a1, input2
    li a2, 8
    li a7, 63
    ecall

    mv a0, a1
    la t0, decoded

    lbu a5, 0(a0)
    addi a5, a5, -48

    lbu a6, 1(a0)
    addi a6, a6, -48

    lbu a1, 2(a0)
    sb a1, 0(t0)
    addi a1, a1, -48

    lbu a7, 3(a0)
    addi a7, a7, -48

    lbu a2, 4(a0)
    sb a2, 1(t0)
    addi a2, a2, -48

    lbu a3, 5(a0)
    sb a3, 2(t0)
    addi a3, a3, -48

    lbu a4, 6(a0)
    sb a4, 3(t0)
    addi a4, a4, -48

    li t1, '\n'
    sb t1, 4(t0)

# terceira parte: verificação
    li t6, 48

    # verificação p1
    li t5, 1
    li t1, 0
    add t1, a1, a2
    add t1, t1, a4

    li t2, 2
    bne t1, t2, pula04
        li t5, 0
    pula04:
    bne t1, x0, pula041
        li t5, 0
    pula041:

    beq a5, t5, pula05
        li t6, 49
    pula05:

    # verificação p2
    li t5, 1
    li t1, 0
    add t1, a1, a3
    add t1, t1, a4

    li t2, 2
    bne t1, t2, pula06
        li t5, 0
    pula06:
    bne t1, x0, pula061
        li t5, 0
    pula061:

    beq a6, t5, pula07
        li t6, 49
    pula07:

    #verificação p3
    li t5, 1
    li t1, 0
    add t1, a2, a3
    add t1, t1, a4

    li t2, 2
    bne t1, t2, pula08
        li t5, 0
    pula08:
    bne t1, x0, pula081
        li t5, 0
    pula081:

    beq a7, t5, pula09
        li t6, 49
    pula09:

    la t3, error
    li t5, '\n'
    sb t6, 0(t3)
    sb t5, 1(t3)

    li a0, 1
    li a2, 5
    la a1, decoded
    li a7, 64
    ecall

    li a0, 1
    li a2, 2
    la a1, error
    li a7, 64
    ecall

# end
li a0, 0
li a7, 93 
ecall     

.data
input1: .skip 0x5
input2: .skip 0x8
encoded: .skip 0x8
decoded: .skip 0x5
error: .skip 0x2