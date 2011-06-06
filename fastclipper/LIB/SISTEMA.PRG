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
#include "\libs\clipapi\version.ch"

FAST_VERSION


FUNCTION DOSShell()
LOCAL cShell := GetEnv( "COMSPEC" )
    Run( If( Empty( cShell ), "COMMAND.COM", cShell ) )
RETURN NIL


FUNCTION Delay( nDuration )
LOCAL nSecs := Seconds()
    WHILE( Seconds() < nSecs + nDuration )
    END
RETURN NIL


FUNCTION Pitido()
    IF IsSound()
      Tone( 300, 0 )
    ENDIF
RETURN NIL

