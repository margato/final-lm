SECTION .text
global get_smallest_main_diagonal_nasm
; int get_smallest_main_diagonal(int matrix[][n]) {
;     int smaller = matrix[0][0];
;     for (int i = 0; i < n; i++) {
;         for (int j = 0; j < n ; j++) {
;             if (i == j && matrix[i][j] < smaller) {
;                 smaller = matrix[i][j];
;             }
;         }
;     }
;     return smaller;
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
%define matrix          dword [ebp + 12]
%define n               dword [ebp + 16]

; variáveis locais
%define i               dword [ebp - 4]
%define j               dword [ebp - 8]
%define smallest        dword [ebp - 12]
get_smallest_main_diagonal_nasm:
    push ebx
    push ebp
    mov ebp, esp                                ; save esp

    mov edx, n                                  ; n
    mov ecx, matrix
    mov ecx, [ecx]
    mov smallest, ecx                         ; smallest = matrix[0][0]

    mov i, 0                                    ; i = 0
    loop_i:
        mov ecx, i
        cmp ecx, edx                            ; i >= n:
        jge end_multiply_matrices_nasm          ;  goto end
        mov j, -1                               ; j = 0   
        loop_j:
            inc j
            mov ecx, j
            cmp ecx, edx                        ; j >= n:
            jge end_loop_j                      ;  goto loop i
            
            mov ebx, i                          ; ebx = i
            cmp ebx, ecx                        ; i != j
            jne loop_j                          ; goto loop_j

            get_value_from_matrix i, j, matrix  ; ebx = matrix[i][j]
            mov eax, smallest                   
            cmp eax, ebx                        ; smallest < matrix[i][j]
            jl loop_j                           ;   goto loop_j

            mov smallest, ebx                   ; smallest = matrix[i][j]
            jmp loop_j                          ; goto loop_j
        end_loop_j:
            inc i                               ; i++
            jmp loop_i
end_multiply_matrices_nasm:
    mov eax, smallest
    mov esp, ebp                                ; restore esp
    pop ebp      
    pop ebx                               
    ret                             
