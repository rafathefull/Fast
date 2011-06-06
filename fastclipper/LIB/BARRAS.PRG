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



#include "fast.ch"
#include "\libs\clipapi\version.ch"

FAST_VERSION


FUNCTION GraphBar ( cTitulo, aFila1, aFila2, aFila3, aFila4, nMode )
LOCAL nInd    := 0
LOCAL nNiv    := 0
LOCAL aNiv    := { 1, 7, 2, 4 }
LOCAL nMax    := 0
LOCAL nMax2   := 0
LOCAL nAncho  := 0
LOCAL nBarra  := 0
LOCAL nSombra := 7
LOCAL nNivel  := 1
LOCAL aFila

    DEFAULT nMode = 0
    IF aFila1 != NIL
      aEval ( aFila1[ 2 ], { | nX | nMax := MAX( nX, nMax ) } )
    ENDIF
    IF aFila2 != NIL
      aEval ( aFila2[2], { | nX | nMax := MAX ( nX, nMax ) } )
    ENDIF
    IF aFila3 != NIL
      aEval ( aFila3[2], { | nX | nMax := MAX ( nX, nMax ) } )
    ENDIF
    IF aFila4 != NIL
      aEval ( aFila4[2], { | nX | nMax := MAX ( nX, nMax ) } )
    ENDIF
    nMax    := INT( nMax )
    nMax2   := VAL( "1" + REPLICATE( "0", LEN( ALLTRIM( STR( nMax ) ) ) ) )
    nMax    := IIF( nMax2 / 5 > nMax, ;
                    nMax2 / 5, ;
                    IIF( nMax2 / 2 > nMax, nMax2 / 2, nMax2 ) )
    DEFAULT aFila1 = { "", {} }
    DEFAULT aFila2 = { "", {} }
    DEFAULT aFila3 = { "", {} }
    DEFAULT aFila4 = { "", {} }
    nAncho  := MAX( LEN( aFila1[ 2 ] ), LEN( aFila2[ 2 ] ) )
    nAncho  := MAX( nAncho, LEN( aFila3[ 2 ] ) )
    nAncho  := 540 / MAX( nAncho, LEN( aFila4[ 2 ] ) )
    nBarra  := nAncho * 0.60
    BackGraph( cTitulo, nMax, 80 )
    Legend(  20, 420, 15, aNiv[ 1 ] + 8, aFila1[ 1 ] )
    Legend( 340, 420, 15, aNiv[ 2 ] + 8, aFila2[ 1 ] )
    Legend(  20, 450, 15, aNiv[ 3 ] + 8, aFila3[ 1 ] )
    Legend( 340, 450, 15, aNiv[ 4 ] + 8, aFila4[ 1 ] )
    aFila := { aFila1, aFila2, aFila3, aFila4 }
    FOR nNiv := 4 TO 1 STEP -1
      FOR nInd := 1 TO LEN( aFila[ nNiv, 2 ] )
        DrawBar ( 20 * ( nNiv - 1 ) + 30 + ( nInd - 1 ) * nAncho, ;
                  390 - 20 * ( nNiv - 1 ), ;
                  aFila[ nNiv, 2, nInd ] / nMax * 250, ;
                  nBarra, ;
                  nSombra, ;
                  aNiv [ nNiv ] + 8, ;
                  aNiv [ nNiv ], ;
                  .F., ;
                  nMode )
      NEXT
    NEXT

RETURN NIL



