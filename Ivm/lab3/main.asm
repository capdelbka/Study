;модель памяти
.model small

;объявление доступности к внешней процедуре
extrn TrimTrail:far

;сегмент данных
.data
msg1 db 0Ah,0Dh,'String: $'
msg2 db 0Ah,0Dh,'Result: $'
msg3 db 0Ah,0Dh,'Bool: $'
S db 32 dup('$')
Len db 5
res db 32 dup('$')
bool db '1',1 dup('$')

;сегмент стека
.stack 100h

;сегмент кода
.code
start:
;инициализация сегмента кода
mov ax,@data
mov ds,ax
mov es,ax

;вывод сообщения
mov ah,9
lea dx,msg1
int 21h

;ввод начальной строки
mov ah,0Ah
lea dx,S
int 21h
xor ax, ax

;адрес начала начальной строки
lea bx,S+1
push bx

lea dx, Len
push dx

lea dx, bool
push dx

lea dx, res
push dx

;вызов процедуры преобразования строки	
call TrimTrail

;вывод сообщения	
mov ah,9
lea dx,msg2
int 21h

;вывод сообщения
mov ah,9
lea dx,res	;адрес результирующей строки
int 21h

mov ah,9
lea dx,msg3
int 21h


mov ah,9
lea dx,bool	;адрес результирующей строки
int 21h

;ожидание нажатия клавиши на клавиатуре
xor ah,ah
int 16h

;выход из программы
mov ah,4Ch
mov al,0
int 21h
;конец программы, указание точки входа в программу
end start