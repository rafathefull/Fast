//  
// ------------------------------------------------------------------------
// FASTlib for Clipper, including all source code, examples and any other 
// file has been donated to Open Source community
// 
// Manu Roibal. Bilbao, May 7 2011
// 
// ------------------------------------------------------------------------
// Please, contact me at		manuroibal@gmail.com
// Follow me at Twitter			@manuroibal
// My Linkedin profile			www.linkedin.com/manuroibal
// 
// Or visit my web site Tons of IT at	www.tonsofit.com
// 



/***********
* FAST.lib language module. Spanish.
*
* (C) 1992-95 Manu Roibal
**/

FUNCTION SetSpanish()

LOCAL aArray := {}

    aAdd( aArray, "ESTADISTICAS" )
    aAdd( aArray, "Bytes a copiar : " )
    aAdd( aArray, "Bytes fichero  : " )
    aAdd( aArray, "Bytes copiados : " )
    aAdd( aArray, "Copiados fich. : " )
    aAdd( aArray, "N£m. ficheros  : " )
    aAdd( aArray, "Fich. salvados : " )
    aAdd( aArray, "Tiempo estimado: " )
    aAdd( aArray, "Realizado      : " )
    aAdd( aArray, "Introduzca un disco en %1" )
    aAdd( aArray, "Salvando " )
    aAdd( aArray, "¨Desea anular el proceso? (S/N)" )
    aAdd( aArray, "Introduzca el disco %1" )
    aAdd( aArray, "Fecha backup   : " )
    aAdd( aArray, "Creado por     : " )
    aAdd( aArray, "¨Desea proceder con la restauraci¢n de ficheros? (S/N)" )
    aAdd( aArray, "Restaurando " )
    aAdd( aArray, "Saltando " )
    aAdd( aArray, "Pulse una tecla para continuar" )
    aAdd( aArray, "SN" )
    aAdd( aArray, "Lu  Ma  Mi  Ju  Vi  Sa  Do" )
    aAdd( aArray, { "F4", "Buscar", "F5", "Siguiente", "F6", "Nuevo", "F7", "Salvar a", "F8", "Salvar", "F10", "Salir" } )
    aAdd( aArray, "Fichero: " )
    aAdd( aArray, "Nuevo fichero destino:" )
    aAdd( aArray, "Nuevo fichero:" )
    aAdd( aArray, "Buscar:" )
    aAdd( aArray, "¨Desea salvar el fichero %1? (S/N)" )
    aAdd( aArray, { "Enero",      "Febrero", "Marzo",     "Abril", ;
                    "Mayo",       "Junio",   "Julio",     "Agosto", ;
                    "Septiembre", "Octubre", "Noviembre", "Diciembre" } )
    aAdd( aArray, "Error accediendo a %1. ¨Reintentar? (S/N)" )
    aAdd( aArray, "Error creando %1. ¨Reintentar? (S/N)" )
    aAdd( aArray, "Error leyendo %1. ¨Reintentar? (S/N)" )
    aAdd( aArray, "Error escribiendo %1. ¨Reintentar? (S/N)" )
    aAdd( aArray, "F¢rmulas" )
    aAdd( aArray, "N£meros" )
    aAdd( aArray, "Editar " )
    aAdd( aArray, "Error de compartici¢n. ¨Reintentar? (S/N)" )
    aAdd( aArray, { "F6", "Calc ", "F7", "Editar ", "F8", "Calcular", "ESC", "Salir" } )
    aAdd( aArray, "¨Desea salir de la Hoja de C lculo? (S/N)" )
    aAdd( aArray, "¨Desea salvar los cambios? (S/N)" )
    aAdd( aArray, "Introduzca Valor:" )
    aAdd( aArray, { "F5", "Copiar", "F6", "Renombrar", "F8", "Borrar", "ESC", "Salir" } )
    aAdd( aArray, "¨Desea salir del File Manager? (S/N)" )
    aAdd( aArray, "Cancelar" )
    aAdd( aArray, "¨Borrar %1? (S/N)" )
    aAdd( aArray, "Renombrar" )
    aAdd( aArray, "Copiar" )
    aAdd( aArray, { "<Ù", "Continuar", "ESC", "Anular" } )
    aAdd( aArray, " a" )
    aAdd( aArray, { Chr( 26 ) + Chr( 27 ), "Mover", "<Ù", "Aceptar", "ESC", "Anular" } )
    aAdd( aArray, { "P", "Pausa", "N£m. L¡neas: ", Nil } )
    aAdd( aArray, "Fin de la partida. ¨Comenzar otra? (S/N)" )
    aAdd( aArray, "Pausa" )
    aAdd( aArray, "¨Desea anular la partida? (S/N)" )
    aAdd( aArray, "¨Desea cancelar la edici¢n y perder los cambios? (S/N)" )
    aAdd( aArray, "¨Desea abandonar la edici¢n y salvar los cambios? (S/N)" )
    aAdd( aArray, .F. )

    SetLanguage( aArray )

RETURN NIL

