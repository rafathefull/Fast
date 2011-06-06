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


Function rInkey( nDelay )
Local nTecla := 0
Local nTime
    nDelay := If( nDelay == Nil, .01, nDelay )
    nTime  := Seconds() + nDelay
    While If( nDelay == 0, .T., nTime >= Seconds() ) .And. nTecla == 0
      nTecla := Inkey( .1 )
      nTecla := If( nTecla != 0, nTecla, If ( rLeft(),   1001, 0 ) )
      nTecla := If( nTecla != 0, nTecla, If ( rRight(),  1002, 0 ) )
      nTecla := If( nTecla != 0, nTecla, If ( rCentre(), 1003, 0 ) )
    End
Return( nTecla )


Function rInkey2( nDelay )
Local nTecla    := rInkey( nDelay )
Local bKeyBlock := SetKey( nTecla )
    If bKeyBlock != Nil
      Eval( bKeyBlock, ProcName( 2 ), ProcLine( 2 ) )
    EndIf
Return( nTecla )

