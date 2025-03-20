[BITS 32]
[ORG 0x7C00]   ; Початкова адреса завантажувача (MBR)

; Завантаження у текстовий відеорежим 80x25
mov ah, 0x00      ; Сервіс BIOS для встановлення відеорежиму
mov al, 0x03      ; 80x25 текстовий режим
int 0x10          ; Викликаємо BIOS

; Виведення рядка "Hello from sleep OS"
mov esi, hello_msg
call print_string

; Завершення роботи завантажувача (переходимо в нескінченний цикл)
hang:
    jmp hang      ; Залишаємося тут, поки комп'ютер не буде вимкнений

print_string:
    ; Виведення рядка на екран
    mov ah, 0x0E  ; Функція BIOS для виведення символу
.print_char:
    lodsb         ; Завантажуємо байт з адреси DS:ESI в AL
    or al, al     ; Перевірка на кінець рядка (null-terminator)
    jz .done      ; Якщо це 0, то завершуємо виведення
    int 0x10      ; Виводимо символ
    jmp .print_char
.done:
    ret

hello_msg db 'Hello from sleep OS', 0

times 510 - ($ - $$) db 0  ; Заповнення до 510 байт (для MBR)
dw 0xAA55    ; Магічне значення для MBR
