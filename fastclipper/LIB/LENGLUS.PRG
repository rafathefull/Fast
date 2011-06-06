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
* FAST.lib language module. Lusitanian.
*
* (C) 1992-95 Manu Roibal
**/

FUNCTION SetLusitanian()

LOCAL aArray := {}

    aAdd( aArray, "ESTADISTICAS" )
    aAdd( aArray, "Bytes a copiar : " )
    aAdd( aArray, "Bytes ficheiro : " )
    aAdd( aArray, "Bytes copiados : " )
    aAdd( aArray, "Copiados fich. : " )
    aAdd( aArray, "N£m. ficheiros : " )
    aAdd( aArray, "Fich. salvƒos  : " )
    aAdd( aArray, "Tempo estimado : " )
    aAdd( aArray, "Reali‡ado      : " )
    aAdd( aArray, "Introdu‡a um disco en %1" )
    aAdd( aArray, "Salvado " )
    aAdd( aArray, "¨Deseja anular o proceso? (S/N)" )
    aAdd( aArray, "Introdu‡a o disco %1" )
    aAdd( aArray, "Data backup    : " )
    aAdd( aArray, "Creado por     : " )
    aAdd( aArray, "¨Deseja proceder con a restauracƒo dos ficheiros? (S/N)" )
    aAdd( aArray, "Restaurando " )
    aAdd( aArray, "Saltando " )
    aAdd( aArray, "Puje uma tecla pa continuar" )
    aAdd( aArray, "SN" )
    aAdd( aArray, "Se  Te  Qu  Qu  Se  Sa  Do" )
    aAdd( aArray, { "F4", "Buscar", "F5", "Siguiente", "F6", "Novo", "F7", "Salvar a", "F8", "Salvar", "F10", "Sair" } )
    aAdd( aArray, "Ficheiro: " )
    aAdd( aArray, "Novo ficheiro destino:" )
    aAdd( aArray, "Novo ficheiro:" )
    aAdd( aArray, "Buscar:" )
    aAdd( aArray, "¨Deseja salvar o ficheiro %1? (S/N)" )
    aAdd( aArray, { "Janeiro",  "Fevereiro", "Mar‡o",    "Abril", ;
                    "Maio",     "Junho",     "Julho",    "Agosto", ;
                    "Setembro", "Outubro",   "Novembro", "Dezembro" } )
    aAdd( aArray, "Error accediendo a %1. ¨Reintentar? (S/N)" )
    aAdd( aArray, "Error creando %1. ¨Reintentar? (S/N)" )
    aAdd( aArray, "Error leyendo %1. ¨Reintentar? (S/N)" )
    aAdd( aArray, "Error escribiendo %1. ¨Reintentar? (S/N)" )
    aAdd( aArray, "F¢rmulas" )
    aAdd( aArray, "N£meros" )
    aAdd( aArray, "Editar " )
    aAdd( aArray, "Error de comparticƒo. ¨Reintentar? (S/N)" )
    aAdd( aArray, { "F6", "Calc ", "F7", "Editar ", "F8", "Calcular", "ESC", "Sair" } )
    aAdd( aArray, "¨Deseja sair da Folha de Calculo? (S/N)" )
    aAdd( aArray, "¨Deseja salvar os cambios? (S/N)" )
    aAdd( aArray, "Introdu‡a valor:" )
    aAdd( aArray, { "F5", "Copiar", "F6", "Renombrar", "F8", "Borrar", "ESC", "Sair" } )
    aAdd( aArray, "¨Deseja sair do File Manager? (S/N)" )
    aAdd( aArray, "Cancelar" )
    aAdd( aArray, "¨Borrar %1? (S/N)" )
    aAdd( aArray, "Renombrar" )
    aAdd( aArray, "Copiar" )
    aAdd( aArray, { "<Ù", "Continuar", "ESC", "Anular" } )
    aAdd( aArray, " a" )
    aAdd( aArray, { Chr( 26 ) + Chr( 27 ), "Mover", "<Ù", "Aceptar", "ESC", "Anular" } )
    aAdd( aArray, { "P", "Pausa", "N£m. L¡neas: ", Nil } )
    aAdd( aArray, "Fin da partida. ¨Comen‡ar outra? (S/N)" )
    aAdd( aArray, "Pausa" )
    aAdd( aArray, "¨Deseja anular a partida? (S/N)" )
    aAdd( aArray, "¨Deseja trocar a edi‡ao e perder os trocos? (S/N)" )
    aAdd( aArray, "¨Deseja abandonar a edi‡ao e salvar os trocos? (S/N)" )
    aAdd( aArray, .F. )

    SetLanguage( aArray )

RETURN NIL

