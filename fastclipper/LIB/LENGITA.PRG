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
* FAST.lib language module. Italian.
*
* (C) 1992-95 Manu Roibal
**/

FUNCTION SetItalian()

LOCAL aArray := {}

    aAdd( aArray, "STATISTICHE" )
    aAdd( aArray, "Bytes a copiare: " )
    aAdd( aArray, "Bytes archivio : " )
    aAdd( aArray, "Bytes copiati  : " )
    aAdd( aArray, "Archivi copiato: " )
    aAdd( aArray, "Num. archivi   : " )
    aAdd( aArray, "Archivi salvati: " )
    aAdd( aArray, "Tempo stimato  : " )
    aAdd( aArray, "Perc. Copiata  : " )
    aAdd( aArray, "Introdurre il disco nel drive %1" )
    aAdd( aArray, "Salvando " )
    aAdd( aArray, "Desidera annullare l'esecuzione? (S/N)" )
    aAdd( aArray, "Introdurre il disco %1" )
    aAdd( aArray, "Data backup    : " )
    aAdd( aArray, "Creato per     : " )
    aAdd( aArray, "Desidera procedere con il ripristino degli archivi? (S/N)" )
    aAdd( aArray, "Restaurato " )
    aAdd( aArray, "Saltando " )
    aAdd( aArray, "Battere un tasto per continuare" )
    aAdd( aArray, "SN" )
    aAdd( aArray, "Lu  Ma  Me  Gi  Ve  Sa  Do" )
    aAdd( aArray, { "F4", "Cercare", "F5", "Seguente", "F6", "Nuovo", "F7", "Salvare come", "F8", "Salvare", "F10", "Uscire" } )
    aAdd( aArray, "Archivi: " )
    aAdd( aArray, "Nuovo archivi destinazione:" )
    aAdd( aArray, "Nouvo archivi:" )
    aAdd( aArray, "Cercare:" )
    aAdd( aArray, "Desidera salvare il archivi %1? (S/N)" )
    aAdd( aArray, { "Gennaio",   "Febbraio", "Marzo",    "Aprile", ;
                    "Maggio",    "Giugno",   "Luglio",   "Agosto", ;
                    "Settembre", "Ottobre",  "Novembre", "Dicembre" } )
    aAdd( aArray, "Errore in apertura %1. Ritentare? (S/N)" )
    aAdd( aArray, "Errore in fase creazione %1. Ritentare? (S/N)" )
    aAdd( aArray, "Errore leggendo %1. Ritentare? (S/N)" )
    aAdd( aArray, "Errore escribendo %1. Ritentare? (S/N)" )
    aAdd( aArray, "Formule" )
    aAdd( aArray, "Numeris" )
    aAdd( aArray, "Pubblicare " )
    aAdd( aArray, "Errore di spartizione. Ritentare? (S/N)" )
    aAdd( aArray, { "F6", "Calco ", "F7", "Visualizzare ", "F8", "Calcolare", "ESC", "Uscire" } )
    aAdd( aArray, "Desidera uscire dal foglio di calcolo? (S/N)" )
    aAdd( aArray, "Desidera salvare i cambiamenti? (S/N)" )
    aAdd( aArray, "Introduca Valore:" )
    aAdd( aArray, { "F5", "Copiare", "F6", "Rinominare", "F8", "Cancellare", "ESC", "Uscire" } )
    aAdd( aArray, "Desidera uscire dal File Manager? (S/N)" )
    aAdd( aArray, "Cancellare" )
    aAdd( aArray, "Cancellare %1? (S/N)" )
    aAdd( aArray, "Rinombrare" )
    aAdd( aArray, "Copiare" )
    aAdd( aArray, { "<Ù", "Continuare", "ESC", "Anullare" } )
    aAdd( aArray, " a" )
    aAdd( aArray, { Chr( 26 ) + Chr( 27 ), "Muovere", "<Ù", "Accettare", "ESC", "Anullare" } )
    aAdd( aArray, { "P", "Pausa", "Num. Line: ", Nil } )
    aAdd( aArray, "Fine della partita. Cominciarne un'altra? (S/N)" )
    aAdd( aArray, "Pausa" )
    aAdd( aArray, "Desidera anullare la partita? (S/N)" )
    aAdd( aArray, "Desidera cancellare la versione e perdere i cambiamenti? (S/N)" )
    aAdd( aArray, "Desidera abbandonare la edizione e salvare i cambiamenti? (S/N)" )
    aAdd( aArray, .F. )

    SetLanguage( aArray )

RETURN NIL

