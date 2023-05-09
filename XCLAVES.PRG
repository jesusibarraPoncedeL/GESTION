************
* USUARIO  : Fondo de Desarrollo Económico del Distrito Federal (FONDECO-DF)
* SISTEMA  : Sistemas de Control de Carteras. (SC²)
* MODULO   : Módulo de Catálogos
* PROGRAMA : XCLAVES
* OBJETIVO : Catalogo de Claves
* AUTOR    : dms
* FECHA    : 17Feb99              &&Miercoles de Ceniza
************
*GEjecuta=.f.
*=gIniPrgm()
MOVE WINDOW wGestion TO 0.083, 0.125
*
*********************************************************************
* Inicializacion de variables
*********************************************************************
*
atributos = 'A'
termina1  = .f.
termina2  = .f.
error     = .f.
aerror    = ''
*
xAlta      = 0
xBaja      = 0
xModifica  = 0
xVerCla    = 0
xImprimir  = 0
xAccesos   = 0
xOpSalir   = 0
*
xdato      = space(10)
xvalor     = space(10)
xcorta     = space(10)
xlarga     = space(40)
xacceso    = .f.
*
wdato      = space(10)
wvalor     = space(10)
*
*********************************************************************
* abrir archivos
*********************************************************************
*
*select 1
*use claves   index  claves
*
*********************************************************************
* Genera Arreglos
*********************************************************************

                             *************************************
                             * Para Dato
                             *************************************
xint1   = space(02) + gfont( 'Dato', 20, 8)
xTitLst = xint1
*
dimension aLista[1, 2]
aLista     = ''
xnMaxLista = 0
xLista     = 0
*
do xGenDato
                             *************************************
                             * Para Valor
                             *************************************
xint1      = space(02) + gfont( 'Valor', 15, 8)
xint2      = gfont( 'Descripción'   , 50, 8)
xTitLstDet = xint1 + xint2
*
dimension aListaDet[1, 2]
aListaDet  = ''
xnMaxLD    = 0
xListaDet  = 0
*
*********************************************************************
* pantalla
*********************************************************************
*
DEFINE WINDOW wclaves ;
	AT  0.000, 0.000  ;
	SIZE 24.846,115.200 ;
	TITLE "Catálogo de Claves" ;
	FONT "MS Sans Serif", 8 ;
	FLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	SYSTEM ;
	COLOR RGB(,,,192,192,192)
MOVE WINDOW wclaves CENTER
*
ACTIVATE WINDOW wclaves
*
@ 1.000,2.600 TO 21.692,112.200 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 1.077,2.800 TO 21.769,112.400 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 2.154,4.600 TO 3.231,25.800 ;
	PATTERN 1 ;
	PEN 1, 8 ;
	COLOR RGB(,,,128,128,128)
@ 2.154,30.800 TO 3.231,89.600 ;
	PATTERN 1 ;
	PEN 1, 8 ;
	COLOR RGB(,,,128,128,128)
@ 2.231,4.800 SAY xTitLst ;
	SIZE 1.000,20.400 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(255,255,255,128,128,128)
*
=gwinname( program())
*
*********************************************************************
* funcion general
*********************************************************************
*
@ 2.231,4.800 SAY xTitLst ;
	SIZE 1.000,20.400 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(255,255,255,128,128,128)
@ 3.308,4.600 GET xLista ;
 	PICTURE "@&N" ;
	FROM aLista ;
	RANGE 1, xnMaxLista ;
	SIZE 17.308,24.200 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	WHEN xDetalle() ;
	COLOR RGB(0,0,0,255,255,255),RGB(0,0,0,255,255,255)
@ 2.231,31.000 SAY xTitLstDet ;
	SIZE 1.000,58.000 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(255,255,255,128,128,128)
