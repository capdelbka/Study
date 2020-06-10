; Резервирoвание места под стек
sseg segment stack 'stack'
     dw 256 dup(?)
sseg ends
; Определение данных
data segment
; Сообщения пользователю
msg1 db 10,13,'SUB'
     db 10,13,'N1: ','$'
msg2 db 10,13,'N2: ','$'
msg3 db 10,13,'N1 - N2 = ','$'
data ends
; Сегмент кода
code segment
assume 	cs:code,ds:data,ss:sseg
start: 	mov ax,data ; настроить сегментный
		mov ds,ax   ; регистр DS на данные
		lea dx,msg1 ; вывести сообщение
		call print_msg
		call input_digit; ввести первое число
		mov bl,al    ; и сохранить в регистре BL
		lea dx,msg2  ; вывести сообщение
		call print_msg
		call input_digit ; ввести второе число
		lea dx,msg3      ; вывести сообщение
		call print_msg
		call add_and_show; сложить и вывести
                        ;  результат
		mov ah,4ch       ; завершить программу
		int 21h             ; и выйти в DOS
; Подпрограмма вывода сообщения на дисплей
; Вход: DS:DX - адрес сообщения
; Выход: вывод сообщения на дисплей
print_msg proc
		push ax     ; сохранить AX
		mov ah,09h ; вывести сообщение
		int 21h    ;  с помощью функции DOS
		pop ax     ; восстановить AX
		ret  ; вернуться в вызывающую программу
print_msg endp
; Подпрограмма ввода числа с клавиатуры
; Вход: набранная с клавиатуры цифра
; Выход: в AL - введенное число
input_digit proc
input_again:
		mov ah,01h  ; ввести символ с клавиатуры
		int 21h     ;  с помощью функции DOS
		cmp al,'0'  ; если символ не цифра,
		jl input_again ; то повторить ввод
		cmp al,'9'
		jg input_again
		sub al,30h; преобразовать код символа
                 ;  в число
		ret  ; вернуться в вызывающую программу
input_digit endp
; Подпрограмма сложения двух чисел
;Вход: AL,BL – слагаемые,
;выход: вывод результата на дисплей
add_and_show proc
		sub bl,al   ;вычитание BL=BL-AL
		jns not_carry ;
		neg bl      ;(0-bl)
		mov ah,2h   ;символ '-'
		mov dl,'-'  ;вывод
		int 21h     ;с помощью функции DOS
not_carry:
		add bl,30h  ;преобразовать число
		mov ah,2h   ;в код символа
		mov dl,bl   ;вывести цифру
		int 21h     ;с помощью функции DOS
		ret         ;вернутся в вызы
add_and_show endp
code ends
end start
