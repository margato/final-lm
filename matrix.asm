SECTION .text
global multiply_matrices_nasm

; int **multiply_matrices(int **matrix_a, int **matrix_b, int **result, int n) {
;     for (int i = 0; i < n; i++) {
;         for (int j = 0; j < n; j++) {
;             result[i][j] = 0;
;             for (int k = 0; k < n; k++)
;                 result[i][j] += matrix_a[i][k] * matrix_b[k][j];
;         }
;     }
; }
multiply_matrices_nasm:
    push ebx
    push ebp
    mov ebp, esp            ; save esp

    mov eax, [ebp + 12]     ; matrix_a address
    mov ebx, [ebp + 16]     ; matrix_b address
    mov ecx, [ebp + 20]     ; result address
    mov edx, [ebp + 24]     ; n 
    imul edx, edx           ; n = n^2             

; void multiply_matrices(int matrix_a[][n], int matrix_b[][n], int result[][n]) {
;     for (int i = 0; i < n; i++) {
;         for (int j = 0; j < n; j++) {
;             result[i][j] = 0;
;             for (int k = 0; k < n; k++)
;                 result[i][j] += matrix_a[i][k] * matrix_b[k][j];
;         }
;     }
; }
    mov byte [ecx], 1
    mov byte [ecx + 4], 2
    mov byte [ecx + 8], 3
    mov byte [ecx + 12], 4

    push eax
    push ebx

    mov eax, 0                          ; i = 0
    jmp loop_i_check

    loop_i:     
        mov ebx, 0                      ; j = 0
        jmp loop_j_check
        loop_j:     
            push eax                    ; save i
            imul eax, 4                   
            mov byte [ecx + eax], 0     ; result[i] = 1
            pop eax                     ; restore i
            inc ebx
        loop_j_check:
            cmp bx, dx                  ; i < n:
            jl loop_j                   ;  goto loop
        inc eax                         ; i++
    loop_i_check:
        cmp ax, dx                      ; i < n:
        jl loop_i                       ;  goto loop
    pop ebx
    pop eax

    mov esp, ebp
    pop ebp
    pop ebx
    ret                             