@ 3.308,30.800 GET xListaDet ;
 	PICTURE "@&N" ;
	FROM aListaDet ;
	RANGE 1, xnMaxLD ;
	SIZE 17.308,61.600 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID xVerCla() ;
	COLOR RGB(0,0,0,255,255,255),RGB(0,0,0,255,255,255)
@ 3.231,95.000 GET xAlta ;
	PICTURE "@*HN << \<Agregar" ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID xAlta()
@ 5.154,95.000 GET xBaja ;
	PICTURE "@*HN \<Eliminar >>" ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID xBaja()
@ 7.077,95.000 GET xModifica ;
	PICTURE "@*HN \<Modifica" ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID xModifica()
@ 9.769,95.000 GET xVerCla ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\verdocsm.bmp","BMP|ICO|PCT|ICN","Where is verdocsm?")) ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID xVerCla()
@ 12.692,95.000 GET xImprimir ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\imprimir.bmp","BMP|ICO|PCT|ICN","Where is imprimir?")) ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID xImprimir()
*@ 18.692,95.000 GET xAccesos ;
*	PICTURE "@*HN A\<ccesos" ;
*	SIZE 2.000,15.200,0.800 ;
*	DEFAULT 1 ;
*	FONT "MS Sans Serif", 8 ;
*	VALID xAccesos()
@ 22.231,2.600 GET xOpSalir ;
	PICTURE "@*HT \? \<Cerrar" ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8

READ CYCLE MODAL WHEN iwwread() 
*
*********************************************************************
* funcion final
*********************************************************************
*
release window wclaves
*close databases
*
erase tmpimp.dbf
erase tmpimp.fpt
erase tmpimp.idx
erase tmpimp.cdx
*
erase tmpcla.dbf
erase tmpcla.fpt
erase tmpcla.idx
erase tmpcla.cdx
*
*GEjecuta=.t.
*=gFinPrgm()

MOVE WINDOW wGestion CENTER

*
return



*
*
*                     P R O C E D I M I E N T O S
*
*


procedure iwwread
*************
* PROGRAMA  : iwwread
* OBJETIVO  : WHEN del READ del Browse
*************
*
if xnMaxLista <= 0
   show get xAlta     enable
   *
   show get xBaja     disable
   show get xModifica disable
   show get xAccesos  disable
   show get xVerCla   disable
   show get xImprimir disable
else
   show get xAlta     enable
   show get xBaja     enable
   show get xModifica enable
   *
   show get xAccesos  enable
   *
   show get xVerCla   enable
   show get xImprimir enable
endif   
*
return .t.




procedure xAlta
*************
* PROGRAMA  : xAlta
* OBJETIVO  : Alta de claves
*************
private wrecno, termina1
*
MOVE WINDOW wclaves TO 0.083, 0.125
=gClick()
*
*********************************************************************
* inicializacion de variables
*********************************************************************
*
xOkDet  = 0
xCanDet = 0
*
xmayc   = 0
xminc   = 0
xmayl   = 0
xminl   = 0
*
*********************************************************************
* pantalla
*********************************************************************
*
do iaecla
ACTIVATE WINDOW wclavesa
*
*********************************************************************
* funcion general
*********************************************************************
*
do iincla
*
if xnMaxLista <= 0
   xdato  = space(10)
else
   xdato  = aLista[ xLista, 2]
endif   
*
termina1 = .f.
do while not termina1
   atributos = 'A'
   do iapcla
   if xdato <> space(10)
      read cycle modal object 2
   else
      read cycle modal
   endif
   *
   if xCanDet = 1
      termina1 = .t.
      loop
   endif
   *
   do ivncla
   if error
      loop
   endif
   *
   xGenDato = .f.
   *
   select Claves
   seek xdato
   if eof()
      xGenDato = .t.
   endif
                             *************************************
                             * Altas en Claves
                             *************************************
   select claves
   append blank
   do iaccla
                             *************************************
                             * Actualiza Vector
                             *************************************
   if xGenDato
      do xGenDato
   endif
   *
   xLista = ascan2(aLista, xdato, 2)
   show get xLista
   *
   do xDetalle
   *
   xListaDet  = xnMaxLD
   show get xListaDet
   *
   do iwwread
   *
   termina1 = .t.
