************
* USUARIO  : Fondo de Desarrollo Económico del Distrito Federal (FONDECO-DF)
* SISTEMA  : Sistemas de Control de Carteras. (SC²)
* MODULO   : Gestion
* PROGRAMA : 
* OBJETIVO : Reportes de Gestion
* AUTOR    : hmp
* FECHA    : 16Feb2000
************
*
*GEjecuta=.f.
*=gIniPrgm()
*
*********************************************************************
* inicializa variables
*********************************************************************
*
atributos = 'A'
termina1  = .f.
termina2  = .f.
error     = .f.
aerror    = ''
*
xOpOk     = 0
xOpCan    = 0
*
xStatus   = space(15)
xFinrec1 = ginidate
xFinrec2 = ginidate
xfolio1   = Space(06)
xfolio2   = Space(06)
xStTur    = Space(06)
xCveArea  = Space(06)
xFectur1  = ginidate
xFectur2  = ginidate
*
iStatus   = space(15)
iStTur    = 0
iCveArea  = 0
*
*********************************************************************
* Definición de arreglos 
*********************************************************************
*
aerror=''
error=.f.
adderr=''
=adderr('Falta especificar opciones para los siguientes')
=adderr("Pop Up's, verifique su Catálogo de Opciones:")
=adderr('==============================================')
*
aStatus  = ''
=gArrCla( aStatus,  'STATUS',   2, 2)
*
aStTur   = '' 
=gArrCla( aStTur,   'STTUR',    2, 1)
*
aCveArea = ''
=gArrCla( aCveArea, 'CVEAREA',  2, 6)
*
if error
	=gerror()
	close databases
	Gejecuta=.t.
   =gFinPrgm()
	return	
endif
*
=gUnTodos( aStatus  , '(Todos)')
=gUnTodos( aStTur   , '(Todos)')
=gUnTodos( aCvearea , '(Todas)')
*
*********************************************************************
* pantalla
*********************************************************************
*
	DEFINE WINDOW wrepgest ;
		AT  0.000, 0.000  ;
		SIZE 28.538,77.000 ;
		TITLE "Reporte de Gestión" ;
		FONT "MS Sans Serif", 8 ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM ;
		COLOR RGB(,,,192,192,192)
	MOVE WINDOW wrepgest CENTER
*
ACTIVATE WINDOW wrepgest
*
@ 0.846,2.200 TO 4.308,58.400 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 0.769,2.000 TO 4.231,58.200 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 24.154,18.600 SAY "De" ;
	FONT "MS Sans Serif", 8
@ 25.769,18.600 SAY "Hasta" ;
	FONT "MS Sans Serif", 8
@ 18.462,6.800 SAY "Status " ;
	FONT "MS Sans Serif", 8
@ 20.385,6.800 SAY "Area " ;
	FONT "MS Sans Serif", 8
@ 10.846,18.600 SAY "De" ;
	FONT "MS Sans Serif", 8
@ 12.308,18.600 SAY "Hasta" ;
	FONT "MS Sans Serif", 8
@ 15.538,2.400 TO 16.923,59.000 ;
	PATTERN 1 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 15.385,2.000 SAY (LOCFILE("bmps\azul.bmp","BMP|ICO|PCT|ICN", "Where is azul?" )) BITMAP ;
	SIZE 1.462,56.600 ;
	STRETCH ;
	STYLE "T"
@ 15.385,2.000 TO 16.770,58.800 ;
	PEN 1, 0 ;
	COLOR RGB(0,0,128,,,,)
@ 15.615,23.200 SAY "Filtro x Turnado" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	COLOR RGB(0,0,0,,,,)
@ 15.538,23.200 SAY "Filtro x Turnado" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	COLOR RGB(255,255,255,,,,)
@ 1.923,5.200 SAY "Status " ;
	FONT "MS Sans Serif", 8
@ 5.846,18.600 SAY "De" ;
	FONT "MS Sans Serif", 8
@ 7.231,18.600 SAY "Hasta" ;
	FONT "MS Sans Serif", 8
