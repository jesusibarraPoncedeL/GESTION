************
* USUARIO  : Fondo de Desarrollo Económico del Distrito Federal (FONDECO-DF)
* SISTEMA  : Sistemas de Control de Carteras. (SC²)
* MODULO   : Todos
* PROGRAMA : Borra
* OBJETIVO : Borra programas para Generar Aplicaciones
* AUTOR    : dms
* FECHA    : 22Feb99
************
*
Parameter zprefijo
*
zprefijo = upper(alltrim(zprefijo))
*
xapp = zprefijo + '.APP'
xexe = zprefijo + '.EXE'
xerr = zprefijo + '.ERR'
xfxp = zprefijo + '.FXP'
xpjt = zprefijo + '.PJT'
xpjx = zprefijo + '.PJX'
*
erase &xapp
erase &xexe
erase &xerr
erase &xfxp
erase &xpjt
erase &xpjx
