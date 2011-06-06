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


Function GaugeNew( nLinea, cMensaje, cColor )
Local nY1 := nLinea - 2
Local nX1 := 36 - Len ( cMensaje ) / 2
Local nY2 := nLinea + 2
Local nX2 := 41 + Len ( cMensaje ) / 2
    DispBegin()
    DispBox ( nY1, nX1, nY2, nX2, "ÚÄ¿³ÙÄÀ³ ", "W+/N" + cColor )
    @ nLinea,     nX1 + 3 Say cMensaje Color "N+/" + cColor
    @ nLinea - 2, 36      Say "   0% " Color "N+/" + cColor
    @ nY1, nX1 Say "Ú" Color "N+/" + cColor
    @ nY2, nX1 Say "À" Color "N+/" + cColor
    @ nY1, nX2 Say "¿" Color "N+/" + cColor
    @ nY2, nX2 Say "Ù" Color "N+/" + cColor
    @ nY1,     nX1 + 1 Say "Ä" Color "N+/" + cColor
    @ nY1,     nX2 - 1 Say "Ä" Color "N+/" + cColor
    @ nY2,     nX1 + 1 Say "Ä" Color "N+/" + cColor
    @ nY2,     nX2 - 1 Say "Ä" Color "N+/" + cColor
    @ nY1 + 1, nX1     Say "³" Color "N+/" + cColor
    @ nY1 + 1, nX2     Say "³" Color "N+/" + cColor
    @ nY1 + 2, nX1     Say "³" Color "N+/" + cColor
    @ nY1 + 2, nX2     Say "³" Color "N+/" + cColor
    @ nY1 + 3, nX1     Say "³" Color "N+/" + cColor
    @ nY1 + 3, nX2     Say "³" Color "N+/" + cColor
    @ nY1,     nX1 + 2 Say "Ä" Color "W/" + cColor
    @ nY1,     nX1 + 3 Say "Ä" Color "W/" + cColor
    @ nY1,     nX1 + 4 Say "Ä" Color "W/" + cColor
    @ nY1,     nX2 - 2 Say "Ä" Color "W/" + cColor
    @ nY1,     nX2 - 3 Say "Ä" Color "W/" + cColor
    @ nY1,     nX2 - 4 Say "Ä" Color "W/" + cColor
    @ nY2,     nX1 + 2 Say "Ä" Color "W/" + cColor
    @ nY2,     nX1 + 3 Say "Ä" Color "W/" + cColor
    @ nY2,     nX1 + 4 Say "Ä" Color "W/" + cColor
    @ nY2,     nX2 - 2 Say "Ä" Color "W/" + cColor
    @ nY2,     nX2 - 3 Say "Ä" Color "W/" + cColor
    @ nY2,     nX2 - 4 Say "Ä" Color "W/" + cColor
    DispEnd()
Return ( { 0, nLinea, ++nX1 , nX2 - nX1 - 2, "GR+/" + cColor, cMensaje } )


Function GaugeUpdate ( aE, nMas )
    aE[ 1 ] += nMas
    @ aE[ 2 ] - 2, 36          Say " " + Str ( aE[ 1 ] * 100, 3 ) + "% "   Color aE[ 5 ]
    @ aE[ 2 ],     aE[ 3 ] + 2 Say SubStr( aE[ 6 ], 1, aE[ 4 ] * aE[ 1 ] ) Color aE[ 5 ]
Return ( Nil )

