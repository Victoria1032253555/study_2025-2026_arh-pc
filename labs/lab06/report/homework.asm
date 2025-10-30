%include 'in_out.asm'
SECTION .data
    div: DB 'Выражение для вычисления: y = (10x - 5)^2', 0
    msg: DB 'Введите x: ', 0
    rem: DB 'Результат вычисления равен: ', 0
    
SECTION .bss
    x resb 10           ; буфер для ввода x
 
SECTION .text
GLOBAL _start
_start:
    ; Выводим выражение для вычисления
    mov eax, div
    call sprintLF
    
    ; Выводим запрос на ввод x
    mov eax, msg
    call sprint
    
    ; Читаем значение x
    mov ecx, x
    mov edx, 10
    call sread
    
    ; Преобразуем строку в число
    mov eax, x
    call atoi           ; преобразуем в число (результат в eax)
    
    ; Вычисляем выражение (10x - 5)^2
    mov ebx, 10         ; ebx = 10
    imul ebx, eax       ; ebx = 10 * x
    sub ebx, 5          ; ebx = 10x - 5
    imul ebx, ebx       ; ebx = (10x - 5) * (10x - 5) = (10x - 5)^2
    
    ; Выводим сообщение о результате
    mov eax, rem
    call sprint
    
    ; Выводим сам результат
    mov eax, ebx
    call iprintLF
    
    ; Завершаем программу
    call quit