@ 17.308,2.200 TO 22.385,58.400 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 17.231,2.000 TO 22.308,58.200 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 5.000,2.200 TO 9.308,58.400 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 4.923,2.000 TO 9.231,58.200 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 10.077,2.200 TO 14.077,58.400 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 10.000,2.000 TO 14.000,58.200 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 4.538,3.800 SAY " Fecha Alta " ;
	FONT "MS Sans Serif", 8
@ 9.615,4.600 SAY "  Folio " ;
	FONT "MS Sans Serif", 8
@ 23.077,2.200 TO 27.615,58.400 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 23.000,2.000 TO 27.538,58.200 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 22.615,3.800 SAY " Fecha Turnado " ;
	FONT "MS Sans Serif", 8


*
=gwinname(program())	
*
*********************************************************************
* funcion general
*********************************************************************
*
iStatus   = 1
xStatus   = '(Todos)'
*
iStTur    = 1
xStTur    = '(Todos)'
*
iCvearea  = 1
xCvearea  = '(Todas)'
*
xfectur1  = ginidate
xfectur2  = ginidate
*
termina1=.f.
do while not termina1
    *
    xOpOk  = 0
    xOpCan = 0
    *
     @ 1.692,18.600 GET iStatus ;
    	PICTURE "@^" ;
    	FROM aStatus ;
     	SIZE 1.538,34.800 ;
     	DEFAULT 1 ;
     	FONT "MS Sans Serif", 8 ;
     	VALID ivvGest()
     @ 5.769,26.600 GET xFinrec1 ;
     	SIZE 1.000,12.000 ;
     	DEFAULT " " ;
     	FONT "MS Sans Serif", 8 ;
     	PICTURE "@K" ;
     	VALID ivvGest() ;
     	COLOR ,RGB(,,,255,255,255)
     @ 7.154,26.600 GET xFinrec2 ;
     	SIZE 1.000,12.000 ;
       	DEFAULT " " ;
     	FONT "MS Sans Serif", 8 ;
     	PICTURE "@K" ;
     	VALID ivvGest() ;
     	COLOR ,RGB(,,,255,255,255)
     @ 10.769,26.600 GET xfolio1 ;
     	SIZE 1.000,12.000 ;
     	DEFAULT " " ;
     	FONT "MS Sans Serif", 8 ;
     	VALID ivvGest() ;
    	PICTURE "@K 999999" ;
     	COLOR ,RGB(,,,255,255,255)
     @ 12.231,26.600 GET xfolio2 ;
     	SIZE 1.000,12.000 ;
     	DEFAULT " " ;
     	FONT "MS Sans Serif", 8 ;
    	PICTURE "@K 999999" ;
      	VALID ivvGest() ;
        COLOR ,RGB(,,,255,255,255)
     @ 18.308,18.600 GET iStTur ;
     	PICTURE "@^" ;
     	FROM aStTur ;
     	SIZE 1.538,21.800 ;
     	DEFAULT 1 ;
     	FONT "MS Sans Serif", 8 ;
   	    VALID ivvGest()
     @ 20.154,18.600 GET iCveArea ;
     	PICTURE "@^" ;
     	FROM aCveArea ;
     	SIZE 1.538,38.200 ;
     	DEFAULT 1 ;
     	FONT "MS Sans Serif", 8 ;
     	VALID ivvGest()
     @ 24.077,25.600 GET xFectur1 ;
     	SIZE 1.000,12.000 ;
     	DEFAULT " " ;
     	FONT "MS Sans Serif", 8 ;
     	PICTURE "@K" ;
     	VALID ivvGest() ;
     	COLOR ,RGB(,,,255,255,255)
     @ 25.692,25.600 GET xFectur2 ;
     	SIZE 1.000,12.000 ;
     	DEFAULT " " ;
     	FONT "MS Sans Serif", 8 ;
     	PICTURE "@K" ;
     	VALID ivvGest() ;
     	COLOR ,RGB(,,,255,255,255)
     @ 0.769,60.200 GET xOpOk ;
     	PICTURE "@*HT \<OK" ;
     	SIZE 2.000,15.200,0.800 ;
     	DEFAULT 1 ;
     	FONT "MS Sans Serif", 8
     @ 3.000,60.200 GET xOpCan ;
     	PICTURE "@*HT \?\<Cancelar" ;
     	SIZE 2.000,15.200,0.800 ;
     	DEFAULT 1 ;
     	FONT "MS Sans Serif", 8
