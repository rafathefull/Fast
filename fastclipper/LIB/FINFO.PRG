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


Function fName( cFile )
Local nPos, cFileBase
    Do Case
      Case ( nPos := Rat ( "\", cFile ) ) != 0
        cFileBase := SubStr ( cFile, nPos + 1 )
      Case ( nPos := At ( ":", cFile ) ) != 0
        cFileBase := SubStr ( cFile, nPos + 1 )
      OtherWise
        cFileBase := cFile
    EndCase
    If ( nPos := At ( ".", cFileBase ) ) != 0
      cFileBase := SubStr ( cFileBase, 1, nPos - 1 )
    EndIf
Return ( cFileBase )


Function fPath ( cFile )
Local nPos
Return ( If ( ( nPos := Rat ( "\", cFile ) ) != 0, SubStr ( cFile, 1, nPos ), "" ) )


Function fExtension ( cFile )
Local nPos
Return ( If ( ( nPos := Rat ( ".", cFile ) ) != 0, SubStr ( cFile, nPos + 1 ), "" ) )


Function fUnit ( cFile )
Local nPos
Return ( If ( ( nPos := At ( ":", cFile ) ) != 0, SubStr ( cFile, 1, nPos - 1 ), "" ) )


Function fDate( cFichero )
Return( fInfo( cFichero, 3 ) )


Function fTime( cFichero )
Return( fInfo( cFichero, 4 ) )


Function fAttributes ( cFichero )
Return( fInfo( cFichero, 5 ) )


Static Function fInfo( cFile, nPos )
Local aFiles := Directory ( cFile, "HSD" )
Local xRet   := If ( Empty ( aFiles ), Nil, aFiles [ 1, nPos ] )
Return( xRet )


