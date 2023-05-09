************
* USUARIO  : Fondo de Desarrollo Económico del Distrito Federal (FONDECO-DF)
* SISTEMA  : Sistemas de Control de Carteras. (SC²)
* MODULO   :
* PROGRAMA : XTurnado
* OBJETIVO :   
* AUTOR    : dms
* FECHA    : 14Feb99            && Disque dia del amor y la amistad y estoy trabajando 7:30pm
************
*
Parameter zFolio
*
MOVE WINDOW wGestion TO 0.083, 0.125
*
*********************************************************************
* Inicializacion de variables
*********************************************************************
*
xFecTur     = ginidate
xReferencia = space(30)
xRespon     = space(50)
xTramite    = ''
*
xStTur      = space(01)
xInstrucc   = space(02)
xTipTur     = space(02)
*
iStTur      = 0
iInstrucc   = 0
iTipTur     = 0
*
xADato   = 0
xBDato   = 0
xCanAcc  = 0
*
xOkDet   = 0
xCanDet  = 0
xBModi   = 0
*
dimension aLstUD[1, 2]
aLstUD     = ''
xnMxLstUD  = 0
xLstUD     = 0
*
dimension aLstUA[1, 2]
aLstUA     = ''
xnMxLstUA  = 0
xLstUA     = 0
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
aStTur = ''
=gArrCla( aStTur   , 'STTUR'   ,  2, 2)
*
aInstrucc = ''
=gArrCla( aInstrucc, 'INSTRUCC',  2, 2)
*
aTipTur = ''
=gArrCla( aTipTur  , 'TIPTUR'  ,  2, 2)
*
if error
	=gerror()
	*close databases
	Gejecuta=.t.
   =gFinPrgm()
	return	
endif
*
********************************************************************
* funcion inicial
********************************************************************
*
dimension aLstUD[1, 2]
aLstUD     = ''
xnMxLstUD  = 0
xLstUD     = 0
*
dimension aLstUA[1, 2]
aLstUA     = ''
xnMxLstUA  = 0
xLstUA     = 0

                             *************************************
                             * Inicia Busqueda
                             *************************************
select * ;
   from claves  ;
   where dato == 'CVEAREA' ;
   order by corta ;
   into table TmpCla
*
select TmpCla
scan
   zValor  = padl( alltrim(TmpCla.valor ),6 )
   *
   select Turnado
   seek zfolio + zValor
   *
   if eof() 
      xnMxLstUD = xnMxLstUD + 1
      dimension aLstUD[ xnMxLstUD, 2]
      *
      xint1 = space(02)+ gfont( TmpCla.Larga , 40, 8 )
      *
      aLstUD[ xnMxLstUD, 1] = xint1 
      aLstUD[ xnMxLstUD, 2] = zValor
   else
      xnMxLstUA = xnMxLstUA + 1
      dimension aLstUA[ xnMxLstUA, 2]
      *
      xint1 = space(02)+ gfont( TmpCla.Larga , 40, 8 )
      *
      aLstUA[ xnMxLstUA, 1] = xint1 
      aLstUA[ xnMxLstUA, 2] = zValor
   endif
   *
endscan
*
select TmpCla
use
*
=asort( aLstUD, 1)
=asort( aLstUA, 1)
*
if xnMxLstUD >= 1
   xLstUD   = 1
else   
   dimension aLstUD[ 1, 2]
   aLstUD = ''
   xLstUD = 0
endif
if xnMxLstUA >= 1
   xLstUA   = 1
else   
   dimension aLstUA[ 1, 2]
   aLstUA = ''
   xLstUA = 0
endif
*
********************************************************************
* pantalla
********************************************************************
*
DEFINE WINDOW wturnado ;
	AT  0.000, 0.000  ;
	SIZE 30.385,131.800 ;
	TITLE "Turnados" ;
	FONT "MS Sans Serif", 8 ;
	FLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	SYSTEM ;
    COLOR RGB(,,,192,192,192)
MOVE WINDOW wturnado CENTER
*
ACTIVATE WINDOW wTurnado
*
@ 1.923,4.000 TO 3.308,50.000 ;
	PATTERN 1 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 1.769,3.600 SAY (LOCFILE("bmps\azul.bmp","BMP|ICO|PCT|ICN", "Where is azul?" )) BITMAP ;
	SIZE 1.462,46.000 ;
	STRETCH ;
	STYLE "T"
