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


FUNCTION Scatter()
LOCAL aMatriz := ARRAY( fCount() )
LOCAL nI      := 1
    aEval( aMatriz, { || aMatriz[ nI++ ] := FieldGet( nI ) } )
RETURN aMatriz


FUNCTION Gather ( aMatriz )
LOCAL nI := 1
    aEval( aMatriz, { | x | FieldPut( nI++, x ) } )
RETURN ( Nil )
