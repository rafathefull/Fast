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




#include "fast.ch"
#include "\libs\clipapi\version.ch"

FAST_VERSION


FUNCTION BigClock( nFila, nCol )
LOCAL acDigito := Array( 4, 11 )
LOCAL acCadena := Array( 4 )
LOCAL anTime   := Array( 6 )
LOCAL nTecla   := 0
LOCAL nInd     := 0
LOCAL nCursor  := SetCursor( 0 )
LOCAL aVent
LOCAL cColor   := "W+/B"
LOCAL cTime
    DEFAULT nFila = 9
    DEFAULT nCol  = 19
    aVent  := BoxOpen( nFila - 1, nCol - 3, nFila + 6, nCol + 45, "B", 0.1 )
    acDigito := { { "€ﬂﬂ€", "   €", "ﬂﬂﬂ€", "ﬂﬂﬂ€", "€  €", "€ﬂﬂﬂ", ;
                    "€ﬂﬂﬂ", "ﬂﬂﬂ€", "€ﬂﬂ€", "€ﬂﬂ€", "  ‹ " }, ;
                  { "€  €", "   €", "‹‹‹€", "‹‹‹€", "€‹‹€", "€‹‹‹", ;
                    "€‹‹‹", "   €", "€‹‹€", "€‹‹€", "    " }, ;
                  { "€  €", "   €", "€   ", "   €", "   €", "   €", ;
                    "€  €", "   €", "€  €", "   €", "  ‹ " }, ;
                  { "ﬂﬂﬂﬂ", "   ﬂ", "ﬂﬂﬂﬂ", "ﬂﬂﬂﬂ", "   ﬂ", "ﬂﬂﬂﬂ", ;
                    "ﬂﬂﬂﬂ", "   ﬂ", "ﬂﬂﬂﬂ", "ﬂﬂﬂﬂ", "    " } }
    WHILE nTecla == 0
      cTime       := Time()
      anTime[ 1 ] := StrGetCar( cTime, 1 ) - 48
      anTime[ 2 ] := StrGetCar( cTime, 2 ) - 48
      anTime[ 3 ] := StrGetCar( cTime, 4 ) - 48
      anTime[ 4 ] := StrGetCar( cTime, 5 ) - 48
      anTime[ 5 ] := StrGetCar( cTime, 7 ) - 48
      anTime[ 6 ] := StrGetCar( cTime, 8 ) - 48
      DispBegin()
      FOR nInd := 1 TO 4
        acCadena[ nInd ] := acDigito[ nInd ] [ anTime[ 1 ] + 1 ] + " " + ;
                            acDigito[ nInd ] [ anTime[ 2 ] + 1 ] + " " + ;
                            acDigito[ nInd ] [ 11 ] + " " + ;
                            acDigito[ nInd ] [ anTime[ 3 ] + 1 ] + " " + ;
                            acDigito[ nInd ] [ anTime[ 4 ] + 1 ] + " " + ;
                            acDigito[ nInd ] [ 11 ] + " " + ;
                            acDigito[ nInd ] [ anTime[ 5 ] + 1 ] + " " + ;
                            acDigito[ nInd ] [ anTime[ 6 ] + 1 ]
        Message( nFila + nInd, nCol + 2, acCadena[ nInd ], cColor )
      NEXT
      DispEnd()
      nTecla := FastInkey( .1 )
    END
    BoxPush( aVent )
    BoxClose( aVent )
    SetCursor( nCursor )
RETURN NIL

