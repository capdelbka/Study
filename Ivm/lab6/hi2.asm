include msgbox.inc
.386 ;��������� 32-������� ������
.model FLAT,STDCALL ;������ ������ FLAT,
;������ �������� ����������
.data
mb_text db 'Hello, World!',0 ;���������� ���������
mb_title db 'Next program',0 ;��� ���������� ���������
.code
start:
	call MessageBoxA,0,offset mb_text, offset mb_title, MB_ICONASTERISK+MB_OK
	call ExitProcess,0 ;���������� ���������
	ends
	end start