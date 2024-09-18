.global _start
 
raiz: # parâmetros em a0, retorno em a0
    li a1, 0
    li t2, 2
    mv t0, a0

    debug0:

    div a0, t0, t2
    div t6, t0, a0
    add t1, a0, t6
    div a0, t1, t2

    debug1:

    enquanto:
        li t1, 21
        li t2, 2
        bge a1, t1, cont

        # t0 = y, t1 = contador do laço
        div t6, t0, a0
        add t3, a0 , t6
        div a0, t3, t2

        debug2:

        addi a1, a1, 1
        j enquanto
    cont:

    debug3:
    ret

_start:
