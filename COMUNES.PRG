************
* USUARIO  : Fondo de Desarrollo Económico del Distrito Federal (FONDECO-DF)
* SISTEMA  : Sistemas de Control de Carteras. (SC²)
* MODULO   : Todos
* PROGRAMA : Comunes
* OBJETIVO : Procedimientos y funciones generales 
* AUTOR    : Nova Alto Nivel en Sistemas, S.A. de C.V.
************
 


*
*                                                                    
* MANEJO DE CATALOGOS DEL SISTEMA                                    
*                                                                    
*

FUNCTION GRECCLA
************
* PROGRAMA : greccla
* OBJETIVO : recupera claves
************
parameters zzdato,zzvalor,znumero
last_area=select()
select claves
zdato=upper(substr(ltrim(zzdato)+space(10),1,10))
zvalor=zzvalor
if type('zvalor') = 'N'
   zvalor = str(zvalor,10)
endif
zvalor=padl(upper(alltrim(zvalor)),10)
longjus = len(zvalor)
if longjus = 0
   zvalor = space (10)
else
   zvalor = space(10-longjus)+zvalor
endif
llave  = zdato+zvalor
seek llave
if eof()
   xinvalida=.t.
   if znumero=1
      zint=space(10)
   else
      zint=space(40)
   endif
else
   xinvalida=.f.
   do case
   case znumero=1
      zint=corta
   case znumero=2
      zint=larga
   case znumero=3
      zint=gest
   case znumero=4
      zint=sector
   endcase
endif
if last_area<>0
   select (last_area)
endif
return zint



FUNCTION GRECEXP
************
* PROGRAMA : grecexp
* OBJETIVO : recupera expediente
************
parameters zexp
last_area=select()
*
SELECT EXP
seek zexp
if eof()
   xinvalida=.t.
   zdescrip=padr('I N V A L I D A',40)
else
   xinvalida=.f.
   zdescrip =ltrim(alltrim(ape)+' ')+alltrim(nom)
   zdescrip =padr(zdescrip,40)
endif
if last_area<>0
   select (last_area)
endif
return zdescrip



FUNCTION GRECIDACRE
************
* PROGRAMA : grecIdAcre
* OBJETIVO : recupera Identificador de Acredores Diversos
************
parameters zIdAcre
last_area=select()
*
SELECT IdAcre
seek zIdAcre
if eof()
   xinvalida=.t.
   zdescrip=padr('I N V A L I D A',40)
else
   xinvalida=.f.
   zdescrip =ltrim(alltrim(ape)+' ')+alltrim(nom)
   zdescrip =padr(zdescrip,40)
endif
if last_area<>0
   select (last_area)
endif
return zdescrip



FUNCTION GRECACRE
************
* PROGRAMA : grecacre
* OBJETIVO : recupera Acreditado
************
parameters zacre
last_area=select()
*
SELECT Acre
seek zacre
if eof()
   xinvalida=.t.
   zdescrip=padr('I N V A L I D A',40)
else
   xinvalida=.f.
   zdescrip =ltrim(alltrim(ape)+' ')+alltrim(nom)
   zdescrip =padr(zdescrip,40)
endif
if last_area<>0
   select (last_area)
endif
return zdescrip



FUNCTION GRECcpto
************
* PROGRAMA : grec
* OBJETIVO : recupera Concepto
************
parameters zcvecon
last_area=select()
select cptos
seek zcvecon
if eof()
   xinvalida=.t.
   zdescrip=padr('I N V A L I D A',40)
else
   xinvalida=.f.
   zdescrip =padr(nomcon,40)
endif
if last_area<>0
   select (last_area)
endif
return zdescrip




FUNCTION GRecCptoCa
************
* PROGRAMA : GRecCptoCa
* OBJETIVO : recupera Concepto de Calculos
************
parameters zcvecon , zcvescon , znumero
*
last_area=select()
select cptocal
seek zcvecon + zcvescon
if eof()
   xinvalida=.t.
   if znumero=1
      zdescrip=padr('INVALIDA',10)
   else
      zdescrip=padr('I N V A L I D A',40)
   endif   
else
   xinvalida=.f.
   if znumero=1
      zdescrip =padr(nomcptoc,10)
   else
      zdescrip =padr(nomcpto,40)
   endif
endif
if last_area<>0
   select (last_area)
endif
return zdescrip



function greccias
************
* PROGRAMA : greccias
* OBJETIVO : recupera compañias
************
parameters zcvecia, znumero
zLastArea=select()
select cias
seek zcvecia
if eof()
   xinvalida=.t.
   do case
   case znumero = 1
      zint = padr('I N V A L I D A', 50)
   case znumero = 2
      zint = padr('I N V A L I D A', 20)
   endcase
else
   xinvalida=.f.
   do case
   case znumero = 1
      zint = nomciac
   case znumero = 2
      zint = nomcia
   endcase
endif
if zLastArea<>0
   select (zLastArea)
endif
return zint



FUNCTION GRecKvars
************
* PROGRAMA : GRecKvars
* OBJETIVO : Recupera Valor en Kvars
************
parameters znomvar , znumero
*
last_area=select()
select kvars
zorden = order()
set order to kvars1
seek alltrim(znomvar)
if eof()
   xinvalida=.t.
   if znumero=1
      zdescrip = space(10)
   else
      zdescrip = space(40)
   endif   
else
   xinvalida=.f.
   if znumero=1
      zdescrip = padr(descrip,40)
   else
      zdescrip = alltrim(valora)
   endif
endif
*
select kvars
set order to &zorden
*
if last_area<>0
   select (last_area)
endif
return zdescrip




*
*                                                                    
* GENERACION DE ARREGLOS PARA POUP'S                                 
*                                                                    
*


function gArrCla
************
* PROGRAMA : gArrCla
* OBJETIVO : genera arreglo de claves
*
*            zvector      nombre del vector
*            zdato        nombre del dato a busca en claves
*            zint         que interpretacion se desea
*            zajuste      recorta el valor a la longitud indicada
*            zIncluirInt  incluir interpretacion en el vector
*            zPrimeroInt  deslpiega primero interpretacion
*            zfont        Tamaño del Font
************
parameters zvector, zdato, zint, zajuste, zIncluirInt, zPrimeroInt , zfont , zsector
private i, zLastArea, zfor
if parameters() <= 3
   zajuste = 10
   zIncluirInt = .f.
endif
if parameters() <= 4
   zIncluirInt = .f.
endif
if parameters() <= 5
   zPrimeroInt = .f.
endif
if parameters() <= 6
   zfont = 8
endif
if parameters() <= 7
   zsector = ''
endif
*
if len(alltrim(zsector)) <> 0
   zfor = ' sector = alltrim(zsector) '
else
   zfor = '.t.'
endif
*
zLastArea=select()
dimension zvector[1,2]
zvector=''
xinvalida=.t.
i=1
*
zdato=upper(padr(alltrim(zdato),10))
select claves
seek zdato
do while .not.eof() and zdato=dato 
 if &zfor
   xinvalida=.f.
   dimension zvector[i,2]
   *
   do case
   case zint=1
      if zIncluirInt
         if zPrimeroInt
            if len(zsector) <> 0
               zvector[i,1] = gfont(padr(alltrim( valor), zajuste) ,  6, zfont) + gfont('  ' + alltrim(corta), 13, zfont)
            else
               zvector[i,1] = gfont(padr(alltrim( valor), zajuste) , 13, zfont) + gfont('  ' + alltrim(corta), 13, zfont)
            endif   
         else
            zvector[i,1] = alltrim(corta) + '  ('+ padr(alltrim( valor), zajuste) +')'
         endif
      else
         zvector[i,1]=alltrim(corta)
      endif   
   case zint=2
      if zIncluirInt
         if zPrimeroInt
            if len(zsector) <> 0
               zvector[i,1] = gfont(padr(alltrim( valor), zajuste),  6, zfont) + gfont('  ' + alltrim(larga), 40, zfont)
            else
               zvector[i,1] = gfont(padr(alltrim( valor), zajuste), 13, zfont) + gfont('  ' + alltrim(larga), 40, zfont)
            endif
         else
             zvector[i,1] = alltrim(larga) + '  ('+ padr(alltrim( valor), zajuste) +')'
         endif
      else
         zvector[i,1]=alltrim(larga)
      endif
   endcase
   zvector[i,2] = padr(alltrim( valor), zajuste)
   i=i+1
   *
  endif
  select claves
  skip
enddo
if .not.xinvalida
   =asort(zvector,1)
else
   error=.t.
   =adderr('% '+ zdato +' (Catálogo de Claves)')
endif
if zLastArea<>0
   select (zLastArea)
endif
return



function gArrKVars
************
* PROGRAMA : gArrKVars
* OBJETIVO : genera arreglo de kvars
************
parameters zvector, zgrupo ,zajuste ,zIncluirInt, zPrimeroInt , zfont
*
private i, zLastArea, zCierra
*
if parameters() <= 2
   zajuste = 10
   zIncluirInt = .f.
endif
*
if parameters() <= 3
   zIncluirInt = .f.
endif
if parameters() <= 4
   zPrimeroInt = .f.
endif
*
if parameters() <= 5
   zfont = 8
endif
*
zLastArea=select()
dimension zvector[1,2]
zvector=''
xinvalida=.t.
i=1
*
zgrupo = upper(padr(alltrim(zgrupo),10))
*
if used('kvars')
   select kvars
   zCierra = .f.
else
   select 0
   use kvars order kvars
   zCierra = .t.
endif   
seek zgrupo
scan while zgrupo = grupo
   xinvalida=.f.
   dimension zvector[i,3]
   *
   if zIncluirInt
      if zPrimeroInt
         zvector[ i, 1] = gfont(padr(alltrim( valora), zajuste) , 5, zfont) + gfont('  ' + alltrim(descrip), 40, zfont)
      else
         zvector[ i, 1] = alltrim(descrip)  + '  ('+ padr(alltrim( valora), zajuste) +')'  
      endif
   else
      zvector[ i, 1] = alltrim( descrip)
   endif
   *
   zvector[ i, 2] = padr(alltrim( valora), zajuste)
   zvector[ i, 3] = Nomvar
   *   
   i=i+1
   select kvars
endscan
if .not.xinvalida
   =asort(zvector,1)
else
   error=.t.
   =adderr('% '+ zgrupo +' (KVARS)')
endif
if zCierra
   select kvars
   use
endif
if zLastArea<>0
   select (zLastArea)
endif
return



function gArrCias
************
* PROGRAMA : gArrCias
* OBJETIVO : genera arreglo de Catalogo Compañías
************
parameters zvector, zNumInt
*
if parameters() = 1
   zNumInt = 1
endif
*
private i, zLastArea
*
*
zLastArea=select()
dimension zvector[1,2]
zvector=''
xinvalida=.t.
i=1
*
select cias
go top
scan 
   xinvalida=.f.
   dimension zvector[i,2]
   do case
   case zNumInt = 1
      zvector[i,1] = nomciac
   case zNumInt = 2
      zvector[i,1] = nomcia
   case zNumInt = 3
      zvector[i,1] = dirdbf
   endcase
   zvector[i,2] = cvecia
   i=i+1
   select cias
endscan
if .not.xinvalida
   =asort(zvector,1)
else
   error=.t.
   =adderr('% Catálogo de Compañías')
endif
if zLastArea<>0
   select (zLastArea)
endif
return



*
*                                                                    
* FUNCIONES PARA ARREGLOS                                            
*                                                                    
*

function gUnBlanco
*************
* PROGRAMA  : gUnBlanco
* OBJETIVO  : Agregar un elemento en Blanco para que puedan dejar blancos
*             Lo agrega al ultimo
*************
parameters zvector, znuevo
private zi, zRowVector, zColVector
zRowVector = alen(zvector, 1) + 1
zColVector = alen(zvector, 2)
dimension zvector[ zRowVector, zColVector]
zvector[ zRowVector, 1] = znuevo
for zi = 2 to zColVector
   zvector[ zRowVector, zi] = znuevo
next
return



function gUnTodos
*************
* PROGRAMA  : gUnTodos
* OBJETIVO  : Agregar un elemento TODOS al Inicio
*************
parameters zvector, znuevo
private zi, zRowVector, zColVector
zRowVector = alen(zvector, 1) + 1
zColVector = alen(zvector, 2)
dimension zvector[ zRowVector, zColVector]
=ains( zvector, 1)
zvector[ 1, 1] = znuevo
for zi = 2 to zColVector
   zvector[ 1, zi] = znuevo
next
return



function gUnNoHay
*************
* PROGRAMA  : gUnNoHay
* OBJETIVO  : Agregar un elemento NO HAY al inicio de la matriz
*************
parameters zvector, znuevo
private zi, zRowVector, zColVector
zRowVector = alen(zvector, 1) + 1
zColVector = alen(zvector, 2)
dimension zvector[ 1, zColVector]
zvector[ 1, 1] = znuevo
for zi = 2 to zColVector
   zvector[ 1, zi] = znuevo
next
return


function ascan2
************
* PROGRAMA : ascan2
* OBJETIVO : busca un elemento en un vector
************
parameters zvector, zbusca, zcolumna
zfound=0
for i=1 to alen(zvector,1)
   if zvector[i,zcolumna]=zbusca
      zfound=i
      exit
   endif
next
return zfound




*
*                                                                    
* CONTROL DE LOCALIZACION DE TABLAS POR COMPAÑIA                     
*                                                                    
*

function gDirCia
************
* PROGRAMA : gDirCia
* OBJETIVO : Recupera ruta de DBFS de una CIA
************
parameters zcvecia
*
zcerrar = .f.
*
if USED('CIAS')
   zLastArea=select()
   select cias
   zcerrar = .f.
else
   select 0
   use cias order cias0
   zcerrar = .t.
endif
*   
select cias
seek zcvecia
if eof()
   xinvalida=.t.
   zruta = ''
else
   xinvalida=.f.
   zruta = gPathRuta+'; '+gPathRuta+'\'+alltrim( dirdbf)
endif
*
if ! zcerrar
   if zLastArea<>0
      select (zLastArea)
   endif
endif
*   
return zruta




Function gDirCie
************
* PROGRAMA : gDirCie
* OBJETIVO : Recupera ruta de DBFS en el Cierre
************
parameters zcvecia
*
zLastArea=select()
*
if USED('CIAS')
   select cias
else
   select 0
   use cias order cias0
endif
*   
select cias
seek zcvecia
if eof()
   xinvalida=.t.
   zRutaCie = ''
else
   xinvalida=.f.
   zRutaCie = gPathRuta +'\' + alltrim( dirdbf) +'\CIERRES\'
endif
*
if zLastArea<>0
   select (zLastArea)
endif
*   
return zRutaCie



*
*                                                                    
* GENERACION DE AYUDAS                                               
*                                                                    
*

FUNCTION GVALCLA
************
* PROGRAMA : gvalcla
* OBJETIVO : ventana de ayuda para catalogo de claves
************
parameters zdato
private seleccion
*
set typeahead to 1
zvar=varread()
ztipo=type(zvar)
zvalor=&zvar
if ztipo='C'
   zlen=len(zvalor)
endif

last_area=select()
select claves
zdato=padr(upper(alltrim(zdato)),10)
if type('zvalor')='N'
   zvalor=str(zvalor,10)
endif
zvalor=padl(upper(alltrim(zvalor)),10)
seleccion=.f.
*
zfor='.t.'
do case
case zdato='CVESAGR'
   zfor='DATO=ZDATO .AND. SUBSTR(VALOR,5,3)=XCVEAGR'
otherwise
   zfor='DATO=ZDATO'
endcase
*                                                &&busca dato
DEFINE WINDOW whelpbrow ;
	AT  0.000, 0.000  ;
	SIZE 12.077,87.200 ;
	TITLE 'Ayuda' ;
	FONT "MS Sans Serif", 8 ;
	FLOAT ;
	GROW ;
	PANEL ;
	CLOSE ;
	NOMINIMIZE 
*
SET MESSAGE TO 'SELECCION REGISTRO Y PRESION <ENTER>, <ESC> PARA CANCELAR'
ON KEY LABEL ENTER DO gsel_reg
BROWSE ;
	NOEDIT ;
	NODELETE ;
	NOAPPEND ;
	NOMENU ;
	SAVE ;
	WINDOW WHELPBROW ;
	FOR &zfor ;
	FIELDS valor:H='Clave',larga:H='Descripción'
*
on key label enter
release window whelpbrow
set message to
*
if last_area<>0
   select (last_area)
endif
return seleccion



FUNCTION GVALFILE
************
* PROGRAMA : gvalfile
* OBJETIVO : ventana de ayuda para catalogos
************
parameters zfile
private seleccion
*
seleccion=.f.
set typeahead to 1
zfile=alltrim(upper(zfile))
zvar=varread()
zllave=&zvar
*
do case                               && Definici¢n de campos para ayuda
case zfile='TASAS'
   ztitulo='Tabla de Tasas de Interes'
   zfields="cvetasa:H='Tasa', ano:H='Año'"
case zfile='EXP' OR ZFILE = 'REESTRUC'
   ztitulo= "Ayuda de "
   ztitulo= ztitulo + "Acreditados" 
   *
   zfields="x=ltrim(alltrim(EXP.ape)+' ')+alltrim(EXP.nom):60:H='N o m b r e',;
            EXP.exp:H='Num',EXP.digito:H='Digito',EXP.stexp:H='St',EXP.cveagr:H='Agr',EXP.tipamo:H='T.Amo'"
case zfile='IDACRE'
   ztitulo= "Ayuda de "
   ztitulo= ztitulo + "Idintidicadores" 
   *
   zfields="x=ltrim(alltrim(IdAcre.ape)+' ')+alltrim(IdAcre.nom):60:H='N o m b r e',;
            IdAcre.IdAcre:H='Num', IdAcre.IdDig:H='Digito' "
case zfile='ACRE' 
   ztitulo= "Ayuda de Acreditados "
   zfields="x=ltrim(alltrim(acre.ape)+' ')+alltrim(acre.nom):65:H='N o m b r e',;
            Acre.acre:H='Número'"
case zfile='CPTOS'
   ztitulo='Tabla de Conceptos'
   zfields="cvecon:H='Clave', nomcon:H='Concepto', cuenta:H='Cuenta'"
case zfile='CIAS'
   ztitulo='Tabla de Fideicomisos'
   zfields="prefijo:H='Prefijo', cvecia:H='Clave', nomcia:H='Nombre'"
endcase
*
last_area=SELECT()
select &zfile
go top
if eof()
   select (last_area)
   return .f.
endif
set near on
seek zllave
set near off
if eof()
   go top
endif
                                       ****************************************
                                       *pantalla
                                       ****************************************
DEFINE WINDOW WHELP;
	AT 0.000, 0.000 ;
	SIZE 18.385,71.333 ;
	TITLE 'Ayuda' ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	FLOAT ;
	NOGROW ;
	CLOSE ;
	NOMINIMIZE ;
	NONE
ACTIVATE WINDOW WHELP
@ 0.077,0.167 TO 13.308,70.834 ;
	PEN 1, 8
@ 0.154,0.333 TO 13.154,70.500 ;
	PEN 1, 8 
@ 0.308,0.667 TO 13.077,70.334 ;
	PEN 1, 8 
@ 13.615,22.333 TO 15.230,27.666 ;
	PATTERN 1 ;
	PEN 1, 8 ;
	STYLE "12" 
@ 13.769,59.000 TO 15.384,65.167 ;
	PATTERN 1 ;
	PEN 1, 8 ;
	STYLE "12" 
@ 13.692,0.833 TO 15.307,8.666 ;
	PATTERN 1 ;
	PEN 1, 8 ;
	STYLE "12"
@ 13.923,24.333 SAY "B"  ;
	FONT "MS Sans Serif", 8 ;
	STYLE "BT" 
@ 14.000,60.333 SAY "Esc"  ;
	FONT "MS Sans Serif", 8 ;
	STYLE "BT"
@ 13.923,2.167 SAY "Enter"  ;
	FONT "MS Sans Serif", 8 ;
	STYLE "BT"
@ 14.000,9.000 SAY "Seleccionar"  ;
	FONT "MS Sans Serif", 8 ;
	STYLE "BT"
@ 14.000,28.167 SAY "Buscar"  ;
	FONT "MS Sans Serif", 8 ;
	STYLE "BT"
@ 14.000,65.667 SAY "Salir"  ;
	FONT "MS Sans Serif", 8 ;
	STYLE "BT"
@ 15.923,0.333 TO 15.923,70.500 ;
	PEN 1, 8 ;
	STYLE "1"
@ 15.923,0.333 TO 17.846,0.333 ;
	PEN 1, 8
@ 17.769,0.333 TO 17.769,70.500 ;
	PEN 1, 8 ;
	STYLE "1"
@ 15.923,70.333 TO 17.846,70.333 ;
	PEN 1, 8 
*
DEFINE WINDOW whelpbrow ;
	AT  0.310, 0.670  ;
	SIZE 11.000,83.000 ;
	TITLE ztitulo ;
	FONT "MS Sans Serif", 8 ;
	NOFLOAT ;
	NOGROW ;
	NOCLOSE ;
	NOMINIMIZE ;
	IN WINDOW WHELP
*
                                       ****************************************
                                       *browse
                                       ****************************************
ACTIVATE WINDOW whelpbrow
ON KEY LABEL ENTER DO gsel_reg
ON KEY LABEL B     DO gposfile
BROWSE ;
	NOEDIT ;
	NODELETE ;
	NOAPPEND ;
	NOMENU ;
	SAVE ;
	IN WINDOW WHELPBROW ;
	FIELDS &zfields
*
do case                               && Definici¢n de campos para ayuda
case zfile='TASAS'
case zfile='EXP'
case zfile='IDACRE'
case zfile='ACRE'
case zfile='CPTOS'
   zvalor=cvecon
case zfile='CIAS'
endcase
                                       ****************************************
                                       *salir
                                       ****************************************
ON KEY LABEL ENTER
ON KEY LABEL B
DEACTIVATE WINDOW WHELPBROW
DEACTIVATE WINDOW WHELP
RELEASE WINDOW WHELP
RELEASE WINDOW whelpbrow
SET MESSAGE TO
*
if last_area<>0
   select (last_area)
endif
return seleccion



PROCEDURE GSEL_REG
************
* PROGRAMA : gsel_reg
* OBJETIVO : detecta seleccion en ayuda
************
STORE .T. TO seleccion
keyboard chr(23)
return


PROCEDURE  GPOSFILE
************
* PROGRAMA : GPOSFILE
* OBJETIVO : posiciona en el browse de ayuda
************
*
ON KEY LABEL ENTER
ON KEY LABEL B
activate window whelp
do case
case zfile='EXP' OR zfile = 'REESTRUC'
   zpos=space(40)
	@ 16.385,1.833 GET zpos ;
		SIZE 1.000,66.500 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "B" ;
		PICTURE '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
   read
   zpos=alltrim(zpos)
	@ 16.385,1.833 clear to 16.385+1.000, 1.833+66.500
case zfile='IDACRE'
   zpos=space(40)
	@ 16.385,1.833 GET zpos ;
		SIZE 1.000,66.500 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "B" ;
		PICTURE '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
   read
   zpos=alltrim(zpos)
	@ 16.385,1.833 clear to 16.385+1.000, 1.833+66.500
case zfile='ACRE'
   zpos=space(40)
	@ 16.385,1.833 GET zpos ;
		SIZE 1.000,66.500 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "B" ;
		PICTURE '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
   read
   zpos=alltrim(zpos)
	@ 16.385,1.833 clear to 16.385+1.000, 1.833+66.500
case zfile='CPTOS'
   zpos=space(03)
	@ 16.385,1.833 GET zpos ;
		SIZE 1.000,66.500 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "B" ;
		PICTURE '!!!'
   read
	@ 16.385,1.833 clear to 16.385+1.000, 1.833+66.500
case zfile='CIAS'
   zpos=space(02)
	@ 16.385,1.833 GET zpos ;
		SIZE 1.000,66.500 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "B" ;
		PICTURE '!!'
   read
	@ 16.385,1.833 clear to 16.385+1.000, 1.833+66.500
endcase
set near on
seek zpos
set near off
activate window whelpbrow
ON KEY LABEL ENTER DO gsel_reg
ON KEY LABEL B     DO gposfile
return .t.





*
*                                                                    
* DE VALIDACION DE CLAVES Y BANDERAS                                 
*                                                                    
*

FUNCTION GBUSCCLA
************
* PROGRAMA : gbusccla
* OBJETIVO : Recupera claves que son "constantes" para el sistema
*            por ejemplo PORIVA, arma el vector de errores
************
parameters zdato,zvalor,znumero,ztexcla
last_area=select()
select claves
zdato=padr(upper(alltrim(zdato)),10)
if type('zvalor') = 'N'
   zvalor=str(zvalor,10)
endif
zvalor=padl(upper(alltrim(zvalor)),10)
seek zdato+zvalor
if eof()
   error=.t.

*123456789.123456789.123456789.123456789.
*
*Dato       Valor      Descripcion
*123456789. 123456789. 123456789.12345678

   =adderr('%'+zdato+' '+padr(alltrim(zvalor),10)+' '+ztexcla)
   zint=''
else
   do case
   case znumero=1
      zint=corta
   case znumero=2
      zint=larga
   endcase
endif
if last_area<>0
   select (last_area)
endif
return zint



function gBuscBan
************
* PROGRAMA : gBuscBan
* OBJETIVO : Busca banderas
************
parameters zarchivo,znumband,znombre
select banderas
zarchivo=upper(padr(alltrim(zarchivo),08))
znumband=upper(padr(alltrim(znumband),10))
seek zarchivo+znumband
if eof()

*123456789.123456789.123456789.123456789.
*Archivo  Bandera    Consecutivo de :
*12345678 123456789. 123456789.123456789.

   =adderr('%'+zarchivo+' '+znumband+' '+znombre)
   error=.t.
   zbandera=1111111110
else
   zbandera=bandera
endif
return zbandera




function gactban
************
* PROGRAMA : gactban
* OBJETIVO : toma un consecutivo de banderas
************
parameters zarchivo,znumband
last_area=select()

select banderas
zarchivo=padr(upper(alltrim(zarchivo)),8)
znumband=padr(upper(alltrim(znumband)),10)
zbandera=0
xinvalida=.f.
seek zarchivo+znumband
if eof()
   xinvalida=.t.
else
   if RecLock(1)
      zbandera=bandera
      replace bandera with zbandera+1
      unlock
   else   
      =gmensred('RECLOCK')
      xinvalida=.t.
   endif
endif
if last_area<>0
   select (last_area)
endif
return zbandera



FUNCTION GRECBAN
************
* PROGRAMA : GRECBAN
* OBJETIVO : VALIDA QUE EXISTA UNA BANDERA
************
PARAMETERS ZARCHIVO,ZNUMBAND
LAST_AREA=SELECT()
SELECT BANDERAS
ZARCHIVO=PADR(UPPER(ALLTRIM(ZARCHIVO)),8)
ZNUMBAND=PADR(UPPER(ALLTRIM(ZNUMBAND)),10)
SEEK ZARCHIVO+ZNUMBAND
IF .NOT. EOF()
   zbandera =bandera
   xinvalida=.F.
ELSE
   zbandera =0
   xinvalida=.T.
ENDIF
IF LAST_AREA<>0
   SELECT (LAST_AREA)
ENDIF
RETURN zbandera




*
*                                                                    
* DE PASSWORDS                                                       
*                                                                    
*

function gpass
************
* PROGRAMA : gpass
* OBJETIVO : genera codigo de un password
************
parameters zvalor
if len(zvalor)<>10
   zvalor = padr(zvalor,10)
endif
zpass=''
for i= 1 to 10
   zpass = zpass + chr(asc(substr(zvalor,i,1))+128+i)
next
return zpass


function ginvpass
************
* PROGRAMA : ginvpass
* OBJETIVO : decodifica un password
************
parameters zvalor
if len(zvalor)<>10
   zvalor = padr(zvalor,10)
endif
zpass=''
for i= 1 to 10
   zpass = zpass + chr(asc( substr(zvalor,i,1))- 128 - i)
next
return zpass



function grecpass
************
* PROGRAMA : grecpass
* OBJETIVO : captura password y valida
************
private svpan,zcveusu, znomusu, zdeptousu, zpassword,zpassn,zpass,last_area,i
zcveusu   = space(10)
znomusu   = space(40)
zdeptousu = space(04)
last_area=select()
						 ********************
						 *dibuja pantalla
						 ********************
if gColor256
DEFINE WINDOW wpass ;
	AT  0.000, 0.000  ;
	SIZE 13.692,54.400 ;
	FONT "MS Sans Serif", 8 ;
	NOFLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	SYSTEM ;
	ICON FILE LOCFILE("BMPS\FONDECO.ICO","ICO", ;
		"Where is fondeco?");
    FILL FILE (LOCFILE("bmps\tapete1.bmp","BMP|ICO|PCT|ICN", "Where is tapete1?" ))
else
DEFINE WINDOW wpass ;
	AT  0.000, 0.000  ;
	SIZE 13.692,54.400 ;
	FONT "MS Sans Serif", 8 ;
	NOFLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	SYSTEM ;
	COLOR RGB(,,,192,192,192) ;
	ICON FILE LOCFILE("BMPS\FONDECO.ICO","ICO", ;
		"Where is fondeco?")
endif

*
MOVE WINDOW wpass CENTER
*
Activate window wpass
*
@ 1.154,6.200 SAY (LOCFILE("bmps\llave.bmp","BMP|ICO|PCT|ICN", "Where is llave?" )) BITMAP ;
	SIZE 2.615,6.400 ;
	STYLE "T"
@ 7.231,7.200 SAY "Usuario" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 9.923,7.200 SAY "Password" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 2.077,15.000 SAY "Clave de Acceso" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "BT" ;
	COLOR RGB(255,255,255,,,,)
@ 2.000,14.800 SAY "Clave de Acceso" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "BT" ;
	COLOR RGB(128,128,128,,,,)
@ 2.077,39.600 SAY "Sc" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "BT" ;
	COLOR RGB(255,255,255,,,,)
@ 2.000,39.400 SAY "Sc" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "BT" ;
	COLOR RGB(128,128,128,,,,)
@ 1.923,43.400 SAY "2000" ;
	FONT "Arial", 8 ;
	STYLE "BT" ;
	COLOR RGB(0,0,0,,,,)
@ 2.000,43.600 SAY "2000" ;
	FONT "Arial", 8 ;
	STYLE "BT" ;
	COLOR RGB(255,255,255,,,,)
@ 1.923,43.400 SAY "2000" ;
	FONT "Arial", 8 ;
	STYLE "BT" ;
	COLOR RGB(128,128,128,,,,)
@ 5.308,2.200 TO 12.770,52.400 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,,,,)
@ 5.231,2.000 TO 12.693,52.200 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 0.769,2.000 TO 4.461,52.400 ;
	PEN 1, 8
@ 0.769,2.000 TO 4.384,52.200 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,,,,)
@ 0.769,2.000 TO 0.769,52.000 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 0.846,2.000 TO 4.384,2.000 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)

						 ********************
						 *pide password
						 ********************
=tone(500,2)
=tone(400,2)
=tone(300,2)
if len(alltrim(zcveusu))=0
   zcveusu=space(10)
else
   zcveusu=padr(alltrim(zcveusu),10)
endif
*
zIntentos=3
do while .t.
   @ 7.100,20.000 GET zcveusu ;
      SIZE 1.000,15.300 ;
      FONT "MS Sans Serif", 10 ;
      STYLE "B" ;
      PICTURE "!!!!!!!!!!" ;
      COLOR ,RGB(0,0,0,255,255,255)

		
	read modal
	if lastkey()=27
	   if last_area<>0
	      select (last_area)
	   endif
	   deactivate window wpass
	   return .f.
	endif
	select pass
	seek zcveusu
	if eof()
	   =tone(400,1)
	   =tone(400,1)
	   =tone(400,1)
	   wait 'Clave de Usuario Invalida.' window
	   zIntentos=zintentos-1
	   if zIntentos=0
		   deactivate window wpass
	      if last_area<>0
				 select (last_area)
	      endif
	      return .f.
	   endif
	else
	   znomusu   = nomusu
	   zdeptousu = deptousu
	   exit
	endif
enddo
*	
zIntentos=3
do while .t.
   dimension apassword(10) 
   for i=1 to 10
	apassword[i]=' '
   next
   i=1
   @ 9.800,20.000 SAY "            "  ;
     FONT "Fixedsys", 8
   @ 9.800,20.000 SAY ""  ;
     FONT "Fixedsys", 8
   do while .t.
      zpassn=inkey(0)
      if lastkey()=27
		   deactivate window wpass
	 		if last_area<>0
	    		select (last_area)
		 	endif
	 		return .f.
      endif
      if lastkey()=13
	 		exit
      endif
      if lastkey()=127
         if i-1=0
            apassword[1]=' '
         else
            apassword[i-1]=' '
         endif
         i=iif(i-1=0,1,i-1)
         @ 9.800,20.000 + (1.6 * (i-1)) SAY " "  ;
           FONT "Fixedsys", 8
         @ 9.800,20.000 + (1.6 * (i-1)) SAY ""  ;
           FONT "Fixedsys", 8
      else
	 		if upper(chr(zpassn))<>' '
	    		apassword[i]=upper(chr(zpassn))
            @ 9.800,20.000 + (1.6 * (i-1)) SAY "€"  ;
              FONT "Fixedsys", 8
	    		i=i+1
	    		if i>10
	       		exit
				endif
			endif
      endif
   enddo
   zpassword = apassword[1] + apassword[2] + apassword[3] + apassword[4] +;
               apassword[5] + apassword[6] + apassword[7] + apassword[8] +;
               apassword[9] + apassword[10]
   zvalpass=gpass(zpassword)
   if zvalpass<>pass.pass
	   =tone(400,1)
	   =tone(400,1)
	   =tone(400,1)
	   wait 'Password Invalido.' window
   else
      exit
   endif
   zIntentos=zintentos-1
   if zIntentos=0
	   deactivate window wpass
      if last_area<>0
			 select (last_area)
      endif
      return .f.
   endif
enddo
if last_area<>0
   select (last_area)
endif
deactivate window wpass
*
release window wpass
gusuario = zcveusu
gnomusu  = znomusu
gdepto   = zdeptousu
zvalor   = zcveusu
*
return .t.




function gacceso
************
* PROGRAMA : gacceso
* OBJETIVO : Funcion que valida el acceso de un usuario a cada opcion
************
parameters zopcion, zmensaje
if parameters() = 1
   zmensaje = .f.
endif
zopcion = upper(padr(alltrim( zopcion), 10))
xindice = ascan(gopciones,zopcion )
if xindice<>0
   ret_val=.t.
else
   if zmensaje
      =tone( 400,1)
      =tone( 400,1)
      =tone( 400,1)
      wait 'Acceso Restringido...' window nowait
   endif   
   ret_val=.f.
endif
return ret_val



function gUnAcceso
************
* PROGRAMA : gUnAcceso
* OBJETIVO : Captura password y valida
************
parameters zopcion, zmensaje
private zcveusu, zIntentos, zLastArea,;
        zpassword, zpassn, zpass, i
*
if parameters() = 1
   zmensaje = 'esta opción'
else
   zmensaje = alltrim( zmensaje)   
endif
*
*********************************************************************
* inicializacion de variables
*********************************************************************
*
gUsuAut   = space(10)
zcveusu   = space(10)
zIntentos = 3
*
zSiAbriPass  = .f.
zSiAbriPassD = .f.
*
*********************************************************************
* abrir archivos
*********************************************************************
*
zLastArea = select()
*
if not used( 'pass')
   zSiAbriPassD = .t.
   select 0 
   use pass order pass
endif
if not used( 'passd')
   zSiAbriPassD = .t.
   select 0 
   use passd order passd
endif
*
*********************************************************************
* pantalla
*********************************************************************
*
DEFINE WINDOW wpass ;
	AT  0.000, 0.000  ;
	SIZE 8.769,44.000 ;
	TITLE "Clave de Seguridad" ;
	FONT "MS Sans Serif", 8 ;
	NOFLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	SYSTEM
MOVE WINDOW wpass CENTER
ACTIVATE WINDOW wpass
@ 2.846,1.400 SAY "Usuario" ;
	SIZE 3.000,20.800, 0.000 ;
	FONT "MS Sans Serif", 10 ;
	STYLE "TB"
@ 4.692,1.400 SAY "Password" ;
	SIZE 3.000,20.800, 0.000 ;
	FONT "MS Sans Serif", 10 ;
	STYLE "TB"
*
*********************************************************************
* funcion general
*********************************************************************
*
                                       *************************************
                                       *Captura Usuario
                                       *************************************
do while .t.
   @ 2.846,18.000 GET zcveusu ;
      SIZE 1.000,15.300 ;
      FONT "MS Sans Serif", 10 ;
      STYLE "B" ;
      PICTURE "!!!!!!!!!!" ;
      COLOR ,RGB(0,0,0,255,255,255)

   READ MODAL
   if lastkey() = 27
      if zLastArea<>0
         select (zLastArea)
      endif
      RELEASE WINDOW wpass
      return .f.
   endif
   select pass
   seek zcveusu
   if eof()
      =tone(400,1)
      =tone(400,1)
      =tone(400,1)
      wait 'Clave Invalida.' window
      zIntentos=zintentos-1
      if zIntentos=0
         if zLastArea<>0
            select (zLastArea)
         endif
         RELEASE WINDOW wpass
         return .f.
      endif
   else
  	   exit
   endif
enddo	
gUsuAut = zcveusu

                                       *************************************
                                       *Captura Password
                                       *************************************
zIntentos = 3
do while .t.
   dimension apassword(10) 
   for i=1 to 10
      apassword[i]=' '
   next
   i=1
   @ 4.692,18.000 SAY "            "  ;
     FONT "Fixedsys", 8
   @ 4.692,18.000 SAY ""  ;
     FONT "Fixedsys", 8
   do while .t.
      zpassn = inkey(0)
      if lastkey() = 27
         if zLastArea<>0
            select (zLastArea)
         endif
         RELEASE WINDOW wpass
         return .f.
      endif
      if lastkey() = 13
         exit
      endif
      if lastkey() = 127
         if i-1=0
            apassword[1]=' '
         else
            apassword[i-1]=' '
         endif
         i=iif(i-1=0,1,i-1)
         @ 4.692,18.000 + (1.6 * (i-1)) SAY " "  ;
           FONT "Fixedsys", 8
         @ 4.692,18.000 + (1.6 * (i-1)) SAY ""  ;
           FONT "Fixedsys", 8
      else
         if upper(chr(zpassn))<>' '
            apassword[i]=upper(chr(zpassn))
            @ 4.692,18.000 + (1.6 * (i-1)) SAY "€"  ;
              FONT "Fixedsys", 8
            i=i+1
            if i>10
               exit
            endif
         endif
      endif
   enddo
   zpassword = apassword[1] + apassword[2] + apassword[3] + apassword[4] +;
               apassword[5] + apassword[6] + apassword[7] + apassword[8] +;
               apassword[9] + apassword[10]
   zvalpass=gpass(zpassword)
   if zvalpass <> pass.pass
      =tone(400,1)
      =tone(400,1)
      =tone(400,1)
      wait 'Password Invalido.' window
   else
      exit
   endif
   zIntentos = zintentos - 1
   if zIntentos = 0
      if zLastArea<>0
         select (zLastArea)
      endif
      RELEASE WINDOW wpass
      return .f.
   endif
enddo
                                       *************************************
                                       *Valida Opcion
                                       *************************************
zopcion = padr(alltrim(upper( zopcion)), 10)
select passd
seek zcveusu+zopcion
if eof()
   agerror = ''
   =adderr( ' ')
   =adderr( ' ')
   =adderr( padc( 'Clave no Autorizada para', 70))
   =adderr( padc( zmensaje, 70))
   =gerror()
   if zLastArea<>0
      select (zLastArea)
   endif
   RELEASE WINDOW wpass
   return .f.
endif
*
*********************************************************************
* funcion final
*********************************************************************
*
if zSiAbriPass
   select pass
   use
endif
if zSiAbriPassD
   select passd
   use
endif
if zLastArea<>0
   select (zLastArea)
endif
RELEASE WINDOW wpass
return .t.





*
*                                                                    
* VARIOS                                                             
*                                                                    
*


function gnommes
************
* PROGRAMA : gnommes
* OBJETIVO : transforma un mes en numerico a letras
************
parameters zmes
do case
case zmes=1
   zlmes='Enero'
case zmes=2
   zlmes='Febrero'
case zmes=3
   zlmes='Marzo'
case zmes=4
   zlmes='Abril'
case zmes=5
   zlmes='Mayo'
case zmes=6
   zlmes='Junio'
case zmes=7
   zlmes='Julio'
case zmes=8
   zlmes='Agosto'
case zmes=9
   zlmes='Septiembre'
case zmes=10
   zlmes='Octubre'
case zmes=11
   zlmes='Noviembre'
case zmes=12
   zlmes='Diciembre'
otherwise
   zlmes='Mes Invalido'
endcase
return zlmes



FUNCTION GMES   &&Buscar dms
************
* PROGRAMA : gmes
* OBJETIVO : transforma un mes en numerico a letras
************
parameters zmes
do case
case zmes=1
   zlmes='Enero'
case zmes=2
   zlmes='Febrero'
case zmes=3
   zlmes='Marzo'
case zmes=4
   zlmes='Abril'
case zmes=5
   zlmes='Mayo'
case zmes=6
   zlmes='Junio'
case zmes=7
   zlmes='Julio'
case zmes=8
   zlmes='Agosto'
case zmes=9
   zlmes='Septiembre'
case zmes=10
   zlmes='Octubre'
case zmes=11
   zlmes='Noviembre'
case zmes=12
   zlmes='Diciembre'
otherwise
   zlmes='Mes Invalido'
endcase
return zlmes



function gfectex
************
* PROGRAMA : gfectex
* OBJETIVO : convierte una fecha en texto
************
parameters zfecha, ztipofec
if parameters()=1
   ztipofec = 'DDdMdAAAA'
endif
ztexto = ''
do case
case ztipofec = 'DDdMdAAAA'
   ztexto = ztexto + alltrim(str(day(zfecha),2))+' de '
   ztexto = ztexto + gnommes(month(zfecha))+' de '
   ztexto = ztexto + str(year(zfecha),4)
case ztipofec = 'DDMAAAA'
   ztexto = ztexto + alltrim(str(day(zfecha),2))+' '
   ztexto = ztexto + gnommes(month(zfecha))+' '
   ztexto = ztexto + str(year(zfecha),4)
case ztipofec = 'MDD,AAAA'
   ztexto = ztexto + gnommes(month(zfecha)) + ' '
   ztexto = ztexto + alltrim(str(day(zfecha),2))+', '
   ztexto = ztexto + str(year(zfecha),4)
case ztipofec == 'DD-MMM-AAAA' or ztipofec == 'DD-MMM-AA'
   ztexto = ztexto + alltrim(str(day(zfecha),2))+'-'
   ztexto = ztexto + left(gnommes(month(zfecha)),3) + '-'
   ztexto = ztexto + str(year(zfecha), 4)
case ztipofec == 'DD-MMM-AA'
   ztexto = ztexto + alltrim(str(day(zfecha),2))+'-'
   ztexto = ztexto + left(gnommes(month(zfecha)),3) + '-'
   ztexto = ztexto + str(year(zfecha)-1900, 2)
endcase
return ztexto



FUNCTION GULTDIA
************
* PROGRAMA : gultdia
* OBJETIVO : regresa ultimo dia del mes
************
parameters zfecha
if month(zfecha)=12
   zifecha=ctod('31/12/'+str(year(zfecha)-1900,2))
else
   zifecha=ctod('01/'+str(month(zfecha)+1,2)+'/'+str(year(zfecha),4))-1
endif
return zifecha



FUNCTION GPRIMDIA
************
* PROGRAMA : gprimdia
* OBJETIVO : regresa primer dia del mes
************
parameters zfecha
return ctod('01/'+str(month(zfecha),2)+'/'+str(year(zfecha),4))



FUNCTION GCONCAT
************
* PROGRAMA : gconcat
* OBJETIVO : concatena varios strings quitando blancos
************
parameters ztex1,ztex2,ztex3,ztex4,ztex5,ztex6,ztex7,ztex8,ztex9,ztex10
zstring=''
if len(ztex1)<>0
   zstring=zstring+ltrim(alltrim(ztex1)+' ')
endif
if len(ztex2)<>0
   zstring=zstring+ltrim(alltrim(ztex2)+' ')
endif
if len(ztex3)<>0
   zstring=zstring+ltrim(alltrim(ztex3)+' ')
endif
if len(ztex4)<>0
   zstring=zstring+ltrim(alltrim(ztex4)+' ')
endif
if len(ztex5)<>0
   zstring=zstring+ltrim(alltrim(ztex5)+' ')
endif
if len(ztex6)<>0
   zstring=zstring+ltrim(alltrim(ztex6)+' ')
endif
if len(ztex7)<>0
   zstring=zstring+ltrim(alltrim(ztex7)+' ')
endif
if len(ztex8)<>0
   zstring=zstring+ltrim(alltrim(ztex8)+' ')
endif
if len(ztex9)<>0
   zstring=zstring+ltrim(alltrim(ztex9)+' ')
endif
if len(ztex10)<>0
   zstring=zstring+ltrim(alltrim(ztex10)+' ')
endif
return alltrim(zstring)



FUNCTION GVECTEX
************
* PROGRAMA : gvectex
* OBJETIVO : convierte un texto en un vector de lineas
*            ztexto  ---> texto puede ser un sola linea con un 'chorizo'
*            zancho  ---> de que ancho se desea cada linea del vector
*            znumlin ---> en cuantas lineas se descompone el texto
*            xvectex ---> variable global en donde se vacia cada linea
*                         del texto. Se tiene que definir en el programa
*                         que llama a esta rutina. 
************
parameters ztexto,zancho,znumlin,zcaracter
private i,zrenglon,zratbco
*
for i=1 to znumlin
   if len(ztexto)=0                            &&prevee que ya no hay texto
      xvectex[i]=replicate(zcaracter,zancho)   &&completa los elementos del
      loop                                     &&vecto
   endif
   if len(ztexto)<=zancho                      &&prevee el ultimo renglon a
      xvectex[i]=padr(ztexto,zancho,zcaracter) &&generar
      ztexto=''
      loop
   endif
   zrenglon=substr(ztexto,1,zancho)
   zratbco =rat(' ',zrenglon)                  &&busca el ultimo blanco
   if substr(ztexto,zancho+1,1)<>' '           &&valida los casos en que una
      if zratbco<>0                            &&palabra termina exactamente
         zrenglon=left(ztexto,zratbco)         &&en la columna zancho
      endif
   endif
   zrenglon=alltrim(zrenglon)
   ztexto=ltrim(substr(ztexto,len(zrenglon)+1))
   xvectex[i]=padr(zrenglon,zancho,zcaracter)
next
return .t.




FUNCTION gBTabla
************
* PROGRAMA : gBTabla
* OBJETIVO : Borra una Tabla con sus Indices
************
parameters ztabla
*
ztabla= upper(alltrim(ztabla))
*
ztabla1 = ztabla + '.DBF'
ztabla2 = ztabla + '.FPT'
ztabla3 = ztabla + '.IDX'
ztabla4 = ztabla + '.CDX'
*
erase &ztabla1
erase &ztabla2
erase &ztabla3
erase &ztabla4
*
return .t.


*
*                                                                    
* DE INTERFACE CON EL USUARIO                                        
*                                                                    
*

function gsino
************
* PROGRAMA : gsino
* OBJETIVO : Pregunta SI o NO
************
parameters zmensaje, ztonos
private zopcion
zparams =parameters()
zopcion = 0
if zparams = 1
   ztonos = .f.
endif
*
*
DEFINE WINDOW wgsino ;
		AT  0.000, 0.000  ;
		SIZE 8.063,40.143 ;
		TITLE " " ;
		FONT "MS Sans Serif", 10 ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		COLOR RGB(,,,192,192,192);
		SYSTEM
MOVE WINDOW wgsino CENTER
ACTIVATE WINDOW WGSINO
*
*
on key label S do gSelSINO with 1
on key label N do gSelSINO with 2
*
*
@ 0.375,0.857 SAY (LOCFILE("bmps\flash.bmp","BMP|ICO|PCT|ICN", "Where is flash?" )) BITMAP ;
	SIZE 2.500,5.714
@ 1.813,7.857 SAY zmensaje ;
	SIZE 2.000,30.429 ;
	FONT "MS Sans Serif", 10 ;
	COLOR RGB(0,0,0,192,192,192)
@ 4.875,9.000 GET zopcion ;
	PICTURE "@*BHT " + ;
		(LOCFILE("bmps\si.bmp","BMP|ICO|PCT|ICN","Where is si?")) + ";" + ;
		(LOCFILE("bmps\no.bmp","BMP|ICO|PCT|ICN","Where is no?")) ;
	SIZE 2.063,9.714,2.857 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 10


if ztonos
   =tone( 400,1)
   =tone( 400,1)
   =tone( 400,1)
endif


READ CYCLE MODAL
*
*
on key label S
on key label N
*
*
release window wgsino
do case
case zopcion = 1
   return 'S'
case zopcion = 2
   return 'N'
endcase
return 'N'


function gSelSINO
************
* PROGRAMA : gSelSINO
* OBJETIVO : seleciona
************
parameters zobjeto
_curobj = zobjeto
keyboard chr(13)
return


function gnosi
************
* PROGRAMA : gnosi
* OBJETIVO : Pregunta NO o SI
************
parameters zmensaje, ztonos
private zopcion
zparams =parameters()
zopcion = 0
if zparams = 1
   ztonos = .f.
endif
*
DEFINE WINDOW wgsino ;
	AT  0.000, 0.000  ;
	SIZE 8.063,40.143 ;
	TITLE " " ;
	FONT "MS Sans Serif", 10 ;
	FLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	COLOR RGB(,,,192,192,192);
	SYSTEM
MOVE WINDOW wgsino CENTER
ACTIVATE WINDOW WGSINO
*
*
on key label S do gSelSINO with 2
on key label N do gSelSINO with 1
*
*
@ 0.375,0.857 SAY (LOCFILE("bmps\flash.bmp","BMP|ICO|PCT|ICN", "Where is flash?" )) BITMAP ;
	SIZE 2.500,5.714
@ 1.813,7.857 SAY zmensaje ;
	SIZE 2.000,30.429 ;
	FONT "MS Sans Serif", 10 ;
	COLOR RGB(0,0,0,192,192,192)
@ 4.875,9.000 GET zopcion ;
	PICTURE "@*BHT " + ;
		(LOCFILE("bmps\no.bmp","BMP|ICO|PCT|ICN","Where is no?")) + ";" + ;
		(LOCFILE("bmps\si.bmp","BMP|ICO|PCT|ICN","Where is si?")) ;
	SIZE 2.063,9.714,2.857 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 10


if ztonos
   =tone( 400,1)
   =tone( 400,1)
   =tone( 400,1)
endif


READ CYCLE MODAL
*
*
on key label S
on key label N
*
*
release window wgsino
do case
case zopcion = 1
   return 'N'
case zopcion = 2
   return 'S'
endcase
return 'N'




function gsinobig
************
* PROGRAMA : gsinobig
* OBJETIVO : Pregunta SI o NO
************
parameters zmensaje, ztonos
private zopcion
zparams =parameters()
zopcion = 0
if zparams = 1
   ztonos = .f.
endif
*
*
DEFINE WINDOW wgsino ;
	AT  0.000, 0.000  ;
	SIZE 9.500,41.429 ;
	TITLE " " ;
	FONT "MS Sans Serif", 10 ;
	FLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	COLOR RGB(,,,192,192,192);
	SYSTEM
MOVE WINDOW wgsino CENTER
ACTIVATE WINDOW WGSINO
*
*
on key label S do gSelSINO with 1
on key label N do gSelSINO with 2
*
*
@ 0.313,0.714 SAY (LOCFILE("bmps\flash.bmp","BMP|ICO|PCT|ICN", "Where is flash?" )) BITMAP ;
	SIZE 2.500,5.714
@ 0.688,8.714 SAY zmensaje ;
	SIZE 5.000,30.857 ;
	FONT "MS Sans Serif", 10 ;
	COLOR RGB(0,0,0,192,192,192)
@ 6.813,12.286 GET zopcion ;
	PICTURE "@*BHT " + ;
		(LOCFILE("bmps\si.bmp","BMP|ICO|PCT|ICN","Where is si?")) + ";" + ;
		(LOCFILE("bmps\no.bmp","BMP|ICO|PCT|ICN","Where is no?")) ;
	SIZE 2.063,9.714,2.857 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 10


if ztonos
   =tone( 400,1)
   =tone( 400,1)
   =tone( 400,1)
endif

READ CYCLE MODAL
*
*
on key label S
on key label N
*
release window wgsino
do case
case zopcion = 1
   return 'S'
case zopcion = 2
   return 'N'
endcase
return 'N'



function gnosibig
************
* PROGRAMA : gnosibig
* OBJETIVO : Pregunta NO o SI
************
parameters zmensaje, ztonos
private zopcion
zparams =parameters()
zopcion = 0
if zparams = 1
   ztonos = .f.
endif
*
*
DEFINE WINDOW wgsino ;
	AT  0.000, 0.000  ;
	SIZE 9.500,41.429 ;
	TITLE " " ;
	FONT "MS Sans Serif", 10 ;
	FLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	COLOR RGB(,,,192,192,192);
	SYSTEM
MOVE WINDOW wgsino CENTER
ACTIVATE WINDOW WGSINO
*
*
on key label S do gSelSINO with 2
on key label N do gSelSINO with 1
*
*
@ 0.313,0.714 SAY (LOCFILE("bmps\flash.bmp","BMP|ICO|PCT|ICN", "Where is flash?" )) BITMAP ;
	SIZE 2.500,5.714
@ 0.688,8.714 SAY zmensaje ;
	SIZE 5.000,30.857 ;
	FONT "MS Sans Serif", 10 ;
	COLOR RGB(0,0,0,192,192,192)
@ 6.813,12.286 GET zopcion ;
	PICTURE "@*BHT " + ;
		(LOCFILE("bmps\no.bmp","BMP|ICO|PCT|ICN","Where is no?")) + ";" + ;
		(LOCFILE("bmps\si.bmp","BMP|ICO|PCT|ICN","Where is si?")) ;
	SIZE 2.063,9.714,2.857 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 10


if ztonos
   =tone( 400,1)
   =tone( 400,1)
   =tone( 400,1)
endif


READ CYCLE MODAL
*
*
on key label S
on key label N
*
*
release window wgsino
do case
case zopcion = 1
   return 'N'
case zopcion = 2
   return 'S'
endcase
return 'N'




function gOk
************
* PROGRAMA : gOk
* OBJETIVO : Mensaje con OK
************
parameters zmensaje, ztonos
private zopcion
zparams =parameters()
zopcion = 1
if zparams = 1
   ztonos = .f.
endif
*
*
DEFINE WINDOW wgok ;
	AT  0.000, 0.000  ;
	SIZE 10.313,42.571 ;
	TITLE " " ;
	FONT "MS Sans Serif", 10 ;
	FLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	COLOR RGB(,,,192,192,192);
	SYSTEM
MOVE WINDOW wgok CENTER
ACTIVATE WINDOW wgok
*
*
@ 0.313,0.714 SAY (LOCFILE("bmps\flash.bmp","BMP|ICO|PCT|ICN", "Where is flash?" )) BITMAP ;
	SIZE 2.500,5.714
@ 0.688,8.714 SAY zmensaje ;
	SIZE 6.000,30.857 ;
	FONT "MS Sans Serif", 10 ;
	COLOR RGB(0,0,0,192,192,192)
@ 7.375,16.857 GET zopcion ;
	PICTURE "@*BHT " + ;
		(LOCFILE("bmps\ok.bmp","BMP|ICO|PCT|ICN","Where is ok?")) ;
	SIZE 2.250,12.286,2.857 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 10


if ztonos
   =tone( 400,1)
   =tone( 400,1)
   =tone( 400,1)
endif

READ CYCLE MODAL
*
*
release window wgok
return




FUNCTION gsinoc
************
* PROGRAMA : gsinoc
* OBJETIVO : Pregunta SI o NO o CANCELAR
************
PARAMETERS ZTEXTO
DEFINE WINDOW wgsinoc ;
	AT  0.000, 0.000  ;
	SIZE 08.000,45.000 ;
	FONT "MS Sans Serif", 8 ;
	FLOAT ;
	NOCLOSE ;
	NOMINIMIZE;
	SYSTEM
MOVE WINDOW wgsinoc CENTER
ACTIVATE WINDOW WGSINOC
*
ZOPCION=1
*
@ 1.000,1.000 SAY (LOCFILE("informac.bmp","BMP|ICO", "Where is informac?")) BITMAP ;
	SIZE 3.462,9.000 ;
	STYLE "T"
@ 1.538,09.500 + (WCOLS() - 09.500 - TXTWIDTH(ztexto,'MS Sans Serif',10,'N')* ;
	FONTMETRIC(6,'MS Sans Serif',10,'N')/FONTMETRIC(6))/2  ;
	SAY ztexto ;
	FONT "MS Sans Serif", 10 ;
	STYLE "N"
@ 5.5000,06.000 GET zopcion ;
	PICTURE "@*HT \<No;\<Si;\<Cancelar" ;
	SIZE 1.769,9.500,1.000 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B"
READ CYCLE
DEACTIVATE WINDOW WGSINOC
RELEASE WINDOW WGSINOC &&SAME
DO CASE
CASE ZOPCION=1
   RETURN 'N'
CASE ZOPCION=2
   RETURN 'S'
CASE ZOPCION=3
   RETURN 'C'
ENDCASE




FUNCTION TONE
************
* PROGRAMA : tone
* OBJETIVO : rutina para mandar sonidos
************
parameters freq,duracion,reps
private freq,duracion,reps,i
do case
case parameters()=0
   freq    =400
   duracion=2
   reps    =1
case parameters()=1
   duracion=3
   reps    =1
case parameters()=2
   reps    =1
endcase
freq    =iif(freq<20,20,freq)
duracion=iif(duracion=0,1,duracion)
for i=1 to reps
   set bell to freq,duracion
   ??chr(7)
endfor
set bell to
return ('')




FUNCTION GGETCN
************
* PROGRAMA : ggetcn
* OBJETIVO : Convierte una variable alfanumerica a numerica
*          : para efectos de los gets
************
parameter zcomodin
*
if parameters() = 0
   zcomodin = .f.
