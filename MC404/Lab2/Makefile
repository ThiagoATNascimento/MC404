debugging_tutorial.s: debugging_tutorial.c
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax debugging_tutorial.c -S -o debugging_tutorial.s

debugging_tutorial.o: debugging_tutorial.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax debugging_tutorial.s -c -o debugging_tutorial.o

debugging_tutorial.x: file1.o debugging_tutorial.o
	ld.lld file1.o debugging_tutorial.o -o debugging_tutorial.x