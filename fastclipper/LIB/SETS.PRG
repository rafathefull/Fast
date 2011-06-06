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


FUNCTION SaveSets()
LOCAL aOldSets := Array ( _SET_COUNT )
    aEval ( aOldSets, { | xE, nE | aOldSets [ nE ] := Set ( nE ) } )
RETURN aOldSets


FUNCTION RestSets( aOldSets )
   aEval ( aOldSets, { | xE, nE | Set ( nE, xE ) }, 1, _SET_COUNT )
RETURN NIL

