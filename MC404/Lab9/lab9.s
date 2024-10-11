.global _start

_start:
# leitura do número
    li a0, 0
    la a1, input
    li a2, 6
    li a7, 63
    ecall

    li a0, 0
    li t0, '-'
    li t1, 1
    lb t2, 0(a1)
    bne t2, t0, while
        li t1, -1
        addi a1, a1, 1
    
    while:
        lb t2, 0(a1)
        li t0, '\n'
        beq t2, t0, break
            li t0, 10
            mul a0, a0, t0
            addi t2, t2, -48
            add a0, a0, t2
            addi a1, a1, 1
            j while
    break:
    mul a0, a0, t1

    la a1, head_node
    li a3, 0
    while2:
        lw t1, 0(a1)
        lw t2, 4(a1)
        add t3, t1, t2
        beq a0, t3, break2
            addi a3, a3, 1
            lw a1, 8(a1)
            bne a1, zero, while2
                li a3, -1
    break2:

    li a2, 1
    la a1, output
    bge a3, zero, cont
        li a2, 3
        li t0, '-'
        li t1, '1'
        li t2, '\n'
        sb t0, 0(a1)
        sb t1, 1(a1)
        sb t2, 2(a1)
        j print
    cont:
        li a4, 0        # marcador da ocorrência do primeiro "1"
        li t0, 1000
        div t1, a3, t0
        beq t1, zero, cont00    # pula se o n° do nó for menor que mil
            li a4, 1            # indica a ocorrência do 1
            addi a2, a2, 1      # aumenta o tamanho do print
            addi t2, t1, 48     # t1(int) -> t2(char)
            sb t2, 0(a1)        # armazenando o char
            addi a1, a1, 1      # aumenta a posição do próximo char
            mul t1, t1, t0      # \ retirando a casa
            sub a3, a3, t1      # / transformada em char
        cont00:

        li t0, 100
        div t1, a3, t0
        bne a4, zero, cont01
            beq t1, zero, cont02
                li a4, 1           # caso seja a primeira ocorrência do '1'
        cont01:
            addi a2, a2, 1      # aumenta o tamanho do print
            addi t2, t1, 48     # t1(int) -> t2(char)
            sb t2, 0(a1)        # armazenando o char
            addi a1, a1, 1      # aumenta a posição do próximo char
            mul t1, t1, t0      # \ retirando a casa
            sub a3, a3, t1      # / transformada em char
        cont02:

        li t0, 10
        div t1, a3, t0
        bne a4, zero, cont03
            beq t1, zero, cont04
                li a4, 1           # caso seja a primeira ocorrência do '1'
        cont03:
            addi a2, a2, 1      # aumenta o tamanho do print
            addi t2, t1, 48     # t1(int) -> t2(char)
            sb t2, 0(a1)        # armazenando o char
            addi a1, a1, 1      # aumenta a posição do próximo char
            mul t1, t1, t0      # \ retirando a casa
            sub a3, a3, t1      # / transformada em char
        cont04:

            addi a2, a2, 1       # aumenta o tamanho do print
            addi t2, a3, 48     # t1(int) -> t2(char)
            sb t2, 0(a1)        # armazenando o char
            addi a1, a1, 1      # aumenta a posição do próximo char

        li t2, '\n'
        sb t2, 0(a1)


    print:
    li a0, 1
    la a1, output
    li a7, 64
    ecall

# end
li a0, 0
li a7, 93
ecall

.data
input: .skip 0x8
output: .skip 0x8