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




#include "\libs\clipapi\version.ch"

FAST_VERSION


Function BoxOpen( nTop, nLef, nBot, nRight, cFon, nV )
Local cPantalla := SaveScreen ( nTop, nLef, nBot, nRight )
    cFon := AllTrim( cFon )
    nV   := If ( nV != Nil, If ( nV <= 0, .8, nV ), .8 )
    DispBox ( nTop, nLef, nBot, nRight, Space ( 9 ), cFon + "/" + cFon )
    Box3D ( nTop, nLef, nBot, nRight, .T., cFon )
Return ( { nTop, nLef, nBot, nRight, cFon, nV, cPantalla } )


Function BoxPush( aA )
Local cPantalla := SaveScreen ( aA [ 1 ] + 1, aA [ 2 ] + 1, aA [ 3 ] - 1, aA [ 4 ] - 1 )
    Box3D( aA [ 1 ], aA [ 2 ], aA [ 3 ], aA [ 4 ], .F., aA [ 5 ] )
    Delay( aA [ 6 ] )
    RestScreen ( aA [ 1 ] + 1, aA [ 2 ] + 1, aA [ 3 ] - 1, aA [ 4 ] - 1, cPantalla )
    Box3D( aA [ 1 ], aA [ 2 ], aA [ 3 ], aA [ 4 ], .T., aA [ 5 ] )
Return ( Nil )


Function BoxTurn( aA, lModo )
    lModo := If( lModo == Nil, .T., lModo )
    Box3D ( aA [ 1 ], aA [ 2 ], aA [ 3 ], aA [ 4 ], lModo, aA [ 5 ] )
Return ( Nil )


Function BoxClose ( aA )
    RestScreen( aA [ 1 ], aA [ 2 ], aA [ 3 ], aA [ 4 ], aA [ 7 ]  )
Return( Nil )


Function BoxDelete( aA )
Local cPantalla := SaveScreen ( aA [ 1 ] + 1, aA [ 2 ] + 1, aA [ 3 ] - 1, aA [ 4 ] - 1 )
    Box3D( aA [ 1 ], aA [ 2 ], aA [ 3 ], aA [ 4 ], .F., aA [ 5 ] )
    Delay( aA [ 6 ] )
    BoxOpen ( aA [ 1 ], aA [ 2 ], aA [ 3 ], aA [ 4 ], aA [ 5 ], aA [ 6 ]  )
Return ( Nil )


Static Function Box3D ( nTop, nLeft, nBot, nRight, lSalido, cFondo )
Local cLuz
Local cSombra
Local nCont
Local nX := Col ()
Local nY := Row ()
    If cFondo == Nil
      cFondo := SetColor ()
      cFondo := SubStr ( cFondo, 1, At ( ",", cFondo ) - 1 )
      cFondo := SubStr ( cFondo, 1 + Rat ( "/", cFondo ) )
    EndIf
    If lSalido
      cLuz    := cFondo + "+/" + cFondo
      cSombra := "N/" + cFondo
    Else
      cSombra := cFondo + "+/" + cFondo
      cLuz    := "N/" + cFondo
    EndIf
    DispBegin()
    Message( nBot, nLeft, "À", cLuz )
    Message( nTop, nLeft, "Ú" + Replicate ( "Ä", nRight - nLeft - 1 ), cLuz )
    For nCont := nTop + 1 To nBot - 1
      Message( nCont, nLeft, "³", cLuz )
    Next
    Message( nTop, nRight,    "¿", cSombra )
    Message( nBot, nLeft + 1, Replicate ( "Ä", nRight - nLeft - 1 ) + "Ù", cSombra )
    For nCont := nTop + 1 To nBot - 1
      Message( nCont, nRight, "³", cSombra )
    Next
    DispEnd()
    SetPos ( nY, nX )
Return ( Nil )

