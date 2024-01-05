.ORIG x3000

        START
        LEA R0, INPUTING    ; Загрузка эффективного адреса строки INPUTING в R0
        PUTS                ; Вывод строки на консоль
        LEA R1, BUFFER      ; Загрузка эффективного адреса буфера BUFFER в R1
        ADD R2, R1, #0      ; R2 используется для перемещения по буферу

        READ
        GETC                ; Считывание символа с консоли
        OUT                 ; Вывод символа на консоль
        ADD R4, R0, #-10    ; Проверка, не является ли символ символом новой строки (ASCII-код - 10)
        BRz PRINT           ; Если да, перейти к подпрограмме PRINT
        STR R0, R2, #0      ; Сохранение считанного символа в буфере на текущей позиции
        ADD R2, R2, #1      ; Переход к следующей позиции в буфере
        BRnzp READ          ; Безусловный переход обратно к READ для продолжения считывания символов

        PRINT
        LEA R0, BUFFER      ; Загрузка эффективного адреса буфера BUFFER в R0
        PUTS                ; Вывод всей строки, хранящейся в буфере
        HALT                ; Остановка выполнения программы

        INPUTING .STRINGZ "Enter random string: " ; Строка с приглашением для ввода
        BUFFER    .BLKW  #80             ; Резервирование блока памяти для буфера в 80 слов

.END
