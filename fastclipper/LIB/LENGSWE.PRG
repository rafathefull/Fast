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
* FAST.lib language module. Swedish.
*
* (C) 1992-95 Manu Roibal
**/

FUNCTION SetSwedish()

LOCAL aArray := {}

    aAdd( aArray, "STATISTIK" )
    aAdd( aArray, "Bytes kopiera  : " )
    aAdd( aArray, "Bytes fil      : " )
    aAdd( aArray, "Bytes kopierade: " )
    aAdd( aArray, "Filer kopierade: " )
    aAdd( aArray, "Antal filer    : " )
    aAdd( aArray, "Sparade filer  : " )
    aAdd( aArray, "Ber�knad tid   : " )
    aAdd( aArray, "Gjorda         : " )
    aAdd( aArray, "S�tt i en disk i %1" )
    aAdd( aArray, "Sparar " )
    aAdd( aArray, "Vill du avbryta processen? (J/N)" )
    aAdd( aArray, "S�tt i en disk i %1" )
    aAdd( aArray, "Backup datum   : " )
    aAdd( aArray, "Skapad av      : " )
    aAdd( aArray, "Vill da forts�tla? (J/N)" )
    aAdd( aArray, "�terst�lla " )
    aAdd( aArray, "Ignorera " )
    aAdd( aArray, "Trych valfri tangent f�r atl forts�tla" )
    aAdd( aArray, "JN" )
    aAdd( aArray, "M�  Ti  On  To  Fr  L�  S�" )
    aAdd( aArray, { "F4", "S�ka", "F5", "N�sta", "F6", "Ny", "F7", "Spara som", "F8", "Spara", "F10", "Avsluta" } )
    aAdd( aArray, "Fil: " )
    aAdd( aArray, "Nytt output namn:" )
    aAdd( aArray, "Ny fil:" )
    aAdd( aArray, "S�ka:" )
    aAdd( aArray, "Vil du spara %1? (J/N)" )
    aAdd( aArray, { "Januari",   "Februari", "Mars",     "April", ;
                    "Maj",       "Juni",     "Juli",     "Augusti", ;
                    "September", "Oktober",  "November", "December" } )
    aAdd( aArray, "Generellt accessfel till %1. Nytt f�rs�k? (J/N)" )
    aAdd( aArray, "Generellt fel vid skapande av %1. Nytt f�rs�k? (J/N)" )
    aAdd( aArray, "Generellt l�sfel av %1. Nytt f�rs�k? (J/N)" )
    aAdd( aArray, "Generellt skrivfel av %1. Nytt f�rs�k? (J/N)" )
    aAdd( aArray, "Formler" )
    aAdd( aArray, "Nummer" )
    aAdd( aArray, "Editera " )
    aAdd( aArray, "Otill�ten delning. Nytt f�rs�k? (S/N)" )
    aAdd( aArray, { "F6", "Calc ", "F7", "Editera ", "F8", "Kalkylera", "ESC", "Avsluta" } )
    aAdd( aArray, "Vill du avsluta? (J/N)" )
    aAdd( aArray, "Vill du spara �ndringarna? (J/N)" )
    aAdd( aArray, "Skriv in v�rden:" )
    aAdd( aArray, { "F5", "Kopiera", "F6", "�ndra namn", "F8", "Radera", "ESC", "Avsluta" } )
    aAdd( aArray, "Vill du avsluta? (J/N)" )
    aAdd( aArray, "Avbryt" )
    aAdd( aArray, "Radera %1? (J/N)" )
    aAdd( aArray, "�ndra namn" )
    aAdd( aArray, "Kopiera" )
    aAdd( aArray, { "<�", "Acceptera", "ESC", "Avbryt" } )
    aAdd( aArray, " till" )
    aAdd( aArray, { Chr( 26 ) + Chr( 27 ), "Flytta", "<�", "Acceptera", "ESC", "Avbryt" } )
    aAdd( aArray, { "P", "Pause", "Ant linjer: ", Nil } )
    aAdd( aArray, "Spelet �r slut. Vill du spela igen? (J/N)" )
    aAdd( aArray, "Pause" )
    aAdd( aArray, "Vill du avbryta spelet? (J/N)" )
    aAdd( aArray, "Vill du avbryta utan att spara �ndringarna? (J/N)" )
    aAdd( aArray, "Vill du avsluta och spara �ndringarna? (J/N)" )
    aAdd( aArray, .F. )

    SetLanguage( aArray )

RETURN NIL

