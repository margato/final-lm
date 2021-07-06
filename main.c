#include <stdio.h>
#include <stdlib.h>
#include <matrix.h>

void ask_n(int *n) {
    scanf("%d", n);
    if (*n < 1) {
        printf("Valor inválido: %d\n", *n);
        exit(-1);
    }
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

    print_matrix(matrix_a, n, "A");
    print_matrix(matrix_b, n, "B");
    print_matrix(matrix_c, n, "C");
}