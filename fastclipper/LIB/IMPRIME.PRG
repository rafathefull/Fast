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


FUNCTION ToPrint( cCtrlCode )
LOCAL lPrinter := SET( _SET_PRINTER, .T. )
LOCAL lConsole := SET( _SET_CONSOLE, .F. )
    ? cCtrlCode
    SET( _SET_PRINTER, lPrinter )
    SET( _SET_CONSOLE, lPrinter )
RETURN NIL
