#include <assembly.h>
#include <matrix.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int n;

void ask_n(int *n) {
    scanf("%d", n);
    if (*n < 1) {
        printf("Valor inválido: %d\n", *n);
        exit(-1);
    }
}

void print_elapsed_time(clock_t time) {
    printf("Tempo gasto: %0.5f ms\n", ((double)time) / CLOCKS_PER_SEC * 1000);
}

/**
 * Prints A x B x C and elapsed time using C language
 */
void run_c(int matrix_a[][n], int matrix_b[][n], int matrix_c[][n]) {
    int result_a_b[n][n];
    int result_ab_c[n][n];

    clock_t elapsed_time = clock();
    multiply_matrices(matrix_a, matrix_b, result_a_b);
    multiply_matrices(result_a_b, matrix_c, result_ab_c);
    elapsed_time = clock() - elapsed_time;

    print_matrix(result_ab_c, "A x B x C (C)");
    print_elapsed_time(elapsed_time);
}

/**
 * Prints A x B x C and elapsed time using NASM language
 */
void run_nasm(int matrix_a[][n], int matrix_b[][n], int matrix_c[][n]) {
    int result_a_b[n][n];
    int result_ab_c[n][n];

    clock_t elapsed_time = clock();
    multiply_matrices_nasm(matrix_a, matrix_b, result_a_b, n);
    multiply_matrices_nasm(result_a_b, matrix_c, result_ab_c, n);
    elapsed_time = clock() - elapsed_time;

    print_matrix(result_ab_c, "A x B x C (nasm)");
    print_elapsed_time(elapsed_time);
}

int main() {
    printf("Digite o tamanho da matriz NxN: ");
    ask_n(&n);

    int matrix_a[n][n];
    int matrix_b[n][n];
    int matrix_c[n][n];

    populate_matrix(matrix_a);
    populate_matrix(matrix_b);
    populate_matrix(matrix_c);

    print_matrix(matrix_a, "A");
    print_matrix(matrix_b, "B");
    print_matrix(matrix_c, "C");

    run_c(matrix_a, matrix_b, matrix_c);
    run_nasm(matrix_a, matrix_b, matrix_c);

    return 0;
}