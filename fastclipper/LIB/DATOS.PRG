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


Function Purge ( xVar )
Local xRet
    If Valtype ( xVar ) == "A"
      xRet := {}
    ElseIf Valtype ( xVar ) == "C"
      xRet := Space( Len( xVar ) )
    ElseIf Valtype ( xVar ) == "N"
      xRet := 0
    ElseIf Valtype ( xVar ) == "D"
      xRet := cTod ( Space ( 8 ) )
    ElseIf Valtype ( xVar ) == "L"
      xRet := .F.
    EndIf
Return ( xRet )


Function Inter ( xVar1, xVar2 )
Local xVarAux
    xVarAux := xVar1
    xVar1   := xVar2
    xVar2   := xVarAux
Return ( Nil )



