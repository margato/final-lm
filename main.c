#include <matrix.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void ask_n(int *n) {
    scanf("%d", n);
    if (*n < 1) {
        printf("Valor inválido: %d\n", *n);
        exit(-1);
    }
}

void print_elapsed_time(clock_t time) {
    printf("\nTempo gasto: %0.5f ms\n", ((double)time) / CLOCKS_PER_SEC * 1000);
}

/**
 * Prints A x B x C and elapsed time using C language
 */
void calculate_matrix_c(int **matrix_a, int **matrix_b, int **matrix_c, int n) {
    clock_t elapsed_time = clock();

    int **result = multiply_matrices(multiply_matrices(matrix_a, matrix_b, n), matrix_c, n);
    
    elapsed_time = clock() - elapsed_time;
    print_elapsed_time(elapsed_time);

    print_matrix(result, n, "A x B x C");
    free(result);
}

int main() {
    int n;
    printf("Digite o tamanho da matriz NxN: ");
    ask_n(&n);

    int **matrix_a = create_matrix(n);
    int **matrix_b = create_matrix(n);
    int **matrix_c = create_matrix(n);

    populate_matrix(matrix_a, n, "A");
    populate_matrix(matrix_b, n, "B");
    populate_matrix(matrix_c, n, "C");

    calculate_matrix_c(matrix_a, matrix_b, matrix_c, n);
}