%include 'in_out.asm'
SECTION .data
div: DB 'Результат: ',0
SECTION .text
GLOBAL _start
_start:
; ---- Вычисление выражения (3+2)*4+5
mov ebx,3
mov eax,2
add ebx,eax    ; ebx = 3+2 = 5
mov eax,ebx    ; ⬅️ ДОБАВЛЕНО: переносим сумму в eax для умножения
mov ecx,4
mul ecx        ; eax = 5*4 = 20
mov ebx,eax    ; ⬅️ ДОБАВЛЕНО: сохраняем результат умножения
add ebx,5      ; ebx = 20+5 = 25
mov edi,ebx
mov eax,div
call sprint
mov eax,edi
call iprintLF
call quit
