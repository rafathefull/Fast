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
    aAdd( aArray, "BerÑknad tid   : " )
    aAdd( aArray, "Gjorda         : " )
    aAdd( aArray, "SÑtt i en disk i %1" )
    aAdd( aArray, "Sparar " )
    aAdd( aArray, "Vill du avbryta processen? (J/N)" )
    aAdd( aArray, "SÑtt i en disk i %1" )
    aAdd( aArray, "Backup datum   : " )
    aAdd( aArray, "Skapad av      : " )
    aAdd( aArray, "Vill da fortsÑtla? (J/N)" )
    aAdd( aArray, "èterstÑlla " )
    aAdd( aArray, "Ignorera " )
    aAdd( aArray, "Trych valfri tangent fîr atl fortsÑtla" )
    aAdd( aArray, "JN" )
    aAdd( aArray, "MÜ  Ti  On  To  Fr  Lî  Sî" )
    aAdd( aArray, { "F4", "Sîka", "F5", "NÑsta", "F6", "Ny", "F7", "Spara som", "F8", "Spara", "F10", "Avsluta" } )
    aAdd( aArray, "Fil: " )
    aAdd( aArray, "Nytt output namn:" )
    aAdd( aArray, "Ny fil:" )
    aAdd( aArray, "Sîka:" )
    aAdd( aArray, "Vil du spara %1? (J/N)" )
    aAdd( aArray, { "Januari",   "Februari", "Mars",     "April", ;
                    "Maj",       "Juni",     "Juli",     "Augusti", ;
                    "September", "Oktober",  "November", "December" } )
    aAdd( aArray, "Generellt accessfel till %1. Nytt fîrsîk? (J/N)" )
    aAdd( aArray, "Generellt fel vid skapande av %1. Nytt fîrsîk? (J/N)" )
    aAdd( aArray, "Generellt lÑsfel av %1. Nytt fîrsîk? (J/N)" )
    aAdd( aArray, "Generellt skrivfel av %1. Nytt fîrsîk? (J/N)" )
    aAdd( aArray, "Formler" )
    aAdd( aArray, "Nummer" )
    aAdd( aArray, "Editera " )
    aAdd( aArray, "OtillÜten delning. Nytt fîrsîk? (S/N)" )
    aAdd( aArray, { "F6", "Calc ", "F7", "Editera ", "F8", "Kalkylera", "ESC", "Avsluta" } )
    aAdd( aArray, "Vill du avsluta? (J/N)" )
    aAdd( aArray, "Vill du spara Ñndringarna? (J/N)" )
    aAdd( aArray, "Skriv in vÑrden:" )
    aAdd( aArray, { "F5", "Kopiera", "F6", "éndra namn", "F8", "Radera", "ESC", "Avsluta" } )
    aAdd( aArray, "Vill du avsluta? (J/N)" )
    aAdd( aArray, "Avbryt" )
    aAdd( aArray, "Radera %1? (J/N)" )
    aAdd( aArray, "éndra namn" )
    aAdd( aArray, "Kopiera" )
    aAdd( aArray, { "<Ÿ", "Acceptera", "ESC", "Avbryt" } )
    aAdd( aArray, " till" )
    aAdd( aArray, { Chr( 26 ) + Chr( 27 ), "Flytta", "<Ÿ", "Acceptera", "ESC", "Avbryt" } )
    aAdd( aArray, { "P", "Pause", "Ant linjer: ", Nil } )
    aAdd( aArray, "Spelet Ñr slut. Vill du spela igen? (J/N)" )
    aAdd( aArray, "Pause" )
    aAdd( aArray, "Vill du avbryta spelet? (J/N)" )
    aAdd( aArray, "Vill du avbryta utan att spara Ñndringarna? (J/N)" )
    aAdd( aArray, "Vill du avsluta och spara Ñndringarna? (J/N)" )
    aAdd( aArray, .F. )

    SetLanguage( aArray )

RETURN NIL

