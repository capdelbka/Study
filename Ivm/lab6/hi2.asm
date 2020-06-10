include msgbox.inc
.386 ;включение 32-битного режима
.model FLAT,STDCALL ;модель пам€ти FLAT,
;пр€ма€ передача параметров
.data
mb_text db 'Hello, World!',0 ;“екстовные константы
mb_title db 'Next program',0 ;дл€ выполнени€ программы
.code
start:
	call MessageBoxA,0,offset mb_text, offset mb_title, MB_ICONASTERISK+MB_OK
	call ExitProcess,0 ;завершение программы
	ends
	end start