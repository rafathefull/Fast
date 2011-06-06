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


FUNCTION StackNew()
RETURN( {} )


FUNCTION StackPush( aStack, exp )
RETURN( aAdd( aStack, exp ) )


FUNCTION StackPop( aStack )
LOCAL xValueLast
LOCAL nLen := Len( aStack )
   IF nLen > 0
     xValueLast := aStack[ nLen ]
     aSize( aStack, nLen - 1 )
   ENDIF
RETURN( xValueLast )


FUNCTION StackEmpty( aStack )
RETURN( Empty( aStack ) )


FUNCTION StackHead( aStack )
RETURN( aTail( aStack ) )


