;������ �����
.model small

;������� ��饤���㯭�� �㭪樨
public TrimTrail

.code
;�㭪�� StrUpCase(buf, len): res
;�����頥� ��ப�, � ���ன �� ����� �㪢� �������� �� �ய���
TrimTrail proc
	push bp 					;��࠭���� bp
	mov bp,sp 					;����ன�� bp �� ���設� �⥪�

	mov si,[bp+12]				;ds:si=���� ��室��� ��ப�
	mov di,[bp+6]	 			;es:di=���� १����	
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