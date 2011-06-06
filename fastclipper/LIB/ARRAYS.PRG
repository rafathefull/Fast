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


Function aMaxArr( aArray )
Local nElement
Local xExplast := 0
Local nLen     := Len( aArray )
    If nLen > 0
      xExpLast := aArray[ 1 ]
      For nElement := 2 To nLen
        xExpLast := If ( xExpLast > aArray[ nElement ], xExpLast, aArray[ nElement ] )
      Next
    EndIf
Return ( xExpLast )


Function aMinArr( aArray )
Local xExpLast := 0
Local nElement
Local nLen     := Len( aArray )
    If nLen > 0
      xExpLast := aArray[ 1 ]
      For nElement := 2 To nLen
        xExpLast := If ( xExpLast < aArray[ nElement ], xExpLast, aArray[ nElement ] )
      Next
    EndIf
Return ( xExpLast )


Function aDimArr( aArray )
Local nDim := 0
    While ( ValType( aArray ) == "A" )
      nDim++
      aArray := aArray[ 1 ]
    End
Return( nDim )



