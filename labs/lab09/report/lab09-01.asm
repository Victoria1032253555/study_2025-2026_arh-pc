%include 'in_out.asm'
SECTION .data
msg: DB 'Введите x: ',0
result: DB 'f(g(x)) = 2(3x-1)+7 = ',0
SECTION .bss
x: RESB 80
res: RESB 80
SECTION .text
GLOBAL _start
_start:
;------------------------------------------
; Основная программа
;------------------------------------------
mov eax, msg
call sprint
mov ecx, x
mov edx, 80
call sread
mov eax,x
call atoi
call _calcul ; Вызов подпрограммы _calcul
mov eax,result
call sprint
mov eax,[res]
call iprintLF
call quit

;------------------------------------------
; Подпрограмма вычисления f(g(x))
; где f(x) = 2x + 7, g(x) = 3x - 1
; Вход: eax = x
; Выход: [res] = f(g(x)) = 2(3x-1)+7
_calcul:
push eax        ; Сохраняем x в стеке
call _subcalcul ; Вызываем подпрограмму для вычисления g(x)
               ; Теперь в eax = g(x) = 3x-1
mov ebx, 2
mul ebx         ; eax = 2 * g(x)
add eax, 7      ; eax = 2*g(x) + 7
mov [res], eax  ; Сохраняем результат
pop eax         ; Восстанавливаем регистр
ret

;------------------------------------------
; Подпрограмма вычисления g(x) = 3x - 1
; Вход: eax = x (через стек из _calcul)
; Выход: eax = g(x) = 3x - 1
_subcalcul:
mov ebx, 3
mul ebx         ; eax = 3 * x
sub eax, 1      ; eax = 3x - 1
ret
