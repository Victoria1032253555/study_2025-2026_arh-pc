%include 'in_out.asm'

SECTION .data
    msg_x db "Введите x: ",0
    msg_a db "Введите a: ",0
    msg_result db "f(x) = ",0
    newline db 0xA,0
    
SECTION .bss
    x resb 10
    a resb 10
    result resb 10

SECTION .text
global _start

_start:
    ; Ввод переменной x
    mov eax, msg_x
    call sprint
    mov ecx, x
    mov edx, 10
    call sread
    mov eax, x
    call atoi
    mov [x], eax
    
    ; Ввод переменной a
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 10
    call sread
    mov eax, a
    call atoi
    mov [a], eax
    
    ; Вычисление функции f(x)
    mov eax, [x]      ; загружаем x в eax
    cmp eax, 4        ; сравниваем x с 4
    jl case_x_less    ; если x < 4, переходим к первому случаю
    
    ; Случай 2: x ≥ 4, f(x) = a*x
case_x_ge:
    mov eax, [a]      ; загружаем a
    mov ebx, [x]      ; загружаем x
    imul eax, ebx     ; eax = a * x
    jmp print_result
    
    ; Случай 1: x < 4, f(x) = x + 4
case_x_less:
    mov eax, [x]      ; загружаем x
    add eax, 4        ; eax = x + 4
    
print_result:
    ; Сохраняем результат
    mov [result], eax
    
    ; Вывод результата
    mov eax, msg_result
    call sprint
    mov eax, [result]
    call iprintLF
    
    ; Завершение программы
    call quit
