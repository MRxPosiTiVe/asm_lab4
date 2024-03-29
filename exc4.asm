.ORIG x3000

        ; Инициализация
        LD R2, INIT           ; Загрузка начального значения счетчика в R2
        LEA R1, BUFFER        ; Загрузка адреса буфера ввода в R1
        LD R4, ASCII_ZERO     ; Загрузка ASCII-кода символа '0' в R4
        LD R5, NEG_ASCII_ZERO ; Загрузка отрицательного ASCII-кода символа '0' в R5

        LEA R0, INPUT_PROMPT  ; Загрузка адреса строки приглашения ввода в R0
        PUTS                  ; Вывод строки приглашения

        ; Ввод данных
        READ_LOOP
        GETC                ; Считывание символа с консоли
        OUT                 ; Вывод символа на консоль

        ADD R3, R0, #-10     ; Проверка на символ новой строки
        BRz CONVERT          ; Переход к конвертации, если достигнут конец строки
        STR R0, R1, #0       ; Сохранение символа в буфер
        ADD R1, R1, #1
        BRnzp READ_LOOP

        ; Конвертация строки в числа
        CONVERT
        LEA R1, BUFFER       ; Адрес начала буфера
        LEA R6, ARRAY        ; Адрес начала массива чисел
        LD R2, INIT          ; Сброс счетчика

        CONVERT_LOOP
        LDR R0, R1, #0       ; Загрузка текущего символа из буфера
        ADD R0, R0, R5       ; Преобразование символа в число
        STR R0, R6, #0       ; Сохранение числа в массиве
        ADD R1, R1, #1
        ADD R6, R6, #1
        ADD R2, R2, #1
        ADD R3, R2, #-10
        BRz BUBBLE_SORT
        BRnzp CONVERT_LOOP

        ; Сортировка пузырьком
        BUBBLE_SORT
        LD R6, ARRAY_LEN     ; Загрузка длины массива в R6
        ADD R4, R6, #0       ; Копирование длины массива в R4

        OUTER_LOOP
        ADD R4, R4, #-1      ; Уменьшение R4 на 1
        BRz OUTPUT_LOOP      ; Если R4 = 0, массив отсортирован
        LEA R3, ARRAY        ; Указатель на начало массива
        ADD R5, R4, #0       ; Копирование R4 в R5

        INNER_LOOP
        LDR R0, R3, #0       ; Загрузка текущего элемента
        LDR R1, R3, #1       ; Загрузка следующего элемента
        NOT R2, R1
        ADD R2, R2, #1
        ADD R2, R0, R2       ; R2 = R0 - R1
        BRN SWAP             ; Если R0 > R1, меняем местами
        SKIP_SWAP
        ADD R3, R3, #1       ; Переход к следующему элементу
        ADD R5, R5, #-1      ; Уменьшение счетчика
        BRp INNER_LOOP       ; Повторение внутреннего цикла, если не все элементы проверены
        BRnzp OUTER_LOOP     ; Повторение внешнего цикла, если не все элементы отсортированы

        SWAP
        STR R1, R3, #0       ; Меняем элементы местами
        STR R0, R3, #1
        BRnzp SKIP_SWAP

        ; Вывод данных
        OUTPUT_LOOP
        LEA R1, ARRAY        ; Перезагрузка адреса начала массива
        LD R2, INIT          ; Сброс счетчика элементов

        PRINT_LOOP
        LDR R0, R1, #0       ; Загрузка элемента массива в R0
        ADD R0, R0, R4       ; Преобразование числа обратно в символ ASCII
        OUT                  ; Вывод символа
        LEA R0, NEWLINE      ; Вывод символа новой строки
        PUTS                 ; Вывод новой строки
        ADD R1, R1, #1       ; Переход к следующему элементу
        ADD R2, R2, #1
        ADD R3, R2, #-10
        BRz END
        BRnzp PRINT_LOOP

        ; Завершение программы
        END
        HALT

        ; Константы и данные
        INIT .FILL #0
        INPUT_PROMPT .STRINGZ "Enter string: "
        NEWLINE .STRINGZ "\n"
        ASCII_ZERO .FILL #48
        NEG_ASCII_ZERO .FILL #-48
        ARRAY .BLKW #10
        ARRAY_LEN .FILL #10
        BUFFER .BLKW #10

        .END