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




#include "inkey.ch"
#include "fast.ch"
#include "\libs\clipapi\version.ch"

FAST_VERSION


FUNCTION AsciiTabPro( nFila, nCol, nComienzo, cColor )
LOCAL aBox
LOCAL nInd1
LOCAL nInd2
LOCAL cHexa := "0123456789ABCDEF"
LOCAL aNew
LOCAL aOld
LOCAL nKey
LOCAL lStable
LOCAL cRet
LOCAL cColorFrame
LOCAL cColorLow
LOCAL cColorHigh
LOCAL cColorSpec

    DEFAULT nComienzo = 0
    DEFAULT nCol      = 12
    DEFAULT nFila     = 2
    DEFAULT cColor    = "B"

    cColorFrame := "W+/"  + cColor
    cColorLow   := "W/"   + cColor
    cColorHigh  := cColor + "/W*"
    cColorSpec  := "GR+/" + cColor
    DispBegin()
    aBox := BoxOpen( nFila, nCol, nFila + 19, nCol + 53, cColor )
    FOR nInd1 := 0 TO 15
      @ nFila + 1, nCol + ( nInd1 * 3 ) + 6 ;
          SAY SUBSTR( cHexa, nInd1 + 1, 1 ) ;
          COLOR cColorFrame
      @ nFila + nInd1 + 3, nCol + 2 ;
          SAY SUBSTR( cHexa, nInd1 + 1, 1 ) + " ³";
          COLOR cColorFrame
    NEXT
    @ nFila + 2, nCol + 1 ;
        SAY REPLICATE( "Ä", 52 ) ;
        COLOR cColorFrame
    @ nFila + 1, nCol + 4 ;
        SAY "³" ;
        COLOR cColorFrame
    @ nFila + 2, nCol + 4 ;
        SAY "Å" ;
        COLOR cColorFrame
    FOR nInd1 := 0 TO 15
      FOR nInd2 := 0 TO 15
        @ nFila + nInd1 + 3, nCol + ( nInd2 * 3 ) + 6 ;
            SAY CHR( nInd1 * 16 + nInd2 ) ;
            COLOR cColorLow
      NEXT
    NEXT
    DispEnd()
    nComienzo := MAX( 0, MIN( 228, nComienzo ) )
    aNew      := { INT( nComienzo / 16 ), INT( nComienzo % 16 ) }
    aOld      := { INT( nComienzo / 16 ), INT( nComienzo % 16 ) }
    lStable   := .F.
    WHILE .T.
      IF ! lStable
        DispBegin()
        @ nFila + aOld[ 1 ] + 3, nCol + ( aOld[ 2 ] * 3 ) + 5 ;
            SAY " " + CHR( aOld[ 1 ] * 16 + aOld[ 2 ] ) + " " ;
            COLOR cColorLow
        aOld := aClone( aNew )
        @ nFila + aOld[ 1 ] + 3, nCol + ( aOld[ 2 ] * 3 ) + 5 ;
            SAY " " + CHR( aOld[ 1 ] * 16 + aOld[ 2 ] ) + " " ;
            COLOR cColorHigh
        @ nFila + 1, nCol + 1 ;
            SAY STR( aOld[ 1 ] * 16 + aOld[ 2 ], 3 ) ;
            COLOR cColorSpec
        DispEnd()
        lStable := .T.
      ENDIF
      nKey    := FastInKey( 0 )
      lStable := .F.
      DO CASE
        CASE nKey = K_ESC
          EXIT
        CASE nKey = K_RETURN
          cRet := CHR( aOld[ 1 ] * 16 + aOld[ 2 ] )
          EXIT
        CASE nKey = K_PGUP
          aNew := { 0, 0 }
        CASE nKey = K_UP
          IF aNew[ 1 ] > 0
            aNew := { aNew[ 1 ] - 1, aNew[ 2 ] }
          ENDIF
        CASE nKey = K_PGDN
          aNew := { 15, 15 }
        CASE nKey = K_DOWN
          IF aNew[ 1 ] < 15
            aNew := { aNew[ 1 ] + 1, aNew[ 2 ] }
          ENDIF
        CASE nKey = K_HOME
          aNew := { aNew[ 1 ], 0 }
        CASE nKey = K_END
          aNew := { aNew[ 1 ], 15 }
        CASE nKey = K_LEFT
          IF aNew[ 2 ] > 0
            aNew := { aNew[ 1 ], aNew[ 2 ] - 1 }
          ELSE
            IF aNew[ 1 ] > 0
              aNew := { aNew[ 1 ] - 1, 15 }
            ENDIF
          ENDIF
        CASE nKey = K_RIGHT
          IF aNew[ 2 ] < 15
            aNew := { aNew[ 1 ], aNew[ 2 ] + 1 }
          ELSE
            IF aNew[ 1 ] < 15
              aNew := { aNew[ 1 ] + 1, 0 }
            ENDIF
          ENDIF
        OTHERWISE
          lStable := .T.
      ENDCASE
    END
    BoxClose( aBox )
RETURN ( cRet )