enddo
*
*********************************************************************
* funcion final
*********************************************************************
*
release window wclavesa
*
return




procedure xBaja
*************
* PROGRAMA  : xBaja
* OBJETIVO  : Baja de claves
*************
private wrecno
*
xdato  = aLista   [ xLista   , 2]
xvalor = aListaDet[ xListaDet, 2]
*
=gClick()
*
select claves
seek xdato + xvalor
if eof()
   =tone( 400,1)
   =tone( 400,1)
   =tone( 400,1)
   return
endif 
*
select claves
do ivecla
*
*********************************************************************
* funcion general
*********************************************************************
*
if gsino('Desea dar de Baja Clave?')='S'
   select claves
   delete
   *
   select claves
   seek xdato
   if eof()
      wLista = xLista
      *
      do xGenDato
      *
      xLista = wLista
      show get xLista
   endif
   *
   wListaDet = xListaDet 
   *
   do xDetalle
   *
   if wListaDet > xnMaxLD 
      xListaDet = wListaDet -1 
   else
      xListaDet = wListaDet
   endif
   *
   show get xListaDet
   *
   do iwwread
   *
endif   
*
*********************************************************************
* funcion final
*********************************************************************
*
return




procedure xModifica
*************
* PROGRAMA  : xModifica
* OBJETIVO  : modificacion de claves
*************
private wrecno, termina1
*
xdato  = aLista   [ xLista   , 2]
xvalor = aListaDet[ xListaDet, 2]
*
MOVE WINDOW wclaves TO 0.083, 0.125
=gClick()
*
select claves
seek xdato + xvalor
if eof()
   =tone( 400,1)
   =tone( 400,1)
   =tone( 400,1)
   return
endif 
*
*********************************************************************
* inicializacion de variables
*********************************************************************
*
xOkDet  = 0
xCanDet = 0
*
xmayc   = 0
xminc   = 0
xmayl   = 0
xminl   = 0
*
*********************************************************************
* pantalla
*********************************************************************
*
do iaecla
ACTIVATE WINDOW wclavesa
*
*********************************************************************
* funcion general
*********************************************************************
*
do iincla
do ivecla
*
termina1 = .f.
do while not termina1
   atributos = 'A'
   do iapcla
   read cycle modal
   *
   if xCanDet = 1
      termina1 = .t.
      loop
   endif
   *
   do ivncla
   if error
      loop
   endif
   *
   select claves
   seek wdato + wvalor
   do iaccla
   *
   wListaDet = xListaDet
   do xDetalle
   xListaDet = wListaDet
   show get xListaDet
   *
   termina1 = .t.
enddo
*
*********************************************************************
* funcion final
*********************************************************************
*
release window wclavesa
*
return




procedure xVerCla
*************
* PROGRAMA  : xVerCla
* OBJETIVO  : Ver una Clave
*************
private wrecno, termina1
*
xdato  = aLista   [ xLista   , 2]
xvalor = aListaDet[ xListaDet, 2]
select claves
seek xdato + xvalor
*
MOVE WINDOW wclaves TO 0.083, 0.125
=gDblClick()
*
*********************************************************************
* inicializacion de variables
*********************************************************************
*
xOkDet  = 0
xCanDet = 0
*
xmayc  = 0
xminc  = 0
xmayl  = 0
xminl  = 0
*
*********************************************************************
* pantalla
*********************************************************************
*
do iaecla
ACTIVATE WINDOW wclavesa
*
*********************************************************************
* funcion general
*********************************************************************
*
do iinCla
do iveCla
*
atributos = 'A'
do iapCla
READ CYCLE MODAL WHEN iwwVer()
*
*********************************************************************
* funcion final
*********************************************************************
*
release window wClavesa
*
return



