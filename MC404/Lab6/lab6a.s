.global _start
_start:

# Primeiro número

    li a0, 0  # file descriptor = 0 (stdin)
    la a1, input_address #  buffer to write the data
    li a2, 4  # size (reads only 4 bytes)
    li a7, 63 # syscall read (63)
    ecall

    la s0, output_address

    la t0, input_address
    li t1, 10
    li t2, 2
    li t4, 0

    # Primeiro dígito
    lbu t3, 0(t0)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    # Segundo dígito
    lbu t3, 1(t0)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    # Terceiro dígito
    lbu t3, 2(t0)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    # Quarto dígito
    lbu t3, 3(t0)
    addi t3, t3, -48
    add t4, t4, t3

    # t2 = 2, t4 = y, t5 = y/2, t6 = y/k, t1 = k+y/k

    # 1°
    div t5, t4, t2
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 2°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 3°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 4°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 5°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 6°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 7°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 8°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 9°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 10°
    div t6, t4, t5
    add t1, t5, t6
    div a3, t1, t2


    # int -> char
    li t1, 1000
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 0(s0)

    li t1, 100
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 1(s0)

    li t1, 10
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 2(s0)

    li t1, 1
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 3(s0)


    li s1, ' '
    sb s1, 4(s0)


# Segundo número

    li a0, 0  
    la a1, input_address 
    li a2, 1
    li a7, 63 
    ecall

    lb t3, 0(a1)
    li a0, 0  
    la a1, input_address 
    li a2, 4
    li a7, 63 
    ecall

    la t0, input_address
    li t1, 10
    li t2, 2
    li t4, 0

    # Primeiro dígito
    lbu t3, 0(t0)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    # Segundo dígito
    lbu t3, 1(t0)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    # Terceiro dígito
    lbu t3, 2(t0)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    # Quarto dígito
    lbu t3, 3(t0)
    addi t3, t3, -48
    add t4, t4, t3


    # 1°
    div t5, t4, t2
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 2°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 3°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 4°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 5°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 6°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 7°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 8°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 9°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 10°
    div t6, t4, t5
    add t1, t5, t6
    div a3, t1, t2

    # int -> char
    li t1, 1000
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 5(s0)

    li t1, 100
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 6(s0)

    li t1, 10
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 7(s0)

    li t1, 1
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 8(s0)

    li s1, ' '
    sb s1, 9(s0)


# Terceiro número

    li a0, 0  
    la a1, input_address 
    li a2, 1
    li a7, 63 
    ecall

    lb t3, 0(a1)
    li a0, 0  
    la a1, input_address 
    li a2, 4
    li a7, 63 
    ecall

    la t0, input_address
    li t1, 10
    li t2, 2
    li t4, 0

    # Primeiro dígito
    lbu t3, 0(t0)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    # Segundo dígito
    lbu t3, 1(t0)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    # Terceiro dígito
    lbu t3, 2(t0)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    # Quarto dígito
    lbu t3, 3(t0)
    addi t3, t3, -48
    add t4, t4, t3


    # 1°
    div t5, t4, t2
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 2°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 3°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 4°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 5°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 6°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 7°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 8°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 9°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 10°
    div t6, t4, t5
    add t1, t5, t6
    div a3, t1, t2

    # int -> char
    li t1, 1000
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 10(s0)

    li t1, 100
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 11(s0)

    li t1, 10
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 12(s0)

    li t1, 1
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 13(s0)

    li s1, ' '
    sb s1, 14(s0)


# Quarto número

li a0, 0  
    la a1, input_address 
    li a2, 1
    li a7, 63 
    ecall

    lb t3, 0(a1)
    li a0, 0  
    la a1, input_address 
    li a2, 4
    li a7, 63 
    ecall

    la t0, input_address
    li t1, 10
    li t2, 2
    li t4, 0

    # Primeiro dígito
    lbu t3, 0(t0)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    # Segundo dígito
    lbu t3, 1(t0)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    # Terceiro dígito
    lbu t3, 2(t0)
    addi t3, t3, -48
    add t4, t4, t3
    mul t4, t4, t1

    # Quarto dígito
    lbu t3, 3(t0)
    addi t3, t3, -48
    add t4, t4, t3


    # 1°
    div t5, t4, t2
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 2°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 3°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 4°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 5°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 6°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 7°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 8°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 9°
    div t6, t4, t5
    add t1, t5, t6
    div t5, t1, t2

    # 10°
    div t6, t4, t5
    add t1, t5, t6
    div a3, t1, t2

    # int -> char
    li t1, 1000
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 15(s0)

    li t1, 100
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 16(s0)

    li t1, 10
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 17(s0)

    li t1, 1
    div t2, a3, t1
    mul t3, t2, t1
    sub a3, a3, t3
    addi t2, t2, 48
    sb t2, 18(s0)

    li s1, '\n'
    sb s1, 19(s0)


# Print
    li a0, 1                # file descriptor = 1 (stdout)
    la a1, output_address   # buffer
    li a2, 20               # size
    li a7, 64               # syscall write (64)
    ecall

.data

output_address: .skip 0x14
input_address: .skip 0x10 