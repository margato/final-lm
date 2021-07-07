#include <matrix.h>
#include <stdio.h>
#include <stdlib.h>

void populate_matrix(int **matrix, int n, char *matrix_name) {
    int value;
    printf("\nInsira os valores para a matrix %s\n", matrix_name);
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

int **multiply_matrices(int **matrix_a, int **matrix_b, int n) {
    int **result = create_matrix(n);
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            result[i][j] = 0;
            for (int k = 0; k < n; k++)
                result[i][j] += matrix_a[i][k] * matrix_b[k][j];
        }
    }
    return result;
}