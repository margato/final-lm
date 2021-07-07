#pragma once

extern int n;

void populate_matrix(int matrix[][n]);
void print_matrix(int matrix[][n], char *matrix_name);
void multiply_matrices(int matrix_a[][n], int matrix_b[][n], int result[][n]);