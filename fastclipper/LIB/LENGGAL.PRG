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
* FAST.lib language module. Galician.
*
* (C) 1992-95 Manu Roibal
**/

FUNCTION SetGalician()

LOCAL aArray := {}

    aAdd( aArray, "ESTADISTICAS" )
    aAdd( aArray, "Bytes a Copiar : " )
    aAdd( aArray, "Bytes Ficheiro : " )
    aAdd( aArray, "Bytes Copiados : " )
    aAdd( aArray, "Copiados Fich. : " )
    aAdd( aArray, "N£m. Ficheiros : " )
    aAdd( aArray, "Fich. Salvados : " )
    aAdd( aArray, "Tempo Estimado : " )
    aAdd( aArray, "Feito          : " )
    aAdd( aArray, "Introduza un disco en %1" )
    aAdd( aArray, "Salvando " )
    aAdd( aArray, "¨Desexa anula-lo proceso? (S/N)" )
    aAdd( aArray, "Introduza o disco %1" )
    aAdd( aArray, "Fecha Backup   : " )
    aAdd( aArray, "Creado por     : " )
    aAdd( aArray, "¨Desexa proceder ca restauraci¢n dos ficheiros? (S/N)" )
    aAdd( aArray, "Restaurando " )
    aAdd( aArray, "Saltando " )
    aAdd( aArray, "Pulse unha tecla para seguir" )
    aAdd( aArray, "SN" )
    aAdd( aArray, "Lu  Ma  Me  Xo  Ve  Sa  Do" )
    aAdd( aArray, { "F4", "Buscar",   "F5", "Seguinte", "F6", "Novo", ;
                    "F7", "Salvar a", "F8", "Salvar",   "F10", "Sa¡r" } )
    aAdd( aArray, "Ficheiro: " )
    aAdd( aArray, "Novo ficheiro destino:" )
    aAdd( aArray, "Novo ficheiro:" )
    aAdd( aArray, "Buscar:" )
    aAdd( aArray, "¨Desexa salva-lo ficheiro %1? (S/N)" )
    aAdd( aArray, { "Xaneiro",  "Febreiro", "Marzal",    "Abril", ;
                    "Maio",     "Xunio",    "Xullo",     "Agosto", ;
                    "Setembro", "Outubro",  "Novembro",  "Nadal" } )
    aAdd( aArray, "Error accedendo a %1. ¨Reintentar? (S/N)" )
    aAdd( aArray, "Error creando %1. ¨Reintentar? (S/N)" )
    aAdd( aArray, "Error lendo %1. ¨Reintentar? (S/N)" )
    aAdd( aArray, "Error escribindo %1. ¨Reintentar? (S/N)" )
    aAdd( aArray, "F¢rmulas" )
    aAdd( aArray, "N£meros" )
    aAdd( aArray, "Editar " )
    aAdd( aArray, "Error de compartici¢n. ¨Reintentar? (S/N)" )
    aAdd( aArray, { "F6", "Calc ", "F7", "Editar ", "F8", "Calcular", "ESC", "Sa¡r" } )
    aAdd( aArray, "¨Desexa sa¡r da Folla de C lculo? (S/N)" )
    aAdd( aArray, "¨Desexa salva-los cambios? (S/N)" )
    aAdd( aArray, "Introduza Valor:" )
    aAdd( aArray, { "F5", "Copiar", "F6", "Renombrar", "F8", "Borrar", "ESC", "Sa¡r" } )
    aAdd( aArray, "¨Desexa realmente sa¡r do File Manager? (S/N)" )
    aAdd( aArray, "Cancelar" )
    aAdd( aArray, "¨Borrar %1? (S/N)" )
    aAdd( aArray, "Renombrar" )
    aAdd( aArray, "Copiar" )
    aAdd( aArray, { "<Ù", "Continuar", "ESC", "Anular" } )
    aAdd( aArray, " a" )
    aAdd( aArray, { Chr( 26 ) + Chr( 27 ), "Mover", "<Ù", "Aceptar", "ESC", "Anular" } )
    aAdd( aArray, { "P", "Pausa", "N£m. Li¤as: ", Nil } )
    aAdd( aArray, "Fin Partida. ¨Comezar outra? (S/N)" )
    aAdd( aArray, "Pausa" )
    aAdd( aArray, "¨Desexa anula-la partida? (S/N)" )
    aAdd( aArray, "¨Desexa rematar a edici¢n e perder os cambeos? (S/N)" )
    aAdd( aArray, "¨Desexa abandoar a edici¢n e gardar os cambeos? (S/N)" )
    aAdd( aArray, .F. )

    SetLanguage( aArray )

RETURN NIL

