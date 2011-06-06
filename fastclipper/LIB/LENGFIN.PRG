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
* FAST.lib language module. Finnish.
*
* (C) 1992-95 Manu Roibal
**/

FUNCTION SetFinnish()

LOCAL aArray := {}

    aAdd( aArray, "TILASTOT" )
    aAdd( aArray, "Kopioitavat tav: " )
    aAdd( aArray, "Tavuja Tiedosto: " )
    aAdd( aArray, "Tavuja kopioitu: " )
    aAdd( aArray, "Tied. kopioitu : " )
    aAdd( aArray, "Kpl Tiedostoja : " )
    aAdd( aArray, "Tied. tallennet: " )
    aAdd( aArray, "Arvioitu aika  : " )
    aAdd( aArray, "Tehty          : " )
    aAdd( aArray, "Laita levyke %1:n" )
    aAdd( aArray, "Talletan " )
    aAdd( aArray, "Haluatko keskeytt„„? (K/E)" )
    aAdd( aArray, "Laita levyke %1" )
    aAdd( aArray, "Varmistus Pvm  : " )
    aAdd( aArray, "Tekij„         : " )
    aAdd( aArray, "Jatkatko? (K/E)" )
    aAdd( aArray, "Palautan " )
    aAdd( aArray, "Hylk„„n " )
    aAdd( aArray, "Paina joku n„pp„in" )
    aAdd( aArray, "KE" )
    aAdd( aArray, "Ma Ti Ke To Pe La Su" )
    aAdd( aArray, { "F4", "Haku", "F5", "Seur", "F6", "Uusi", "F7", "Tall.Ni", "F8", "Talleta", "F10", "Ulos" } )
    aAdd( aArray, "Tied: " )
    aAdd( aArray, "Uusi tied. nimi: " )
    aAdd( aArray, "Uusi tied: " )
    aAdd( aArray, "Hae: " )
    aAdd( aArray, "Talletatko %1? (K/E)" )
    aAdd( aArray, { "Tammikuu", "Helmikuu", "Maaliskuu", "Huhtikuu", ;
                    "Toukokuu", "Kes„kuu",  "Hein„kuu",  "Elokuu", ;
                    "Syyskuu",  "Lokakuu",  "Marraskuu", "Joulukuu" } )
    aAdd( aArray, "Virhe laitteella %1. Uusinta? (K/E)" )
    aAdd( aArray, "Virhe luotaessa %1. Uusinta? (K/E)" )
    aAdd( aArray, "Virhe luettaessa %1. Uusinta? (K/E)" )
    aAdd( aArray, "Virhe kirjoittaessa %1. Uusinta? (K/E)" )
    aAdd( aArray, "Kaava" )
    aAdd( aArray, "Arvo" )
    aAdd( aArray, "Korjaa " )
    aAdd( aArray, "Verkko virhe. Uusinta? (K/E)" )
    aAdd( aArray, { "F6", "Laske", "F7", "Korjaa", "F8", "Laskenta", "ESC", "Ulos" } )
    aAdd(aArray, "Lopetatko? (K/E)" )
    aAdd(aArray, "Talletatko muutokset? (K/E)" )
    aAdd(aArray, "Anna arvo:" )
    aAdd(aArray, { "F5", "Kopioi", "F6", "Nime„", "F8", "Poista", "ESC", "Ulos" } )
    aAdd(aArray, "Lopetatko? (K/E)" )
    aAdd(aArray, "Keskeyt„" )
    aAdd(aArray, "Poistatko %1? (K/E)" )
    aAdd(aArray, "Nime„" )
    aAdd(aArray, "Kopioi" )
    aAdd(aArray, { "<Ù ", "Hyv„ksy", "ESC", "Keskeyt„" } )
    aAdd(aArray, " Ä>" )
    aAdd(aArray, { Chr( 26 ) + Chr( 27 ), "Liikkuu", "<Ù ", "Hyv„ksy", "ESC", "Keskeyt„" } )
    aAdd(aArray, { "P", "Paussi", "Rivi„: ", nil } )
    aAdd(aArray, "Peli loppu, pelaatko uudestaan? (K/E)" )
    aAdd(aArray, "Paussi" )
    aAdd(aArray, "Keskeyt„tk” pelin? (K/E)" )
    aAdd(aArray, "Keskeyt„tk” ja menet„t muutokset? (K/E)" )
    aAdd(aArray, "Lopetatko ja talletat muutokset? (K/E)" )
    aAdd( aArray, .F. )

    SetLanguage( aArray )

RETURN NIL
