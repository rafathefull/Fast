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


STATIC aArray := {}

FUNCTION GiveMsg( nNumero, xConcat )
LOCAL cMens
LOCAL nInd
    cMens := aArray[ nNumero ]
    IF VALTYPE( xConcat ) == "A"
      FOR nInd := 1 TO LEN( xConcat )
        cMens := StrTran( cMens, "%" + Str( nInd, 1 ), xConcat[ nInd ] )
      NEXT
    ELSEIF VALTYPE( xConcat ) == "N"
      cMens := SubStr( cMens, 1, xConcat )
    ENDIF
RETURN cMens


FUNCTION SetLanguage( aLenguaje )
    aArray := aLenguaje
RETURN NIL
