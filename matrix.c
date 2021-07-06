#include <stdio.h>
#include <stdlib.h>
#include <matrix.h>

void populate_matrix(int **matrix, int n, char *matrix_name) {
    int value;
    printf("Insira os valores para a matrix %s\n", matrix_name);
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("Matrix %s [%d][%d]: ", matrix_name, i, j);
            scanf("%d", &value);
            matrix[i][j] = value;
        }
    }
}

void print_matrix(int **matrix, int n, char *matrix_name) {
    int value;
    printf("\nMatrix %s:\n", matrix_name);
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) printf("%d ", matrix[i][j]);
        printf("\n");
    }
    printf("\n");
}

int **create_matrix(int n) {
    int **matrix = malloc(sizeof(int *) * n);
    for (int i = 0; i < n; i++) matrix[i] = malloc(sizeof(int) * n);
    return matrix;
}