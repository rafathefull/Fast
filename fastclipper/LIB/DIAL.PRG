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


FUNCTION Dial( cPort, cPhoneNum, cCadena )
LOCAL nHandle
LOCAL cBuffer
    DEFAULT cPort   = "COM1"
    DEFAULT cCadena = "ATDP"
    IF cPhonenum == NIL .OR. ( nHandle := fOpen ( cPort, 2 ) ) == -1
      RETURN .F.
    ENDIF
    cBuffer := cCadena + AllTrim ( cPhonenum ) + CHR ( 13 )
    IF fWrite ( nHandle, cBuffer, LEN ( cBuffer ) ) != LEN ( cBuffer )
      RETURN .F.
    ENDIF
RETURN .T.



FUNCTION Hangup( cPort, cHangup )
LOCAL nHandle
    DEFAULT cPort   = "COM1"
    DEFAULT cHangUp = "+++ATH0"
    IF ( nHandle := fOpen ( cPort, 2 ) ) == -1 .OR. ;
       fWrite( nHandle, cHangup, 7 ) != 7 .OR. ! fClose ( nHandle )
      RETURN .F.
    ENDIF
RETURN .T.

