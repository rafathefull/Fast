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
* FAST.lib language module. Basque.
*
* (C) 1992-95 Manu Roibal
**/

FUNCTION SetBasque()

LOCAL aArray := {}

    aAdd( aArray, "ESTATISTIKAK" )
    aAdd( aArray, "Byte kopiatzeko: " )
    aAdd( aArray, "Byte fitxero   : " )
    aAdd( aArray, "Byte kopiatuta : " )
    aAdd( aArray, "Fitx. kopiatuta: " )
    aAdd( aArray, "Fitx. zenbakia : " )
    aAdd( aArray, "Fitx. gordeta  : " )
    aAdd( aArray, "Denbor gutxi gb: " )
    aAdd( aArray, "Eginda         : " )
    aAdd( aArray, "Sartu disko bat %1-ean" )
    aAdd( aArray, "Gordetzen " )
    aAdd( aArray, "Prozesua ezabatu nahi dizu? (B/E)" )
    aAdd( aArray, "Sartu diskoa %1" )
    aAdd( aArray, "Data Backup    : " )
    aAdd( aArray, "Egilea         : " )
    aAdd( aArray, "Fitxero berriztatzea egin nahi duzu? (B/E)" )
    aAdd( aArray, "Berriztatzen " )
    aAdd( aArray, "Saltoka " )
    aAdd( aArray, "Sakatu tekla bat jarraitzeko" )
    aAdd( aArray, "BE" )
    aAdd( aArray, "Al  Ar  Az  Og  Ol  La  Ig" )
    aAdd( aArray, { "F4", "Bilatu", "F5", "Hurrengoa", "F6", "Berria", "F7", "Nora Gorde", "F8", "Gorde", "F10", "Irten" } )
    aAdd( aArray, "Fitxero: " )
    aAdd( aArray, "Helburu fitxero berria:" )
    aAdd( aArray, "Fitxero berria:" )
    aAdd( aArray, "Bilatu:" )
    aAdd( aArray, "%1 fitxero gorde nahi duzu? (B/E)" )
    aAdd( aArray, { "Urtarrila", "Otsaila", "Martxoa", "Apirila", ;
                    "Maiatza",   "Ekaina",  "Uztaila", "Abuztua", ;
                    "Iraila",    "Urria",   "Azaroa",  "Abendua" } )
    aAdd( aArray, "Okerra %1-ena heltzen. Berriro saiatu? (B/E)" )
    aAdd( aArray, "Okerra %1 sortzen. Berriro saiatu? (B/E)" )
    aAdd( aArray, "Okerra %1 irakurtzen. Berriro saiatu? (B/E)" )
    aAdd( aArray, "Okerra %1 idazten. Berriro saiatu? (B/E)" )
    aAdd( aArray, "Formulak" )
    aAdd( aArray, "Zenbakiak" )
    aAdd( aArray, "Argitaratu " )
    aAdd( aArray, "Konpartiketa okerra. Saiatu berriro? (B/E)" )
    aAdd( aArray, { "F6", "Calc ", "F7", "Argitaratu ", "F8", "Kalkulatu", "ESC", "Irten" } )
    aAdd( aArray, "Kalkulu orritik irten nahi duzu? (B/E)" )
    aAdd( aArray, "Aldaketak gordetu nahi dituzu? (B/E)" )
    aAdd( aArray, "Sartu balioa:" )
    aAdd( aArray, { "F5", "Kopiatu", "F6", "Izena berriro ipini", "F8", "Ezabatu", "ESC", "Irten" } )
    aAdd( aArray, "File Managerretik irten nahi duzu egiazki? (B/E)" )
    aAdd( aArray, "Ezeztatu" )
    aAdd( aArray, "Borratu %1? (B/E)" )
    aAdd( aArray, "Beste izena ipini" )
    aAdd( aArray, "Kopiatu" )
    aAdd( aArray, { "<Ù", "Jarraitu", "ESC", "Ezeztatu" } )
    aAdd( aArray, " " )
    aAdd( aArray, { Chr( 26 ) + Chr( 27 ), "Mugitu", "<Ù", "Onartu", "ESC", "Ezeztatu" } )
    aAdd( aArray, { "P", "Pausu", "Lerro Zenbakia : ", Nil } )
    aAdd( aArray, "Jokaldi amaiera. Beste bat hasi nahi duzu? (B/E)" )
    aAdd( aArray, "Pausu" )
    aAdd( aArray, "Jokaldia ezeztatu nahi duzu? (B/E)" )
    aAdd( aArray, "Argitarapena ezeztatu nahi duzu eta aldaketak galdu? (B/E)" )
    aAdd( aArray, "Argitarapena utzi nahi duzu eta aldaketak zaindu? (B/E)" )
    aAdd( aArray, .F. )

    SetLanguage( aArray )

RETURN NIL

