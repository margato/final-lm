extern int n;

extern void multiply_matrices_nasm(int matrix_a[][n], int matrix_b[][n], int result[][n], int n);
extern int get_smallest_main_diagonal_nasm(int matrix[][n], int n);

extern void multiply_matrices_gas(int matrix_a[][n], int matrix_b[][n], int result[][n], int n);
extern int get_smallest_main_diagonal_gas(int matrix[][n], int n);