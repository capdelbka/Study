MB_OK = 0000H
MB_OKCANCEL = 0001H
MB_ABORTRETRYIGNORE = 0002H
MB_YESNOCANCEL = 0003H
MB_YESNO = 0004H
MB_RETRYCANCEL = 0005H
MB_ICONHAND = 0010H
MB_ICONQUESTION = 0020H
MB_ICONEXCLAMATION = 0030H
MB_ICONASTERISK = 0040H
;������� ���������
includelib import32.lib
	extrn MessageBoxA:proc
	extrn ExitProcess:proc