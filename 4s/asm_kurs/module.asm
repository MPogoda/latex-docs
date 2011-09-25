		.model	compact
		.stack	100h
		.data
equip_flag		EQU		byte	ptr	ds:[10h]
CGAbits			EQU		00100000b
MDAbits			EQU		00110000b;биты для переменной equip_flag
MASK_BL_INTS	EQU		01110111b;установка на 0 мерцания и интенсивности
BLINK_ON		EQU		10000000b;
INTENS_ON		EQU		00001000b;
BG_MASK			EQU		10001111b;
FG_MASK			EQU		11111000b;
len				db		?
		.code
	PUBLIC	_SetVmode ;int SetVmode(int n)
	PUBLIC	_GetVmode ;int	GetVmode(void)
	PUBLIC	_GetCursorX;int	GetCursorX(void); int GetCursorY(void)
	PUBLIC	_GetCursorY;чтение регистров положения курсора
	PUBLIC	_SetCursor
	PUBLIC	_PutSymb
	PUBLIC	_PutSymbXY
	PUBLIC	_ClearRectArea
	PUBLIC	_SetBgColour
	PUBLIC	_SetTextColour
	PUBLIC	_ReadChar
	PUBLIC	_ReadCharXY
	PUBLIC	_SetBlinkIntens
	PUBLIC	_SetAttr
	PUBLIC	_GetAttr
	public	_DispT
_SetVmode		PROC	c near
		arg n:byte
	;сохранение регистров вызывающей программы
		push	ds; 

		mov		al,n

		cmp		al,15
		je		wrong
		cmp		al,0
		jl		wrong
		cmp		al,19
		ja		wrong
		cmp		al,7
		jle		wright
		cmp		al,13
		jl		wrong
wright:		
		xor		ah,ah; ah=0 - номер функции прерывания INT 10h
		
		push	bp
		int		10h
		pop		bp
		mov		ax,0
		jmp		wright_end
wrong:	
		mov		ax,1
wright_end:
		pop		ds
		ret			;восстановление регистров и выход из программы
_SetVmode		ENDP

_GetVmode		PROC	c near
		
		mov		ah,0fh;ah=0fh - номер функции прерывания INT 10h
		
		int		10h

		sub		ah,ah;AX- номер видеорежима
		
		ret
_GetVmode		ENDP

CursorGet	macro; общая часть функций _GetCursorX и _GetCursorY
		mov		ax,40h
		mov		es,ax; ES-сегмент данных видео-BIOS
		mov		dx,es:[63h]; DX=3d4h - порт адресного регистра микросхемы видеоконтроллера 6845
		   ;получаем доступ к регистру младшего байта
		mov		al,0eh
		out		dx,al; выбираем регистр старшего байта позици курсора
		  ;посылаем младший байт результата
		inc		dx
		in		al,dx; читаем выбранный регистр через порт 3b5h 
		
		mov		ah,al; ah - старший байт расположения курсора
		dec		dx
		   ;получаем доступ к регистру старшего байта
		mov		al,0Fh
		out		dx,al; выбираем регистр младшего байта позици курсора
		   ;посылаем старший байт результата
		inc		dx
		in		al,dx; ax - смещение курсора относительно начала видеобуфера
		;преобразуем это значение в значения строки и столбца
		mov		dx,es:[4Eh]; DX=CRT_START
						   ; смещение начала видеобуфера в байтах
		shr		dx,1h; преобразуем байты в слова
		sub		ax,dx; вычитаем из смещения курсора
		div		byte	ptr	es:[4Ah]; делим на переменную CRT_COLS
		;ah-столбец, al-строка
endm

_GetCursorX		proc	c near
		CursorGet
		xchg	ah,al		;вернуть значение ah
		sub		ah,ah
		ret
_GetCursorX		endp


_GetCursorY		proc	c near
		CursorGet
		sub		ah,ah		;вернуть значение al
		ret
_GetCursorY		endp

_SetCursor		proc	c near ;SetCursor(short x, short y)
		arg		x:byte,y:byte
		
		
		mov		dh,y ;dh=y
		mov		dl,x ;dl=x
		mov		bh,00h ; экран 0 (для windows 7 может не работать (начинается с 1-й))
		mov		ah,2 ;AH = номер функции прерывания INT 104
		int		10h

		
		ret
_SetCursor		endp

_PutSymb		proc	c near;PutSymb(char a)
		arg		a:byte
		
		mov     al,a
		mov		bh,0
		mov		cx,1
		mov		ah,09h
		int		10h
		
		ret
_PutSymb		endp

_PutSymbXY		proc 	c near;PutSymbXY(char a,short x, short y)
		arg		a:byte,x:byte,y:byte
		
		mov		dh,y ;dh=y
		mov		dl,x ;dl=x
		mov		bh,00h ; экран 0 (для windows 7 может не работать (начинается с 1-й))
		mov		ah,2 ;AH = номер функции прерывания INT 10h
		int		10h
		
		mov     al,a ;output
		mov		ah,09h
		mov		cx,1
		mov		bh,0
		int		10h
		
		ret
_PutSymbXY		endp

