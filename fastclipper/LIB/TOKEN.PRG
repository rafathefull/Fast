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


FUNCTION aToken( cList, cDelimiter )
LOCAL nPos
LOCAL nInd
LOCAL aList := {}
LOCAL aDeli := {}
LOCAL nLen
LOCAL nElement
    If cDelimiter == Nil
      cDelimiter := " ,;:.?ин!()&/*+-%[]{}'" + '"' + chr(0) + chr(9) + ;
                    chr(10) + chr(13) + chr(26) + chr(138) + chr(141)
    EndIf
    nLen := LEN( cDelimiter )
    FOR nInd := 1 TO nLen
      aAdd( aDeli, SubStr( cDelimiter, nInd, 1 ) )
    NEXT
    WHILE .T.
      nPos := 0
      FOR nElement := 1 TO nLen
        nInd := AT( aDeli[ nElement ], cList )
        nPos := Min( IF( nPos == 0, LEN( cList ) + 1, nPos ), ;
                     IF( nInd == 0, nPos, nInd ) )
      NEXT
      IF nPos == 0
        EXIT
      ENDIF
      IF nPos > 1
        aAdd( aList, LEFT( cList, nPos - 1 ) )
      ENDIF
      cList := SubStr( cList, nPos + 1 )
    END
    IF LEN( cList ) > 0
      aAdd( aList, cList)
    ENDIF
RETURN ( aList )


FUNCTION NumToken( cFrase, nSeps )
RETURN ( LEN ( aToken( cFrase, nSeps ) ) )


FUNCTION Token( cFrase, cSeps, nPal )
LOCAL aPals
    nPal  := IIF( ValType( nPal ) != "N", 1, nPal )
    aPals := aToken( cFrase, cSeps )
RETURN ( IIF ( nPal >= 1 .AND. nPal <= LEN( aPals ), aPals[ nPal ], "" ) )



