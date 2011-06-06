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


FUNCTION AsciiTab( nFila, nCol, nComienzo, cColor )
LOCAL nNumer
LOCAL nInd, nTecla, nCont, aBox
LOCAL nSelect
LOCAL cRet
LOCAL cColorLow
LOCAL cColorHigh
LOCAL cColorSpec
LOCAL nDifer

    DEFAULT nComienzo = 0
    DEFAULT nCol      = 5
    DEFAULT nFila     = 5
    DEFAULT cColor    = "B"

    cColorLow  := "W/"   + cColor
    cColorHigh := cColor + "/W*"
    cColorSpec := "GR+/" + cColor
    nSelect := nComienzo
    aBox    := BoxOpen( nFila, nCol, nFila + 15, nCol + 19, cColor )
    WHILE .T.
      nSelect   := MAX( 0, MIN( 255, nSelect   ) )
      nComienzo := MAX( 0, MIN( 228, nComienzo ) )
      nCont := 0
      DispBegin()
      FOR nInd := nComienzo TO nComienzo + 13
        nCont++
        @ nFila + nCont, nCol +  2 ;
            SAY   PadL( nInd, 3 ) ;
            COLOR cColorLow
        @ nFila + nCont, nCol +  6 ;
            SAY   " " + CHR( nInd ) + " " ;
            COLOR cColorSpec
        @ nFila + nCont, nCol + 11 ;
            SAY   PadL( nInd + 14, 3 ) ;
            COLOR cColorLow
        @ nFila + nCont, nCol + 15 ;
            SAY   " " + CHR( nInd + 14 ) + " " ;
            COLOR cColorSpec
        nDifer := nSelect - nComienzo
        @ nFila + 1 + nDifer % 14, nCol + 6 + IIF( nDifer > 13, 9, 0 ) ;
            SAY   " " + CHR( nSelect ) + " " ;
            COLOR cColorHigh
      NEXT
      DispEnd()
      nTecla := FastInkey( 0 )
      DO CASE
        CASE nTecla = K_ESC
          EXIT
        CASE nTecla = K_RETURN
          cRet := CHR( nSelect )
          EXIT
        CASE nTecla = K_PGUP
          nComienzo -= 28
          nSelect   -= 28
        CASE nTecla = K_UP
          nSelect--
          IF nSelect < nComienzo
            nComienzo --
          ENDIF
        CASE nTecla = K_PGDN
          nComienzo += 28
          nSelect   += 28
        CASE nTecla = K_DOWN
          nSelect++
          IF nSelect > nComienzo + 27
            nComienzo ++
          ENDIF
        CASE nTecla = K_HOME
          nComienzo := 0
          nSelect   := 0
        CASE nTecla = K_END
          nComienzo := 228
          nSelect   := 255
      ENDCASE
    END
    BoxClose( aBox )
RETURN( cRet )

