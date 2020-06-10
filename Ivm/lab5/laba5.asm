cseg segment
	assume cs:cseg,ds:cseg
a dq 1.0
b dq 10.0
n dq 100.0
two dq 2.0
status dw ?
res dq ?
start:
	mov ax,cs
	mov ds,ax
	finit
	.386
	fldz
	fld n
	fld1
	fld b
	fld a
	fsubp st(1),st
	fld n
	fdivp st(1),st
	fst st(1)
	
	fld two
	fdivp st(1),st
	fld a
	fsub st,st(1)
	fstp st(1)
	fldz
again:
	fstp st(0)
	fld1
	fmul st,st(2)
	fmul st,st(3)
	fld1
	fsubp st(4),st
	fadd st,st(1)
	fsincos
	fstp st
	fld two
	faddp st(1),st
	fld1
	fxch st(1)
	fyl2x
	fldln2
	fmul
	faddp st(4),st
	fldz
	fcom st(3)
	fstsw status
	mov ax,status
	sahf
	jb again
	fxch st(4)
	fmul st,st(2)
	fstp res
	mov ax,4c00h
	int 21h
Cseg ends
end start
