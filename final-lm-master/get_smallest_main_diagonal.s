SECTION .text
global get_smallest_main_diagonal_gas
; int get_smallest_main_diagonal(int matrix[][n]) {
;     int smaller = matrix[0][0];
;     for (int i = 0; i < n; i++) {
;        if (matrix[i][i] < smaller) {
;           smaller = matrix[i][i];
;        }
;     }
;     return smaller;
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
;%define matrix          dword [ebp + 12] 12(%ebp)
;%define n               dword [ebp + 16] 16(%ebp)

; variáveis locais
;%define i               dword [ebp - 4] -4(%ebp)
;%define smallest        dword [ebp - 8] -8(%ebp)

get_smallest_main_diagonal_nasm:
    pushl %ebx
    pushl %ebp
    movl %esp, %ebp                                ; save esp

    movl 16(%ebp), %edx                                  ; n
    movl 12(%ebp), %ecx
    movl (%ecx), %ecx
    movl %ecx, -8(%ebp)                          ; smallest = matrix[0][0]

    movw $0, -4(%ebp)                                   ; i = 0
    loop_i:
        movl -4(%ebp), %ecx
        cmpl %edx, %ecx                            ; i >= n:
        jge end_multiply_matrices_nasm          ;  goto end

        get_value_from_matrix $-4(%ebp), $-4(%ebp), $12(%ebp)      ; ebx = matrix[i][i]
        movl -8(%ebp), %eax                   
        cmpl %ebx, %eax                            ; smallest < matrix[i][i]
        jl inc_loop_i                           ;   goto loop_i

        movw %ebx, -8(%ebp)                       ; smallest = matrix[i][i]
    inc_loop_i:
        incw -4(%ebp)                                   ; i++
        jmp loop_i
end_multiply_matrices_nasm:                            
    movl -8(%ebp), %eax
    movl %ebp, %esp
    popl %ebp
    popl %ebx
    ret