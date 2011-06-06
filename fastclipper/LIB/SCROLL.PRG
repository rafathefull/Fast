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


FUNCTION MsgScroll( nFila, nColu, nEspacio, cTexto, cColor, nTimes )
LOCAL nCont2  := 0
LOCAL nCont1  := 0
LOCAL nLong
LOCAL nMax    := 0
LOCAL cCadena := ""
    IF PCount() < 4
      RETURN NIL
    ENDIF
    nLong := LEN( cTexto )
    WHILE Inkey() == 0 .AND. ( nTimes == NIL .OR. nMax < nTimes )
      nCont1++
      IF nCont1 < nEspacio
        cCadena := SPACE( nEspacio - nCont1 ) + SubStr( cTexto, 1, nCont1 )
      ELSEIF nCont2 > nLong
        nCont1 := nCont2 := 0
        nMax++
      ELSE
        nLong := LEN( AllTrim( cTexto ) )
        nCont2++
        cCadena := SubStr( cTexto, nCont2, nEspacio )
        cCadena := cCadena + SPACE( nEspacio - LEN( cCadena ) )
      ENDIF
      DispBegin()
      @ nFila, nColu SAY Space( nEspacio ) COLOR cColor
      @ nFila, nColu SAY cCadena           COLOR cColor
      DispEnd()
      Delay( 0.1 )
    END
RETURN( IIF( nTimes == NIL, .T., nTimes != nMax ) )

