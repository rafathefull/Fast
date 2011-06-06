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


FUNCTION BigString( nRow, nCol, cString, cColor )
    MakeIt( nRow, nCol, cString, cColor, .T. )
RETURN NIL


FUNCTION SmallString( nRow, nCol, cString, cColor )
    MakeIt( nRow, nCol, cString, cColor, .F. )
RETURN NIL


STATIC FUNCTION MakeIt( nRow, nCol, cString, cColor, lMode )
LOCAL nInd
LOCAL nBit
LOCAL aLetter
LOCAL nLen
    DispBegin()
    FOR nInd := 1 TO LEN( cString )
      aLetter := IIF( lMode, ;
                      BigLetter(   ASC( SubStr( cString, nInd, 1 ) ) ), ;
                      SmallLetter( ASC( SubStr( cString, nInd, 1 ) ) ) )
      nLen := LEN( aLetter )
      FOR nBit := 1 TO nLen
        @ nRow + nBit - 1, nCol SAY aLetter[ nBit ] COLOR cColor
      NEXT
      nCol += 8
    NEXT
    DispEnd()
RETURN NIL

