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
* FAST.lib language module. Asturian.
*
* (C) 1992-95 Manu Roibal
**/

FUNCTION SetAsturian()

LOCAL aArray := {}

    aAdd( aArray, "ESTADISTIQUES" )
    aAdd( aArray, "Bytes a copiar : " )
    aAdd( aArray, "Bytes ficheru  : " )
    aAdd( aArray, "Bytes copiaos  : " )
    aAdd( aArray, "Copiaos fich.  : " )
    aAdd( aArray, "N£mb. ficheros : " )
    aAdd( aArray, "Fich. salvaos  : " )
    aAdd( aArray, "Tiempu estim†u : " )
    aAdd( aArray, "IgÅ†u          : " )
    aAdd( aArray, "Enserte un discu en %1" )
    aAdd( aArray, "Salvando " )
    aAdd( aArray, "®PÇta-y parar el procesu? (S/N)" )
    aAdd( aArray, "Enserte el discu %1" )
    aAdd( aArray, "Fecha backup   : " )
    aAdd( aArray, "Cre†u por      : " )
    aAdd( aArray, "®PÇta-y entamar la restauraci¢n de ficheros? (S/N)" )
    aAdd( aArray, "Restaurando " )
    aAdd( aArray, "Saltando " )
    aAdd( aArray, "Calque una tecla pa siguir" )
    aAdd( aArray, "SN" )
    aAdd( aArray, "Ll  Ma  Mi  Xu  Vi  Sa  Do" )
    aAdd( aArray, { "F4", "Buscar", "F5", "Siguiente", "F6", "Nueu", "F7", "Salvar a", "F8", "Salvar", "F10", "Salir" } )
    aAdd( aArray, "Ficheru: " )
    aAdd( aArray, "Nueu ficheru de dest°n:" )
    aAdd( aArray, "Nueu ficheru:" )
    aAdd( aArray, "Buscar:" )
    aAdd( aArray, "®PÇta-y salvar el ficheru %1? (S/N)" )
    aAdd( aArray, { "Xineru",    "Febreru", "Marzu",   "Abril", ;
                    "Mayu",      "Xunu",    "Xunetu",  "Agostu", ;
                    "Setiembre", "Ochobre", "Payares", "Avientu" } )
    aAdd( aArray, "Error al dir a %1. ®Reintentar? (S/N)" )
    aAdd( aArray, "Error creando %1. ®Reintentar? (S/N)" )
    aAdd( aArray, "Error lleendo %1. ®Reintentar? (S/N)" )
    aAdd( aArray, "Error escribiendo %1. ®Reintentar? (S/N)" )
    aAdd( aArray, "F¢rmules" )
    aAdd( aArray, "N£mberos" )
    aAdd( aArray, "Editar " )
    aAdd( aArray, "Error de compartici¢n. ®Reintentar? (S/N)" )
    aAdd( aArray, { "F6", "Calc ", "F7", "Editar ", "F8", "Calcular", "ESC", "Salir" } )
    aAdd( aArray, "®PÇta-y salir de la Fueya C†lculu? (S/N)" )
    aAdd( aArray, "®PÇta-y salvar los cambios? (S/N)" )
    aAdd( aArray, "Enserte Valor:" )
    aAdd( aArray, { "F5", "Copiar", "F6", "Renomar", "F8", "Borrar", "ESC", "Salir" } )
    aAdd( aArray, "®De verd† quier salir del File Manager? (S/N)" )
    aAdd( aArray, "Cancelar" )
    aAdd( aArray, "Borrar" )
    aAdd( aArray, "Renomar" )
    aAdd( aArray, "Copiar" )
    aAdd( aArray, { "<Ÿ", "Siguir", "ESC", "Anular" } )
    aAdd( aArray, " a" )
    aAdd( aArray, { Chr( 26 ) + Chr( 27 ), "Mover", "<Ÿ", "Aceptar", "ESC", "Anular" } )
    aAdd( aArray, { "P", "Pausa", "N£mb. Ringleres: ", Nil } )
    aAdd( aArray, "Fin Partida. ®Entamar otra? (S/N)" )
    aAdd( aArray, "Pausa" )
    aAdd( aArray, "®Quier anular la partida? (S/N)" )
    aAdd( aArray, "®PÇta-y perder los cambios? (S/N)" )
    aAdd( aArray, "®PÇta-y salvar los cambios? (S/N)" )
    aAdd( aArray, .F. )

    SetLanguage( aArray )

RETURN NIL

