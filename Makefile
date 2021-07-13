CC=gcc
CFLAGS=-m32 -g -I ./include
LD=$(CC)
LDFLAGS=-m32

default:
	@echo "make: correct usage: make main"
	@exit 1

%_nasm.o:
	nasm -f elf -o multiply_matrix_nasm.o multiply_matrix.asm 
	nasm -f elf -o get_smallest_main_diagonal_nasm.o get_smallest_main_diagonal.asm 

main: main.o matrix.o multiply_matrix_nasm.o get_smallest_main_diagonal_nasm.o
	$(LD) $(LDFLAGS) -o $@ $^ 

clean:
	$(RM) *.o main