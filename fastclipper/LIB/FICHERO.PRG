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


FUNCTION GetLabel( nUnit )
LOCAL cFichero := IIF( nUnit == Nil .Or. nUnit == 0, "", Chr( Asc( "A" ) + nUnit - 1 ) + ":\" )
LOCAL aFiles   := Directory ( cFichero, "V" )
LOCAL cRet     := IIF( Empty ( aFiles ), Nil, aFiles [ 1, 1 ] )
RETURN( IIF( cRet == Nil, "", cRet ) )


FUNCTION DirExist( cDrvDir )
RETURN( FILE ( ( cDrvDir + IIF( SubStr( cDrvDir, -1, 1 ) == "\", "", "\" ) + "NUL" ) ) )


FUNCTION ClipperPath()
RETURN( SET( _SET_PATH ) )

