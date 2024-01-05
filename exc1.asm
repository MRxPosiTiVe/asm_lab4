.ORIG x3000         ; Начальный адрес программы

    LEA R0, HELLO    ; Загрузить адрес строки в регистр R0
    PUTS             ; Вывести строку
    HALT             ; Остановить выполнение программы

HELLO   .STRINGZ "Hello, World!"  ; Строка Hello, World!

.END
