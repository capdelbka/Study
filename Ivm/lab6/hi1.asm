includelib import32.lib ;����������� ���������� �������
 ;��������� �������
.386 ;��������� 32-������� ������
.model flat ;������ ������ FLAT
	extrn MessageBoxA:proc ;������� ���������
	extrn ExitProcess:proc
.data
mb_text db 'Hello, World!',0 ;��������� ���������
mb_title db 'My first program',0 ;��� ����������
;���������
.code
start: push 0 ;������������
	push offset mb_title ;����������
	push offset mb_text ;� ����� ���;MessageBox -
	push 0 ;������ ��������
	call MessageBoxA ;����� MessageBox
	push 0 ;�������� ��� ExitProcess
	call ExitProcess ;���������� ���������
	ends
	end start