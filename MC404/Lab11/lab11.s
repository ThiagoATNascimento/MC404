.global _start

_start:

# memory slot: 0xFFFF0100

li a0, 0xFFFF0100   # GPS trigger
addi a1, a0, 16     # X
addi a2, a0, 20     # Y
addi a3, a0, 24     # Z
addi a4, a0, 32     # direção da roda
addi a5, a0, 33     # direção do carro
addi a6, a0, 34     # freio de mão

li t5, 1
sb t5, (a5)

li t5, -15
sb t5, (a4)


0:
    li t5, 1
    sb t5, (a0)
    lw t1, (a1)
    # X
    li t5, 58
    blt t1, t5, 0b
    li t5, 88
    bge t1, t5, 0b
    
    # freio
    li t5, 1
    sb t5, (a6)
    li t5, 0
    sb t5, (a5)

    # Z
    lw t3, (a3)
    li t5, -34
    blt t3, t5, 0b
    li t5, -4
    bge t3, t5, 0b

    