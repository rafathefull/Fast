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


FUNCTION Chaos()
LOCAL nRow
LOCAL nCol
LOCAL cTmpScr
LOCAL cTmpScr2
LOCAL cOldScreen := SaveScreen( 0, 0, MaxRow(), MaxCol() )
    WHILE ( Inkey() == 0 )
      nRow := nRandom( MaxRow() )
      nCol := nRandom( MaxCol() )
      IF GetChar( nRow, nCol ) != " "
        cTmpScr  := SaveScreen( nRow, nCol, nRow, nCol )
        cTmpScr2 := " " + Chr( 7 )
        WHILE GetChar( ++nRow, nCol ) == " "
          RestScreen( nRow-1, nCol, nRow - 1, nCol, cTmpScr2 )
          cTmpScr2 := SaveScreen( nRow, nCol, nRow, nCol )
          RestScreen( nRow, nCol, nRow, nCol, cTmpScr )
          Delay( .001 )
        END
      ENDIF
    END
    RestScreen( 0, 0, MaxRow(), MaxCol(), cOldScreen )
RETURN NIL


