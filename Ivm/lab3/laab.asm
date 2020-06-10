;модель памяти
.model small

;объявление общедоступной функции
public TrimTrail

.code
;функция StrUpCase(buf, len): res
;возвращает строку, в которой все строчные буквы заменены на прописные
TrimTrail proc
	push bp 					;сохранение bp
	mov bp,sp 					;настройка bp на вершину стека

	mov si,[bp+12]				;ds:si=адрес исходной строки
	mov di,[bp+6]	 			;es:di=адрес результата	
	mov bx,[bp+10]				;len

	lodsb
	mov cx,ax
	mov dx,cx
check:
	lodsb

	cmp al,32
	je change
	stosb
	jmp ag
change:
	dec dx
ag:
	cmp dl,byte ptr [bx]
	je ex
	loop check
	mov di,[bp+8]
	mov byte ptr [di],'0'
	jmp exit
ex:
	dec cx
ex1:lodsb
	stosb
	loop ex1

exit: 
	pop bp
retf 8						
TrimTrail endp
end