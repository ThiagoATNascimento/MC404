calculadora.s: calculadora.c
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax calculadora.c -S -o calculadora.s

calculadora.o: calculadora.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax calculadora.s -c -o calculadora.o

calculadora.x: file1.o calculadora.o
	ld.lld file1.o calculadora.o -o calculadora.x