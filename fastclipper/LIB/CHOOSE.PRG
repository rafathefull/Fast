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


Function ChooseColor( nPosY, nPosX, lColor )
Local nX     := 1
Local nY     := 1
Local aBox
Local nInd1
Local nInd2
Local nKey
Local nCursor := SetCursor( 0 )
Local cBuffer
    nPosY  := If( nPosY  == Nil,   3, nPosY )
    nPosX  := If( nPosX  == Nil,  28, nPosX )
    lColor := IF( lColor == Nil, .F., lColor )
    DispBegin()
    aBox  := BoxOpen( nPosY - 1, nPosX - 2, nPosY + 18, nPosX + 19, "W" )
    For nInd1 := 0 To 15
      cBuffer := ""
      For nInd2 := 0 To 15
        cBuffer += "þ" + Chr( nInd2 + nInd1 * 16 )
      Next
      RestScreen( nPosY + nInd1 + 1, nPosX + 1, nPosY + nInd1 + 1, nPosX + 16, cBuffer )
    Next
    DispEnd()
    While nKey != K_RETURN .And. nKey != K_ESC
      DispBegin()
      @ nPosY + nY, nPosX + nX Say "û"       Color Give( nX, 1 ) + "/" + Give( nY, 2 )
      @ nPosY + nY, nPosX - 1  Say "Ä" + Chr( 26 ) Color "N/W"
      @ nPosY,      nPosX + nX Say Chr( 25 ) Color "N/W"
      If lColor
        @ nPosY + 17, nPosX Say PadC( Give( nX, 1 ) + "/" + Give( nY, 2 ), 18 ) Color "N/W"
      EndIF
      DispEnd()
      nKey := FastInkey( 0 )
      DispBegin()
      @ nPosY + nY, nPosX + nX Say "þ"  Color Give( nX, 1 ) + "/" + Give( nY, 2 )
      @ nPosY + nY, nPosX - 1  Say "  " Color "N/W"
      @ nPosY,      nPosX + nX Say " "  Color "N/W"
      DispEnd()
      If nKey == K_DOWN
        nY++
      ElseIf nKey == K_UP
        nY--
      ElseIf nKey == K_RIGHT
        nX++
      ElseIf nKey == K_LEFT
        nX--
      EndIf
      nY := Max( 1, Min( nY, 16 ) )
      nX := Max( 1, Min( nX, 16 ) )
    End
    SetCursor( nCursor )
    BoxClose( aBox )
Return( If( nKey == K_ESC, ;
          Nil, ;
          Give( nX, 1 ) + "/" + Give( nY, 2 ) ) )



Static Function Give( nNumber, nMode )
Local aColor := { "N", "B", "G", "BG", "R", "RB", "GR", "W" }
Local cRet
Local nAux
    nAux := nNumber % 8
    nAux := If( nAux == 0, 8, nAux )
    cRet := aColor[ nAux ]
    If nNumber > 8
      cRet += If( nMode == 1, "+", "*" )
    EndIf
Return( cRet )

