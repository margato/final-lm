#include <matrix.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h> 

void populate_matrix(int matrix[][n]) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) matrix[i][j] = rand() % 10;
}

void print_matrix(int matrix[][n], char *matrix_name) {
    int value;
    printf("\n______________________\n\nMatrix %s:\n", matrix_name);
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) printf("%0d ", matrix[i][j]);
        printf("\n");
    }
    printf("______________________\n\n");
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

int get_smallest_main_diagonal(int matrix[][n]) {
    int smallest = matrix[0][0];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n ; j++) {
            if (i == j && matrix[i][j] < smallest) {
                smallest = matrix[i][j];
            }
        }
    }
    return smallest;
}