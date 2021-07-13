SECTION .text
global multiply_matrices_nasm

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
%macro get_offset 2
    mov eax, %1                     ; eax = row
    imul eax, n                     ; eax *= n
    add eax, %2                     ; eax += column
    imul eax, 4                     ; eax *= 4 bytes
%endmacro


; calculates matrix offset, grab matrix[x][y] value and returns in ebx
%macro get_value_from_matrix 3
    get_offset %1, %2
    mov ecx, %3
    mov ebx, [ecx + eax]            ; ebx = matrix[%1][%2], obtém valor da matrix + offset (eax)
%endmacro

; parâmetros
%define matrix_a        dword [ebp + 12]
%define matrix_b        dword [ebp + 16]
%define result_matrix   dword [ebp + 20]
%define n               dword [ebp + 24]

; variáveis locais
%define i               dword [ebp - 4]
%define j               dword [ebp - 8]
%define k               dword [ebp - 12]
%define sum             dword [ebp - 16]
%define aux             dword [ebp - 20]
multiply_matrices_nasm:
    push ebx
    push ebp
    mov ebp, esp                                ; save esp

    mov edx, n                                  ; n
    mov i, 0                                    ; i = 0
    loop_i:
        mov ecx, i
        cmp ecx, edx                            ; i >= n:
        jge end_multiply_matrices_nasm          ;  goto end
        mov j, 0                                ; j = 0   
        loop_j:
            mov ecx, j
            cmp ecx, edx                                ; j >= n:
            jge end_loop_j                              ;  goto loop i
            mov sum, 0                                  ; sum = 0
            mov k, 0                                    ; k = 0     
            loop_k:
                mov ecx, k
                cmp ecx, edx                            ; k >= n:
                jge end_loop_k                          ;  goto end_loop_k

                get_value_from_matrix i, k, matrix_a    ; returns matrix_a[i][k] in ebx
                mov aux, ebx                            ; push matrix_a[i][k]

                get_value_from_matrix k, j, matrix_b    ; returns matrix_a[k][j] in ebx
                mov ecx, aux

                imul ebx, ecx                         ; ebx *= ecx
                add sum, ebx                            ; sum += ebx
            
                inc k                           ; k++
                jmp loop_k

                end_loop_k:
                get_offset i, j
                mov ecx, result_matrix
                mov ebx, sum
                mov [ecx + eax], ebx                  ; result[i][j] = sum
                inc j                                 ; j++
                jmp loop_j
        end_loop_j:
            inc i                               ; i++
            jmp loop_i
end_multiply_matrices_nasm:
    mov esp, ebp                                ; restore esp
    pop ebp      
    pop ebx                               
    ret                             