@ 1.769,3.600 TO 3.154,49.800 ;
	PEN 1, 8 ;
	COLOR RGB(0,0,128,,,,)
@ 2.000,22.000 SAY "Areas" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	COLOR RGB(0,0,0,,,,)
@ 1.923,22.000 SAY "Areas" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	COLOR RGB(255,255,255,,,,)
@ 1.923,65.400 TO 3.308,111.400 ;
	PATTERN 1 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 1.769,65.000 SAY (LOCFILE("bmps\azul.bmp","BMP|ICO|PCT|ICN", "Where is azul?" )) BITMAP ;
	SIZE 1.462,46.000 ;
	STRETCH ;
	STYLE "T"
@ 1.769,65.000 TO 3.154,111.200 ;
	PEN 1, 8 ;
	COLOR RGB(0,0,128,,,,)
@ 2.000,83.800 SAY "Turnado a " ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	COLOR RGB(0,0,0,,,,)
@ 1.923,83.800 SAY "Turnado a " ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	COLOR RGB(255,255,255,,,,)
@ 0.846,2.200 TO 14.846,113.400 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 0.769,2.000 TO 14.769,113.200 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 17.846,4.800 SAY "Fecha Turnado" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 23.308,4.800 SAY "Responsable" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 19.308,4.800 SAY "Referencia" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 24.615,4.800 SAY "Trámite" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 16.692,2.200 TO 29.538,113.400 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 16.615,2.000 TO 29.461,113.200 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 16.154,1.400 TO 16.154,131.000 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 16.000,1.600 TO 16.000,131.400 ;
	PEN 2, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 17.538,80.800 SAY "Status" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 21.769,4.800 SAY "Instrucción" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 21.923,82.600 SAY "Tipo" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 20.846,3.600 TO 20.846,111.000 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 20.769,3.600 TO 20.769,111.000 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
*
=gwinname(program())
*
********************************************************************
* funcion general
********************************************************************
*
@ 3.692,3.800 GET xLstUD ;
 	PICTURE "@&N" ;
	FROM aLstUD ;
	RANGE 1, xnMxLstUD ;
	SIZE 10.385,46.000 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID xADato() ;
	COLOR RGB(0,0,0,255,255,255),RGB(0,0,0,255,255,255)
@ 3.538,65.200 GET xLstUA ;
 	PICTURE "@&N" ;
	FROM aLstUA ;
	RANGE 1, xnMxLstUA ;
	SIZE 10.385,46.000 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID xDetalle() ;
	WHEN  iwwDet() ;
	COLOR RGB(0,0,0,255,255,255),RGB(0,0,0,255,255,255)
@ 3.769,51.400 GET xADato ;
	PICTURE "@*HN  >>" ;
	SIZE 1.769,12.400,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID xADato()
@ 5.692,51.400 GET xBDato ;
	PICTURE "@*HN << " ;
	SIZE 1.769,12.400,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID xBDato()
@ 0.769,114.400 GET xCanCue ;
	PICTURE "@*HT \? \<Cerrar" ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8
*
@ 17.923,20.800 GET xFecTur ;
	SIZE 1.000,12.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K" ;
	DISABLE ;
	COLOR ,RGB(,,,255,255,255)
@ 19.231,20.800 GET xReferencia ;
	SIZE 1.000,33.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K" ;
	DISABLE ;
	COLOR ,RGB(,,,255,255,255)
@ 21.692,20.400 GET iInstrucc ;
	PICTURE "@^" ;
	FROM aInstrucc ;
	SIZE 1.538,34.200 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID ivvTurnado() ;
	DISABLE
@ 21.692,89.000 GET iTipTur ;
	PICTURE "@^" ;
	FROM aTipTur ;
	SIZE 1.538,22.400 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID ivvTurnado() ;
	DISABLE
@ 23.462,20.800 GET xRespon ;
	SIZE 1.000,90.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" ;
	DISABLE ;
	COLOR ,RGB(,,,255,255,255)
@ 24.769,20.800 EDIT xTramite ;
	SIZE 4.000,90.600,0.000 ;
	PICTURE "@K" ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	SCROLL ;
	DISABLE ;
	COLOR ,RGB(,,,255,255,255)
@ 17.308,89.000 GET iStTur ;
	PICTURE "@^" ;
	FROM aSttur ;
	SIZE 1.538,22.400 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID ivvTurnado() ;
	DISABLE
*
@ 16.615,114.400 GET xOkDet ;
	PICTURE "@*HN \<OK" ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	DISABLE ;
	VALID xOKDet()
