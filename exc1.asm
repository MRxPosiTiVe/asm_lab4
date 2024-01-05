.ORIG x3000

        LEA R0, HELLO_STR    ; Загрузка эффективного адреса строки в R0
        PUTS                 ; Вывод строки
        HALT                 ; Остановка программы

        HELLO_STR .STRINGZ "Hello, World!" ; Строка "Hello, World!" с нулевым завершением

        .END
