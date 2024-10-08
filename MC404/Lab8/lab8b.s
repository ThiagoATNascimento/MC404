.global _start

setPixel:
    # a0 <= coordenada X do pixel
    # a1 <= coordenada Y do pixel
    # a2 <= número da cor do pixel
    li a7, 2200
    ecall
    ret

setCanvaSize:
    # a0 <= canvas width (0 - 512)
    # a1 <= canvas height(0 - 512)
    li a7, 2201
    ecall
    ret

read: # a2 = size
    li a0, 0
    la a1, input
    li a7, 63
    ecall
    ret

_start:
# open
    la a0, input_file    # address for the file path
    li a1, 0             # flags (0: rdonly, 1: wronly, 2: rdwr)
    li a2, 0             # mode
    li a7, 1024          # syscall open
    ecall

    la a1, buffer
    li a2, 262159
    li a7, 63
    ecall
# close
    li a0, 3             # file descriptor (fd) 3
    li a7, 57            # syscall close
    ecall

# Leitura dos dados

    la a3, buffer
    addi a3, a3, 3

    
lerX:
    li t1, ' '
    lb t2, 0(a3)
    beq t1, t2, cont00
        lb t3, dimX
        li t0, 10
        mul t3, t3, t0
        addi t2, t2, -48
        add t3, t3, t2
        sb t3, dimX, t0
        addi a3, a3, 1
        addi t5, t5, 1
        j lerX
cont00:
    addi a3, a3, 1

lerY:
    li t1, '\n'
    lb t2, 0(a3)
    beq t1, t2, cont01
        lb t3, dimY
        li t0, 10
        mul t3, t3, t0
        addi t2, t2, -48
        add t3, t3, t2
        sb t3, dimY, t0
        addi a3, a3, 1
        j lerY
cont01:
    addi a3, a3, 1

    lbu a0, dimX
    lbu a1, dimY
    jal setCanvaSize


lerCor:
    li t1, '\n'
    lb t2, 0(a3)
    beq t1, t2, cont02
        lb t3, cor
        li t0, 10
        mul t3, t3, t0
        addi t2, t2, -48
        add t3, t3, t2
        sb t3, cor, t0
        addi a3, a3, 1
        j lerCor
cont02:
    addi a3, a3, 1


    lb t1, dimX
    lb t2, dimY
    mul a5, t1, t2

    li a6, 0
    li a0, 0 # posição x do pixel
    li a1, 0 # posição y do pixel

while:
    li a2, 0 # número da cor do pixel
    bge a6, a5, break

# verificação pixels da borda
    # primeira coluna
        li t0, 0
        bne a0, t0, p1
            li t1, 0
            j set
        p1:
    # última coluna
        lbu t0, dimX
        addi t0, t0, -1
        bne a0, t0, p2
            li t1, 0
            j set
        p2:

    # primeira linha
        li t0, 0
        bne a1, t0, p3
            li t1, 0
            j set
        p3:
    
    # última linha
        lbu t0, dimY
        addi t0, t0, -1
        bne a1, t0, p4
            li t1, 0
            j set
        p4:

# mudança na cor do pixel caso ele não esteja na borda
        # pixel central
        lbu t1, 0(a3)
        li t0, 8
        mul t1, t1, t0
        
    # linha de cima
        mv t0, a3
        lbu t2, dimX
        debug:
        sub t0, t0, t2

        # primeiro pixel (canto superior esquerdo)
        lbu t3, -1(t0)
        sub t1, t1, t3

        # segundo pixel (em cima)
        lbu t3, 0(t0)
        sub t1, t1, t3

        # terceiro pixel (canto superior direito)
        lbu t3, 1(t0)
        sub t1, t1, t3

    # linha do meio
        mv t0, a3

        # pixel esquerdo
        lbu t3, -1(t0)
        sub t1, t1, t3
    
        # pixel direito
        lbu t3, 1(t0)
        sub t1, t1, t3

    # linha de baixo
        mv t0, a3
        lbu t2, dimX
        add t0, t0, t2

        # primeiro pixel (canto inferior esquerdo)
        lbu t3, -1(t0)
        sub t1, t1, t3

        # segundo pixel
        lbu t3, 0(t0)
        sub t1, t1, t3

        # terceiro pixel (canto inferior direito)
        lbu t3, 1(t0)
        sub t1, t1, t3

    # se passar dos limites
        # menor que zero
        li t0, 0
        bge t1, t0, pula04
            li t1, 0
            j set
        pula04:

        # maior que 255
        li t0, 255
        blt t1, t0, set
            li t1, 255

# setando as cores dos pixels
        set:
        add a2, a2, t1
        slli a2, a2, 8
        add a2, a2, t1
        slli a2, a2, 8
        add a2, a2, t1
        slli a2, a2, 8
        
        lbu t2, cor
        add a2, a2, t2
        addi a3, a3, 1

        jal setPixel

        addi a0, a0, 1
        lb t1, dimX
        blt a0, t1, pula03
            li a0, 0
            addi a1, a1, 1
        pula03:
    j while
break:

# end
li a0, 0
li a7, 93 
ecall     


.data

input_file: .asciz "image.pgm"
buffer: .skip 0x4000F
input: .skip 0x4

.bss

cor: .skip 0x4
dimX: .skip 0x4
dimY: .skip 0x4
X: .skip 0x4
Y: .skip 0x4