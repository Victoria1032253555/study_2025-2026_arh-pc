%include 'in_out.asm'
SECTION .data
msg db "Результат: ",0
error_msg db "Ошибка: недостаточно аргументов",0
SECTION .text
global _start

; Функция f(x) = 30x - 11
; Вход: eax = x
; Выход: eax = 30*x - 11
f:
    push ebx
    mov ebx, 30    ; ebx = 30
    imul ebx       ; eax = eax * 30 (теперь в eax результат)
    sub eax, 11    ; eax = eax - 11
    pop ebx
    ret

_start:
    pop ecx        ; Извлекаем количество аргументов
    pop edx        ; Извлекаем имя программы
    
    sub ecx, 1     ; Уменьшаем количество аргументов (без имени программы)
    jnz continue   ; Если есть аргументы, продолжаем
    
    ; Если аргументов нет
    mov eax, error_msg
    call sprintLF
    call quit
    
continue:
    mov esi, 0     ; Используем esi для хранения суммы (esi = 0)

next:
    pop eax        ; Извлекаем следующий аргумент из стека
    call atoi      ; Преобразуем символ в число (результат в eax)
    
    call f         ; Вычисляем f(x) = 30*x - 11
    
    add esi, eax   ; Добавляем результат к сумме (esi = esi + f(x))
    
    loop next      ; Переход к обработке следующего аргумента

_end:
    mov eax, msg   ; Вывод сообщения "Результат: "
    call sprint
    mov eax, esi   ; Записываем сумму в регистр eax
    call iprintLF  ; Печать результата
    call quit      ; Завершение программы