@ 18.846,114.400 GET xCanDet ;
	PICTURE "@*HN \? \<Cancelar" ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	DISABLE ;
	VALID xCanDet()
@ 12.846,114.400 GET xBModi ;
	PICTURE "@*HN \<Modificar " ;
	SIZE 2.000,15.200,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID xDetalle()

READ CYCLE MODAL WHEN iwwRead0()
*
*********************************************************************
* funcion final
*********************************************************************
*
release window wTurnado
*
MOVE WINDOW wgestion CENTER
*
return



procedure iwwRead0
*************
* PROGRAMA  : iwwRead0
* OBJETIVO  : WHEN del Read 0
*************
if xnMxLstUD <= 0
   show get xADato     disable
else
   show get xADato     enable
endif
if xnMxLstUA <= 0
   show get xBDato    disable
   show get xBModi    disable
   *
   xFecTur     = ginidate
   xReferencia = space(30)
   xRespon     = space(50)
   xTramite    = ''
   *
   xStTur      = space(01)
   xInstrucc   = space(02)
   xTipTur     = space(02)
   *
   iStTur      = 0
   iInstrucc   = 0
   iTipTur     = 0
else
   show get xBDato    enable
   show get xBModi    enable
   *
   do iwwDet
endif
*
return .t.



*
*                                                                    
*                     P R O C E D I M I E N T O S                    
*                                                                    
*

procedure xADato
*************
* PROGRAMA  : xADato
* OBJETIVO  : Da de Altas Nueva Cuenta
*************
*********************************************************************
* funcion general
*********************************************************************
*
xdato  = aLstUD[ xLstUD, 2]
                                       ****************************************
                                       *agregar a los "actuales"
                                       ****************************************
xnMxLstUA = xnMxLstUA + 1
dimension aLstUA[ xnMxLstUA, 2]
*
aLstUA[ xnMxLstUA, 1] = aLstUD[ xLstUD, 1]
aLstUA[ xnMxLstUA, 2] = aLstUD[ xLstUD, 2]
*
=asort( aLstUA, 1)
xLstUA = ascan2( aLstUA, xdato, 2)
show get xBDato    enable
show get xBModi    enable
show get xLstUA
                                       ****************************************
                                       *eliminar de los "disponibles"
                                       ****************************************
=adel( aLstUD, xLstUD)
xnMxLstUD = xnMxLstUD - 1
if xLstUD > xnMxLstUD
   xLstUD = xnMxLstUD
endif
if xnMxLstUD > 0
   dimension aLstUD[ xnMxLstUD, 2]
endif
if xnMxLstUD <= 0
   show get xADato     disable
else
   show get xADato     enable
endif
=asort( aLstUD, 1)
show get xLstUD
                                       ****************************************
                                       * Da de Alta Una Cuenta
                                       ****************************************
wait 'Actualizando ...' window nowait
*
select turnado
append blank
replace ;
   folio   with zFolio ,;
   cvearea with xdato
*
*=gSndOk()
*
wait clear
*
do xDetalle
*
*********************************************************************
* funcion general
*********************************************************************
*
return




procedure xBDato
*************
* PROGRAMA  : xBDato
* OBJETIVO  : Quitar una Cuenta
*************
*
if MESSAGEBOX( +CHR(13)+ "Esta Seguro que Desea Borrar este Turnado?     "+CHR(13)+""+CHR(13)+""+CHR(13),48+256+1,"Eliminar") = 2
   return
endif  
*
*********************************************************************
* funcion general
*********************************************************************
*
xdato = aLstUA[ xLstUA, 2]
                                       ****************************************
                                       *agregar a los "disponibles"
                                       ****************************************
xnMxLstUD = xnMxLstUD + 1
dimension aLstUD[ xnMxLstUD, 2]
*
aLstUD[ xnMxLstUD, 1] = aLstUA[ xLstUA, 1]
aLstUD[ xnMxLstUD, 2] = aLstUA[ xLstUA, 2]
*
=asort( aLstUD, 1)
xLstUD = ascan2( aLstUD, xdato, 2)
show get xADato     enable
show get xLstUD
                                       ****************************************
                                       *eliminar de los "actuales"
                                       ****************************************
=adel( aLstUA, xLstUA)
xnMxLstUA = xnMxLstUA - 1
if xLstUA > xnMxLstUA
   xLstUA = xnMxLstUA
