CC=gcc
CFLAGS=-m32 -g -I ./include
LD=$(CC)
LDFLAGS=-m32

matrix_assembly_nasm.o:
	nasm -f elf -o matrix_assembly_nasm.o matrix.asm

main: main.o matrix.o matrix_assembly_nasm.o
	$(LD) $(LDFLAGS) -o $@ $^ 

clean:
	$(RM) *.o main