procedure iwwVer
*************
* PROGRAMA  : iwwVer
* OBJETIVO  : WHEN del READ para consulta
*************
show gets disable
show get  xCanDet enable
return .t.





procedure ivncla
*************
* PROGRAMA  : ivncla
* OBJETIVO  : valida captura claves
*************
error  = .f.
aerror = ''
*
*********************************************************************
* valida Movimiento
*********************************************************************
*
*select claves
*seek xdato
*if !eof()
*   xacceso = claves.acceso
*   *
*   if !gacceso( 'SUPERVISOR') and !xacceso
*      error=.t.
*      =adderr( '%No Tiene Acceso Para Dar de Alta esa Clave.')
*   endif
*else
   xacceso = .t.
*endif   
*
*********************************************************************
* valida duplicados
*********************************************************************
*
select claves
if wdato + wvalor <> xdato + xvalor
   select claves
   seek xdato + xvalor
   if not eof()
      error=.t.
      =adderr( '%Clave duplicada.')
   endif
endif
*
*********************************************************************
* valida clave
*********************************************************************
*
if xdato = space(10)
   error=.t.
   =adderr( '%"Dato" inválida.')
endif
*
*********************************************************************
* despliega errores
*********************************************************************
*
if error
   =gerror()
endif
return



procedure iaecla
*************
* PROGRAMA  : iaecla
* OBJETIVO  : pantalla claves
*************
*
DEFINE WINDOW wclavesa ;
	AT  0.000, 0.000  ;
	SIZE 12.231,100.200 ;
	TITLE "Claves" ;
	FONT "MS Sans Serif", 8 ;
	FLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	SYSTEM ;
	COLOR RGB(,,,192,192,192)
MOVE WINDOW wclavesa CENTER
*
ACTIVATE WINDOW wclavesa
*
@ 1.538,5.000 SAY "Dato" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 3.000,5.000 SAY "Valor" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 8.769,5.000 SAY "Larga" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 7.154,5.000 SAY "Corta" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 0.846,2.200 TO 4.923,36.600 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 0.769,2.000 TO 4.846,36.400 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 6.000,2.200 TO 10.923,82.800 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 5.923,2.000 TO 10.846,82.600 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 5.385,3.400 SAY " Interpretación  " ;
	FONT "MS Sans Serif", 8
*
return



procedure iapcla
*************
* PROGRAMA  : iapcla
* OBJETIVO  : captura datos claves
*************
do case
case atributos = 'A'

@ 1.538,14.200 GET xdato ;
	SIZE 1.000,15.200 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K !!!!!!!!!!" ;
	VALID ivvcla() ;
	COLOR ,RGB(,,,255,255,255)
@ 3.000,14.200 GET xvalor ;
	SIZE 1.000,15.200 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K !!!!!!!!!!" ;
	VALID ivvcla() ;
	COLOR ,RGB(,,,255,255,255)
@ 7.154,14.200 GET xcorta ;
	SIZE 1.000,13.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K xxxxxxxxxx" ;
	VALID ivvcla() ;
	COLOR ,RGB(,,,255,255,255)
@ 8.769,14.200 GET xlarga ;
	SIZE 1.000,54.800 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" ;
	VALID ivvcla() ;
	COLOR ,RGB(,,,255,255,255)
@ 0.769,82.800 GET xOkDet ;
	PICTURE "@*HT \<OK" ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8
@ 2.923,82.800 GET xCanDet ;
	PICTURE "@*HT \? \<Cancelar" ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8
@ 6.615,30.000 GET xmayc ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\mayusc.bmp","BMP|ICO|PCT|ICN","Where is mayusc?")) ;
	SIZE 1.615,4.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID ivvcla()
@ 6.615,35.200 GET xminc ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\minusc.bmp","BMP|ICO|PCT|ICN","Where is minusc?")) ;
	SIZE 1.615,4.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID ivvcla()
