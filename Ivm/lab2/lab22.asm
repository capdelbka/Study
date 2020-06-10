data segment
arr db 1, -3, -6, 5, -8, 3, 7
ad dw 1
co dw 3
data ends

obr macro adder, count
		local ag, otr, ex
		push bx si dx
		mov cx, count
	ag:
		mov si,cx
		dec si
		mov bx, adder
		add bx, si
		cmp arr[bx],0
		jl otr
		loop ag
		jmp ex
	otr:
		neg arr[bx]
		not arr[bx]
		loop ag
	ex:
		pop dx si bx
		endm
code segment
assume 	cs:code,ds:data

start:
	mov ax,data
	mov ds,ax
	xor ax,ax
	obr ad, co
	mov ah,4ch
	int 21h
code ends
end start