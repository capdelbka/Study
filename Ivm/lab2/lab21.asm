; Макроопределения
; Макроопределение задержки на заданное время
delay macro minutes,seconds,hundr
	local secs,mins,hrs,check,quit
	push_regs <ax,bx,cx,dx>; сохранить регистры
	read_time ; считать текущее время
	mov ah,ch ; скопировать часы в АН,
	mov al,cl ; минуты -в АL,
	mov bh,dh ; секунды -в BH,
	mov bl,dl ; сотые доли -в BL
; получить время конца паузы, добавляя значения
; входных параметров к текущему времени
	ifnb <minutes>
	add al,minutes
	endif
	ifnb <seconds>
	add bh,seconds
	endif
	ifnb <hundr>
	add bl,hundr
	endif
; учесть возможные переносы
	cmp bl,100
	jb secs
	sub bl,100
	inc bh
secs: cmp bh,60
	jb mins
	sub bh,60
	inc al
mins: cmp al,60
	jb hrs
	sub al,60
	inc ah
hrs: cmp ah,24
	jne check
	sub ah,ah
; ждать наступления полученного времени считыванием
; текущего времени и сравнением с полученным
check: read_time
	cmp cx,ax
	ja quit
	jb check
	cmp dx,bx
	jb check
quit: pop_regs <dx,cx,bx,ax> ; восстановить
	endm ; значения регистров
; Макроопределение занесения регистров в стек
;в заданном порядке
push_regs macro reg_list
	irp reg,<reg_list>
	push reg
	endm
	endm
; Макроопределение восстановления регистров
; из стека в заданном порядке
pop_regs macro reg_list
	irp reg,<reg_list>
	pop reg
	endm
	endm
; Макроопределение получения в AL случайного числа
;в промежутке 0 - lim, где lim=4-127
rand macro lim
	local strip
	push_regs <cx,dx,ax>; сохранить значения
	; регистров
	mov ax,0 ; считать показания таймера
	int 1ah
	mov ax,dx; поместить младшую часть в АХ
	mov cl,lim ; поместить lim и CL
; удалить из делимого (АХ) достаточное число
; старших битов, чтобы гарантировать отсутствие
; переполнения
	mov dh,3fh; поместить в DH маску
	; для операции AND
	cmp cl,64
	jae strip
	shr dh,1 ; если lim<64, удалить 3 бита
	cmp cl,32
	jae strip
	shr dh,1 ; если lim<32, удалить 4 бита
	cmp cl,16
	jae strip
	shr dh,1 ; если lim<16, удалить 5 бит
	cmp cl,0
	jae strip
	shr dh,1 ; если lim<8, удалить 6 бит
	shr dh,1
strip: and ah,dh ; удалить биты
	div cl ; разделить результат в АХ
	; на lim в CL
	mov al,ah; поместить остаток в АL
	pop cx ; восстановить значения
	mov ah,ch; регистров
	pop_regs <dx,cx>
	endm
; Макроопределение чтения текущего времени
;(CH - часы, CL - минуты, DH - секунды, DL – сотые
; доли секунды)
read_time macro
	push ax
	mov ah,2ch; выбрать режим чтения
	; времени
	int 21h ; считать время
	pop ax
	endm
; Начало программы
code segment
	assume cs:code
start: push_regs <ax,bx,cx,dx> ; сохранить
	;значения регистров
	mov ah,15 ; загрузить в ВН номер
	int 10h ; активной страницы экрана
	mov al, 2
	mov ah,0 ; задать текстовый
	int 10h ; черно-белый режим 80*25
	mov cx,1 ; установить счетчик символов
	mov dl,0 ; установить столбец 0
	rand 24 ; выбрать строку через генератор
	mov dh,al ; случайных чисел
	
crsr: mov ah,2 ;установить позицию курсора
	int 10h
	mov al,2 ; задать символ - "рожицу"
	mov ah,10 ; вывести символ на экран
	int 10h
	delay , ,12 ; выдержать паузу
	sub al,al ; стереть "рожицу"
	mov ah,10
	int 10h
	inc dl ; выбрать следующую позицию
	cmp dl,79 ; в столбце и выйти, если
	je leftcrs ; он равен 80
	cmp dh,0 ; проверить не установлены ли
	je ext ; граничные значения строки
	cmp dh,24 ; и если да, то выйти
	je ext
	rand 60 ; используя генератор случайных
	cmp al,20 ; чисел, выбрать направление
	jbe zero ; движения "рожицы": вверх,
	cmp al,40 ; вниз, вперед
	jbe one
	jmp crsr
zero: inc dh ; двигаться вниз
	jmp crsr
one: dec dh ; двигаться вверх
	jmp crsr		
ext: pop_regs <dx,cx,bx,ax> ; восстановить
	;регистры
	mov ah,4ch ; выйти в DOS
	int 21h
leftcrs: mov ah,2 ;установить позицию курсора
	int 10h
	mov al,2 ; задать символ - "рожицу"
	mov ah,10 ; вывести символ на экран
	int 10h
	delay , ,12 ; выдержать паузу
	sub al,al ; стереть "рожицу"
	mov ah,10
	int 10h
	dec dl ; выбрать следующую позицию
	cmp dl,0 ; в столбце и выйти, если
	je ext ; он равен 0
	cmp dh,0 ; проверить не установлены ли
	je ext ; граничные значения строки
	cmp dh,24 ; и если да, то выйти
	je ext
	rand 60 ; используя генератор случайных
	cmp al,20 ; чисел, выбрать направление
	jbe zero1 ; движения "рожицы": вверх,
	cmp al,40 ; вниз, вперед
	jbe one1
	jmp leftcrs
;вверх и вниз для движения влево
zero1: inc dh
	jmp leftcrs
one1: dec dh
	jmp leftcrs

code ends
	end start
