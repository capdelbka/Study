;������ �����
.model small

;������� ����㯭��� � ���譥� ��楤��
extrn TrimTrail:far

;ᥣ���� ������
.data
msg1 db 0Ah,0Dh,'String: $'
msg2 db 0Ah,0Dh,'Result: $'
msg3 db 0Ah,0Dh,'Bool: $'
S db 32 dup('$')
Len db 5
res db 32 dup('$')
bool db '1',1 dup('$')

;ᥣ���� �⥪�
.stack 100h

;ᥣ���� ����
.code
start:
;���樠������ ᥣ���� ����
mov ax,@data
mov ds,ax
mov es,ax

;�뢮� ᮮ�饭��
mov ah,9
lea dx,msg1
int 21h

;���� ��砫쭮� ��ப�
mov ah,0Ah
lea dx,S
int 21h
xor ax, ax

;���� ��砫� ��砫쭮� ��ப�
lea bx,S+1
push bx

lea dx, Len
push dx

lea dx, bool
push dx

lea dx, res
push dx

;�맮� ��楤��� �८�ࠧ������ ��ப�	
call TrimTrail

;�뢮� ᮮ�饭��	
mov ah,9
lea dx,msg2
int 21h

;�뢮� ᮮ�饭��
mov ah,9
lea dx,res	;���� १������饩 ��ப�
int 21h

mov ah,9
lea dx,msg3
int 21h


mov ah,9
lea dx,bool	;���� १������饩 ��ப�
int 21h

;�������� ������ ������ �� ���������
xor ah,ah
int 16h

;��室 �� �ணࠬ��
mov ah,4Ch
mov al,0
int 21h
;����� �ணࠬ��, 㪠����� �窨 �室� � �ணࠬ��
end start