*
@ 5.923,61.200 GET XOPSED ;
	PICTURE "@*C SEDECO" ;
	SIZE 1.308,12.833 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "BT"
     	
    *
    READ CYCLE MODAL
    *
    if xOpCan = 1
       termina1=.t.
       loop
    endif
    *
    do ivnGest
    *
    if error
       loop
    endif
    *
    if xopsed = 1
       =xgentmps()
    else   
       =xGenTmp()
    endif    
    *
    select tmpimp
    go top
    if eof()
       aaviso = ''   
       =addavi( ' ')
       =addavi( ' ')
       =addavi( '%No Existen Datos para la Seleccion Efectuada.')
       =gaviso()
       select tmpimp
       use 
       loop
    else  
                             *************************************
                             * Impresión
                             *************************************
       xforma   = 'rGest'
       xtitulo1 = 'Control y Seguimiento de Asuntos'
       xtitulo2 = ''
       xdummy   = 1
       *
       select tmpimp
       do while .t.
          select tmpimp       
          xtiprep= gpreview(xforma,.t.,.f.)
          do case
          case xtiprep = 'C'
             exit
         case xtiprep = 'I' or  xtiprep = 'D'
            *
            report form rGest to print noconsole
            *
            if xtiprep = 'I'
               exit
            endif   
          case xtiprep = 'T'
             report form rGest to print prompt noconsole
          case xtiprep = 'P'
             report form rGest preview
          endcase
       enddo
    endif
    *
    select tmpimp
    use
enddo
*
*********************************************************************
* funcion final
*********************************************************************
*
release window wrepgest
*
*close database
*
erase tmpimp.dbf
erase tmpimp.fpt
erase tmpimp.idx
erase tmpimp.cdx
*
*GEjecuta=.t.
*=gFinPrgm()
*
return






*€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
*€                                                                   €
*€                    P R O C E D I M I E N T O S                    €
*€                                                                   €
*€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€


procedure xGenTMP
*************
* PROGRAMA  : xGenTMP
* OBJETIVO  : Genera temporal
*************
*
wait 'Creando Temporal...' window nowait
*
xwhere = ".T."
*
if xstatus <> '(Todos)'
   xwhere  = xwhere + " and status = xstatus "
endif
*
if xFinrec1 <> ginidate
   xwhere  = xwhere + " and (Finrec >= xFinrec1 and Finrec  <= xFinrec2) "
endif
*
if xFolio1 <> space(06)
   xwhere  = xwhere + " and (gestion.Folio >= xFolio1 and gestion.Folio <= xFolio2) "
endif
*
                             *************************************
                             * Genera temporal 
                             *************************************
if xStTur = '(Todos)' and xCveArea  = '(Todas)' and xFectur1  = ginidate and xFectur2  = ginidate

   select gestion.* ;
       from gestion ;
       where &xwhere ;
       into table TmpImp
   do xActTur
else
   if xStTur <> '(Todos)'
      xwhere  = xwhere + " and sttur = xsttur "
   endif
   *
   if xCvearea <> '(Todas)'
      xwhere  = xwhere + " and cvearea = xcvearea "
   endif
   *
   if xFectur1 <> ginidate
      xwhere  = xwhere + " and ( Fectur >= xFectur1 and Fectur  <= xFectur2) "
   endif
   *
   select gestion.* ;
      from gestion, turnado ;
      where gestion.folio = turnado.folio and &xwhere ;
      order by gestion.folio ;
      into table TmpImp 

   do xActTur
endif
*
*********************************************************************
* funcion final
*********************************************************************
*
wait clear
*
return


procedure xGenTMPs
*************
* PROGRAMA  : xGenTMPs
* OBJETIVO  : Genera temporal
*************
*
wait 'Creando Temporal...' window nowait
*
xwhere = ".t."
*
if xFinrec1 <> ginidate
      xwhere  = xwhere + " and (Finrec >= xFinrec1 and Finrec  <= xFinrec2) "
endif
*
select * from gestion;
       where ALLTRIM(gestion.areade) == "Secretaria Particular de SEDECO" ;
       and &xwhere;
       into table TmpImp 
