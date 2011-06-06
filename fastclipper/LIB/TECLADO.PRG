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


FUNCTION ClrBuffer()
    SetLastKey( 32 )
RETURN NIL


FUNCTION SetLastKey( nKey )
    IF ValType( nKey ) == "N"
      Keyboard Chr ( nKey )
      Inkey( 0 )
    ENDIF
RETURN NIL


FUNCTION Inkey2( nSecs )
LOCAL nKey      := InKey( nSecs )
LOCAL bKeyBlock := SetKey( nKey )
    IF bKeyBlock != Nil
      Eval ( bKeyBlock, ProcName ( 2 ), ProcLine ( 2 ) )
    ENDIF
RETURN nKey


FUNCTION FastInkey( nTime, lMouse )
LOCAL nValor    := 0
LOCAL nComienzo := GiveTime()
LOCAL bKeyBlock
    lMouse := If( lMouse == Nil, .F., lMouse )
    nTime  := If( nTime  == Nil, .01, nTime  )
    WHILE If( nTime == 0, .T., nTime + nComienzo >= GiveTime() ) .And. nValor == 0
      nValor := If( lMouse, rInkey( 0.02 ), Inkey( 0.02 ) )
      IF ( bKeyBlock := SetKey ( nValor ) ) != Nil
        Eval ( bKeyBlock, ProcName ( 2 ), ProcLine ( 2 ) )
        nValor := 0
      ENDIF
    END
RETURN nValor


STATIC FUNCTION GiveTime()
LOCAL anDias := { 1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335 }
RETURN ( ( anDias[ MONTH( DATE() ) ] + DAY( DATE() ) - 1 ) * 86400 ) + SECONDS()

