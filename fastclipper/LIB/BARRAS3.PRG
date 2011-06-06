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


Function GraphBar3( cTitulo, aLeyenda, aDatos, nMode )
Local nInd    := 0
Local nAux    := 0
Local nNiv    := 0
Local nMax    := 0
Local nMin    := 0
Local nMax2   := 0
Local nAncho  := 0
Local nBarra  := 0
Local nSombra := 7
    nMode := If( nMode == Nil, 0, nMode )
    aEval ( aDatos, { | nX | nMax := Max ( nX, nMax );
                           , nMin := Min ( nX, nMin ) } )
    nMax    := Int( nMax )
    nMin    := Int( nMin )
    if nMin<0
      nMax := Max( nMax, Abs(nMin) )
    endif
    nMax2   := Val ( "1" + Replicate ( "0", Len ( AllTrim ( Str ( nMax ) ) ) ) )
    nMax    := If ( nMax2 / 5 > nMax, nMax2 / 5, If ( nMax2 / 2 > nMax, nMax2 / 2, nMax2 ) )
    if nMin<0
      nMin := -nMax
    endif
    nAncho  := 540 / Max ( nAncho, Len ( aDatos ) )
    nBarra  := nAncho * 0.60
    BackGraph( cTitulo, nMax, 40, nMin )
    For nAux := 1 To 4
      For nInd := ( nAux - 1 ) * 4 + 1 To Min( ( nAux * 4 ), Len( aLeyenda ) )
        Legend( ( nAux - 1 ) * 160 + 5, 375 + 20 * If( nInd < 5, nInd, If( nInd % 4 == 0, 4, nInd % 4 ) ), 15, nInd, SubStr( aLeyenda[ nInd ], 1, 12 ) )
      Next
    Next
    For nInd := 1 To Len ( aDatos )
      IF nMin>=0
        DrawBar( 90 + ( nInd - 1 ) * nAncho, ;
                 330, ;
                 aDatos [ nInd ] / nMax * 250, ;
                 nBarra, ;
                 nSombra, ;
                 nInd, ;
                 nInd, ;
                 .T., ;
                 nMode )
      ELSE
        DrawBar( 90 + ( nInd - 1 ) * nAncho, ;
                 ( 330 - 125 ) + IIF( aDatos[nInd]>0, ;
                                      0, ;
                                      ABS( aDatos[ nInd ] ) / nMax * 125 ), ;
                 ABS( aDatos [ nInd ] ) / nMax * 125, ;
                 nBarra, ;
                 nSombra, ;
                 nInd, ;
                 nInd, ;
                 .T., ;
                 nMode )
      ENDIF
    NEXT
    IF nMin < 0
      fgLine( 90, 330-125, 90 + 540 - nAncho, 330 - 125, 16 )
    ENDIF
RETURN ( NIL )