endif
*
zvar = varread()
z    = alltrim(right(&zvar,1))
*
&zvar=iif(val(&zvar)<> 0 , str(val(&zvar),len(&zvar)) , space(len(&zvar)) )
*
if zcomodin and z = '?'
   &zvar= padl( alltrim(&zvar), len(&zvar)-1 ) + '?'
endif
*
return .t.



FUNCTION GGETCNCA
************
* PROGRAMA : ggetcnca
* OBJETIVO : Convierte una variable alfanumerica a numerica y un Alfanumero al Final
*          : para efectos de los gets
************
*
if parameters() = 0
   zcomodin = .f.
endif
*
zvar = varread()
z    = iif( !empty(alltrim(&zvar)) ,  right( alltrim(&zvar) , 1 )  , space(01) )
*
&zvar=iif(val(&zvar)<> 0 , str(val(&zvar),len(&zvar)) , space(len(&zvar)) )
&zvar= padl( alltrim(&zvar), len(&zvar)-1 ) + z
*
return .t.




function gwinname
************
* PROGRAMA : gwinname
* OBJETIVO : Presenta nombre de programa
************
parameters ztexto
*
gPrgAct = ztexto
*
ztexto=upper(alltrim(ztexto))
*
zrow1=wrows()-1.150
zcol1=wcols()-14
zrow2=wrows()-0.150
zcol2=wcols()-0.500
zrow3=wrows()-1.100
*
@ zrow1,zcol1 TO zrow2,zcol2 ;
	PATTERN 1 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,192,192,192)
@ zrow1,zcol1 TO zrow1,zcol2 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ zrow1,zcol1 TO zrow2,zcol1 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ zrow3,(((zcol2-zcol1) - txtwidth(ztexto,'MS Serif',7)* ;
	fontmetric(6,'MS Serif',7)/fontmetric(6))/2)+zcol1  ;
	say ztexto ;
	FONT "MS Serif", 7 ;
	STYLE "T"
return



procedure gnohay
************
* PROGRAMA : GNOHAY
* OBJETIVO : MENSAJE QUE INDICA QUE LA OPCION NO SE PUEDE EJECUTAR
* AUTOR    : Nova Alto Nivel en Sistemas, S.A. de C.V.
*          : jem
* FECHA    : 13may92
************
DEFINE WINDOW WGNOHAY ;
	AT  0.000, 0.000  ;
	SIZE 9.538,51.400 ;
	FONT "MS Sans Serif", 8 ;
	FLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	SYSTEM
MOVE WINDOW WGNOHAY CENTER
ACTIVATE WINDOW WGNOHAY
*
ZOPCION=1
*
@ 1.000,5.200 SAY 'OPCION NO DESARROLLADA   !!!' ;
	SIZE 3.000,33.333 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" 
@ 5.538,20.400 GET zopcion ;
	PICTURE "@*HT \<OK" ;
	SIZE 1.769,12.667,0.333 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B"
READ CYCLE
RELEASE WINDOW WGNOHAY SAME
RETURN .T.




*
*                                                                    
* ERRORES Y AVISOS                                                   
*                                                                    
*


function adderr
************
* PROGRAMA : adderr
* OBJETIVO : genera vector de mensajes de error
************
parameters ztexto
if len(agerror)<>0
   dimension agerror[alen(agerror)+1]
   agerror[alen(agerror)]=ztexto
else
   dimension agerror[1]
   agerror[1]=ztexto
endif
return



function gerror
************
* PROGRAMA : gerror
* OBJETIVO : muestra los errores de una validacion
************
private zlinea
*
if gColor256
	DEFINE WINDOW werror ;
		AT  0.000, 0.000  ;
		SIZE 15.308,70.000 ;
		TITLE "Errores" ;
		FONT "MS Sans Serif", 8 ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM ;
		COLOR RGB(,,,255,255,206)
else
	DEFINE WINDOW werror ;
		AT  0.000, 0.000  ;
		SIZE 15.308,70.000 ;
		TITLE "Errores" ;
		FONT "MS Sans Serif", 8 ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM;
		COLOR RGB(,,,255,255,0)
endif
*
MOVE WINDOW werror CENTER
ACTIVATE WINDOW WERROR
*
do case
case gtono = 0
case gtono = 1
   =tone(500,1)
case gtono = 2
   =tone(400,1)
   =tone(400,1)
case gtono = 3
   =tone(500,1)
   =tone(400,1)
   =tone(300,1)
case gtono = 9
   =gSndError()
endcase
*
for i=1 to alen(agerror)
   if i>10
      exit
   endif
   zlinea=agerror[i]
   if substr(zlinea,1,1)='%'
      if gColor256
	     @ 0.077+((i-1)*1.308),0.200 SAY ;
		   (LOCFILE("bmps\punto.bmp","BMP|ICO|PCT|ICN", "Where is punto?" )) BITMAP ;
    	   SIZE 1.000,2.400 ;
	       STYLE "T"
	  else    
    	 @ 0.077+((i-1)*1.308),0.200 SAY 'x' ;
			SIZE 1.000,1.000 ;
			FONT "Wingdings", 10 ;
			STYLE "B" ;
			COLOR RGB(0,0,128,255,255,0)
      endif
      *
	  zlinea=substr(zlinea,2,len(zlinea))     
   endif
   
   if type('gfontfijo')<>'U'
      if gfontfijo
         if gColor256
			@ 0.077+((i-1)*1.308),3.200 SAY zlinea ;
				SIZE 1.000,41.125 ;
				FONT "Fixedsys", 9 ;
				STYLE "N" ;
				COLOR RGB(0,0,0,255,255,206)
         else
			@ 0.077+((i-1)*1.308),3.200 SAY zlinea ;
				SIZE 1.000,41.125 ;
				FONT "Fixedsys", 9 ;
				STYLE "N" ;
				COLOR RGB(0,0,128,255,255,0)
         endif
		else
         if gColor256
			@ 0.077+((i-1)*1.308),3.200 SAY zlinea ;
				SIZE 1.000,46.780 ;
				FONT "MS Sans Serif", 10 ;
				STYLE "N" ;
				COLOR RGB(0,0,0,255,255,206)
         else
			@ 0.077+((i-1)*1.308),3.200 SAY zlinea ;
				SIZE 1.000,46.780 ;
				FONT "MS Sans Serif", 10 ;
				STYLE "N" ;
				COLOR RGB(0,0,128,255,255,0)
         endif
		endif           
   else       
        if gColor256
    		@ 0.077+((i-1)*1.308),3.200 SAY zlinea ;
			SIZE 1.000,46.780 ;
			FONT "MS Sans Serif", 10 ;
			STYLE "N" ;
			COLOR RGB(0,0,0,255,255,206)
        else
       		@ 0.077+((i-1)*1.308),3.200 SAY zlinea ;
			SIZE 1.000,46.780 ;
			FONT "MS Sans Serif", 10 ;
			STYLE "N" ;
			COLOR RGB(0,0,128,255,255,0)
       endif
   endif
next
@ 12.923,28.600 GET zopcion ;
	PICTURE "@*HT \OK" ;
	SIZE 1.769,10.500,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B"
READ CYCLE MODAL

deactivate window werror
release window werror
*
agerror = ''
*
return .t.




function addavi
************
* PROGRAMA : addavi
* OBJETIVO : genera vector de mensajes de aviso
************
parameters ztexto
if len(aaviso)<>0
   dimension aaviso[alen(aaviso)+1]
   aaviso[alen(aaviso)]=ztexto
else
   dimension aaviso[1]
   aaviso[1]=ztexto
endif
return
return .t.


function gAviso
************
* PROGRAMA : gaviso
* OBJETIVO : muestra avisos para un proceso
************
parameters zlinea
DEFINE WINDOW waviso ;
	AT  0.000, 0.000  ;
	SIZE 15.308,70.000 ;
	TITLE "A v i s o" ;
	FONT "MS Sans Serif", 8 ;
	FLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	SYSTEM ;
	COLOR RGB(,,,255,255,255)
MOVE WINDOW waviso CENTER
ACTIVATE WINDOW waviso
*
do case
case gtono = 0
case gtono = 1
   =tone(500,1)
case gtono = 2
   =tone(400,1)
   =tone(400,1)
case gtono = 3
   =tone(500,1)
   =tone(400,1)
   =tone(300,1)
case gtono = 9
   =gSndError()
endcase
*
for i=1 to alen(aaviso)
   if i>10
      exit
   endif
   zlinea=aaviso[i]
   if substr(zlinea,1,1)='%'
		@ 0.077+((i-1)*1.308),0.200 SAY 'm' ;
			SIZE 1.000,1.000 ;
			FONT "Wingdings", 10 ;
			STYLE "B" ;
			COLOR RGB(0,128,0,255,255,255)
		zlinea=substr(zlinea,2,len(zlinea))     
   endif
	@ 0.077+((i-1)*1.308),3.200 SAY zlinea ;
		SIZE 1.000,47.000 ;
		FONT "MS Sans Serif", 10 ;
		STYLE "N" ;
		COLOR RGB(0,128,0,255,255,255)
next
@ 12.923,28.600 GET zopcion ;
	PICTURE "@*HT \OK" ;
	SIZE 1.769,10.500,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B"
READ CYCLE MODAL
*
deactivate window waviso
release window waviso
return .t.





function gErrorFox
************
* PROGRAMA : gErrorFox
* OBJETIVO : Muestra Errores de Fox
************
*
parameter zproced
*
if parameters() <= 0
   zprogram = ''
endif
*
on error
*
dimension aagerror[3]
aagerror  =''
zerror  = 1
zIgnora = .f.
*
aagerror[1] = space(01) + 'Error       :  ' + alltrim(STR(ERROR()) )
aagerror[2] = space(01) + 'Linea      :  '  + MESSAGE(1)  
aagerror[3] = space(01) + 'Mensaje :  '     + MESSAGE() 
*
select 0
use syserror
append blank
replace ;
   numero  with alltrim(STR(ERROR()) ) ,;
   linea   with MESSAGE(1)  ,;
   mensaje with MESSAGE()   ,;
   fecha   with date()      ,;   
   hora    with time()      ,;
   cveusu  with gusuario    ,;
   program with gprgAct     ,;
   proced  with zproced
   
select syserror
use 
*
DEFINE WINDOW wErrorFox ;
	AT  0.000, 0.000  ;
	SIZE 13.462,74.600 ;
	FONT "MS Sans Serif", 8 ;
    TITLE 'Error Fox';
	FLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	SYSTEM
MOVE WINDOW wErrorFox CENTER
*
ACTIVATE WINDOW wErrorFox
*
@ 0.000,0.000 SAY (LOCFILE("bmps\tapete3.bmp","BMP|ICO|PCT|ICN", "Where is tapete3?" )) BITMAP ;
	SIZE 13.462,74.600 ;
	STRETCH ;
	STYLE "T"
@ 0.615,1.600 SAY (LOCFILE("bmps\flash2.bmp","BMP|ICO|PCT|ICN", "Where is flash2?" )) BITMAP ;
	SIZE 2.769,7.400 ;
	STYLE "T"
@ 10.692,27.800 TO 12.692,44.400 ;
	PEN 1, 8
@ 10.692,27.800 TO 12.615,44.200 ;
	PATTERN 1 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,192,192,192)
@ 10.692,28.000 TO 10.692,44.200 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 10.692,27.800 TO 12.538,27.800 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 11.231,34.600 SAY "OK" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
*
@ 11.000,28.600 GET zOK ;
	PICTURE "@*IHT \? " ;
	SIZE 1.462,15.000,0.800 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8
@ 1.000,9.800 GET zerror ;
 	PICTURE "@&N" ;
	FROM aagerror ;
	SIZE 9.231,62.200 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(,,,255,255,255),RGB(,,,255,255,255)

ON KEY LABEL F8 do xIgnora_Error
*
read cycle modal
*
ON KEY LABEL F8
*
RELEASE WINDOW wErrorFox
*
if zIgnora
   on error do gErrorFox with program()
else
   if file( 'Fondeco.TXT')
      Cancel
   else
      quit
   endif
endif   
*
return


function xIgnora_Error
************
* PROGRAMA : xIgnora_Error
* OBJETIVO : Ignara Error de Fox
************
*
if gUnAcceso( 'SUPERVISOR', 'Ingnora error de Fox')
   zIgnora = .t.
   *
   _curobj = objnum(zOK)
   keyboard '{ENTER}'
endif
*
return 


function gOnError
************
* PROGRAMA : gOnError
* OBJETIVO : Activa Mensajes de Error de Fox
************
*
if file('Fondeco.TXT')
   on error 
else
   on error do gErrorFox with program()
endif



*
*                                                                    
* RUTINAS VARIAS                                                     
*                                                                    
*

function gDelBar
*************
* PROGRAMA  : gDelBar
* OBJETIVO  : Borra las opciones para que x Usuario no entre, ni siquiera
*             vea las opciones
*************
parameters zpopup,zbar1, zbar2, zbar3, zbar4, zbar5, zbar6, zbar7, zbar8, zbar9, zbar10
if not gEsPemex
   return
endif
znparams=parameters()
if znparams>1
   release bar zbar1 of &zpopup
endif   
if znparams>2
   release bar zbar2 of &zpopup
endif   
if znparams>3
   release bar zbar3 of &zpopup
endif   
if znparams>4
   release bar zbar4 of &zpopup
endif   
if znparams>5
   release bar zbar5 of &zpopup
endif   
if znparams>6
   release bar zbar6 of &zpopup
endif   
if znparams>7
   release bar zbar7 of &zpopup
endif   
if znparams>8
   release bar zbar8 of &zpopup
endif   
if znparams>9
   release bar zbar9 of &zpopup
endif   
if znparams>10
   release bar zbar10 of &zpopup
endif   
return



function gDirectory
*************
* PROGRAMA  : gDirectory
* OBJETIVO  : valida si existe un directorio
*************
parameters zDirectorio

zError=.f.                             &&indica si hay error
*
zDirectorio = alltrim(zDirectorio)
if right(zDirectorio,1)='\'
   zDirectorio = substr(zDirectorio,1,len(zDirectorio)-1)
endif
*
********************************************************************
* genera un archivo temporal
********************************************************************
*
zTexTmp='nada1'
zTmpTxT=sys(3)+'.tmp'
zTmpDbf=sys(3)