*
do xActTur
*
wait clear
*
return




procedure xActTur
*************
* PROGRAMA  : xActTur
* OBJETIVO  : Actualiza Turnados
*************
*
select tmpimp
go top
scan
   select turnado
   seek TmpImp.folio
   scan while folio = tmpimp.folio
     xint1      = gfont( iif(!empty(turnado.fectur) , gfectex( turnado.fectur , 'DD-MMM-AA') , "") , 15, 8)
     xint2      = gfont( Proper(greccla('CVEAREA', turnado.cvearea,2)) , 28, 8)
*     xint3      = space(04)+ gfont( Proper(turnado.instruc)                       , 30, 8)
     xinth      = greccla("INSTRUCC",turnado.instrucc,2)
     xint4      = turnado.tramite
     rturnado   = xint1 + xint2 + chr(13)
     *
     select tmpimp
     replace reporte with reporte + rturnado
     replace descargo with ALLTRIM(xinth) + " => " + xint4
   endscan
endscan   
*
return



procedure ivnGest
*************
* PROGRAMA  : ivnGest
* OBJETIVO  : valida captura 
*************
aerror=''
error =.f.
*
***********************************************************************
* Valida Fechas
***********************************************************************
*
if xFinrec1 <> ginidate and xFinrec2 = ginidate
   xFinrec2  = xFinrec1
endif
*
if xFinrec2 <> ginidate and xFinrec1 = ginidate
   error  = .t.
   =adderr("%Indique la Fecha de Alta 'De'")
endif
*
if xFinrec1 > xFinrec2
   error  = .t.
   =adderr('%Rango de Fechas de Alta Invalida.')
endif
*
***********************************************************************
* Valida Folio
***********************************************************************
*
if xFolio1 <> space(06) and xFolio2 = space(06)
   xFolio2  = xFolio1
endif
*
if xFolio2 <> space(06) and xFolio1 = space(06)
   error  = .t.
   =adderr("%Indique el Folio 'De'")
endif
*
if xFolio1 > xFolio2
   error  = .t.
   =adderr('%Rango de Folios Invalido.')
endif
*
*
***********************************************************************
* Valida Fecha de Turnado
***********************************************************************
*
if xFecTur1 <> ginidate and xFecTur2 = ginidate
   xFecTur2  = xFecTur1
endif
*
if xFecTur2 <> ginidate and xFecTur1 = ginidate
   error  = .t.
   =adderr("%Indique la Fech de Turnado 'De'")
endif
*
if xFecTur1 > xFecTur2
   error  = .t.
   =adderr('%Rango de Fechas de Trunado Invalida.')
endif
*
***********************************************************************
* despliega errores
***********************************************************************
*
if error
   =gerror()
endif
*
return



PROCEDURE ivvGest
*************
* PROGRAMA  : ivvGest
* OBJETIVO  : valida captura
*************
zretorno=.T.
zvar=VARREAD()
*
do case
case zvar= 'ISTATUS'
   if iStatus > 0
      xStatus = aStatus[iStatus, 1]
   else
      xStatus = space(01)
   endif
case zvar= 'XFINREC1'
   if xFinrec1 <> ginidate and xFinrec2 = ginidate
      *
      xFinrec2 = xFinrec1
      show get xFinrec2
   endif
case zvar= 'XFOLIO1'
   if xFolio1 <> space(06) and xFolio2 = space(06)
      *
      xFolio2 = xFolio1
      show get xFolio2
   endif
case zvar= 'ISTTUR'
   if iStTur > 0
      xStTur = aStTur[iStTur, 2]
   else
      xStTur = space(01)
   endif
case zvar= 'ICVEAREA'
   if icveArea > 0
      if acveArea[icveArea, 2] =  '(Todas)'
         xcveArea = acveArea[icveArea, 2]
      else
         xcveArea = padl(alltrim(acveArea[icveArea, 2]) , 6)
      endif   
   else
      xcveArea = space(06)
   endif

case zvar= 'XFECTUR1'
   if xFecTur1 <> ginidate and xFecTur2 = ginidate
      *
      xFecTur2 = xFecTur1
      show get xFecTur2
   endif
endcase
*
return
