#pragma once

void populate_matrix(int **matrix, int n, char *matrix_name);
void print_matrix(int **matrix, int n, char *matrix_name);
int **create_matrix(int n);
int **multiply_matrices(int **matrix_a, int **matrix_b, int n);