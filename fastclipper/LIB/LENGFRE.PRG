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
* FAST.lib language module. French.
*
* (C) 1992-95 Manu Roibal
**/

FUNCTION SetFrench()

LOCAL aArray := {}

    aAdd( aArray, "STATISTIQUES" )
    aAdd( aArray, "Bytes … copier : " )
    aAdd( aArray, "Bytes fichier  : " )
    aAdd( aArray, "Bytes copi‚s   : " )
    aAdd( aArray, "Copi‚s fich.   : " )
    aAdd( aArray, "Num. fichiers  : " )
    aAdd( aArray, "Fich. sauv‚s   : " )
    aAdd( aArray, "Temps estim‚   : " )
    aAdd( aArray, "R‚alis‚        : " )
    aAdd( aArray, "Veuillez introduire une disquette dans le lecteur %1" )
    aAdd( aArray, "En sauvant " )
    aAdd( aArray, "D‚sirez-vous annuler le traitement? (O/N)" )
    aAdd( aArray, "Introduisez la disquette %1" )
    aAdd( aArray, "Date backup    : " )
    aAdd( aArray, "Cr‚e par       : " )
    aAdd( aArray, "D‚sirez vous restituer les fichiers? (O/N)" )
    aAdd( aArray, "En restaurant " )
    aAdd( aArray, "En sautant " )
    aAdd( aArray, "Appuyez sur une touche pour continuer" )
    aAdd( aArray, "ON" )
    aAdd( aArray, "Lu  Ma  Me  Je  Ve  Sa  Di" )
    aAdd( aArray, { "F4", "Chercher", "F5", "Suivant", "F6", "Nouveau", "F7", "Enregistrer sous", "F8", "Enregistrer", "F10", "Quitter" } )
    aAdd( aArray, "Fichiers: " )
    aAdd( aArray, "Nom du fichier de destination:" )
    aAdd( aArray, "Nouveau fichier:" )
    aAdd( aArray, "Chercher:" )
    aAdd( aArray, "D‚sirez vous sauvegarder le fichier %1? (O/N)" )
    aAdd( aArray, { "Janvier",    "F‚vrier", "Mars",      "Avril", ;
                    "Mai",        "Juin",    "Juillet",   "Ao–t", ;
                    "Septembre",  "Octobre", "Novembre",  "D‚cembre" } )
    aAdd( aArray, "Erreur d'accŠs au fichier %1. R‚essayer? (O/N)" )
    aAdd( aArray, "Erreur lors de la cr‚ation de %1. R‚essayer? (O/N)" )
    aAdd( aArray, "Erreur en lecture de %1. R‚essayer? (O/N)" )
    aAdd( aArray, "Erreur en ‚criture de %1. R‚essayer? (O/N)" )
    aAdd( aArray, "Formules" )
    aAdd( aArray, "Num‚ros" )
    aAdd( aArray, "Editer " )
    aAdd( aArray, "Erreur de compartition. R‚essayer? (O/N)" )
    aAdd( aArray, { "F6", "Calc ", "F7", "Editer ", "F8", "Calculer", "ESC", "Quitter" } )
    aAdd( aArray, "D‚sirez vous sortir de la Feuille de Calcul? (O/N)" )
    aAdd( aArray, "Enregistrer les modifications? (O/N)" )
    aAdd( aArray, "Saisir une valeur:" )
    aAdd( aArray, { "F5", "Copier", "F6", "Renommer", "F8", "Effacer", "ESC", "Quitter" } )
    aAdd( aArray, "D‚sirez vous quitter le Gestionnaire de Fichiers? (O/N)" )
    aAdd( aArray, "Annuler" )
    aAdd( aArray, "Effacer %1? (O/N)" )
    aAdd( aArray, "Renommer" )
    aAdd( aArray, "Copier" )
    aAdd( aArray, { "<Ù", "Continuer", "ESC", "Annuler" } )
    aAdd( aArray, " a" )
    aAdd( aArray, { Chr( 26 ) + Chr( 27 ), "D‚placer", "<Ù", "Accepter", "ESC", "Annuler" } )
    aAdd( aArray, { "P", "Pause", "Num. Lignes: ", Nil } )
    aAdd( aArray, "Fin du Jeu. Voulez vous jouer une autre partie? (O/N)" )
    aAdd( aArray, "Pause" )
    aAdd( aArray, "Abandon du jeu? (O/N)" )
    aAdd( aArray, "D‚sirez-vous annuler l'‚dition et perdre les modifications? (O/N)" )
    aAdd( aArray, "D‚sirez vous abandonner l'‚dition et enregister les modifications? (O/N)" )
    aAdd( aArray, .F. )

    SetLanguage( aArray )

RETURN NIL

