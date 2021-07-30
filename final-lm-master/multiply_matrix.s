SECTION .text
global multiply_matrices_gas

; void multiply_matrices(int matrix_a[][n], int matrix_b[][n], int result[][n]) {
;     for (int i = 0; i < n; i++) {
;         for (int j = 0; j < n; j++) {
;             result[i][j] = 0;
;             for (int k = 0; k < n; k++)
;                 result[i][j] += matrix_a[i][k] * matrix_b[k][j];
;         }
;     }
; }

; calculates matrix offset and returns in eax
; matrix_memory_offset = (row * n + column) * 4
.macro get_offset arg1, arg2
    movl \arg1, %eax                     ; eax = row
    imul %n, %eax                     ; eax *= n
    addl \arg2, %eax                     ; eax += column
    imul $4, %eax                     ; eax *= 4 bytes
.endm


; calculates matrix offset, grab matrix[x][y] value and returns in ebx
.macro get_value_from_matrix arg1, arg2, arg3
    get_offset \arg2, \arg1
    movl \arg3, %ecx 
    movl (%ecx, %eax, 1), %ebx            ; ebx = matrix[%1][%2], obtém valor da matrix + offset (eax)
.endm

; parâmetros
;%define matrix_a        dword [ebp + 12] 12(%ebp)
;%define matrix_b        dword [ebp + 16] 16(%ebp)
;%define result_matrix   dword [ebp + 20] 20(%ebp)
;%define n               dword [ebp + 24] 24(%ebp)

; variáveis locais
;%define i               dword [ebp - 4] -4(%ebp)
;%define j               dword [ebp - 8] -8(%ebp)
;%define k               dword [ebp - 12] -12(%ebp)
;%define sum             dword [ebp - 16] -16(%ebp)
;%define aux             dword [ebp - 20] -20(%ebp)
multiply_matrices_nasm:
    pushl %ebx
    pushl %ebp
    movl %esp, %ebp                                        ; save esp

    movl 24(%ebp), %edx                                          ; n
    movw $0, -4(%ebp)                                            ; i = 0
    loop_i:
        movl -4(%ebp), %ecx
        cmpl %edx, %ecx                                    ; i >= n:
        jge end_multiply_matrices_nasm                  ;  goto end
        movw $0, -8(%ebp)                                        ; j = 0   
        loop_j:
            movl -8(%ebp), %ecx
            cmpl %edx, %ecx                                ; j >= n:
            jge end_loop_j                              ;  goto loop i
            movw $0, -16(%ebp)                                  ; sum = 0
            movw $0, -12(%ebp)                                    ; k = 0     
            loop_k:
                movl -12(%ebp), %ecx
                cmpl %edx, %ecx                            ; k >= n:
                jge end_loop_k                          ;  goto end_loop_k

                get_value_from_matrix $-4(%ebp), $-12(%ebp), $12(%ebp)    ; returns matrix_a[i][k] in ebx
                movl %ebx, -20(%ebp)                            ; save ebx in aux (stack)

                get_value_from_matrix $-12(%ebp), $-8(%ebp), $16(%ebp)    ; returns matrix_b[k][j] in ebx
                movl -20(%ebp), %ecx                            ; value obtained from matrix_a

                imul %ecx, %ebx                           ; ebx *= ecx
                addl %ebx, -16(%ebp)                            ; sum += ebx
            
                incw -12(%ebp)                                   ; k++
                jmp loop_k

                end_loop_k:
                get_offset $-4(%ebp), $-8(%ebp)                         
                movl 16(%ebp), %ecx
                movl -16(%ebp), %ebx
                movl %ebx, (%ecx, %eax, 1)                ; result[i][j] = sum
                incw -8(%ebp)                                   ; j++
                jmp loop_j
        end_loop_j:
            incw -4(%ebp)                                       ; i++
            jmp loop_i
end_multiply_matrices_nasm:
    movl %ebp, %esp                                        ; restore esp
    popl %ebp      
    popl %ebx                               
    ret    