@ 8.231,70.800 GET xmayl ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\mayusc.bmp","BMP|ICO|PCT|ICN","Where is mayusc?")) ;
	SIZE 1.615,4.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID ivvcla()
@ 8.231,76.000 GET xminl ;
	PICTURE "@*BHN " + ;
		(LOCFILE("bmps\minusc.bmp","BMP|ICO|PCT|ICN","Where is minusc?")) ;
	SIZE 1.615,4.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID ivvcla()


endcase
return



procedure ivecla
*************
* PROGRAMA  : ivecla
* OBJETIVO  : asigna variables de claves
*************
select claves
xdato  = dato
xvalor = valor
xcorta = corta
xlarga = larga
*
wdato  = dato
wvalor = valor
*
return



procedure iincla
*************
* PROGRAMA  : iincla
* OBJETIVO  : inicializa variables claves
*************
xdato  = space(10)
xvalor = space(10)
xcorta = space(10)
xlarga = space(40)
*
wdato  = space(10)
wvalor = space(10)
*
return



procedure iaccla
*************
* PROGRAMA  : iaccla
* OBJETIVO  : actualiza registro de claves
*************
replace ;
dato   with xdato   ,;
valor  with xvalor  ,;
corta  with xcorta  ,;
larga  with xlarga  ,;
acceso with xacceso
*
return



procedure ivvcla
*************
* PROGRAMA  : ivvcla
* OBJETIVO  : VALID's de campos de captura
*************
zvarread=varread()
do case
case zvarread = 'XDATO'
   xdato = padr(alltrim( xdato), 10)
   show get xdato
case zvarread = 'XVALOR'
   xvalor = padl(alltrim( xvalor), 10)
   show get xvalor
case zvarread = 'XCORTA'
   if xlarga = space(40)
      xlarga = padr( xcorta,40)
      show get xlarga
   endif
case zvarread = 'XLARGA'
   if xcorta = space(10)
      xcorta = substr( xlarga, 1, 10)
      show get xcorta
   endif
case zvarread = 'XMAYC'
   xcorta = upper( xcorta)
   show get xcorta
   _curobj = objnum(xlarga)
case zvarread = 'XMINC'
   xcorta = proper( xcorta)
   show get xcorta
   _curobj = objnum(xlarga)
case zvarread = 'XMAYL'
   xlarga = upper( xlarga)
   show get xlarga
   _curobj = objnum(xOkDet)
case zvarread = 'XMINL'
   xlarga = proper( xlarga)
   show get xlarga
   _curobj = objnum(xOkDet)
endcase
*
return .t.




procedure xDetalle
*************
* PROGRAMA  : xDetalle
* OBJETIVO  : Detalle de Clave
*************
*
if xnMaxLista = 0
   dimension aListaDet[1, 2]
   aListaDet  = ''
   xnMaxLD    = 0
   xListaDet  = 0
   *
   return
endif
*
dimension aListaDet[1, 2]
aListaDet  = ''
xnMaxLD    = 0
xListaDet  = 0
*
xdato = aLista[xLista,2]
*
select claves
seek xdato
scan  while dato = xdato
   xnMaxLD = xnMaxLD + 1
   dimension aListaDet[ xnMaxLD, 2]
   *
   xint1 = space(02)+gfont( iif(empty(valor), '*'+corta , valor), 15, 8 )
   xint2 = gfont( larga, 50, 8 )
   *
   aListaDet[ xnMaxLD, 1] = xint1 + xint2
   aListaDet[ xnMaxLD, 2] = valor
   *
endscan
if xnMaxLD >= 1
   xListaDet   = 1
else   
   dimension aListaDet[ 1, 2]
   aListaDet = ''
   xListaDet = 0
endif
*
show get xListaDet
*
return





procedure xGenDato
*************
* PROGRAMA  : xGenDato
* OBJETIVO  : Genera Dato
*************
*
*if gacceso( 'SUPERVISOR')
   xwhere = ''
