#include <matrix.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void populate_matrix(int matrix[][n]) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) {
            matrix[i][j] = rand() % 100;
        }
}

void print_matrix(int matrix[][n], char *matrix_name) {
    int value;
    printf("\n==========================\nMatrix %s:\n", matrix_name);
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) printf("%d ", matrix[i][j]);
        printf("\n");
    }
    printf("\n");
}

void multiply_matrices(int matrix_a[][n], int matrix_b[][n], int result[][n]) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            result[i][j] = 0;
            for (int k = 0; k < n; k++)
                result[i][j] += matrix_a[i][k] * matrix_b[k][j];
        }
    }
}