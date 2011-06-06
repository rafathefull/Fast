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
* FAST.lib language module. German.
*
* (C) 1992-95 Manu Roibal
**/

FUNCTION SetGerman()

LOCAL aArray := {}

    aAdd( aArray, "STATISTIK" )
    aAdd( aArray, "Zu Kop. Bytes  : " )
    aAdd( aArray, "Dateigrî·e     : " )
    aAdd( aArray, "Kopierte bytes : " )
    aAdd( aArray, "Datei zahl     : " )
    aAdd( aArray, "Zu kop. Dateien: " )
    aAdd( aArray, "Gesicherte Dat.: " )
    aAdd( aArray, "UngefÑhre Zeit : " )
    aAdd( aArray, "Erfolgt        : " )
    aAdd( aArray, "Legen Sie eine Diskette in %1" )
    aAdd( aArray, "Beim Sichern " )
    aAdd( aArray, "Wollen Sie den Vorgang unterbrechen? (J/N)" )
    aAdd( aArray, "Schieben Sie die %1 diskette" )
    aAdd( aArray, "Backup Datum   : " )
    aAdd( aArray, "Erstellt durch : " )
    aAdd( aArray, "Wollen Sie mit der wiederherstellung der Dateien beginnen? (J/N)" )
    aAdd( aArray, "Restaurierend " )
    aAdd( aArray, "Beim öbergehen " )
    aAdd( aArray, "DrÅcken Sie auf eine Taste um fortzufahren" )
    aAdd( aArray, "JN" )
    aAdd( aArray, "Mo  Di  Mi  Do  Fr  Sa  So" )
    aAdd( aArray, { "F4", "Suchen", "F5", "NÑchste", "F6", "Neu", "F7", "Sichern als", "F8", "Sichern", "F10", "Verlassen" } )
    aAdd( aArray, "Datei: " )
    aAdd( aArray, "Neue Zieldatei:" )
    aAdd( aArray, "Neue Datei:" )
    aAdd( aArray, "Suchen:" )
    aAdd( aArray, "Wollen Sie die %1 Datei sichern? (J/N)" )
    aAdd( aArray, { "Januar",    "Februar", "MÑrz",     "April", ;
                    "Mai",       "Juni",    "Juli",     "August", ;
                    "September", "Oktober", "November", "Dezember" } )
    aAdd( aArray, "Fehler beim Zugriff auf %1. Wiederholen? (J/N)" )
    aAdd( aArray, "Fehler bei der Erstellung von %1. Wiederholen? (J/N)" )
    aAdd( aArray, "Fehler beim Lesen von %1. Wiederholen? (J/N)" )
    aAdd( aArray, "Fehler beim Schreiben von %1. Wiederholen? (J/N)" )
    aAdd( aArray, "Formeln" )
    aAdd( aArray, "Zahlen" )
    aAdd( aArray, "Editieren " )
    aAdd( aArray, "Fehler in der Partition. Wiederholen? (J/N)" )
    aAdd( aArray, { "F6", "Rechn ", "F7", "Editieren ", "F8", "Rechnen", "ESC", "Beenden" } )
    aAdd( aArray, "Mîchten Sie die Tabellenkalkulation beenden? (J/N)" )
    aAdd( aArray, "Mîchten Sie die énderungen speichern? (J/N)" )
    aAdd( aArray, "Wert eingeben:" )
    aAdd( aArray, { "F5", "Kopieren", "F6", "Umbenennen", "F8", "Lîschen", "ESC", "Verlassen" } )
    aAdd( aArray, "Wollen Sie wirklich den Datei Manager verlassen? (J/N)" )
    aAdd( aArray, "Abbrechen" )
    aAdd( aArray, "Lîschen" )
    aAdd( aArray, "Umbenennen" )
    aAdd( aArray, "Kopieren" )
    aAdd( aArray, { "<Ÿ", "Fortsetzen", "ESC", "Abbrechen" } )
    aAdd( aArray, " nach" )
    aAdd( aArray, { Chr( 26 ) + Chr( 27 ), "Bewegen", "<Ÿ", "Akzeptieren", "ESC", "Abbrechen" } )
    aAdd( aArray, { "P", "Pause", "Zeilenzahl: ", Nil } )
    aAdd( aArray, "Spielende. Nachmal spielen? (J/N)" )
    aAdd( aArray, "Pause" )
    aAdd( aArray, "Wollen Sie das Spiel abbrechen? (J/N)" )
    aAdd( aArray, "Wollen Sie die Eingabe abbrechen und die énderungen verwerfen? (J/N)" )
    aAdd( aArray, "Wollen Sie die Eingabe und die énderungen sichern? (J/N)" )
    aAdd( aArray, .F. )

    SetLanguage( aArray )

RETURN NIL
