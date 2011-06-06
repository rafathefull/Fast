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


Static aScrFifo := {}


Function PushColors()
    aAdd( aScrFifo, SetColor() )
Return( Nil )


Function PopColors()
Local cColor := aTail( aScrFifo )
    aSize( aScrFifo, Len( aScrFifo ) - 1 )
    SetColor( cColor )
Return( Nil )

