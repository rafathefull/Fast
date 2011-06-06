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


#define LenBuffer 32768


STATIC cFirma := "@FAST@lib"


FUNCTION IsPirate()
LOCAL lVal    := .T.
LOCAL cTururu := "@"
    IF cFirma == cTururu + "FAST" + cTururu + "lib"
      IsProt()
      lVal := .F.
    ENDIF
RETURN( lVal .AND. cFirma != DiskSerNum( 3 ) )



STATIC FUNCTION IsProt()
LOCAL nHandle
LOCAL cBuffer
LOCAL nLen
LOCAL nPos
LOCAL cTururu := "@"
    nHandle := fOpen( cArgV( 0 ), 2 )
    nLen    := LenBuffer
    WHILE nLen == LenBuffer
      cBuffer := SPACE( LenBuffer )
      nLen    := fRead( nHandle, @cBuffer, LenBuffer )
      nPos    := At( cTururu + "FAST" + cTururu + "lib", cBuffer )
      IF nPos > 0
        fSeek( nHandle, nLen * ( -1 ), 1 )
        cBuffer := SubStr( cBuffer, 1, nPos - 1 ) + ;
                   DiskSerNum( 3 ) + ;
                   SubStr( cBuffer, nPos + 9 )
        fWrite( nHandle, cBuffer, nLen )
      ENDIF
    END
    fClose( nHandle )
RETURN NIL


