.text
.global multiply_matrices_gas

# void multiply_matrices(int matrix_a[][n], int matrix_b[][n], int result[][n]) {
#     for (int i = 0; i < n; i++) {
#         for (int j = 0; j < n; j++) {
#             result[i][j] = 0;
#             for (int k = 0; k < n; k++)
#                 result[i][j] += matrix_a[i][k] * matrix_b[k][j];
#         }
#     }
# }

# calculates matrix offset and returns in eax
# matrix_memory_offset = (row * n + column) * 4
.macro get_offset i, j
    mov \i, %eax                     # eax = row
    imul 24(%ebp), %eax                     # eax *= n
    add \j, %eax                     # eax += column
    imul $4, %eax                    # eax *= 4 bytes
.endm


# # calculates matrix offset, grab matrix[x][y] value and returns in ebx
.macro get_value_from_matrix i, j, matrix
    get_offset \i, \j
    mov \matrix, %ecx
    mov (%ecx, %eax, 1), %ebx            # ebx = matrix[%1][%2], obtém valor da matrix + offset (eax)
.endm

# parâmetros
# %define matrix_a        dword [ebp + 12]
# %define matrix_b        dword [ebp + 16]
# %define result_matrix   dword [ebp + 20]
# %define n               dword [ebp + 24]

# variáveis locais
# %define i               dword [ebp - 4]
# %define j               dword [ebp - 8]
# %define k               dword [ebp - 12]
# %define sum             dword [ebp - 16]
# %define aux             dword [ebp - 20]
multiply_matrices_gas:
    push %ebx
    push %ebp
    mov %esp, %ebp                                              # save esp
    subl $20, %esp                                              # allocate 20 bytes to use as local variables

    mov 24(%ebp), %edx                                          # n
    movl $0, -4(%ebp)                                           # i = 0
    loop_i:
        mov -4(%ebp), %ecx                                      # ecx = i
        cmp %edx, %ecx                                          # i >= n:
        jge end_multiply_matrices_gas                           #  goto end
        movl $0, -8(%ebp)                                       # j = 0   
        loop_j:
            mov -8(%ebp), %ecx
            cmp %edx, %ecx                                      # j >= n:
            jge end_loop_j                                      #  goto loop i
            movl $0, -16(%ebp)                                  # sum = 0
            movl $0, -12(%ebp)                                  # k = 0 
            loop_k:
                mov -12(%ebp), %ecx
                cmp %edx, %ecx                                          # k >= n:
                jge end_loop_k                                          #  goto end_loop_k

                get_value_from_matrix -4(%ebp), -12(%ebp), 12(%ebp)     # returns matrix_a[i][k] in ebx
                mov %ebx, -20(%ebp)                                     # save ebx in aux (stack)

                get_value_from_matrix -12(%ebp), -8(%ebp), 16(%ebp)     # returns matrix_b[k][j] in ebx
                mov -20(%ebp), %ecx                                     # value obtained from matrix_a

                imul %ecx, %ebx                                         # ebx *= ecx
                add %ebx, -16(%ebp)                                     # sum += ebx
            
                incl -12(%ebp)                                          # k++
                jmp loop_k

                end_loop_k:
                get_offset -4(%ebp), -8(%ebp)                                         
                mov 20(%ebp), %ecx
                mov -16(%ebp), %ebx
                mov %ebx, (%ecx, %eax, 1)                               # result[i][j] = sum
                incl -8(%ebp)                                           # j++
                jmp loop_j
        end_loop_j:
            incl -4(%ebp)                                               # i++
            jmp loop_i
end_multiply_matrices_gas:
    mov %ebp, %esp                                                      # restore esp
    pop %ebp      
    pop %ebx                               
    ret                             
