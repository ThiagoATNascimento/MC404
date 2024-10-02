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
    debug:
    li a6, 0
    li a0, 0 # posição x do pixel
    li a1, 0 # posição y do pixel
while:
    li a2, 0 # número da cor do pixel
    bge a6, a5, break
        lbu t1, 0(a3)
        lbu t2, cor

        add a2, a2, t1
        slli a2, a2, 8
        add a2, a2, t1
        slli a2, a2, 8
        add a2, a2, t1
        slli a2, a2, 8
        
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
pixels: .skip 0x4

.bss

cor: .skip 0x4
dimX: .skip 0x4
dimY: .skip 0x4
X: .skip 0x4
Y: .skip 0x4