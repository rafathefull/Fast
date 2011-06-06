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
* FAST.lib language module. Catal†n.
*
* (C) 1992-95 Manu Roibal
**/

FUNCTION SetCatalan()

LOCAL aArray := {}

    aAdd( aArray, "ESTADISTIQUES" )
    aAdd( aArray, "Bytes a Copiar : " )
    aAdd( aArray, "Bytes Fitxer   : " )
    aAdd( aArray, "Bytes Copiats  : " )
    aAdd( aArray, "Copiats Fitx.  : " )
    aAdd( aArray, "N£m. Fitxers   : " )
    aAdd( aArray, "Fitx. Guardats : " )
    aAdd( aArray, "Temps Previst  : " )
    aAdd( aArray, "Realitzat      : " )
    aAdd( aArray, "Introdueixi un disc a %1" )
    aAdd( aArray, "Guardant " )
    aAdd( aArray, "Vol aturar el procäs? (S/N)" )
    aAdd( aArray, "Introdueixi el disc %1" )
    aAdd( aArray, "Data Backup    : " )
    aAdd( aArray, "Creat per      : " )
    aAdd( aArray, "Vol continuar amb la restauraci¢ de fitxers? (S/N)" )
    aAdd( aArray, "Restaurant " )
    aAdd( aArray, "Saltant " )
    aAdd( aArray, "Premi una tecla per a continuar" )
    aAdd( aArray, "SN" )
    aAdd( aArray, "Dl  Dm  Di  Dj  Dv  Ds  Du" )
    aAdd( aArray, { "F4", "Buscar", "F5", "SegÅent", "F6", "Nou", "F7", "Guardar a", "F8", "Guardar", "F10", "Sortir" } )
    aAdd( aArray, "Fitxer : " )
    aAdd( aArray, "Nou fitxer destinaci¢:" )
    aAdd( aArray, "Nou fitxer:" )
    aAdd( aArray, "Buscar:" )
    aAdd( aArray, "Vol guardar el fitxer %1? (S/N)" )
    aAdd( aArray, { "Gener",      "Febrer", "Mará",     "Abril", ;
                    "Maig",       "Juny",   "Juliol",     "Agost", ;
                    "Septembre", "Octobre", "Novembre", "Decembre" } )
    aAdd( aArray, "Error accedint a %1. Reintentar? (S/N)" )
    aAdd( aArray, "Error creant %1. Reintentar? (S/N)" )
    aAdd( aArray, "Error llegint %1. Reintentar? (S/N)" )
    aAdd( aArray, "Error escrivint a %1. Reintentar? (S/N)" )
    aAdd( aArray, "F¢rmules" )
    aAdd( aArray, "N£meros" )
    aAdd( aArray, "Editar " )
    aAdd( aArray, "Error de compartici¢. Reintentar? (S/N)" )
    aAdd( aArray, { "F6", "Calc ",    "F7",  "Editar ", "F8", "Calcular", "ESC", "Sortir" } )
    aAdd( aArray, "Vol sortir de la Fulla de CÖlcul? (S/N)" )
    aAdd( aArray, "Vol guardar els canvis? (S/N)" )
    aAdd( aArray, "Entri el Valor:" )
    aAdd( aArray, { "F5", "Copiar", "F6",  "Canviar nom", "F8", "Esborrar", "ESC", "Sortir" } )
    aAdd( aArray, "Vol sortir realment del File Manager? (S/N)" )
    aAdd( aArray, "Cancelar" )
    aAdd( aArray, "Esborrar %1? (S/N)" )
    aAdd( aArray, "Canviar Nom" )
    aAdd( aArray, "Copiar" )
    aAdd( aArray, { "<Ÿ", "Continuar", "ESC", "Anular" } )
    aAdd( aArray, " a" )
    aAdd( aArray, { Chr( 26 ) + Chr( 27 ), "Moure", "<Ÿ", "Acceptar", "ESC", "Anular" } )
    aAdd( aArray, { "P", "Pausa", "N£m. L°nies: ", Nil } )
    aAdd( aArray, "Fi Partida. Comenáar una altra? (S/N)" )
    aAdd( aArray, "Pausa" )
    aAdd( aArray, "Vol anular la partida? (S/N)" )
    aAdd( aArray, "Voleu cancel˙lar l'edici¢ i perdre els canvis? (S/N)" )
    aAdd( aArray, "Voleu abandonar l'edici¢ i guardar els canvis? (S/N)" )
    aAdd( aArray, .F. )

    SetLanguage( aArray )

RETURN NIL
