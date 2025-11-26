%include 'in_out.asm'

SECTION .data
    prompt db 'Как Вас зовут? ', 0h
    message db 'Меня зовут ', 0h
    filename db 'name.txt', 0h

SECTION .bss
    name resb 100   ; буфер для ввода имени

SECTION .text
    global _start

_start:
    ; --- Вывод приглашения
    mov eax, prompt
    call sprint

    ; --- Ввод фамилии и имени с клавиатуры
    mov ecx, name
    mov edx, 100
    call sread

    ; --- Создание и открытие файла для записи
    mov ecx, 0x241  ; O_CREAT|O_WRONLY|O_TRUNC (создать, запись, очистить)
    mov ebx, filename
    mov eax, 5      ; sys_open
    int 80h

    ; --- Проверка успешности открытия файла
    cmp eax, -1
    jle error

    ; --- Сохранение дескриптора файла
    mov esi, eax

    ; --- Запись в файл сообщения "Меня зовут "
    mov eax, message
    call slen       ; получаем длину сообщения

    mov edx, eax    ; длина сообщения
    mov ecx, message ; указатель на сообщение
    mov ebx, esi    ; дескриптор файла
    mov eax, 4      ; sys_write
    int 80h

    ; --- Дозапись в файл введенного имени
    mov eax, name
    call slen       ; получаем длину введенного имени

    mov edx, eax    ; длина имени
    mov ecx, name   ; указатель на имя
    mov ebx, esi    ; дескриптор файла
    mov eax, 4      ; sys_write
    int 80h

    ; --- Закрытие файла
    mov ebx, esi
    mov eax, 6      ; sys_close
    int 80h

    call quit

error:
    mov eax, 'О'
    call sprint
    mov eax, 'ш'
    call sprint
    mov eax, 'и'
    call sprint
    mov eax, 'б'
    call sprint
    mov eax, 'к'
    call sprint
    mov eax, 'а'
    call sprint
    mov eax, ' '
    call sprint
    mov eax, 'с'
    call sprint
    mov eax, 'о'
    call sprint
    mov eax, 'з'
    call sprint
    mov eax, 'д'
    call sprint
    mov eax, 'а'
    call sprint
    mov eax, 'н'
    call sprint
    mov eax, 'и'
    call sprint
    mov eax, 'я'
    call sprint
    mov eax, ' '
    call sprint
    mov eax, 'ф'
    call sprint
    mov eax, 'а'
    call sprint
    mov eax, 'й'
    call sprint
    mov eax, 'л'
    call sprint
    mov eax, 'а'
    call sprint
    call quit