_ClearRectArea	proc	c near ; ClearRectArea(short x1, short y1, short x2, short y2)
		arg		x1:byte,y1:byte,x2:byte,y2:byte

		mov		ah,08h
		int		10h
		mov		bh,7;Нормальный атрибут (черно/белый)
		mov		ah,06h		  ;AH 06 (прокрутка)
   		mov		al,00h	       ;AL 00 (весь экран)
		mov		dh,[bp+10]; dh=y2  \  нижняя правая позиция  
		mov		dl,[bp+8]; dl=x2   /
		mov		ch,[bp+6]; ch=y1 \ верхняя левая позиция
		mov		cl,[bp+4]; cl=x1 /
		int		10h

		ret
_ClearRectArea	endp

_SetBgColour	proc	c near;SetBgColour(int c) // 0<=c<=7
		arg 	n:byte

		mov 	ah,2	;return cursor to the left-top position
		mov 	bh,0
		mov 	dh,0
		mov 	dl,0
		int 	10h	

		mov  	AH,8        ;функция чтения символа/атрибутов
		int	 	10h
		
		mov 	bl,ah
		and		bl,BG_MASK;сохр. все атрибуты кроме цвета фона
		
		mov 	al,32 ;rectangle symbol
		mov		cl,n
		shl		cl,4
		add		bl,cl;
		mov 	bh,0
		mov 	cx,80*50
		mov 	ah,9
		int 	10h
			
		ret		
_SetBgColour	endp

_SetTextColour	proc	c near
		arg 	col:byte
		
		mov 	ah,2	;return cursor to the left-top position
		mov 	bh,0
		mov 	dh,0
		mov 	dl,0
		int 	10h	
		
		mov  	AH,8        ;функция чтения символа/атрибутов
		int	 	10h
		
		mov 	bl,ah
		and		bl,FG_MASK;сохр. все атрибуты кроме цвета текста
		add		bl,col
		
		mov 	al,32 ;rectangle symbol
		mov 	cx,80*50
		mov 	ah,9
		int 	10h
		
		ret
_SetTextColour	endp

_DispT			proc	 near; void	DispT(char* text,int n)
		push	bp
		mov		bp,sp
			
		mov		cx,[bp+6]

		mov		si,2
VYV:
		mov		dl,[bp+6+si]
		inc		si

		mov 	ah,0ah
		mov		bh,0
		mov		cx,1
		int 	10h

		loop	VYV
		
		mov		sp,bp
		pop		bp
		ret
_DispT			endp

_ReadChar		proc	c near; char ReadChar()
		mov		bh,0
		mov  	ah,8        ;функция чтения символа/атрибутов
		int	 	10h;в AH:AL теперь атрибуты и символ
		
		ret
_ReadChar		endp

_ReadCharXY		proc	c near;char ReadCharXY(short x, short y)
		arg		x:byte,y:byte
		
		mov		dh,y ;dh=y
		mov		dl,x ;dl=x
		mov		bh,00h ; экран 0 (для windows 7 может не работать (начинается с 1-й))
		mov		ah,2 ;AH = номер функции прерывания INT 104
		int		10h
		
		mov  	AH,8        ;функция чтения символа/атрибутов
		int	 	10h;в AH:AL теперь атрибуты и символ
		
		ret
_ReadCharXY		endp

_SetBlinkIntens	proc	c near; SetBlinkIntens(short blink, short intens)
							; 
							; blink=10000000b if true,00000000b if false
							; intens={00001000b if true ,00000000b if false
		arg		blink:byte,intens:byte
		
		mov 	ah,2	;return cursor to the left-top position
		mov 	bh,0
		mov 	dh,0
		mov 	dl,0
		int 	10h	

		mov  	AH,8        ;функция чтения символа/атрибутов
		int	 	10h
		
		mov		bl,ah
		and		bl,MASK_BL_INTS; устанавливаем на 0 мерцание и интенсивность
		
		mov		ah,0
		cmp		intens,ah
		je		Intens_off
		or		bl,INTENS_ON
Intens_off:		
		cmp		blink,ah
		je		Blink_off
		or		bl,BLINK_ON
Blink_off:
		
		mov 	al,32 ;space symbol
		mov 	bh,0
		mov 	cx,80*50
		mov 	ah,9
		int 	10h
		
		ret
_SetBlinkIntens	endp

_SetAttr		proc	c near;void SetAttr(short blink, short bgcol,short intens, short col)
		arg		blink:byte,bgcol:byte,intens:byte,col:byte
		
		mov 	ah,2	;return cursor to the left-top position
		mov 	bh,0
		mov 	dh,0
		mov 	dl,0
		int 	10h	
		
		mov 	al,32 ;rectangle symbol
		sub 	bl,bl
		mov		ah,0
		cmp		intens,ah
		je		Intns_off
		or		bl,INTENS_ON
Intns_off:		
		cmp		blink,ah
		je		Blnk_off
		or		bl,BLINK_ON
Blnk_off:
		add		bl,col
		mov		cl,bgcol
		shl		cl,4
		add		bl,cl
		mov 	bh,0
		mov 	cx,80*50
		mov 	ah,9
		int 	10h
		ret
_SetAttr		endp

_GetAttr		proc	c near;short GetAttr() - биты 0-2 - цвет текста
							;						3 - интенсивность
							;						4-6 - цвет фона
							;						7 - мерцание
		mov  	AH,8        ;функция чтения символа/атрибутов
		int	 	10h;в AH:AL теперь атрибуты и символ
		
		xchg	ah,al
		sub		ah,ah
		ret
_GetAttr		endp
END
		
		