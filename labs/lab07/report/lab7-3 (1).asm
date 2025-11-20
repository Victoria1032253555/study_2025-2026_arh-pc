%include 'in_out.asm'

SECTION .data
    msg_a db "Введите a: ",0
    msg_b db "Введите b: ",0  
    msg_c db "Введите c: ",0
    msg_result db "Наименьшее число: ",0
    
SECTION .bss
    a resb 10
    b resb 10
    c resb 10
    min resb 10

SECTION .text
global _start

_start:
    ; Ввод переменной a
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 10
    call sread
    mov eax, a
    call atoi
    mov [a], eax
    
    ; Ввод переменной b
    mov eax, msg_b
    call sprint
    mov ecx, b
    mov edx, 10
    call sread
    mov eax, b
    call atoi
    mov [b], eax
    
    ; Ввод переменной c
    mov eax, msg_c
    call sprint
    mov ecx, c
    mov edx, 10
    call sread
    mov eax, c
    call atoi
    mov [c], eax
    
    ; Находим наименьшее число
    mov eax, [a]   ; предполагаем, что a - наименьшее
    
    ; Сравниваем с b
    cmp eax, [b]
    jl check_c     ; если a < b, проверяем c
    mov eax, [b]   ; иначе min = b
    
check_c:
    ; Сравниваем с c
    cmp eax, [c]
    jl print_min   ; если текущий min < c, выводим результат
    mov eax, [c]   ; иначе min = c
    
print_min:
    mov [min], eax
    
    ; Вывод результата
    mov eax, msg_result
    call sprint
    mov eax, [min]
    call iprintLF
    
    call quit
