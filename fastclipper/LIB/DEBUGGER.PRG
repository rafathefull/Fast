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


Function __DbgClr( nColor )
Local aColores := { "W+/BG", "N/BG", "R/BG", "N+/BG", "W+/B", "GR+/B",;
                    "W/B",   "N/W",  "R/W",  "N/BG",  "R/BG" }
Return( aColores[ nColor ] )


Function InspectOBJ( cTitle, aArray )
Local cScreen := SaveScreen( 0, 0, MaxRow(), MaxCol() )
Local nCursor := SetCursor( 0 )
    __DBGInsp( cTitle, aArray )
    SetCursor( nCursor )
    RestScreen( 0, 0, MaxRow(), MaxCol(), cScreen )
Return( Nil )



Function InspectDBF()
Local cScreen := SaveScreen( 0, 0, MaxRow(), MaxCol() )
Local nCursor := SetCursor( 0 )
    __DBFList()
    SetCursor( nCursor )
    RestScreen( 0, 0, MaxRow(), MaxCol(), cScreen )
Return( Nil )



Function InspectSETS()
Local cScreen := SaveScreen( 0, 0, MaxRow(), MaxCol() )
Local nCursor := SetCursor( 0 )
    __DBGSets()
    SetCursor( nCursor )
    RestScreen( 0, 0, MaxRow(), MaxCol(), cScreen )
Return( Nil )

