CFLAGS=-g -I ./include

main: main.o matrix.o
	$(CC) -o $@ $^ 

clean:
	$(RM) *.o main