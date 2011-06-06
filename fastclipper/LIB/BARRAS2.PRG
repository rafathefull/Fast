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


Function GraphBar2 ( cTitulo, aArray, nMode )
Local nInd    := 0
Local nInd2   := 0
Local nMax    := 0
Local nMax2   := 0
Local nAncho  := 0
Local nBarra  := 0
Local nSombra := 7
Local nNivel  := 1
Local nElem   := 0
    nMode := If( nMode == Nil, 0, nMode )
    aEval ( aArray, { | aX | nElem := Max ( Len( aX ), nElem ) } )
    nAncho  := 550 / ( Len( aArray ) * nElem )
    nBarra  := nAncho * 0.75
    For nInd := 1 To Len( aArray )
      aEval ( aArray[ nInd ], { | nX | nMax := Max ( nX, nMax ) } )
    Next
    nMax    := Int( nMax )
    nMax2   := Val ( "1" + Replicate ( "0", Len ( AllTrim ( Str ( nMax ) ) ) ) )
    nMax    := If ( nMax2 / 5 > nMax, nMax2 / 5, If ( nMax2 / 2 > nMax, nMax2 / 2, nMax2 ) )
    BackGraph( cTitulo, nMax, 30 )
    For nInd := 1 To nElem
      For nInd2 := 1 To Len( aArray )
        If Len( aArray[ nInd2 ] ) >= nInd
          DrawBar ( 75 + ( Len( aArray ) * ( nInd - 1 ) - ( nInd - 1 ) ) * nAncho + ;
                         ( nInd - 1 ) * nAncho + ;
                         ( nInd2 * nBarra ), ;
                    330, ;
                    aArray[ nInd2, nInd ] / nMax * 250, ;
                    nBarra, ;
                    nSombra, ;
                    nInd2 + 8, ;
                    nInd2, ;
                    .F., ;
                    nMode )
        EndIf
      Next
    Next
Return ( Nil )


