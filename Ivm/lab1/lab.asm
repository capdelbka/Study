; ��������o����� ����� ��� ����
sseg segment stack 'stack'
     dw 256 dup(?)
sseg ends
; ����������� ������
data segment
; ��������� ������������
msg1 db 10,13,'SUB'
     db 10,13,'N1: ','$'
msg2 db 10,13,'N2: ','$'
msg3 db 10,13,'N1 - N2 = ','$'
data ends
; ������� ����
code segment
assume 	cs:code,ds:data,ss:sseg
start: 	mov ax,data ; ��������� ����������
		mov ds,ax   ; ������� DS �� ������
		lea dx,msg1 ; ������� ���������
		call print_msg
		call input_digit; ������ ������ �����
		mov bl,al    ; � ��������� � �������� BL
		lea dx,msg2  ; ������� ���������
		call print_msg
		call input_digit ; ������ ������ �����
		lea dx,msg3      ; ������� ���������
		call print_msg
		call add_and_show; ������� � �������
                        ;  ���������
		mov ah,4ch       ; ��������� ���������
		int 21h             ; � ����� � DOS
; ������������ ������ ��������� �� �������
; ����: DS:DX - ����� ���������
; �����: ����� ��������� �� �������
print_msg proc
		push ax     ; ��������� AX
		mov ah,09h ; ������� ���������
		int 21h    ;  � ������� ������� DOS
		pop ax     ; ������������ AX
		ret  ; ��������� � ���������� ���������
print_msg endp
; ������������ ����� ����� � ����������
; ����: ��������� � ���������� �����
; �����: � AL - ��������� �����
input_digit proc
input_again:
		mov ah,01h  ; ������ ������ � ����������
		int 21h     ;  � ������� ������� DOS
		cmp al,'0'  ; ���� ������ �� �����,
		jl input_again ; �� ��������� ����
		cmp al,'9'
		jg input_again
		sub al,30h; ������������� ��� �������
                 ;  � �����
		ret  ; ��������� � ���������� ���������
input_digit endp
; ������������ �������� ���� �����
;����: AL,BL � ���������,
;�����: ����� ���������� �� �������
add_and_show proc
		sub bl,al   ;��������� BL=BL-AL
		jns not_carry ;
		neg bl      ;(0-bl)
		mov ah,2h   ;������ '-'
		mov dl,'-'  ;�����
		int 21h     ;� ������� ������� DOS
not_carry:
		add bl,30h  ;������������� �����
		mov ah,2h   ;� ��� �������
		mov dl,bl   ;������� �����
		int 21h     ;� ������� ������� DOS
		ret         ;�������� � ����
add_and_show endp
code ends
end start
