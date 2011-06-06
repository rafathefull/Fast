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


Function New16( nTam, xRelleno )
Local aArray := Array ( 4096 )
Local nInd   := 0
Local nDiv
Local nInd2
    For nInd := 1 To 4096
      aArray[ nInd ] := {}
    Next
    nDiv := Int ( nTam / 4096 )
    For nInd := 1 To nDiv
      For nInd2 := 1 To 4096
        aAdd( aArray [ nInd ], xRelleno )
      Next
    Next
    nDiv := nTam % 4096
    For nInd2 := 1 To nDiv
      aAdd( aArray [ nInd ], xRelleno )
    Next
Return ( aArray )


Function Get16 ( aArray, nPos )
Local nCol := Int ( nPos % 4096 )
Local nLin := Int ( nPos / 4096 ) + If ( nCol > 0, 1, 0 )
    nCol := If ( nCol == 0, 4096, nCol )
Return( If( Len ( aArray [ nLin ] ) >= nCol, aArray [ nLin, nCol ], Nil ) )


Function Set16 ( aArray, nPos, xValue )
Local nCol := Int ( nPos % 4096 )
Local nLin := Int ( nPos / 4096 ) + If ( nCol > 0, 1, 0 )
    nCol := If ( nCol == 0, 4096, nCol )
    If Len ( aArray [ nLin ] ) >= nCol
      aArray [ nLin, nCol ] := xValue
    EndIf
Return ( Nil )


Function Add16( aArray, xValue )
Local nInd := 1
    While Len( aArray [ nInd ] ) == 4096
      nInd++
    End
    aAdd( aArray[ nInd ], xValue )
Return( Nil )


Function Len16 ( aArray )
Local nInd := 1
Local nLen := 0
    While ! Empty ( aArray [ nInd ] ) .And. nInd < 4097
      nLen += Len ( aArray [ nInd ] )
      nInd ++
    End
Return ( nLen )


Function Scan16 ( aArray, xSearch, nPos )
Local nLin := 1
Local nCol := 1
Local nRet := 0
Local nInd
    If nPos != Nil
      nCol := Int ( nPos % 4096 )
      nLin := Int ( nPos / 4096 ) + If ( nCol > 0, 1, 0 )
      nCol := If ( nCol == 0, 4096, nCol )
    EndIf
    nInd := nLin
    While ! Empty ( aArray [ nInd ] ) .And. nInd < 4097 .And. nRet == 0
      nCol := If ( nInd > nLin, 1, nCol )
      nRet := aScan ( aArray [ nInd ], xSearch, nCol )
      nInd ++
    End
Return( ( nRet += If ( nRet == 0, 0, 4096 * ( nInd - 2 ) ) ) )



