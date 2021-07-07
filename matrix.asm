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
    ; init
	; push ebx			
	; push ebp			
	; mov	ebp, esp		
	; mov	eax, [ebp + 12] 	; eax = matriz_a
	; mov	ebx, [ebp + 16]	    ; ebx = matriz_b
	; mov	edi, [ebp + 20]	    ; edi = result
	; mov	ecx, [ebp + 24]	    ; ecx = n

    ; ; mov byte [[ecx]], 1

	; pop eax						
	; mov esp, ebp					
	; pop ebp						
	; pop ebx						
	ret								
