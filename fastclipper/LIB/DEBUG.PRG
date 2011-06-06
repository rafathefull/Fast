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




#include "inkey.ch"
#include "\libs\clipapi\version.ch"

FAST_VERSION


Function MiniDebug( nY, cFrase )
Static cOldFrase := ""
Local GetList    := {}
Local cExp
Local cColor     := SetColor( "W/B" )
Local nCursor    := SetCursor()
Local aBox1
Local aBox2
    cFrase := PadR( If( cFrase != Nil, cFrase, cOldFrase ), 200 )
    nY     := If( nY == Nil, 8, nY )
    aBox1  := BoxOpen( nY,     2, nY + 2, 77, "B", .1 )
    aBox2  := BoxOpen( nY + 3, 2, nY + 5, 77, "B", .1 )
    While .T.
      @ nY + 1, 5 get cFrase picture "@KS70"
      SetCursor( 1 )
      Read
      SetCursor( 0 )
      BoxPush( aBox1 )
      If lastkey() == K_ESC .or. Empty( cFrase )
        Exit
      Else
        cExp := ToChar( AllTrim( cFrase ) )
        @ nY + 4, 5 SAY PadR( cExp, 70 )
      EndIf
    End
    SetCursor( nCursor )
    If ! Empty( cFrase )
      cOldFrase := AllTrim( cFrase )
    EndIf
    SetCursor( nCursor )
    SetColor( cColor )
    BoxClose( aBox1 )
    BoxClose( aBox2 )
Return( Nil )


Static Function ToChar ( xVariable )
Local cFrase := "-Undefined-"
Local cType  := ValType( cFrase )
    If ! Type( xVariable ) $ "UE"
      Begin Sequence
        cFrase := &( xVariable )
      End
    Else
      cFrase := xVariable
    EndIf
    cType := Valtype( cFrase )
    Do Case
      Case cType == "N"
        cFrase = LTrim( Str( cFrase ) )
      Case cType == "D"
        cFrase = DToC( cFrase )
      Case cType == "L"
        cFrase := If( cFrase, ".T.", ".F." )
      Case 'U' $ cType
        cFrase := "-Nil-"
      Case cType == "B"
        cFrase := "-Codeblock-"
      Case cType == "A"
        cFrase := "-Array-"
      Case cType == "O"
        cFrase := "-Object-"
    EndCase
Return ( cFrase )
