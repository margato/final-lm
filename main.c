#include <assembly.h>
#include <matrix.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int n;
int show_matrix;

void ask_params() {
    printf("Digite o tamanho da matriz NxN: ");
    scanf("%d", &n);
    if (n < 1) {
        printf("Valor inválido: %d\n", n);
        exit(-1);
    }

    char should_show_matrix;
    printf("Deve mostrar matrizes? (s / n): ");
    scanf(" %c", &should_show_matrix);
    show_matrix = should_show_matrix == 's' ? 1 : 0;
    printf("\n");
}

void print_elapsed_time(char* language, clock_t time) {
    printf("Tempo gasto (%s): %f ms\n", language, ((double)time) / CLOCKS_PER_SEC * 1000);
}

/**
 * Prints A x B x C and elapsed time using C language
 */
void run_c(int matrix_a[][n], int matrix_b[][n], int matrix_c[][n]) {
    int result_a_b[n][n];
    int result_ab_c[n][n];
    int smallest;

    clock_t elapsed_time = clock();
    multiply_matrices(matrix_a, matrix_b, result_a_b);
    multiply_matrices(result_a_b, matrix_c, result_ab_c);
    smallest = get_smallest_main_diagonal(result_ab_c);
    elapsed_time = clock() - elapsed_time;

    if (show_matrix) print_matrix(result_ab_c, "A x B x C (C)");
    printf("Menor valor encontrado na diagonal principal: %d\n", smallest);
    print_elapsed_time("C", elapsed_time);
}

void to_zero(int matrix_a[][n]) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) matrix_a[i][j] = 0;
}

/**
 * Prints A x B x C and elapsed time using NASM language
 */
void run_nasm(int matrix_a[][n], int matrix_b[][n], int matrix_c[][n]) {
    int result_a_b[n][n];
    int result_ab_c[n][n];
    int smallest = -1;

    to_zero(result_a_b);
    to_zero(result_ab_c);

    clock_t elapsed_time = clock();
    multiply_matrices_nasm(matrix_a, matrix_b, result_a_b, n);
    multiply_matrices_nasm(result_a_b, matrix_c, result_ab_c, n);
    smallest = get_smallest_main_diagonal_nasm(result_ab_c, n);
    elapsed_time = clock() - elapsed_time;

    if (show_matrix) print_matrix(result_ab_c, "A x B x C (nasm)");
    printf("Menor valor encontrado na diagonal principal: %d\n", smallest);
    print_elapsed_time("nasm", elapsed_time);
}

int main(int argc, char** argv) {
    show_matrix = 0;
    if (argc == 2) {
        n = atoi(argv[1]);
    } else if (argc == 3) {
        n = atoi(argv[1]);
        show_matrix = argv[2][0] == 's' ? 1 : 0;
    } else {
        ask_params();
    }
    if (n > 645) {
        printf("Valor máximo permitido: 645");
        exit(1);
    }

    int matrix_a[n][n];
    int matrix_b[n][n];
    int matrix_c[n][n];

    srand(time(NULL));
    populate_matrix(matrix_a);
    populate_matrix(matrix_b);
    populate_matrix(matrix_c);

    if (show_matrix) {
        print_matrix(matrix_a, "A");
        print_matrix(matrix_b, "B");
        print_matrix(matrix_c, "C");
    }

    run_c(matrix_a, matrix_b, matrix_c);
    printf("\n");
    run_nasm(matrix_a, matrix_b, matrix_c);

    return 0;
}