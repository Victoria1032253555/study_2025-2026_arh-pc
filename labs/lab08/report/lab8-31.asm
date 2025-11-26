%include 'in_out.asm'
SECTION .data
msg db "Результат: ",0
SECTION .text
global _start
_start:
pop ecx ; Извлекаем количество аргументов
pop edx ; Извлекаем имя программы
sub ecx,1 ; Уменьшаем количество аргументов (без имени программы)
mov esi, 1 ; Используем esi для хранения произведения (начинаем с 1, а не с 0!)

cmp ecx,0h ; Проверяем, есть ли аргументы
jz _end ; Если нет аргументов - выходим

next:
pop eax ; Извлекаем следующий аргумент из стека
call atoi ; Преобразуем символ в число

; Умножаем: esi = esi * eax
imul esi, eax

loop next ; Переход к обработке следующего аргумента

_end:
mov eax, msg ; Вывод сообщения "Результат: "
call sprint
mov eax, esi ; Записываем произведение в регистр eax
call iprintLF ; Печать результата
call quit ; Завершение программы
