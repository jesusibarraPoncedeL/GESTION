************
* USUARIO  : Fondo de Desarrollo Económico del Distrito Federal (FONDECO-DF)
* SISTEMA  : Sistemas de Control de Carteras. (SC²)
* MODULO   : Todos
* PROGRAMA : GPREVIEW
* OBJETIVO : Controla la salida del Reporte 
* AUTOR    : dms
* FECHA    : 03Mar99            &&3años 3meses.. Y quien sabe si me casa!!
************
*
parameters zCveRep, zSiXLS , zCoi
*
private zTipoRep
if parameters() = 1
   zSiXLS = .f.
endif
*
if parameters() = 2
   zCoi  = .f.
endif
*
*********************************************************************
* inicilizacion de variables
*********************************************************************
*
zTipoRep='I'                           && 'I' a Impresora
                                       && 'T' a Impresora con Prompt
                                       && 'P' Vista Preliminar
                                       && 'X' Archivo Excel
                                       && 'O' COI
                                       && 'B' DBF
                                       && 'C' Cancelar, (nada)
zPrnDirect = 0
zPrnSelect = 0
zPrnPrevw  = 0
zPrnXls    = 0
zPrnOk     = 0  
zPrnCan    = 0
*
zdirecto   = .f.
*
*********************************************************************
* funcion inicial
*********************************************************************
*
do case
case gprevista=1                       &&directo a impresora sin preguntar
   zTipoRep='I'                        && 'I' a Impresora
   return zTipoRep
case gprevista=2                       &&directo a Vista Preliminar sin preguntar
   zTipoRep='P'                        && 'P' Vista Preliminar
   return zTipoRep
endcase
                                       &&OTHERWISE asume que preguntará que 
                                       &&desean si a Impresora o Vista Preliminar
*
*********************************************************************
* pantalla
*********************************************************************
*
DEFINE WINDOW wpreview ;
	AT  0.000, 0.000  ;
	SIZE 12.846,55.200 ;
	TITLE "Imprimir ..." ;
	FONT "MS Sans Serif", 8 ;
	FLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	SYSTEM ;
	COLOR RGB(,,,192,192,192)
MOVE WINDOW wpreview CENTER
*
ACTIVATE WINDOW wpreview
*
@ 2.077,4.200 TO 9.539,51.600 ;
	PATTERN 1 ;
	PEN 1, 8 ;
	COLOR RGB(,,,255,255,255)
@ 2.077,48.400 TO 9.539,48.400 ;
	PEN 1, 8
@ 2.154,48.600 SAY (LOCFILE("bmps\listup.bmp","BMP|ICO|PCT|ICN", "Where is listup?" )) BITMAP ;
	SIZE 1.154,2.800 ;
	STYLE "T"
@ 8.385,48.600 SAY (LOCFILE("bmps\listdown.bmp","BMP|ICO|PCT|ICN", "Where is listdown?" )) BITMAP ;
	SIZE 1.077,2.800 ;
	STYLE "T"
@ 2.308,7.400 SAY (LOCFILE("bmps\print2.bmp","BMP|ICO|PCT|ICN", "Where is print2?" )) BITMAP ;
	SIZE 1.385,3.600 ;
	STYLE "T"
@ 2.462,13.600 SAY "Imprimir" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	COLOR RGB(0,0,0,,,,)
@ 4.000,7.400 SAY (LOCFILE("bmps\printp2.bmp","BMP|ICO|PCT|ICN", "Where is printp2?" )) BITMAP ;
	SIZE 1.385,3.600 ;
	STYLE "T"
@ 4.231,13.600 SAY "Seleccionar Impresora" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	COLOR RGB(0,0,0,,,,)
@ 5.692,7.400 SAY (LOCFILE("bmps\preview2.bmp","BMP|ICO|PCT|ICN", "Where is preview2?" )) BITMAP ;
	SIZE 1.385,3.600 ;
	STYLE "T"
@ 6.000,13.600 SAY "Vista Preliminar" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	COLOR RGB(0,0,0,,,,)
@ 1.077,2.400 TO 10.077,53.200 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 1.000,2.200 TO 10.000,53.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 10.846,42.400 SAY "Cerrar" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	COLOR RGB(0,0,0,,,,)
@ 10.462,37.800 TO 12.308,53.200 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 10.462,37.800 TO 10.462,52.800 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 10.462,37.800 TO 12.308,37.800 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 0.462,3.400 SAY " Salida de Información " ;
	FONT "MS Sans Serif", 8
@ 7.846,46.200 SAY (LOCFILE("bmps\listder.bmp","BMP|ICO|PCT|ICN", "Where is listder?" )) BITMAP ;
	SIZE 0.538,1.200 ;
	STYLE "T"
*
if zSiXLS

   @ 7.385,7.000 SAY (LOCFILE("bmps\exporta.bmp","BMP|ICO|PCT|ICN", "Where is exporta?" )) BITMAP ;
    	SIZE 1.385,3.600 ;
    	STYLE "T"
   @ 7.615,13.600 SAY "Exporta" ;
     	FONT "MS Sans Serif", 8 ;
     	STYLE "T" ;
     	COLOR RGB(0,0,0,,,,)
   @ 7.846,46.200 SAY (LOCFILE("bmps\listder.bmp","BMP|ICO|PCT|ICN", "Where is listder?" )) BITMAP ;
     	SIZE 0.538,1.200 ;
    	STYLE "T"