create dbf (zTmpDbf) ;
(texto     M(10))
*
append blank
replace texto with zTexTmp
copy memo texto to (zTmpTxT)
use
*
*******************************************************************
* intenta copiar el temporal
********************************************************************
*
on error do gErrDir
copy file (zTmpTxT) to (zDirectorio+'\'+zTmpTxT)
*
=gOnError()
*
if file(zTmpTxT)
   erase (zTmpTxT)
endif
if file(zDirectorio+'\'+zTmpTxT)
   erase (zDirectorio+'\'+zTmpTxT)
endif
if file(zTmpDbf+'.DBF')
   erase (zTmpDbf+'.DBF')
endif
if file(zTmpDbf+'.FPT')
   erase (zTmpDbf+'.FPT')
endif
return .not. zError


procedure gErrDir
if error()=202
   zError=.t.
endif
return



function valinterfaz
************
* PROGRAMA : Valinterfaz
* OBJETIVO : Valida la interfaz de proteccion
************
if getenv('160498')='OFF'
   return .t.
endif
zposicion  = 1
zesperado  = 65534
zstatusflg = 0
zcontenido = 0
zretorno    = '00000'

*LOAD PEGE  &&dms Investigar
IF zPosicion < 10
   zposicion2 = '0'+STR(zposicion,1)+zretorno
ELSE
   zposicion2 = STR(zposicion,2)+zretorno
ENDIF
*CALL PEGE WITH  zposicion2   &&dms Investigar
zstatusflg = VAL( LEFT(zposicion2,2) )
zcontenido = VAL( RIGHT (LEFT(zposicion2,7), 5) )
IF zcontenido # 0
   IF zesperado = zcontenido 
*     ------ INTERFACE TECSIN ENCONTRADA -------- 
      zexiste=.t.
   ELSE
*     --- INTERFACE ERRONEA O NO SE ENCUENTRA --- 
      zexiste=.f.
   ENDIF
ELSE
*  --- INTERFACE ERRONEA O NO SE ENCUENTRA --- 
   zexiste=.f.
ENDIF
IF .not.zexiste 
   agerror=''
   =adderr('                                        ')
   =adderr('                                        ')
   =adderr('                                        ')
   =adderr('INTERFAZ DE PROTECCION NO ENCONTRADA')
   =adderr('                     ACCESO RESTRINGIDO ')
   =gerror()
   agerror=''
ENDIF
return zexiste



procedure gLimpiaScr
************
* PROGRAMA : gLimpiaScr
* OBJETIVO : Cierra ventanas, menus y archivos
************
DEACTIVATE WINDOW ALL
RELEASE WINDOW ALL
SET SYSMENU TO DEFAULT
CLOSE ALL
SET DEVICE TO SCREEN
gsalir=.t.            && Sale del sistema (desarrollo)
return




function gFldStr
*************
* PROGRAMA  : gFldStr
* OBJETIVO  : genera un string con los campos que deben ser de 
*             acuerdo al mes actual
*************
parameters zStr, zMes1, zMes2, zQuitaUltimo
private zi
*
zfields= ''
*
do case
case at( 'Suma(mes(i..j))', zStr) <> 0
   ztexto = ''
   for zi = zMes1 to zMes2
      zmes   = 'mes'+alltrim(str(zi))
      ztexto = ztexto + zmes+'+'
   next
   ztexto = left( ztexto, len( ztexto)-1)
   zfields = strtran( zStr, 'Suma(mes(i..j))', ztexto )
otherwise
   for zi = zMes1 to zMes2
      ztexto = zStr
      if at( 'mes(i)', zStr) <> 0
         zmes   = 'mes'+alltrim(str(zi))
         ztexto = strtran( ztexto, 'mes(i)', zmes )
      endif   
      if at( 'mesname(i)', zStr) <> 0
         zmes   = alltrim( gnommes(zi))
         ztexto = strtran( ztexto, 'mesname(i)', zmes )
      endif
      zfields = zfields + ztexto
   next
endcase
if zQuitaUltimo
   zfields = left( zfields, len(zfields)-1)
endif
return zfields



function gFont
************
* PROGRAMA : gFont
* OBJETIVO : Ajusta un texto al tamano deseado de acuerdo al font
*            seleccionado
* NOTAS    :
*            SOLO FUNCION PARA LOS SIGUIENTES FONTS
*                 'Arial'        ,  8, 'N'
*                 'MS Sans Serif',  8, 'N'
*                 'MS Sans Serif', 10, 'N'
*                 'Small Fonts'  ,  7, 'N'
*            ya se sabe que el tamaño del pixel en este font, 
*            el tamaño promedio del font
*
*            eL ZLEN es el tamano pero en caracteres del font
************
parameters ztexto, zlen, ztamano, zFont
private zparams, zpromedio, ztampixel, ztamblanco, zajustar, zajuste
zparams = parameters()
if zparams <= 2
   ztamano = 8
endif
if zparams <= 3
   zFont = 'MSSansSerif'
endif
ztexto2 = ztexto
if type( 'ztamano') <> 'N'
   ztamano = 8
endif
do case
case zFont = 'Arial' and ztamano = 10
                                       &&constantes

   zpromedio = 6                       &&FONTMETRIC ( 6, "Small Fonts", 7, 'N')
   ztampixel = 0.166                   &&DIBUJAR UNA RAYA DE 10 PIXELES Y DIVIDIR
                                       &&EL ANCHO ENTRE 10
   ztamblanco= 0.667                   &&TXTWIDTH ( ' ', "Small Fonts", 7, 'N')
   zajustar  = (zpromedio * ztampixel) * zlen
case ztamano = 7
                                       &&constantes
   zpromedio = 5                       &&FONTMETRIC ( 6, "Small Fonts", 7, 'N')
   ztampixel = 0.200                   &&DIBUJAR UNA RAYA DE 10 PIXELES
   ztamblanco= 0.400                   &&TXTWIDTH ( ' ', "Small Fonts", 7, 'N')
   zajustar  = (zpromedio * ztampixel) * zlen
case ztamano = 8
                                       &&constantes
   zpromedio = 5
   ztampixel = 0.200
   ztamblanco= 0.600
   zajustar  = (zpromedio * ztampixel) * zlen
case ztamano = 10
                                       &&constantes
   zpromedio = 7
   ztampixel = 0.143
   ztamblanco= 0.429
   zajustar  = (zpromedio * ztampixel) * zlen
endcase
*
ztexto2 = alltrim( ztexto2)
*
do case
case zFont = 'Arial' and ztamano = 10
   do while .t.
      if txtwidth( ztexto2, 'Arial', 10, 'N') <= zajustar
         zajuste = zajustar - txtwidth( ztexto2, 'Arial', 10, 'N')
         ztexto2 = ztexto2 + replicate( ' ', floor( zajuste / ztamblanco))
         exit
      endif
      ztexto2 = left( ztexto2, len( ztexto2) -1)
   enddo
case ztamano = 7
   do while .t.
      if txtwidth( ztexto2, 'Small Fonts', 7, 'N') <= zajustar
         zajuste = zajustar - txtwidth( ztexto2, 'Small Fonts', 7, 'N')
         ztexto2 = ztexto2 + replicate( ' ', floor( zajuste / ztamblanco))
         exit
      endif
      ztexto2 = left( ztexto2, len( ztexto2) -1)
   enddo
case ztamano = 8
   do while .t.
      if txtwidth( ztexto2, 'MS Sans Serif', 8, 'N') <= zajustar
         zajuste = zajustar - txtwidth( ztexto2, 'MS Sans Serif', 8, 'N')
         ztexto2 = ztexto2 + replicate( ' ', floor( zajuste / ztamblanco))
         exit
      endif
      ztexto2 = left( ztexto2, len( ztexto2) -1)
   enddo
case ztamano = 10
   do while .t.
      if txtwidth( ztexto2, 'MS Sans Serif', 10, 'N') <= zajustar
         zajuste = zajustar - txtwidth( ztexto2, 'MS Sans Serif', 10, 'N')
         ztexto2 = ztexto2 + replicate( ' ', floor( zajuste / ztamblanco))
         exit
      endif
      ztexto2 = left( ztexto2, len( ztexto2) -1)
   enddo
endcase
return ztexto2



function gFontIzq
************
* PROGRAMA : gFontIzq
* OBJETIVO : Ajusta un texto al tamano deseado de acuerdo al font
*            seleccionado
* NOTAS    :
*            SOLO FUNCION PARA LOS SIGUIENTES FONTSÇ
*                 'MS Sans Serif', 8, 'N'
*                 'MS Sans Serif', 10, 'N'
*                 'Small Fonts',   7,  'N'
*            ya se sabe que el tamaño del pixel en este font, 
*            el tamaño promedio del font
*
*            eL ZLEN es el tamano pero en caracteres del font
************
parameters ztexto, zlen, ztamano
private zpromedio, ztampixel, ztamblanco, zajustar, zajuste
if parameters() = 2
   ztamano = 8
endif
ztexto2 = ztexto
if type( 'ztamano') <> 'N'
   ztamano = 8
endif
do case
case ztamano = 7
                                       &&constantes
   zpromedio = 5                       &&FONTMETRIC ( 6, 'Small Fonts', 7, 'N')
   ztampixel = 0.200                   &&DIBUJAR UNA RAYA DE 10 PIXELES
   ztamblanco= 0.400                   &&TXTWIDTH ( ' ', 'Small Fonts', 7, 'N')
   zajustar  = (zpromedio * ztampixel) * zlen
case ztamano = 8
                                       &&constantes
   zpromedio = 5
   ztampixel = 0.200
   ztamblanco= 0.600
   zajustar  = (zpromedio * ztampixel) * zlen
case ztamano = 10
                                       &&constantes
   zpromedio = 7
   ztampixel = 0.143
   ztamblanco= 0.429
   zajustar  = (zpromedio * ztampixel) * zlen
endcase
*
ztexto2 = alltrim( ztexto2)
*
do case
case ztamano = 7
   do while .t.
      if txtwidth( ztexto2, 'Small Fonts', 7, 'N') <= zajustar
         zajuste = zajustar - txtwidth( ztexto2, 'Small Fonts', 7, 'N')
         ztexto2 = replicate( ' ', floor( zajuste / ztamblanco)) + ztexto2
         exit
      endif
      ztexto2 = left( ztexto2, len( ztexto2) -1)
   enddo
case ztamano = 8
   do while .t.
      if txtwidth( ztexto2, 'MS Sans Serif', 8, 'N') <= zajustar
         zajuste = zajustar - txtwidth( ztexto2, 'MS Sans Serif', 8, 'N')
         ztexto2 = replicate( ' ', floor( zajuste / ztamblanco)) + ztexto2 
         exit
      endif
      ztexto2 = left( ztexto2, len( ztexto2) -1)
   enddo
case ztamano = 10
   do while .t.
      if txtwidth( ztexto2, 'MS Sans Serif', 10, 'N') <= zajustar
         zajuste = zajustar - txtwidth( ztexto2, 'MS Sans Serif', 10, 'N')
         ztexto2 = ztexto2 + replicate( ' ', floor( zajuste / ztamblanco))
         exit
      endif
      ztexto2 = left( ztexto2, len( ztexto2) -1)
   enddo
endcase
return ztexto2





*
*                                                                    
* FUNCIONES PARA RED                                                 
*                                                                    
*

FUNCTION RecLock
************
* PROGRAMA : RecLock
* OBJETIVO : Bloquea un registro
************
parameters nSeconds
private lForever
if RLOCK()
   return .t.                          &&Bloqueado
endif
lForever= (nSeconds = 0)
do while (lForever .or. nSeconds > 0)
   if RLOCK()
      return .t.                       &&Bloqueado
   endif
   =inkey(.5)                     &&espera 1/2 segundo
   nSeconds=nSeconds - 0.5
enddo
return .f.                             &&No bloqueado



function gmensred
************
* PROGRAMA : gmensred
* OBJETIVO : control de mensajes de error para uso de archivos en red
************
parameters ztipomen
=tone(400,1)
=tone(400,1)
=tone(400,1)
do case
case ztipomen='RECLOCK'
	DEFINE WINDOW wred1 ;
		AT 0.000, 0.000 ;
		SIZE 8.538,55.000 ;
		TITLE "Mensajes de Red" ;
		FONT "MS Sans Serif", 8 ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM;
		COLOR RGB(,,,192,192,192)
	ACTIVATE WINDOW wred1
	@ 0.615,41.600 TO 4.692,53.000 ;
		PATTERN 1 ;
		PEN 1, 8 ;
		COLOR RGB(128,128,128,255,255,255)
	@ 1.231,44.800 SAY (LOCFILE("net03.bmp","BMP|ICO", "Where is net03?")) BITMAP ;
		SIZE 2.462,6.400
	@ 4.538,41.800 TO 4.538,53.200 ;
		PEN 2, 8 ;
		STYLE "1" ;
		COLOR RGB(128,128,128,128,128,128)
	@ 0.692,52.800 TO 4.615,52.800 ;
		PEN 2, 8 ;
		COLOR RGB(128,128,128,128,128,128)
	@ 0.538,3.200 SAY "Información no disponible  en"  ;
		FONT "MS Sans Serif", 10 ;
		STYLE "T" ;
		COLOR RGB(255,255,255,,,,)
	@ 1.769,3.200 SAY "este momento, la operacion "  ;
		FONT "MS Sans Serif", 10 ;
		STYLE "T" ;
		COLOR RGB(255,255,255,,,,)
	@ 3.000,3.200 SAY "no fue realizada . "  ;
		FONT "MS Sans Serif", 10 ;
		STYLE "T" ;
		COLOR RGB(255,255,255,,,,)
	@ 4.231,3.200 SAY "Intente Nuevamente."  ;
		FONT "MS Sans Serif", 10 ;
		STYLE "T" ;
		COLOR RGB(255,255,255,,,,)
	@ 5.846,40.000 GET xokred ;
		PICTURE "@*HT \<Continuar" ;
		SIZE 1.769,11.167,0.667 ;
		DEFAULT 1 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "B"
	READ CYCLE
	DEACTIVATE WINDOW wred1
	RELEASE WINDOW wred1
case ztipomen='NETUSE'
case ztipomen='ADDREC'
endcase
return .t.


Procedure Greclock 
*************
* PROGRAMA  : Greclock
* OBJETIVO  : 
* Autor     : David del Valle
*************
if rlock()
   return .t. 
endif 
Return .f.                  



*
*                                                                    
* CONVERSION DE NUMEROS A LETRAS                                     
*                                                                    
*


FUNCTION GNUMLET
************
* PROGRAMA : gnumlet
* OBJETIVO : conversion de un numero a letras
************
parameters zimporte,zmoneda
private zletras,acentavos
*
*********************************************************************
*inicializacion de variables
*********************************************************************
*
declare VUnidades[9]
declare VDecenas [9]
declare VCentenas[9]
declare VDieces  [9]
declare VVeintes [9]
declare VDigito  [12]
declare VLetras  [12]
* 
VUnidades[1]=' UN'
VUnidades[2]=' DOS'
VUnidades[3]=' TRES'
VUnidades[4]=' CUATRO'
VUnidades[5]=' CINCO'
VUnidades[6]=' SEIS'
VUnidades[7]=' SIETE'
VUnidades[8]=' OCHO'
VUnidades[9]=' NUEVE'
*
VDecenas [1]=' DIEZ'
VDecenas [2]=' VEINTE'
VDecenas [3]=' TREINTA'
VDecenas [4]=' CUARENTA'
VDecenas [5]=' CINCUENTA'
VDecenas [6]=' SESENTA'
VDecenas [7]=' SETENTA'
VDecenas [8]=' OCHENTA'
VDecenas [9]=' NOVENTA'
*
VCentenas[1]=' CIENTO'
VCentenas[2]=' DOSCIENTOS'
VCentenas[3]=' TRESCIENTOS'
VCentenas[4]=' CUATROCIENTOS'
VCentenas[5]=' QUINIENTOS'
VCentenas[6]=' SEISCIENTOS'
VCentenas[7]=' SETECIENTOS'
VCentenas[8]=' OCHOCIENTOS'
VCentenas[9]=' NOVECIENTOS'
*
VDieces  [1]=' ONCE'
VDieces  [2]=' DOCE'
VDieces  [3]=' TRECE'
VDieces  [4]=' CATORCE'
VDieces  [5]=' QUINCE'
VDieces  [6]=' DIECISEIS'
VDieces  [7]=' DIECISIETE'
VDieces  [8]=' DIECIOCHO'
VDieces  [9]=' DIECINUEVE'
*
VVeintes [1]=' VEINTIUN'
VVeintes [2]=' VEINTIDOS'
VVeintes [3]=' VEINTITRES'
VVeintes [4]=' VEINTICUATRO'
VVeintes [5]=' VEINTICINCO'
VVeintes [6]=' VEINTISEIS'
VVeintes [7]=' VEINTISIETE'
VVeintes [8]=' VEINTIOCHO'
VVeintes [9]=' VEINTINUEVE'
*
*********************************************************************
*funcion Inicial
*********************************************************************
*
nCentavos= 0
nPesos   =int(zimporte)
nCentavos=100 * (zimporte - nPesos)
aCentavos=padl(alltrim(str(nCentavos,2)),2,'0')+'/100 M.N.'
if nPesos > 999999999999
   Letras='ERROR !!!. LIMITE EXCEDIDO....'
   return
endif
aPesos=str(nPesos,12)
for i=12 to 1 step -1
   VDigito[i]=val(substr(aPesos,i,1))
next
*
*********************************************************************
*funcion general
*********************************************************************
*
                                       ****************************************
                                       *llena un vector con la interpreta
                                       *cion de cada digito
                                       ****************************************
for i=12 to 1 step -1
   if VDigito[i]=0
      VLetras[i]=''
      loop
   endif
   EsUnidades=iif(i=12.or.i=9.or.i=6.or.i=3,.t.,.f.)
   EsDecenas =iif(i=11.or.i=8.or.i=5.or.i=2,.t.,.f.)
   EsCentenas=iif(i=10.or.i=7.or.i=4.or.i=1,.t.,.f.)
   do case
   case EsUnidades
      VLetras[i]=VUnidades[VDigito[i]]
   case EsDecenas
      if VDigito[i+1]<>0
         do case
         case VDigito[i]=1                           &&esta entre 11 y 19
            VLetras[i]  =VDieces[VDigito[i+1]]
            VLetras[i+1]=''
         case VDigito[i]=2                           &&esta entre 21 y 29
            VLetras[i]=VVeintes[VDigito[i+1]]
            VLetras[i+1]=''
         otherwise                                   &&esta entre 31 y 99
            VLetras[i]=VDecenas[VDigito[i]]+' Y'
         endcase
      else
         VLetras[i]=VDecenas[VDigito[i]]
      endif
   case EsCentenas 
                                                     &&es 'cien'
      if VDigito[i]=1 .and. VDigito[i+1]=0 .and. VDigito[i+2]=0
         VLetras[i]=' CIEN'
         loop
      else
         VLetras[i]=VCentenas[VDigito[i]]
      endif
   endcase
next
                                       ****************************************
                                       *llena un vector con la interpreta
                                       *cion de cada digito
                                       ****************************************
zletras=''
for i=1 to 12
   if len(VLetras[i]) > 1
      zletras=zletras+VLetras[i]
   endif
   if nPesos >999999999 .and. i=3
      zletras=zletras+' MIL'
   endif
   if nPesos >999999    .and.nPesos<2000000 .and. i=6
      zletras=zletras+' MILLON'
   else
      if nPesos>999999 .and. i=6
         zletras=zletras+' MILLONES'
      endif
   endif
   if nPesos/1000000 <> int(nPesos/1000000)
      EsMillones=.f.
   else
      EsMillones=.t.
   endif
   if .not. EsMillones                 &&verifica miles de pesos
      if nPesos>999 .and. i=9   .and. ;
         (substr(aPesos,7,1)>'0' .or. ;
          substr(aPesos,8,1)>'0' .or. ;
          substr(aPesos,9,1)>'0')
         zletras=zletras+' MIL'
      endif
   endif
next
release VUnidades
release VDecenas
release VCentenas
release VDieces
release VVeintes
release VDigito
                                       ****************************************
                                       *asigna centavos y  moneda
                                       ****************************************
if EsMillones
   if zmoneda=1
      zlet   =zletras+' DE PESOS '+aCentavos
      zletras=''
      zletras=zlet
   else
      zletras=zletras+' DE DOLARES USD '+aCentavos
   endif
else
   if zmoneda=1
      zlet   =zletras+' PESOS '+aCentavos
      zletras=''
      zletras=zlet
   else
      zletras=zletras+' DOLARES USD '+aCentavos
   endif
endif
return alltrim(zletras)



function gnumletU
************
* PROGRAMA : gnumletU
* OBJETIVO : conversion de un numero a letras en Ingles
************
parameters zimporte
private zletras, zCentavos, nPesos, aPesos, i ;
        EsUnidades, EsDecenas, EsCentenas

*
*********************************************************************
*inicializacion de variables
*********************************************************************
*
declare VUnidades[9]
declare VDecenas [9]
declare VDieces  [9]
declare VDigito  [12]
declare VLetras  [12]
* 
VUnidades[1]=' ONE'
VUnidades[2]=' TWO'
VUnidades[3]=' THREE'
VUnidades[4]=' FOUR'
VUnidades[5]=' FIVE'
VUnidades[6]=' SIX'
VUnidades[7]=' SEVEN'
VUnidades[8]=' EIGHT'
VUnidades[9]=' NINE'
*
VDecenas [1]=' TEN'
VDecenas [2]=' TWENTY'
VDecenas [3]=' THIRTY'
VDecenas [4]=' FORTY'
VDecenas [5]=' FIFTY'
VDecenas [6]=' SIXTY'
VDecenas [7]=' SEVENTY'
VDecenas [8]=' EIGHTY'
VDecenas [9]=' NINETY'
*
VDieces  [1]=' ELEVEN'
VDieces  [2]=' TWELVE'
VDieces  [3]=' THIRTEEN'
VDieces  [4]=' FOURTEEN'
VDieces  [5]=' FIFTEEN'
VDieces  [6]=' SIXTEEN'
VDieces  [7]=' SEVENTEEN'
VDieces  [8]=' EIGHTEEN'
VDieces  [9]=' NINETEEN'
*
*********************************************************************
*funcion Inicial
*********************************************************************
*
zCentavos = 0
nPesos    = int(zimporte)
zCentavos = 100 * (zimporte - nPesos)
zCentavos = padl(alltrim(str( zCentavos,2)),2,'0')+'/100'
if nPesos > 999999999999
   return 'ERROR !!!. LIMITE EXCEDIDO....'
endif
                                       *************************************
                                       *para cada digito de la cantidad, pasa
                                       *a un vector de digitos
                                       *************************************
aPesos = str(nPesos,12)
for i=12 to 1 step -1
   VDigito[i] = val(substr( aPesos, i, 1))
next
*
*********************************************************************
*funcion general
*********************************************************************
*
                                       *************************************
                                       *llena un vector con la interpreta-
                                       *cion de cada digito
                                       *************************************
for i=12 to 1 step -1
   if VDigito[i]=0
      VLetras[i]=''
      loop
   endif
   EsUnidades = iif( i=12 or i=9 or i=6 or i=3, .t., .f.)
   EsDecenas  = iif( i=11 or i=8 or i=5 or i=2, .t., .f.)
   EsCentenas = iif( i=10 or i=7 or i=4 or i=1, .t., .f.)
   do case
   case EsUnidades
      VLetras[i] = VUnidades[ VDigito[ i]]
   case EsDecenas
      if VDigito[i+1]<>0               &&si es una decena y existen 
                                       &&unidades              
         if VDigito[i]=1               &&esta entre 11 y 19
            VLetras[i] = VDieces[ VDigito[ i+1]]
            VLetras[i+1]=''
         else                          &&esta entre 21 y 99
            VLetras[i] = VDecenas[ VDigito[ i]] + '-' + ;
                         alltrim( VLetras[ i+1])
            VLetras[i+1]=''
         endif
      else
         VLetras[i] = VDecenas[ VDigito[i]]
      endif
   case EsCentenas
                                       &&checa que sea una centena entera
                                       &&100,200,300,etc
      if VDigito[i+1] = 0 and VDigito[i+2] = 0
         VLetras[i] = VUnidades[ VDigito[ i]] + ' HUNDRED'
      else   
         VLetras[i] = VUnidades[ VDigito[ i]] + ' HUNDRED AND'
      endif
   endcase
next
                                       *************************************
                                       *con el vector de letras, genera
                                       *el texto asociado.
                                       *asigna ademas miles, millones
                                       *y billones
                                       *************************************
zletras=''
for i=1 to 12
   if len(VLetras[i]) > 1
      zletras=zletras+VLetras[i]
   endif
   if nPesos >999999999 and i=3
      zletras=zletras+' BILLION'
   endif
   if nPesos>999999 and i=6 and substr(aPesos, 4, 3) <> '000'
                                       &&solo se ponen el "MILLONES" cuando
                                       &&los millones son diferente a ceros
                                       &&Ej: 2,000,000,100    NO
                                       &&    2,000,000,000    NO
                                       &&    2,001,000,000    SI
                                       &&    2,010,000,000    SI
                                       &&    2,100,000,000    SI
      zletras=zletras+' MILLION'
   endif
   if nPesos>999    and i=9 and substr(aPesos, 7, 3) <> '000'
                                       &&solo se ponen el "MILES" cuando
                                       &&los miles son diferente a ceros
                                       &&Ej: 2,000,100    NO
                                       &&    2,000,000    NO
                                       &&    2,001,000    SI
                                       &&    2,010,000    SI
                                       &&    2,100,000    SI
       zletras=zletras+' THOUSAND'
   endif
next
                                       &&le pega Moneda y centavos
zletras=zletras+' USD '+zCentavos + ' CY '
*
release VUnidades
release VDecenas
release VDieces
release VDigito
release VLetras
return alltrim(zletras)




*
*                                                                         
* ACCESO A ARCHIVOS EXCLUSIVOS                                            
*                                                                         
*

function gAbrir
************
* PROGRAMA : gAbrir 
* OBJETIVO : funcion para atrapar errores al abrir archivos
************
parameters zError, zArchivo, zModo, ztabla
private zmenserr 
*
if parameters() = 3
   ztabla = ''
endif
*
do case
case zError = 1705                 &&File access denied
   error = .t.
   xint1 = gfont( ztabla , 30, 8)
   xint2 = gfont( zModo , 20, 8)
   =adderr( xint1 + xint2 )
case zError = 1                    &&File <> does not exist
   error = .t.
   if !empty(ztabla)
      xint1 = gfont( ztabla , 30, 8)
      xint2 = gfont( 'NO Existe' , 20, 8)
      =adderr( xint1 + xint2 )
   else
      zmenserr = left( zArchivo, rat( "'", zArchivo) -1)
      zmenserr = substr( zmenserr, at( "'", zArchivo) + 1)
      *
      xint1 = gfont( zmenserr , 30, 8)
      xint2 = gfont( 'NO Existe' , 20, 8)
      *
      =adderr( xint1 + xint2)
   endif   
endcase
return



*
*                                                                    
* RUTINAS PARA CONTROL DE PANTALLA PRINCIPAL                         
*                                                                    
*
procedure gIniPrgm
*************
* PROGRAMA  : gIniPrgm
* OBJETIVO  : Valida si esta la ventana del menu principal y la 
*             oculta
*************
if WEXIST("wmenup")
   gPrgAct   = ''
   hide window wmenup
   *
   ON KEY LABEL F9 
   *
   if gtono = 9
     =gSndAbrir()
   endif
   *
endif
return .t.



procedure gFinPrgm
*************
* PROGRAMA  : gFinPrgm
* OBJETIVO  : Al terminar el programa vuelve a activar la venta del
*             Menu principal
*************
if wexist( "wmenup")
   if not wvisible( "wmenup")
      activate window wmenup
      *
      ON KEY LABEL F9 do xMenuFidei
      *
      if gtono = 9
         =gSndCerrar()
      endif
      *
   endif   
endif
*
return .t.



*
*                                                                    
* SONIDOS                                                            
*                                                                    
*
procedure gClick
*************
* PROGRAMA  : gClick
* OBJETIVO  : Sonido para click
*************
set bell to 'WAVS\WCCLICK.WAV', 0
?? chr(7)
set bell to
return


procedure gDblClick
*************
* PROGRAMA  : gDblClick
* OBJETIVO  : Sonido para doble click
*************
set bell to 'WAVS\WCCLICK.WAV', 0
?? chr(7)
?? chr(7)
set bell to
return


procedure gSndAbrir
*************
* PROGRAMA  : gSndAbrir
* OBJETIVO  : Sonido para abrir algo
*************
set bell to 'WAVS\WCASYN.WAV', 0
?? chr(7)
set bell to
return


procedure gSndCerrar
*************
* PROGRAMA  : gSndCerrar
* OBJETIVO  : Sonido para abrir algo
*************
set bell to 'WAVS\SCROLL.WAV', 0
?? chr(7)
set bell to
return


procedure gSndError
*************
* PROGRAMA  : gSndError
* OBJETIVO  : Sonido para marcar error
*************
set bell to 'WAVS\CHORD.WAV', 0
?? chr(7)
set bell to
return


procedure gSndOk
*************
* PROGRAMA  : gSndOk
* OBJETIVO  : Sonido para mensaje ok
*************
set bell to 'WAVS\REVDN1.WAV', 0
?? chr(7)
set bell to
return



procedure gSndIni
*************
* PROGRAMA  : gSndOk
* OBJETIVO  : Sonido para mensaje ok
*************
set bell to 'WAVS\LEVLSTRT.WAV', 0
?? chr(7)
set bell to
return



procedure gSndReturn
*************
* PROGRAMA  : gSndReturn
* OBJETIVO  : Sonido para mensaje ok
*************
set bell to 'WAVS\WALK0.WAV', 0
?? chr(7)
set bell to
return





*
*                                                                    
* CONTROL DE IMPRESIONES                                             
*                                                                    
*

PROCEDURE GCHKPRN
************
* PROGRAMA : gchkprn
* OBJETIVO : checa que la impresora este lista
************
parameters zactiva
set cursor off
if zactiva<>'INICIO'
   set escape on
   deactivate window wchkprn				&&desactiva ventana
   release window wchprn
   set cursor on
   return .f.
endif
*
do case
case gimpresora='MATRIZ'
   zimpresora=1
case gimpresora='LASER'
   zimpresora=2
endcase
zopcion   =0
zpagina   =0
zavance   =0
*
set escape off
DEFINE WINDOW wchkprn ;
	AT  0.000, 0.000  ;
	SIZE 15.563,32.000 ;
	TITLE "Imprimir Reporte" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "B" ;
	NOFLOAT ;
	NOCLOSE ;
	NOMINIMIZE ;
	SYSTEM
MOVE WINDOW wchkprn CENTER
ACTIVATE WINDOW wchkprn
*
@ 0.688,1.500 SAY "Reporte"  ;
	FONT "MS Sans Serif", 10 ;
	STYLE "BT"
@ 3.813,1.500 SAY "Impresora"  ;
	FONT "MS Sans Serif", 10 ;
	STYLE "BT"
@ 2.188,1.500 SAY "Orientación"  ;
	FONT "MS Sans Serif", 10 ;
	STYLE "BT"
@ 0.688,13.500 SAY xcverep ;
	SIZE 1.000,13.000 ;
	FONT "MS Sans Serif", 10 ;
	STYLE "B" ;
	PICTURE "!!!!!!!!!!" 
do case
case gtipopap=1
   zorienta='Vertical    '
case gtipopap=2
   zorienta='Horizontal  '
endcase   
@ 2.188,13.500 SAY zorienta ;
	SIZE 1.000,13.000 ;
	FONT "MS Sans Serif", 10 ;
	STYLE "B" ;
	PICTURE "XXXXXXXXXXXX" 

@ 13.500,7.125 GET zopcion ;
	PICTURE "@*HT OK;Cancelar" ;
	SIZE 1.438,8.625,0.500 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 10 ;
	STYLE "B"
do case
case gimpresora='MATRIZ'
	@ 3.750,13.250 GET zimpresora ;
		PICTURE "@^ Genérica de Matriz;LaserJet II / III" ;
		SIZE 1.538,24.500 ;
		DEFAULT "Genérica de Matriz" ;
		FONT "MS Sans Serif", 8 ;
		STYLE "B"
case gimpresora='LASER'
	@ 3.750,13.250 GET zimpresora ;
		PICTURE "@^ Genérica de Matriz;LaserJet II / III" ;
		SIZE 1.538,24.500 ;
		DEFAULT "LaserJet II / III" ;
		FONT "MS Sans Serif", 8 ;
		STYLE "B"
endcase
READ CYCLE MODAL
if lastkey()=27
   impflg=.f.
   deactivate window wchkprn				&&desactiva ventana          
   release window wchprn
   return .f.
endif   
if zopcion=2
   impflg=.f.
   deactivate window wchkprn			&&desactiva ventana          
   release window wchprn
   return .f.
endif   
*
@ 9.750,7.000 clear to 12.000,25,000

@ 9.688,6.000 SAY "Página :"  ;
	FONT "MS Sans Serif", 10 ;
	STYLE "BT"
@ 11.188,6.000 SAY "Avance :"  ;
	FONT "MS Sans Serif", 10 ;
	STYLE "BT"

@ 9.688,18.250 SAY zpagina ;
	SIZE 1.000,7.750 ;
	FONT "MS Sans Serif", 10 ;
	STYLE "B" ;
	PICTURE "9,999" 
@ 11.188,16.750 SAY zavance ;
	SIZE 1.000,9.125 ;
	FONT "MS Sans Serif", 10 ;
	STYLE "B" ;
	PICTURE "999.99%" 
@ 13.500,6.500 GET zcancela ;
	PICTURE "@*HN <Esc> para Cancelar" ;
	SIZE 1.438,18.875,0.500 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 10 ;
	STYLE "B"
clear gets	
*	
do case

case zimpresora=1
   gimpresora		='MATRIZ'
   I_LinePrinter	='CHR(15)'
   I_Cour10cpi  	='CHR(18)'
   I_Space8lpp      ='CHR(27)+"0"'
   I_Space6lpp      ='CHR(27)+"2"'
      
   if gtipopap=1
      I_PageLen		='CHR(27)+CHR(67)+CHR(66)'
   else
      I_PageLen		='CHR(27)+CHR(67)+CHR(51)'
   endif   
case zimpresora=2
   gimpresora		='LASER'
   I_LinePrinter	='CHR(27)+"&k2S"'
   I_Cour10cpi  	='CHR(27)+"&k0S"'
   I_Space8lpp      ='CHR(027)+CHR(038)+CHR(108)+CHR(056)+CHR(068)'   
   I_Space6lpp      ='CHR(027)+CHR(038)+CHR(108)+CHR(054)+CHR(068)'   

   if gtipopap=1
      I_PageLen		='CHR(27)+"&l0O"+CHR(27)+"&l66P"'
   else
      I_PageLen		='CHR(27)+"&l1O"+CHR(27)+"&l55P"'
   endif   
endcase   
impflg=.t.

set color to
set cursor off
return .t.





PROCEDURE GREP_CP
************
* PROGRAMA : grep_cp
* OBJETIVO : despliega el porcentaje de avance en la impresion de reportes
************
set device to screen
zpagina=hoja-1
if totreg<>0
   zavance=round((contador/totreg)*100,2)
else
   zavance=0
endif   
@ 9.688,18.250 SAY zpagina ;
	SIZE 1.000,7.750 ;
	FONT "MS Sans Serif", 10 ;
	STYLE "B" ;
	PICTURE "9,999" 
@ 11.188,16.750 SAY zavance ;
	SIZE 1.000,9.125 ;
	FONT "MS Sans Serif", 10 ;
	STYLE "B" ;
	PICTURE "999.99%" 
set device to print
return



PROCEDURE GREP_SI
************
* PROGRAMA : grep_si
* OBJETIVO : detecta la suspension de la impresion para los reportes
*          : asume todas las situaciones y variables
************
set cursor off
=inkey()
if lastkey()=27
   set device to screen
                                       **********************************
                                       *pantalla
                                       **********************************
	DEFINE WINDOW wrepsi ;
		AT  0.000, 0.000  ;
		SIZE 15.563,32.000 ;
		TITLE "Imprimir Reporte" ;
		FONT "MS Sans Serif", 10 ;
		STYLE "B" ;
		NOFLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM
	MOVE WINDOW wrepsi CENTER
	ACTIVATE WINDOW wrepsi

	@ 0.688,1.500 SAY "Reporte"  ;
		FONT "MS Sans Serif", 10 ;
		STYLE "BT"
	@ 3.813,1.500 SAY "Impresora"  ;
		FONT "MS Sans Serif", 10 ;
		STYLE "BT"
	@ 2.188,1.500 SAY "Orientación"  ;
		FONT "MS Sans Serif", 10 ;
		STYLE "BT"
	@ 9.688,5.750 SAY "Impresión del Reporte ?"  ;
		FONT "MS Sans Serif", 10 ;
		STYLE "BT"
	@ 8.188,6.750 SAY "¿Desea Suspender la"  ;
		FONT "MS Sans Serif", 10 ;
		STYLE "BT"
	@ 7.438,2.375 TO 7.438,29.625 ;
		PEN 2, 8 ;
		STYLE "1"
	@ 14.063,2.375 TO 14.063,29.875 ;
		PEN 6, 8 ;
		STYLE "1"
	@ 7.438,29.125 TO 14.376,29.125 ;
		PEN 6, 8
	@ 7.563,2.375 TO 14.438,2.375 ;
		PEN 2, 8
	@ 0.688,13.500 SAY xcverep ;
		SIZE 1.000,13.000 ;
		FONT "MS Sans Serif", 10 ;
		STYLE "B" ;
		PICTURE "!!!!!!!!!!"
	do case
	case gtipopap=1
	   zorienta='Vertical    '
	case gtipopap=2
	   zorienta='Horizontal  '
	endcase
	@ 2.188,13.500 SAY zorienta ;
		SIZE 1.000,13.000 ;
		FONT "MS Sans Serif", 10 ;
		STYLE "B" ;
		PICTURE "XXXXXXXXXXXX"
	*
	do case
	case gimpresora='MATRIZ'
	   zimpresora=1
		@ 3.750,13.250 GET zimpresora ;
			PICTURE "@^ Genérica de Matriz;LaserJet II / III" ;
			SIZE 1.538,24.500 ;
			DEFAULT "Genérica de Matriz" ;
			FONT "MS Sans Serif", 8 ;
			STYLE "B"
	case gimpresora='LASER'
	   zimpresora=2
		@ 3.750,13.250 GET zimpresora ;
			PICTURE "@^ Genérica de Matriz;LaserJet II / III" ;
			SIZE 1.538,24.500 ;
			DEFAULT "LaserJet II / III" ;
			FONT "MS Sans Serif", 8 ;
			STYLE "B"
	endcase
	clear gets
*
	zopcion=1
	@ 12.000,7.000 GET zopcion ;
		PICTURE "@*HT NO;SI" ;
		SIZE 1.438,8.625,0.500 ;
		DEFAULT 1 ;
		FONT "MS Sans Serif", 10 ;
		STYLE "B"
	READ CYCLE
	if zopcion=2
      set device to print
      renimp=renimp+2
      @ renimp,000 say '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
      renimp=renimp+1
      @ renimp,000 say '< La Impresion fue suspendida por el usuario <'
      renimp=renimp+1
      @ renimp,000 say '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'
      renimp=renimp+2
      set device to screen
      detenido=.t.
      go bottom                               && hace que termine la
      skip                                    && impresion en forma normal
   else
   endif
   set device to print
	*
	DEACTIVATE WINDOW wrepsi
	RELEASE WINDOW wrepsi
endif
set color to
set cursor on
return





PROCEDURE GENC10
************
* PROGRAMA : GENC10
* OBJETIVO : Encabezados reporte en hoja carta
************
*         10        20        30        40        50        60        70
*0123456789.123456789.123456789.123456789.123456789.123456789.123456789.12345
*123456789.123456789.123456789.                               R0000
*123456789.123456789.123456789.                               HOJA :    9,999
*123456789.123456789.123456789.123456789.123456789.123456789. FECHA: 99/99/99
*123456789.123456789.123456789.123456789.123456789.12345      HORA :    99:99
*
parameters xtitulo, xtitulo2, xpagina,xcverep
xtitulo  = padr(alltrim(xtitulo ),60)
xtitulo2 = padr(alltrim(xtitulo2),60)
znomcia  = gnomcia
znomsis  = gnomsis
@ 00,000 say &I_PageLen+&i_cour10cpi
xlinea=space(75)
=glinea(000, gnomcia,			'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
=glinea(061, xcverep,			'!!!!!!!!!!')
@ 00,000 say xlinea
xlinea=space(75)
=glinea(000, gnomsis,			'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
=glinea(061, 'HOJA :',			'!!!!!')
=glinea(071, xpagina,			'9,999')
@ 01,000 say xlinea
xlinea=space(75)
=glinea(000, xtitulo,			'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
=glinea(061, 'FECHA:',			'!!!!!')
=glinea(068, date(),				'@E')
@ 02,000 say xlinea
xlinea=space(75)
=glinea(000, xtitulo2,			'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
=glinea(061, 'HORA :',			'!!!!!')
=glinea(071, substr(time(),1,5),	'!!!!!')
@ 03,000 say xlinea
@ 04,000 say substr(doblelinea,1,76)
return



PROCEDURE GENC10L
************
* PROGRAMA : GENC10L
* OBJETIVO : Encabezados reporte en hoja carta LANDSCAPE
************
*
*         10        20        30        40        50        60        70        80        90
*0123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789
*123456789.123456789.123456789.                                                       R0000
*123456789.123456789.123456789.                                                       HOJA :    9,999
*123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.1234 FECHA: 99/99/99
*123456789.123456789.123456789.123456789.123456789.12345                              HORA :    99:99
*
*===========================================================================================================================================================================
*0123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.
*         10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170

parameters xtitulo, xtitulo2, xpagina,xcverep
xtitulo  = padr(alltrim(xtitulo ),84)
xtitulo2 = padr(alltrim(xtitulo2),84)
znomcia  = gnomcia
znomsis  = gnomsis
xlinea=space(100)
@ 000,000 say &I_PageLen+&i_cour10cpi
=glinea(000, gnomcia,			'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
=glinea(085, xcverep,			'!!!!!!!!!!')
@ 00,000 say xlinea
xlinea=space(100)
=glinea(000, gnomsis,			'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
=glinea(085, 'HOJA :',			'!!!!!')
=glinea(095, xpagina,			'9,999')
@ 01,000 say xlinea
xlinea=space(100)
=glinea(000, xtitulo,			'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
=glinea(085, 'FECHA:',			'!!!!!')
=glinea(092, date(),				'@E')
@ 02,000 say xlinea
xlinea=space(100)
=glinea(000, xtitulo2,			'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
=glinea(085, 'HORA :',			'!!!!!')
=glinea(095, substr(time(),1,5),	'!!!!!')
@ 03,000 say xlinea
@ 04,000 say substr(doblelinea,1,100)
return


PROCEDURE GENC15
************
* PROGRAMA : GENC15
* OBJETIVO : Encabezados reporte 15
************
*
*         10        20        30        40        50        60        70        80        90
*0123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789
*123456789.123456789.123456789.                                                       R0000
*123456789.123456789.123456789.                                                       HOJA :    9,999
*123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.1234 FECHA: 99/99/99
*123456789.123456789.123456789.123456789.123456789.12345                              HORA :    99:99
*
*===========================================================================================================================================================================
*0123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.123456789.
*         10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170

parameters xtitulo, xtitulo2, xpagina,xcverep
xtitulo  = padr(alltrim(xtitulo ),84)
xtitulo2 = padr(alltrim(xtitulo2),84)
znomcia  = gnomcia
znomsis  = gnomsis
xlinea=space(100)
@ 00,000 say &I_PageLen+&i_cour10cpi
=glinea(000, gnomcia,			'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
=glinea(115, xcverep,			'!!!!!!!!!!')
@ 00,000 say xlinea
xlinea=space(100)
=glinea(000, gnomsis,			'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
=glinea(115, 'HOJA :',			'!!!!!')
=glinea(125, xpagina,			'9,999')
@ 01,000 say xlinea
xlinea=space(100)
=glinea(000, xtitulo,			'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
=glinea(115, 'FECHA:',			'!!!!!')
=glinea(122, date(),				'@E')
@ 02,000 say xlinea
xlinea=space(100)
=glinea(000, xtitulo2,			'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
=glinea(115, 'HORA :',			'!!!!!')
=glinea(125, substr(time(),1,5),	'!!!!!')
@ 03,000 say xlinea
@ 04,000 say substr(doblelinea,1,130)
return




function glinea
************
* PROGRAMA : glinea
* OBJETIVO : Concatena los datos que se van a imprimir
*            Solo funciona para FOXPRO Windows
************
parameters zpos,zdato,zpicture
xlinea=stuff(xlinea,zpos+1,len(transform(zdato,zpicture)),transform(zdato,zpicture))
return






*
*                                                                    
* CONTROL DE IMPRESIONES DE TEXTOS MEMO                              
*                                                                    
*

Procedure gImpTexto
*************
* PROGRAMA  : gImpTexto
* OBJETIVO  : Procedimiento que liga el machote con Texto
*************
parameter zTexto, zcompactada , zzpagina
*
if parameters() <= 1
   zcompactada = .f.
endif
*
if parameters() <= 2
   zzpagina    = .f.
endif
*
*********************************************************************
* iniciación de Variables
*********************************************************************
*
*#define  SpacMargen  05
*#define  NumColPag   70
*#define  NumcolScr   73
*#define  Linpp       55                 && 55 para espaciado normal
*#define  Margen      Space(spacMargen)
*#define  MargSup     10
*#define  sLinpp      25
*
*Imprimio = .F. 
*
*********************************************************************
* Funcion General
*********************************************************************
*
create table Tmpimp    ;
   (Texto     M(10)   ,;
    Ligado    M(10))
*
select tmpimp
append blank
replace texto with zTexto

                             *************************************
                             * Liga Archivo
                             *************************************
TMPARCH  = 'TmpArch'  + '.TMP'
*
set MemoWidth to NumColPag
set TextMerge on to (TMPARCH)
set console off
\<<Tmpimp.Texto>>
set TextMerge to 
                             *************************************
                             * Copy el archivo Ligado
                             *************************************
select Tmpimp
append memo Ligado From &TMPARCH OverWrite

                             *************************************
                             * Manda a Impresión
                             *************************************
impok=EnvImp()
set console on
*
*********************************************************************
* Funcion Final
*********************************************************************
*
select tmpimp
use
*
erase TMPARCH.TMP
*
erase tmpimp.dbf
erase tmpimp.fpt
*
return impok




Procedure EnvImp
*************
* PROGRAMA  : EnvImp
* OBJETIVO  : Envia Impresión
*************
*
*      Justificar la linea
*  *   Dejar el texto sin formato
*  ^   Centra Linea
*  ]   Justificar a la derecha
*  &   Aumenta giones al resto de la linea
*  |   Centrar la linea con giones a la derecha
*  @   Para el Fin del Archivo
*
*********************************************************************
* Inicializa Variables
*********************************************************************
*
Store 0 to _Mline
*
gimpresora = 'MATRIZ'
xCveRep    = ''
gtipopap   = 1
ImpFlg     = .f. 
*
Numlines   = MemLines(LIGADO)
renimp     = 0
Pag        = 1
Fin_de_Arc = .f.
Totreg     = NumLines	    
contador   = 0
*
*********************************************************************
* Funcion General
*********************************************************************
*
=Gchkprn('INICIO')
*
if !impflg
    return .f.
endif 

                   *************************************
                   * Inicia Impresión
                   *************************************
if zcompactada
   ???chr(15)
else
   ??? CHR(18)
endif
*
set device to printer
*@ prow(), pcol() say &I_Cour10cpi   
*
for a = 1 to NumLines
	
   memline = MLine( ligado, 1 ,_mline)

                   *************************************
                   * Para el Fin del Archivo
                   *************************************
   if Occurs(chr(64),memline)>0
      Fin_de_Arc = .t.
      memline    = strtran(memline,chr(64),'')
   endif
   *	
   do case
                             *************************************
                             * Dejar el texto sin formato
                             *************************************
   case Occurs('*',memline)>0          
      linrem = StrTran(memline,'*','')+chr(13)

                             *************************************
                             * Centrar la linea
                             *************************************
   case Occurs('^',memline)>0          
      linrem = centrar(strtran(memline,'^',''),NumColPag)+chr(13)

                             *************************************
                             * Justificar a la derecha
                             *************************************
   case Occurs(']',memline)>0          
      linrem = jderecha(strtran(memline,']',''),NumColPag)+chr(13)

                             *************************************
                             * Aumenta giones al resto de la linea
                             *************************************
   case Occurs('&',memline)>0 
	  aumenta_l = replicate('-',NumColPag-len(StrTran(memline,'&','')))
	  linrem    = StrTran(memline,'&','')+aumenta_l+chr(13)

                             *************************************
                             * Centrar la linea con giones a la derecha
                             *************************************
   case Occurs('|',memline)>0 
      linrem = central(strtran(memline,'|',''),NumColPag)+chr(13)

                             *************************************
                             * Justificar la linea
                             *************************************
   otherwise   
      linrem = Justifica(memline,NumColPag)+chr(13)
   endcase

                   *************************************
                   * Imprime Linea
                   *************************************
   @renimp+margsup,0 say margen +linrem
   renimp = renimp + 1


                   *************************************
                   * Imprime Pie de Página
                   *************************************
    if renimp = linpp
       if zzpagina
          Pie_de_pag = Centrar('P gina: '+alltrim(str(pag)),NumColPag)
          @ renimp+2+margsup,0 say margen+Pie_de_pag
       endif   
       *
       Pag = Pag +1
       renimp = 0
    endif
                   *************************************
                   * Imprime Pie de Página al Final del Archivo
                   *************************************
    if Fin_de_Arc
       if renimp < linpp
   	      if zzpagina
   	         Pie_de_pag = Centrar('P gina: '+alltrim(str(pag)),NumColPag)
             @ renimp+2+margsup,0 say Pie_de_pag
          endif   
       endif
       *
       exit
    endif
    *
    hoja     = Pag 
    contador = contador + 1
    =Grep_Cp()
    *
    detenido = .f. 
    =GRep_SI()
    *
    if detenido 
       exit 
    endif    
endfor
*
*********************************************************************
* Funcion Final
*********************************************************************
*
if !detenido 
   Imprimio = .t.
endif 
* 
set printer to 
set device to screen
=GChkPrn('FINAL')
*
return Imprimio




PROCEDURE centrar
*************
* PROGRAMA  : centrar
* OBJETIVO  : Centra una linea de texto en impresión con lineas a los lados
*************
Parameter linea,Hancho_de_linea
*
LineaPura = alltrim(linea) 
Espacios  = Hancho_de_linea-len(LineaPura)
*
Mitad_De_espacios = int(Espacios/2)
Linea_Centrada    = space(Mitad_de_Espacios) + LineaPura
*
Retu Linea_Centrada 



PROCEDURE central
*************
* PROGRAMA  : central
* OBJETIVO  : Centra una linea de texto en impresión con lineas a los lados
*************
Parameter linea,Hancho_de_linea
*
LineaPura = alltrim(linea) 
Espacios = Hancho_de_linea-len(LineaPura)
Mitad_De_espacios = int(Espacios/2)
Linea_Centradal   = replicate('-',Mitad_de_Espacios) + LineaPura +replicate('-',Hancho_de_linea-(Mitad_de_Espacios + LEN(LineaPura)))
*
Retu Linea_Centradal




PROCEDURE jderecha
*************
* PROGRAMA  : jderecha
* OBJETIVO  : Justifica una linea de texto a la derecha en impresión
*************
Parameter linea,Hancho_de_linea
*
LineaPura = alltrim(linea) 
Espacios = Hancho_de_linea-len(LineaPura)
Linea_jderecha     = space(Espacios) + LineaPura
*
Retu Linea_jderecha



PROCEDURE justifica
*************
* PROGRAMA  : justifica
* OBJETIVO  : Justifica una linea de texto en impresión
*************
Parameter linea,Hancho_de_linea
Private LinAux
Private Array Palabras
*
Dimension Palabras(1)
LinAux = ltrim(Linea)
LinAux = Rtrim(linAux)
*
Espacios = Hancho_de_linea-len(StrTran(linAux,' ',''))
*
If len(strtran(LinAux,' ','')) > 0 
    a = 0
	Do while .T. 
		Dimension Palabras(a+1)	
		SpacePos   = At(' ',rtrim(LinAux))
		LenLin     = Len(LinAux)
		lenAlltrim = Len(StrTran(LinAux,' ',''))
		If SpacePos = 0 and lenalltrim > 0 
		   Palabra  = StrTran(LinAux,' ','')
		else 
		   Palabra  = StrTran(Substr(LinAux,1,SpacePos),' ','')		
		EndIf
		LinAux   = Substr(LinAux,SpacePos+1,(LenLin-SpacePos+1))
		Palabras(a+1) = Palabra
		A = A + 1 
        *
		If SpacePos = 0 
		   Exit
		EndIf
	Enddo 	
	TotalPalabras = A
	Separaciones  = TotalPalabras  - 1
    *
    if separaciones<>0
	   RestoDeEspacios = Mod(Espacios,Separaciones)
	else   
	   RestoDeEspacios = 0
    endif
    *
	Espacios = Espacios - RestoDeEspacios
    *
    if separaciones<>0
       Espaciado = (Espacios/Separaciones)
    else
       Espaciado = 0
    endif
    *
	If Espaciado < 1
	   espaciado = 1
	EndIf   
    *
	Linea = Palabras(1)
	For a = 1 to Separaciones
        EspacioAdicional = IIF(RestoDeEspacios<1,0,1)
        Linea = Linea + Space(Espaciado)+Space(EspacioAdicional) + Palabras(a+1)
        RestoDeEspacios = RestoDeEspacios - 1
    Endfor 
Else
    * El par metro es un str nulo
endif        	
*
Retu Linea




*
*                                                                    
* RUTINAS SOLO PARA ESTE SISTEMA                                     
*                                                                    
*

procedure gdigver
************
* PROGRAMA : gdigver
* OBJETIVO : Calcula digito verificador
************
parameters xrefer
xuno   =val(substr(xrefer,1,1))
xdos   =val(substr(xrefer,2,1))
xtres  =val(substr(xrefer,3,1))
xcuatro=val(substr(xrefer,4,1))
xcinco =val(substr(xrefer,5,1))
xseis  =val(substr(xrefer,6,1))
xsiete =val(substr(xrefer,7,1))
xocho  =val(substr(xrefer,8,1))
xtotal =xuno*9+xdos*8+xtres*7+xcuatro*6+xcinco*5+xseis*4+xsiete*3+xocho*2
*
xvalor =9-mod(xtotal,9)
*
return xvalor



procedure gdigAlf
************
* PROGRAMA : gdigAlf
* OBJETIVO : Calcula digito verificador Alfabetico
************
parameters xrefer
xuno    = val(substr(xrefer,1,1))
xdos    = val(substr(xrefer,2,1))
xtres   = val(substr(xrefer,3,1))
xcuatro = val(substr(xrefer,4,1))
xcinco  = val(substr(xrefer,5,1))
xseis   = val(substr(xrefer,6,1))
xsiete  = val(substr(xrefer,7,1))
xocho   = val(substr(xrefer,8,1))
xtotal  = xuno*9+xdos*8+xtres*7+xcuatro*6+xcinco*5+xseis*4+xsiete*3+xocho*2
xvalorn = 25-mod(xtotal,25)
*
xvalor  = chr(64 + xvalorn)
*
return xvalor





FUNCTION gsigmes
*************
* PROGRAMA  : gsigmes
* OBJETIVO  : Calcula siguiente mes de una fecha
*             Ejemplo: 14Feb92 --> 14Mar92
*                      20Dic92 --> 20Ene93
*             ASUME QUE NUNCA HABRA FECHAS DE MAS DEL DIA 28, PARA NO
*             TENER BRONCAS DE CUAL ES EL SIGUIENTE CORTE.
*************
PARAMETERS zfecha1
zdia2=DAY(zfecha1)
IF zdia2>28
   zdia=28
ENDIF
zmes2=MONTH(zfecha1)+1
zano2=YEAR(zfecha1)
IF zmes2=13
   zmes2=1
   zano2=zano2+1
ENDIF
zfecha2=CTOD(STR(DAY(zfecha1),2)+'/'+STR(zmes2,2)+'/'+STR(zano2,4))
RETURN zfecha2




*
*                                                                    
* RUTINAS DE CALCULO PARA ESTE SISTEMA                               
*                                                                    
*

Function gmesv
*************
* PROGRAMA  : gmesv
* OBJETIVO  : calcula meses vencidos
*************
*
parameters zexp ,  zFeccor , zFecAct ,  zvfecultcor,  zvfecultemi , zvigente
*
if parameters() <= 3
   zvfecultcor = ginidate
   zvfecultemi = ginidate
   zvigente    = .f.
endif
*
select ade
zorden = order()
set order to ade1                            && exp + fecvto
*
swfirst = .t. 
zmesv   = 0
*
select ade
seek zexp
do while exp = zexp
   if tipade==gtadeamo and importe<>0 
      *
      if fecvto < zFecCor and stade=='2' 
         *
         if swfirst and tipade==gtadeamo
            zmesv       = (zFecAct - fecvto)/30.4
            zvfecultcor = gomonth(fecvto,3)
            zvfecultemi = gomonth(fecemi,3)
            zvigente    = iif( round(zmesv,0) < 4  , .t. , .f. )
            swfirst = .f.	
         endif
      endif 
   endif   
   *
   skip 
enddo
*
select ade
set order to &zorden
*
return zmesv



function gcalnafin
*************
* PROGRAMA  : gcalnafin
* OBJETIVO  : Calcula interés Nafin
*************
parameters zimporte,zcvetasa,zpuntos,zfeclib,zfecvto,zexp
private ;
xdias1,;
xdias2,;
xtasa1,;
xtasa2,;
xint  ,;
zfecha1,;
zfecha2,;
xdia,;
xmes,;
xano
last_area=select()

xint=0
zfecha2=zfecvto                                     && fecha hasta

xdia=day  (zfecha2)
xmes=month(zfecha2)
xano=year (zfecha2)
xmes=xmes-1
if xmes=0
   xmes=12
   xano=xano-1
endif

zfecha1=str(xdia,2)+'/'+str(xmes,2)+'/'+str(xano,4) && fecha desde
zfecha1=ctod(zfecha1)
if zfecha1<zfeclib
   zfecha1=zfeclib
endif   


if month(zfecha1)=month(zfecha2).and.;
   year (zfecha1)=year (zfecha2)	   &&el periodo est  en el mismo mes
   xdias1=zfecha2-zfecha1
   xdias2=0
   xtasa1=gtasa(zcvetasa,zfecha1,zexp)
   xtasa2=0
else												&& abarca dos meses
   xenmedio='01/'+str(month(zfecha2),2)+'/'+str(year(zfecha2),4)
   xenmedio=ctod(xenmedio)-1
   xdias1=xenmedio-zfecha1
   xdias2=zfecha2-xenmedio
   xtasa1=gtasa(zcvetasa,zfecha1,zexp)
   xtasa2=gtasa(zcvetasa,zfecha2,zexp)
endif
xfactor =xtasa1*xdias1+xtasa2*xdias2
xdivisor=zpuntos*(xdias1+xdias2)+xfactor
if xdivisor<>0
   xint=zimporte*xfactor / xdivisor
else
   xint=0
endif      
xint=round(xint,2)
if last_area<>0
   select (last_area)
endif
return xint




function gtasa
*************
* PROGRAMA  : gtasa
* OBJETIVO  : Obtiene la tasa vigente para una fecha
*************
parameters zcvetasa,zfecha,zexp
private xano, xtasa
*
if parameters() <= 2
   zexp = ''
endif
*
zfechax = gomonth(zfecha,-1)
xano=substr(alltrim(str(year(zfechax))),3,2)
xmes=month(zfechax)
xmes=ltrim(str(xmes,2))
*  
select tasas
seek zcvetasa+xano
if eof()
   set device to screen
   agerror  = ''
   =adderr('E R R O R   I R R E C U P E R A B L E')
   =adderr('=========================================')
   =adderr('Tasa NO definida y requeirada.       ')
   =adderr(space(40))
   =adderr('El proceso NO puede continuar !. Reestablezca')
   =adderr('su respaldo y reinicie el Proceso.')
   =adderr(space(40))
   =adderr('Acreditado ...'+alltrim(zexp))
   =adderr('Tasa...............'+alltrim(zcvetasa))
   =adderr('Fecha.............'+transform(zfecha,'@E'))
   =gerror()
   ErrorIrrecuperable=.t.
   set device to print
   return 0
endif
mtasa='tasa'+xmes
xtasa=&mtasa
return xtasa




*
*                                                                    
* RUTINAS DE CALCULO DE AMORTIZACIONES                               
*                                                                    
*

procedure gentbl
************
* PROGRAMA : gentbl
* OBJETIVO : Genera las tablas para los diferentes tipos de amortizaciones
*            y los agrega a un areglo, el parametro 'SOLOCALCULO' si es
*            verdadero solo calcula las amortizaciones, si es falso
*            utiliza el textmerge para mandar la salida a un archivo o 
*            a la impresora.
* AUTOR    : Gama
*          : 
* FECHA    : 14Jul95
************
Parameter POBJETIVO 
private areaini 
*
  
    areaini = select()  
	tmpade=sys(3)+'.tmp'
	Select 0
	Use tamo
	Copy struc to (tmpade) 
	Use (tmpade) alias tmpade
*	
	Do GenAmo           && Genera la tabla en un temporal 
    Do Calctbl	        && Calcula los importes por concepto de 
    					&& intereses, iva, pago total, etc.. 
*
	If POBJETIVO ='PAGARE'
	   Do RegAmortizacion
	   Do ImpAmortizacion
	Else    
	   Do imptabla 
	Endif 
	Select tmpade
	Use 
	Erase (tmpade) 
	Select (areaIni)
*	
Return 

						

PROCEDURE genamo
*************
* PROGRAMA  : genamo
* OBJETIVO  : Genera tabla de amortizacion Temporal
*************
DO CASE
CASE xtipamo=gtamonor
   ****************************************
   *Tabla de Amortizacion NORMAL
   ****************************************
   xinormal=ROUND(xcredito/xpagos,2)
   && redondeo de decimales en
   &&el £ltimo.
   xultimo=xcredito-xinormal*(xpagos-1)
   
   ygracia=xgracia
   xfecvto=xfecpri
   xsalcap=xcredito
   FOR xperiodo=1 TO xplazo
      DO CASE												&&calculo del importe
      CASE xperiodo=xplazo
         ximporte=xultimo
      CASE ygracia>0
         ximporte=0
         ygracia=ygracia-1
      OTHERWISE
         ximporte=xinormal
      ENDCASE
      SELECT tmpade
      APPEND BLANK
      REPLACE ;
		periodo		WITH xperiodo,;
		stade		WITH gstadepv,;
		fecvto		WITH xfecvto,;
		importe		WITH ximporte,;
		sdoinitab	WITH xsalcap
	      
      xfecvto=gsigmes(xfecvto)						&&calcula el siguente vencimiento
      xsalcap=xsalcap-ximporte                  &&siguiente saldo de capital
   NEXT
   
CASE xtipamo=gtamocre .or. xtipamo = gtamoaf
   ****************************************
   *Tabla de Amortizacion CRECIENTE y ARRENDAMIENTO FIINACIERO
   ****************************************
   xtasa  =xtasa_ac/12/100
   xrenta =ROUND(xcredito/((1 - (1+xtasa)^(-xpagos) ) / xtasa),2)
   ygracia=xgracia
   xfecvto=xfecpri
   xsalcap=xcredito							&& saldo inicial de capital
   FOR xperiodo=1 TO xplazo
      DO CASE								&&c lculo del importe
      CASE xperiodo=xplazo
         ximporte=xsalcap					&& lo que queda
      CASE ygracia>0
         ximporte=0
         ygracia=ygracia-1
      OTHERWISE
         xinteres=ROUND(xsalcap*xtasa,2)
         ximporte=ROUND(xrenta-xinteres,2)
      ENDCASE
      SELECT tmpade
      APPEND BLANK
      REPLACE ;
         periodo	WITH xperiodo,;
         stade		WITH gstadepv,;
         fecvto		WITH xfecvto,;
         importe	WITH ximporte,;
         sdoinitab	WITH xsalcap
      
      xfecvto=gsigmes(xfecvto)						&&c lculo de sig. venmto
      xsalcap=xsalcap-ximporte          			&&siguiente saldo de capital
   NEXT
   
CASE xtipamo=gtamovp
   xmesprianu=0
   IF xpaganual='S'										&&HZL 5JUL93
      xanos=0
      xcontmes=MONTH(xfecpri)
      xprimera=.T.										&& para meses que transc.
      &&para la primera anualidad
      FOR i=1 TO xplazo
         IF xcontmes=xmesanual.and. i > xgracia
            xanos=xanos+1
            IF xprimera
               xmesprianu=i
               xprimera=.F.
            ENDIF
         ENDIF
         IF xcontmes=12
            xcontmes=1
         ELSE
            xcontmes=xcontmes+1
         ENDIF
      NEXT
   ELSE
      xanos=0
   ENDIF
   xtasam  =xtasa_ac/12/100
   xtasaa  =xtasa_ac/100
   xtasaacap=(1+xtasaa/12)^(12)-1
   xinormal=ROUND(xcredito/xpagos,0)
   xultimo =xcredito-xinormal*(xpagos-1)			&& ajuste al ultimo pago
   xfacmes  =(1- (1+xtasam) ^ (-xpagos) ) / xtasam
   xfacmes  =xfacmes * (1+xtasam) ^ (-xgracia)
   xfacanu  =(1- (1+xtasaacap)^ (-xanos)  ) / xtasaacap
   xfacanu  =xfacanu * (1+xtasam) ^ (12-xmesprianu)
   xpagmesvp=xcredito / (xfacmes+xfacanu)
   
   ****************************************************
   
   xgracia1=xgracia
   xfecvto=xfecpri   									&& de la pantalla
   xsalcap =xcredito										&& saldo inicial de capital
   FOR xperiodo=1 TO xplazo
      xmesreal=MONTH(xfecvto)
      xinteres=xsalcap*xtasam							&&c lculo del inter‚s
      DO CASE
      CASE xperiodo=xplazo
         ximporte=xultimo
         xpagmes =xsalcap
      CASE xgracia1>0
         ximporte=0
         xgracia1=xgracia1 - 1
         xpagmes =0
      OTHERWISE
         ximporte=xinormal
         IF xmesreal=xmesanual.and.xpaganual='S'
            && pago doble
            xpagmes =xpagmesvp*2
         ELSE
            xpagmes =xpagmesvp
         ENDIF
      ENDCASE
      SELECT tmpade
      APPEND BLANK
      REPLACE ;
         conade		WITH xconade,;
         periodo	WITH xperiodo,;
         stade		WITH gstadepv,;
         fecvto		WITH xfecvto,;
         importe	WITH ximporte,;
         sdoinitab	WITH xsalcap
      
      xfecvto=gsigmes(xfecvto)						&&c lculo de sig. venmto
      &&c lculo del siguiente saldo
      xsalcap=xsalcap + xinteres - xpagmes
   NEXT
   
CASE xtipamo=gtamopv
   ****************************************
   *Tabla de Amortizacion Pagare al Vencimiento
   ****************************************
   xinormal=ROUND(xcredito/xpagos,2)
   && redondeo de decimales en
   &&el £ltimo.
   xultimo=xcredito-xinormal*(xpagos-1)
   
   ygracia=xgracia
   xfecvto=xfecpri
   xsalcap=xcredito
   FOR xperiodo=1 TO xplazo
      DO CASE												&&calculo del importe
      CASE xperiodo=xplazo
         ximporte=xultimo
      CASE ygracia>0
         ximporte=0
         ygracia=ygracia-1
      OTHERWISE
         ximporte=xinormal
      ENDCASE
      SELECT tmpade
      APPEND BLANK
      REPLACE ;
         periodo 	WITH xperiodo,;
         stade		WITH gstadepv,;
         fecvto		WITH xfecvto,;
         importe	WITH ximporte,;
         sdoinitab	WITH xsalcap
        xfecvto=gsigmes(xfecvto)						&&calcula el siguente vencimiento
        xsalcap=xsalcap-ximporte                        &&siguiente saldo de capital
   NEXT
ENDCASE
RETURN




PROCEDURE Calctbl
*************
* PROGRAMA  : Calctbl
* OBJETIVO  : 
*************
go top
do case
	case xtipamo=gtamonor
	   replace all ;
			sdofin   with sdoinitab-importe
	case xtipamo=gtamocre or xtipamo=gtamoaf
	   xtasam  =xtasa_ac/12/100
	   replace all ;
			interes  with round(sdoinitab*xtasam,2),;
			pagmesvp with interes+importe,;
			sdofin   with sdoinitab+interes-pagmesvp
	case xtipamo=gtamovp
	   xtasam  =xtasa_ac/12/100
	   replace all ;
			interes  with round(sdoinitab*xtasam,2),;
			pagmesvp with iif(xgracia>=periodo, 0, ;
						      iif(xpagmesvp>sdoinitab*(1+xtasam),round(sdoinitab*(1+xtasam),2),;
			                      iif(xmesanual=month(fecvto), xpagmesvp*2, xpagmesvp))),;
			finadi   with interes+importe-pagmesvp,;
			sdofin   with sdoinitab+interes-pagmesvp
	   replace all ;
			amoadi   with iif(finadi<0,finadi,0),;
			finadi   with iif(finadi<0,0,finadi)
	endcase
Return 



PROCEDURE RegAmortizacion
*************
* PROGRAMA  : RegAmortizacion
* OBJETIVO  : 
*************
Go top 
Dimx  = 0
xsuma = 0

Do while !eof() 
   Do case 
	  case xtipamo = gtamonor 
	     If !(importe = 0)
		     cadena = dtoc(fecvto)+' N$'+str(importe,10,2) 	     
		     dimx = dimx + 1	
		     Dimension amortiza(dimx)
             amortiza(dimx) = cadena
         EndIf     
	  case xtipamo=gtamocre or xtipamo=gtamoaf or xtipamo =gtamovp
	     If !(pagmesvp = 0)
	  	     cadena = dtoc(fecvto)+' N$'+str(pagmesvp,10,2) 	     
		     dimx = dimx + 1	
		     Dimension amortiza(dimx)
             amortiza(dimx) = cadena
         EndIf     
   EndCase       	  
   Skip
Enddo   
Return 




PROCEDURE ImpAmortizacion
*************
* PROGRAMA  : ImpAmortizacion
* OBJETIVO  : 
*************
private x,y,a

 x = 1 
 y = 1
py = 0

lencampo = len(amortiza(1))
enteros   = Int(dimx/lineas_libres)
decimales = dimx/lineas_libres-enteros
 
 if decimales > 0 
    columnas = enteros +1
 Else
    columnas = enteros
EndIf         
 
Dimension DimAux(lineas_libres,columnas) 
For a = 1 to dimx

    con = alltrim(str(a,3))
    con = replicate('0',3-len(con))+con 
    Dimaux(y,x) = con+' '+amortiza(a) 
    y = y + 1
    
    If y > Lineas_libres
        x = x + 1
        y = 1
    EndIf        
     
Endfor 

encab = ''
encab2= ''
encab3= ''
	For a = 1 to columnas
		    encab = encab+'No.  Fecha      Importe   ' 
		    encab2= encab2+'------------------------- ' 
		    encab3= encab3
	Endfor 
		    \<<encab+'^'>>
		    \<<encab2+'^'>>
		    \<<encab3+'^'>>		    
      
n = 0      
For y = 1 to lineas_libres 
   renglon = '' 
   For x = 1 to columnas
        If type('DimAux(y,x)')<>'C'
		       renglon = renglon +'  '+ replicate('.',lencampo+4)
	    else 
		       renglon = renglon +'  '+DimAux(y,x)
	    Endif       
   endfor 
  
   	    \<<renglon+'^'>>
EndFor 	    
return 	    




PROCEDURE xGenAde
*************
* PROGRAMA  : xGenAde 
* OBJETIVO  : GENERA TABLA DE AMORTIZACION PARA UN ACREDITADO
*             Ejemplo : plazo=14, gracia=2, pagos=12, significa que
*                       se generaran 14 ADEs, aunque los dos
*                       primeros seran en cero
*************
do case
                                       ****************************************
                                       * Tabla de Amortizacion NORMAL
                                       ****************************************
case xtipamo=gtamonor
   xinormal= ROUND(xcredito/xpagos,2)            &&redondeo de decimales en
                                                 &&el ultimo.
   xultimo = xcredito - ( xinormal * (xpagos-1)) &&Ultimo Pago
   *
   ygracia = xgracia
   xfecvto = xfecpri
   xsalcap = xcredito
   xvalPer = val(greccla('PERIODI',xperiodi,1))  &&Periodicidad 
   *
   for xperiodo=1 TO xpagos + (xgracia / xvalPer)
      *
      do case                                    &&calculo del importe
      case xperiodo = xpagos + (xgracia / xvalPer)
         ximporte = xultimo
      case ygracia>0
         ximporte = 0
         ygracia  = ygracia - xvalPer
      otherwise
         ximporte = xinormal
      endcase
      *
      fconade=gactban('ADE','')                  &&obtiene el siguiente consecutivo
      xconade=STR(fconade,7)
      *
      select ade
      append blank
      replace ;
        conade    with xconade ,;
        periodo   with xperiodo,;
        tipade    with gtadeamo,;
        stade     with gstadepv,;
        exp       with xexp    ,;
        fecvto    with xfecvto ,;
        importe   with ximporte,;
        sdoinitab with xsalcap ,;
        feccal    with date()

      xfecvto = iif(xvalper>=1,gomonth(xfecvto, xvalPer),xfecvto+(xvalper*10))        &&calcula el siguente vencimiento
      xsalcap = xsalcap-ximporte                 &&siguiente saldo de capital
   next
                                                 ****************************************
                                                 * Tabla de Amortizacion CRECIENTE y
                                                 * ARRENDAMIENTO FIINACIERO
                                                 ****************************************
case xtipamo=gtamocre or xtipamo = gtamoaf
   xvalPer = val(greccla('PERIODI',xperiodi,1))  &&Periodicidad 
   *
   xtasa   = iif(xvalper>=1, (xtasa_ac/12/100), ((xtasa_ac/360/100)*(xvalper*10)) )   && Tasa mensual   
   xrenta  = ROUND( xcredito / ((1 - (1+xtasa)^(-xpagos) ) / xtasa)  , 2)
   ygracia = xgracia
   xfecvto = xfecpri
   xsalcap = xcredito                             &&saldo inicial de capital
   *
   for xperiodo=1 to xpagos + (xgracia / iif(xvalPer < 1, 1, xvalPer) ) 
      *
      do  case                                   &&calculo del importe
      case xperiodo = xpagos + (xgracia / iif(xvalPer < 1, 1, xvalPer) ) 
         ximporte=xsalcap                        &&lo que queda
      case ygracia>0
         ximporte=0
         ygracia=ygracia - (iif(xvalPer < 1, 1, xvalPer))
      otherwise
         xinteres=ROUND(xsalcap*xtasa,2)
         ximporte=ROUND(xrenta-xinteres,2)
      endcase
      *
      fconade=gactban('ADE','')                  &&obtiene el siguiente consecutivo
      xconade=STR(fconade,7)
      *
      select ade
      append blank
      replace ;
         conade     with xconade ,;
         periodo    with xperiodo,;
         tipade     with gtadeamo,;
         stade      with gstadepv,;
         exp        with xexp    ,;
         fecvto     with xfecvto ,;
         importe    with ximporte,;
         sdoinitab  with xsalcap ,;
         feccal    with date()
      
      xfecvto = iif(xvalper>=1,gomonth(xfecvto, xvalPer),xfecvto+(xvalper*10))   &&calcula el siguente vencimiento
      xsalcap = xsalcap-ximporte                                                 &&siguiente saldo de capital
   next
   
CASE xtipamo=gtamovp
   ****************************************
   *Tabla de Amortizacion A VALOR PRESENTE
   ****************************************
   ****************************************************
   *Notas :
   *
   * xplazo   =72
   * xgracia  = 3
   * xpagos   =69
   * xanos    =?    Num de anualidades,
   *                en este caso = 5
   * xpaganual='S'  Tiene pago anual s¡
   *                o no
   * xmesanual=5    El pago anual es en
   *                mayo
   * xmes1= mes del primer corte menos un mes
   * xmes2= mes de la primera anualidad
   * xmesprianu=meses que transcurren hasta el pago de la primera anualidad
   * xpagmesvp=?    Es el pago fijo
   *                mensual y ser  el
   *                resultado de la
   *                f¢rmula.
   * xtasam   =?    tasa mensual
   * xtasaa   =?    tasa anual
   * xtasaacap=?  tasa anual CAPITALIZADA
   ****************************************************
   xmesprianu=0
   IF xpaganual='S'										&&HZL 5JUL93 
      xanos=0
      xcontmes=MONTH(xfecpri)
      xprimera=.T.										&& para meses que transc.
      &&para la primera anualidad
      FOR i=1 TO xplazo
         IF xcontmes=xmesanual.and. i > xgracia
            xanos=xanos+1
            IF xprimera
               xmesprianu=i
               xprimera=.F.
            ENDIF
         ENDIF
         IF xcontmes=12
            xcontmes=1
         ELSE
            xcontmes=xcontmes+1
         ENDIF
      NEXT
      &&HZL 5JUL93
   ELSE
      xanos=0
   ENDIF
   xtasam  =xtasa_ac/12/100
   xtasaa  =xtasa_ac/100
   &&HZL 5JUL93
   xtasaacap=(1+xtasaa/12)^(12)-1
   &&HZL 5JUL93
   xinormal=ROUND(xcredito/xpagos,0)
   xultimo =xcredito-xinormal*(xpagos-1)			&& ajuste al ultimo pago
   ****************************************
   *se aplica la f¢rmula para obtener
   *xpagmesvp=pago fijo mensual
   ****************************************
   ****************************************************
   *FORMULA ANTERIOR   :
   *  xfacmes  =(1- (1+xtasam) ^ (-xpagos) ) / xtasam
   *  xfacmes  =xfacmes * (1+xtasam) ^ (-xgracia)
   *  xfacanu  =(1- (1+xtasaa) ^ (-xanos)  ) / xtasaa
   *  xfacanu  =xfacanu * (1+xtasam) ^ (-xgracia)
   *  xpagmesvp=round(xcredito / (xfacmes+xfacanu),2)
   ****************************************************
   *FORMULA ACTUALIZADA:
   *  xfacmes  =(1- (1+xtasam) ^ (-(xpagos+1)) ) / xtasam
   *  xfacmes  =xfacmes * (1+xtasam) ^ (-xgracia)
   *   xfacanu  =(1- (1+xtasaa) ^ (-xanos)  ) / xtasaa
   *   xfacanu  =xfacanu * (1+xtasam) ^ (-(xmesprianu-xgracia))
   *   xpagmesvp=round(xcredito / (xfacmes+xfacanu),2)
   ****************************************************
   *FORMULA RE-ACTUALIZADA: 5JUL93
   
   xfacmes  =(1- (1+xtasam) ^ (-xpagos) ) / xtasam
   xfacmes  =xfacmes * (1+xtasam) ^ (-xgracia)
   xfacanu  =(1- (1+xtasaacap)^ (-xanos)  ) / xtasaacap
   xfacanu  =xfacanu * (1+xtasam) ^ (12-xmesprianu)
   &&LE QUITE EL ROUND
   *  xpagmesvp=round(xcredito / (xfacmes+xfacanu),2)
   xpagmesvp=xcredito / (xfacmes+xfacanu)
   
   ****************************************************
   
   xgracia1=xgracia
   xfecvto=xfecpri   									&& de la pantalla
   xsalcap =xcredito										&& saldo inicial de capital
   FOR xperiodo=1 TO xplazo
      xmesreal=MONTH(xfecvto)
      &&LE QUITE EL ROUND
      
      *     xinteres=round(xsalcap*xtasam,2)
      &&HZL 5JUL93
      xinteres=xsalcap*xtasam							&&c lculo del inter‚s
      &&c lculo del importe de pago de
      &&amortizaci¢n mensual
      DO CASE
      CASE xperiodo=xplazo
         ximporte=xultimo
         xpagmes =xsalcap
      CASE xgracia1>0
         ximporte=0
         xgracia1=xgracia1 - 1
         xpagmes =0
      OTHERWISE
         ximporte=xinormal
         IF xmesreal=xmesanual.and.xpaganual='S'
            && pago doble
            xpagmes =xpagmesvp*2
         ELSE
            xpagmes =xpagmesvp
         ENDIF
      ENDCASE
      fconade=gactban('ADE','')						&&obtiene el siguiente consecutivo
      xconade=STR(fconade,7)
      SELECT ade
      APPEND BLANK
      REPLACE ;
         conade		WITH xconade  ,;
         periodo	WITH xperiodo ,;
         tipade		WITH gtadeamo ,;
         stade		WITH gstadepv ,;
         EXP		WITH xexp     ,;
         fecvto		WITH xfecvto  ,;
         importe	WITH ximporte ,;
         sdoinitab	WITH xsalcap  ,;
         feccal     with date()
      
      xfecvto=gsigmes(xfecvto)						&&c lculo de sig. venmto
      &&c lculo del siguiente saldo
      xsalcap=xsalcap + xinteres - xpagmes
   NEXT
   ****************************************
   *graba en EXP xpagmesvp
   ****************************************
   SELECT EXP
   REPLACE pagmesvp WITH xpagmesvp
   
CASE xtipamo=gtamopv
   ****************************************
   *Tabla de Amortizacion Pagare al Vencimiento
   ****************************************
   xinormal=ROUND(xcredito/xpagos,2)
   && redondeo de decimales en
   &&el £ltimo.
   xultimo=xcredito-xinormal*(xpagos-1)
   
   ygracia=xgracia
   xfecvto=xfecpri
   xsalcap=xcredito
   FOR xperiodo=1 TO xplazo
      DO CASE												&&calculo del importe
      CASE xperiodo=xplazo
         ximporte=xultimo
      CASE ygracia>0
         ximporte=0
         ygracia=ygracia-1
      OTHERWISE
         ximporte=xinormal
      ENDCASE
      fconade=gactban('ADE','')						&&obtiene el siguiente consecutivo
      xconade=STR(fconade,7)
      SELECT ade
      APPEND BLANK
      REPLACE ;
	  conade		WITH xconade  ,;
         periodo 	WITH xperiodo ,;
         tipade		WITH gtadeamo ,;
         stade		WITH gstadepv ,;
         EXP		WITH xexp     ,;
         fecvto		WITH xfecvto  ,;
         importe	WITH ximporte ,;
         sdoinitab	WITH xsalcap  ,;
         feccal     with date()
         
        xfecvto=gsigmes(xfecvto)						&&calcula el siguente vencimiento
      xsalcap=xsalcap-ximporte                  &&siguiente saldo de capital
   NEXT
ENDCASE
RETURN





*
*                                                                    
* Borrarse                                                           
*                                                                    
*

