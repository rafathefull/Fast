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


Function aCar2Arr ( cFichero, cCaracter )
Local aArray := {}
Local cFichTmp := cFichero
Local nNum
Local cCampo
    nNum := At ( cCaracter, cFichTmp )
    While ( nNum > 0 )
      cCampo := SubStr ( cFichTmp, 1, nNum - 1 )
      If Len ( AllTrim ( cCampo ) ) > 0
        aAdd ( aArray, cCampo )
      EndIf
      cFichTmp := SubStr ( cFichTmp, nNum + 1, Len ( cFichTmp ) )
      nNum     := At ( cCaracter, cFichTmp )
    End
    If ! Empty( cFichTmp )
      aAdd( aArray, cFichTmp )
    EndIf
Return ( aArray )