else

   @ 7.385,7.000 SAY (LOCFILE("bmps\exportad.bmp","BMP|ICO|PCT|ICN", "Where is exportad?" )) BITMAP ;
    	SIZE 1.385,3.600 ;
    	STYLE "T"
   @ 7.615,13.600 SAY "Exporta" ;
     	FONT "MS Sans Serif", 8 ;
     	STYLE "T" ;
	    COLOR RGB(128,128,128,,,,)
   @ 7.846,46.200 SAY (LOCFILE("bmps\listderd.bmp","BMP|ICO|PCT|ICN", "Where is listderd?" )) BITMAP ;
     	SIZE 0.538,1.200 ;
    	STYLE "T"
endif
*
*********************************************************************
* funcion general
*********************************************************************
*
ON KEY LABEL Ctrl+P do xPrnDirect
*
zPrnDirect = 0
zPrnSelect = 0
zPrnPrevw  = 0
zPrnXls    = 0
zPrnOk     = 0   
zPrnCan    = 0
*
@ 2.231,4.600 GET zPrnDirect ;
	PICTURE "@*IHT " ;
	SIZE 1.538,43.800,0.800 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8
@ 3.923,4.600 GET zPrnSelect ;
	PICTURE "@*IHT " ;
	SIZE 1.538,43.800,0.800 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8
@ 5.615,4.600 GET zPrnPrevw ;
	PICTURE "@*IHT " ;
	SIZE 1.538,43.800,0.800 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8

*
if zSiXLS
   @ 7.308,4.600 GET zPrnXls ;
     	PICTURE "@*IHN " ;
    	SIZE 1.538,43.800,0.800 ;
    	DEFAULT 0 ;
    	FONT "MS Sans Serif", 8 ;
    	VALID  zexporta()

endif
*
@ 10.692,38.600 GET zPrnCan ;
	PICTURE "@*IHT \? " ;
	SIZE 1.462,14.000,0.800 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8


READ CYCLE MODAL

if lastkey()=27 and ( zPrnDirect <> 0 and zPrnSelect <> 0 and  zPrnPrevw  <> 0)
   zPrnCan = 1
   zTipoRep='C'
endif
*
do case
case zPrnCan    = 1
   zTipoRep='C'
case zPrnDirect = 1
   zTipoRep='I'
   *
   if zdirecto
      zTipoRep='D'
   endif
case zPrnSelect = 1
   zTipoRep='T'
case zPrnPrevw  = 1
   zTipoRep='P'
case zPrnXls    = 1
*   zTipoRep='X' para el caso de Exportación
endcase
*
if zPrnDirect = 0  and ;
   zPrnSelect = 0  and ;
   zPrnPrevw  = 0  and ;
   zPrnOk     = 0  and ;
   zPrnCan    = 0  and ;
   zTipoRep  <>'X' and ;
   zTipoRep  <>'O' and ;
   zTipoRep  <>'B'
   *   
   zTipoRep='C'
endif
*
*********************************************************************
* funcion general
*********************************************************************
*
ON KEY LABEL Ctrl+P
*
RELEASE WINDOW wpreview
return zTipoRep






*€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
*€                                                                   €
*€                    P R O C E D I M I E N T O S                    €
*€                                                                   €
*€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€

procedure xPrnDirect
************
* PROGRAMA : xPrnDirect
* OBJETIVO : 
************
*
zdirecto = .t.
*
_curobj = objnum(zPrnDirect)
keyboard '{ENTER}'
*
return


procedure zExporta
************
* PROGRAMA : zExporta
* OBJETIVO : 
************
*
DEFINE POPUP MenuExporta FROM 8, wcols('wpreview')-25 MARGIN RELATIVE COLOR SCHEME 4  
DEFINE BAR 1  OF MenuExporta PROMPT "Microsoft Excel...  " 
DEFINE BAR 2  OF MenuExporta PROMPT "Aspel Coi...        " skip for !zCoi
DEFINE BAR 3  OF MenuExporta PROMPT "Tabla Dbf...        " skip for !zCoi

ON SELECTION BAR 1  OF MenuExporta do xOpExporta with 1
ON SELECTION BAR 2  OF MenuExporta do xOpExporta with 2
ON SELECTION BAR 3  OF MenuExporta do xOpExporta with 3

ACTIVATE POPUP MenuExporta
*
return




procedure xOpExporta
*************
* PROGRAMA  : xOpExporta
* OBJETIVO  : Control de opciones para Exportar
*************
parameters zOpExporta
*
zPrnXls = 0
*
HIDE POPUP MenuExporta
xClickRMouse = .t.
do case
case zOpExporta = 1
   zTipoRep='X'
   clear read
case zOpExporta = 2
   zTipoRep='O'
   clear read
case zOpExporta = 3
   zTipoRep='B'
   clear read
endcase
*
DEACTIVATE POPUP MenuExporta
RELEASE POPUP MenuExporta
*
return
