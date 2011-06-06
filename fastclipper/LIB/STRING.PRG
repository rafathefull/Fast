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


Function Expand ( cCadena, cCar )
Local nInd
Local cRet := ""
    cCar := If ( cCar == Nil, " ", cCar )
    For nInd := 1 To Len ( cCadena ) - 1
      cRet += SubStr ( cCadena, nInd, 1 ) + cCar
    Next
    cRet += SubStr ( cCadena, Len ( cCadena ) )
Return ( cRet )


Function Capital ( cCadena )
Local nInd
Local nDerecha   := Len ( cCadena ) - Len ( cCadena := ( RTrim ( cCadena ) ) )
Local nIzquierda := Len ( cCadena ) - Len ( cCadena := ( LTrim ( cCadena ) ) )
    cCadena := Lower ( cCadena )
    cCadena := Upper ( SubStr ( cCadena, 1, 1 ) ) + SubStr ( cCadena, 2 )
    For nInd := 2 To Len ( cCadena )
      If SubStr ( cCadena, nInd, 1 ) == " "
        cCadena := SubStr ( cCadena, 1, nInd ) + ;
                   Upper ( SubStr ( cCadena, nInd + 1, 1 ) ) + ;
                   SubStr ( cCadena, nInd + 2 )
      EndIf
    Next
Return ( Space ( nIzquierda ) + cCadena + Space ( nDerecha ) )


FUNCTION AT2( cSearch, cTarget, nOccurs )
LOCAL nCount, nPos, nPos2 := 0
LOCAL cSubstr := cTarget
    IF nOccurs == NIL
      nOccurs := 1
    ENDIF
    FOR nCount := 1 TO nOccurs
      nPos := AT( cSearch, cSubstr )
      nPos2 += nPos
      cSubstr := SUBSTR( cSubstr, AT( cSearch, cSubstr ) +1 )
      IF nPos == 0
        EXIT
      ENDIF
    NEXT
RETURN ( nPos2 )


Function Occurs ( cCheckFor, cCheckIn )
Return ( If ( Len ( cCheckFor ) == 0 .Or. Len ( cCheckIn ) == 0, ;
           0, ;
           Len ( cCheckFor ) - Len ( StrTran ( cCheckFor, cCheckIn ) ) ) )