*else
*   xwhere = ' and acceso = .t.'
*endif
*
select * ;
   from claves ;
   where dato <> 'CVEAGR' and dato <> 'CVESAGR';
         &xwhere ;
   group by dato ;
   into table TmpCla
*
dimension aLista[1, 2]
aLista     = ''
xnMaxLista = 0
xLista     = 0
*
select tmpcla
scan 
   xnMaxLista = xnMaxLista + 1
   dimension aLista[ xnMaxLista, 2]
   *
   xint1 = space(02)+gfont( Dato, 20, 8 )
   *
   aLista[ xnMaxLista, 1] = xint1
   aLista[ xnMaxLista, 2] = dato
   *
endscan
*
select TmpCla
use
*
if xnMaxLista >= 1
   xLista   = 1
else   
   dimension aLista[ 1, 2]
   aLista = ''
   xLista = 0
endif
*
return




procedure xImprimir
*************
* PROGRAMA  : xImprimir
* OBJETIVO  : Imprime reporte de claves
*************
private wrecno
*
*********************************************************************
* inicializacion de variables
*********************************************************************
*
xdato   = aLista[xLista, 2]
*
xOkRep  = 0
xCanRep = 0
*
*********************************************************************
* funcion general
*********************************************************************
*
DEFINE WINDOW wclavesr ;
	AT  0.000, 0.000  ;
	SIZE 7.000,55.000 ;
	TITLE "Reporte" ;
	FONT "MS Sans Serif", 8 ;
	FLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	SYSTEM ;
	COLOR RGB(,,,192,192,192)
MOVE WINDOW wclavesr CENTER
*
ACTIVATE WINDOW wclavesr
*
@ 1.231,3.200 TO 5.693,35.800 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 1.154,3.000 TO 5.616,35.600 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 2.923,7.600 SAY "Dato" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 3.000,15.200 GET xdato ;
	SIZE 1.000,14.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K !!!!!!!!!!" ;
	COLOR ,RGB(,,,255,255,255)
@ 1.154,37.400 GET xOkRep ;
	PICTURE "@*HT \<OK" ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8
@ 3.308,37.400 GET xCanRep ;
	PICTURE "@*HT \? \<Cancelar" ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8

READ CYCLE MODAL

if xOkRep = 1
   if xdato = space(10)
      select claves
      copy to tmpimp for dato <> 'CVEAGR' and dato <> 'CVESAGR'
   else
      select claves
      set near on
      seek alltrim( xdato)
      set near off
      copy to tmpimp while dato = alltrim(xdato)
   endif
   *
   select 0
   use tmpimp
   index on dato+valor to tmpimp
   go top
   if eof()
      aerror = ''
      =adderr( ' ')
      =adderr( ' ')
      =adderr( padc('No existen datos para el Reporte,', 70))
      =adderr( padc('de acuerdo a la selección.', 70))
      =gerror()
   else
      xtitulo1 = 'Catálogo de Claves'
      xtitulo2 = ''
      xforma   = 'RXclaves'
      do while .t.
         xtiprep= gpreview( xforma)
         do case
         case xtiprep = 'C'
            exit
         case xtiprep = 'I' or  xtiprep = 'D'
            report form RXclaves to print noconsole
            *
            if xtiprep = 'I'
               exit
            endif   
         case xtiprep = 'T'
            report form RXclaves to print prompt noconsole
         case xtiprep = 'P'
            report form RXclaves preview
         endcase
      enddo
   endif
   select tmpimp
   use
endif
*
*********************************************************************
* funcion final
*********************************************************************
*
release window wclavesr
*
return



procedure xAccesos
*************
* PROGRAMA  : xAccesos
* OBJETIVO  : Accesos para datos
*************
*
MOVE WINDOW wclaves TO 0.083, 0.125
=gClick()
*
*do xclavesd
*
return