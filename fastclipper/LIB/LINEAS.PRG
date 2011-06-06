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


Function GraphLine( cTitulo, aGraph )
Local nInd
Local nInd2
Local nInd3
Local aColores
Local nYAnt
Local nMax    := 0
Local nMax2   := 0
Local nAncho  := 0
    aEval( aGraph, { | aDato | aEval( aDato, { | nDato | nMax := Max( nMax, nDato ) } ) } )
    nMax    := Int( nMax )
    nMax2   := Val ( "1" + Replicate ( "0", Len ( AllTrim ( Str ( nMax ) ) ) ) )
    nMax    := If ( nMax2 / 5 > nMax, nMax2 / 5, If ( nMax2 / 2 > nMax, nMax2 / 2, nMax2 ) )
    nAncho  := 540 / Len( aGraph[ 1 ] )
    BackGraph( cTitulo, nMax, 40 )
    For nInd := 1 To Len ( aGraph )
      nYAnt := 340 - aGraph[ nInd, 1 ] / nMax * 250
      aColores := { nInd, nInd + 8, nInd, nInd, nInd }
      For nInd2 := 2 To Len( aGraph[ nInd ] )
        For nInd3 := 0 To 4
          fgLine( 80 + ( nInd2 - 2 ) * nAncho, ;
                 nYAnt + nInd3, ;
                 80 + ( nInd2 - 1 ) * nAncho, ;
                 340 - aGraph[ nInd, nInd2 ] / nMax * 250 + nInd3, ;
                 aColores[ nInd3 + 1 ] )
        Next
        nYAnt := 340 - aGraph[ nInd, nInd2 ] / nMax * 250
      Next
    Next
Return ( Nil )


Function GraphZone( cTitulo, aGraph )
Local nInd
Local nInd2
Local nInd3
Local nColor
Local nYAnt
Local nMax    := 0
Local nMax2   := 0
Local nAncho  := 0
Local nSombra := 15
Local nX1
Local nX2
Local nY2
    aEval( aGraph, { | aDato | aEval( aDato, { | nDato | nMax := Max( nMax, nDato ) } ) } )
    nMax    := Int( nMax )
    nMax2   := Val ( "1" + Replicate ( "0", Len ( AllTrim ( Str ( nMax ) ) ) ) )
    nMax    := If ( nMax2 / 5 > nMax, nMax2 / 5, If ( nMax2 / 2 > nMax, nMax2 / 2, nMax2 ) )
    nAncho  := 540 / Len( aGraph[ 1 ] )
    BackGraph( cTitulo, nMax, 80 )
    For nInd := 1 To Len( aGraph )
      nYAnt := 340 - aGraph[ nInd, 1 ] / nMax * 250 + 20 * ( nInd - 1 )
      For nInd2 := 2 To Len( aGraph[ nInd ] )
        nX1 := 80 + ( nInd2 - 2 ) * nAncho - 20 * ( nInd - 1 )
        nX2 := 80 + ( nInd2 - 1 ) * nAncho - 20 * ( nInd - 1 )
        nY2 := 340 - aGraph[ nInd, nInd2 ] / nMax * 250 + 20 * ( nInd - 1 )
        nColor := nInd + If( nYAnt >= nY2, 0, 8 )
        For nInd3 := 0 To nSombra
          fgLine( nX1 + nInd3,     nYAnt - nInd3, nX2 + nInd3,     nY2 - nInd3, nColor )
          fgLine( nX1 + nInd3 + 1, nYAnt - nInd3, nX2 + nInd3 + 1, nY2 - nInd3, nColor )
        Next
        fgLine( nX1,           nYAnt,           nX2,           nY2,           0 )
        fgLine( nX1 + nSombra, nYAnt - nSombra, nX2 + nSombra, nY2 - nSombra, 0 )
        nYAnt := 340 - aGraph[ nInd, nInd2 ] / nMax * 250 + 20 * ( nInd - 1 )
      Next
    Next
Return ( Nil )