endif   
if xnMxLstUA > 0
   dimension aLstUA[ xnMxLstUA, 2]
endif
if xnMxLstUA <= 0
   show get xBDato    disable
   show get xBModi    disable
else
   show get xBDato    enable
   show get xBModi    enable
endif
=asort( aLstUA, 1)
show get xLstUA
                                       ****************************************
                                       * Quitando Acceso
                                       ****************************************
wait 'Actualizando ...' window nowait
*
select turnado
seek zFolio + xdato 
delete
*
*=gSndOk()
*
wait clear
*
do iwwDet
*
*********************************************************************
* funcion general
*********************************************************************
*
return




procedure xDetalle
*************
* PROGRAMA  : xDetalle
* OBJETIVO  : Captura Detalle
*************
*
show get xFecTur      enable
show get xReferencia  enable
show get xRespon      enable
show get xTramite     enable
show get iStTur       enable
show get iInstrucc    enable
show get iTipTur      enable
*
show get xOkDet      enable
show get xCanDet     enable
*
show get xLstUD      Disable
show get xLstUA      Disable
show get xADato      Disable
show get xBDato      Disable
show get xCanCue     Disable
show get xBModi      Disable
*
return





procedure xCanDet
*************
* PROGRAMA  : xCanDet
* OBJETIVO  : Cancela detalle
*************
*
do xrestaura
*
return



procedure xrestaura
*************
* PROGRAMA  : xrestaura
* OBJETIVO  : restaura
*************
*
show get xFecTur      Disable
show get xReferencia  Disable
show get xRespon      Disable
show get xTramite     Disable
show get iStTur       Disable
show get iInstrucc    Disable
show get iTipTur      Disable
*
show get xOkDet      Disable
show get xCanDet     Disable
*
show get xLstUD      enable
show get xLstUA      enable
show get xADato      enable
show get xBDato      enable
show get xCanCue     enable
show get xBModi      enable
*
do iwwRead0
*
return




PROCEDURE ivvTurnado
*************
* PROGRAMA  : ivvTurnado
* OBJETIVO  : valida captura
*************
zretorno=.T.
zvar=VARREAD()
*
do case
case zvar= 'ISTTUR'
   if iStTur > 0
      xStTur = aStTur[iStTur, 2]
   else
      xStTur = space(01)
   endif
case zvar= 'IINSTRUCC'
   if iInstrucc > 0
      xInstrucc = aInstrucc[iInstrucc, 2]
   else
      xInstrucc = space(02)
   endif
case zvar= 'ITIPTUR'
   if iTipTur > 0
      xTipTur = aTipTur[iTipTur, 2]
   else
      xTipTur = space(02)
   endif
endcase
return





procedure xOKDet
*************
* PROGRAMA  : xOKDet
* OBJETIVO  : 
*************
*
xcvearea = aLstUA[ xLstUA, 2]
*
select turnado
seek zfolio+xcvearea
replace ;
   fectur     with xfectur    ,;
   referencia with xreferencia,;
   Respon     with xRespon    ,;
   Tramite    with xTramite   ,;
   StTur      with xStTur     ,;
   Instrucc   with xInstrucc  ,;
   TipTur     with xTipTur 
*
do xrestaura
*
return





procedure iwwDet
*************
* PROGRAMA  : iwwDet
* OBJETIVO  :  
*************
*
if xnMxLstUA <= 0
   xFecTur     = ginidate
   xReferencia = space(30)
   xRespon     = space(50)
   xTramite    = ''
   *
   xStTur      = space(01)
   xInstrucc   = space(02)
   xTipTur     = space(02)
   *
   iStTur      = 0
   iInstrucc   = 0
   iTipTur     = 0
else
   xcvearea = aLstUA[ xLstUA, 2]
   *
   select turnado
   seek zfolio+xcvearea
   *
   xFecTur     = FecTur
   xReferencia = Referencia
   xRespon     = Respon
   xTramite    = Tramite
   *
   xStTur      = StTur
   xInstrucc   = Instrucc
   xTipTur     = TipTur
   *
   iStTur      = ascan2(aSttur    , xsttur    ,2)
   iInstrucc   = ascan2(aInstrucc , xInstrucc ,2)
   iTipTur     = ascan2(aTipTur   , xTipTur   ,2)
endif
*
show get xFecTur     
show get xReferencia 
show get xRespon     
show get xTramite    
*
show get iStTur      
show get iInstrucc   
show get iTipTur     
*
return





