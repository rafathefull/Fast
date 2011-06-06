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


FUNCTION CompNumber( xValue, lMode, nTamano, nDecimales )
LOCAL cTmp
LOCAL xAux
LOCAL nInd
LOCAL nMulti := 1
LOCAL xRet
LOCAL nLen
    nTamano    := IIF( nTamano     == NIL, 10, nTamano + 1 )
    nDecimales := IIF( nDecimales  == NIL,  0, nDecimales )
    nTamano    += IIF( nTamano / 2 != INT( nTamano / 2 ), 1, 0 )
    IF lMode
      xValue := xValue * ( 10 ** nDecimales )
      cTmp   := STRZERO( ABS( xValue ), nTamano )
      xAux   := CHR( VAL( LEFT( cTmp, 1 ) ) + IIF( xValue < 0, 128, 0 ) )
      nLen   := LEN( cTmp )
      FOR nInd := 3 TO nLen STEP 2
        xAux += CHR( VAL( SUBSTR( cTmp, nInd, 2 ) ) )
      NEXT
      xRet := xAux
    ELSE
      IF ASC( xValue ) > 127
        cTmp   := STR( ASC( xValue ) - 128, 2 )
        nMulti := -1
      ELSE
        cTmp   := STR( ASC( xValue ), 2 )
      ENDIF
      nLen := LEN( xValue )
      FOR nInd := 2 TO nLen
        cTmp += STRZERO( ASC( SUBSTR( xValue, nInd, 1 ) ), 2 )
      NEXT
      xAux := LEFT( cTmp, nTamano - nDecimales ) + "." + ;
              SUBSTR( cTmp, nTamano - nDecimales + 1 )
      xRet := VAL( xAux ) * nMulti
    ENDIF
RETURN xRet

