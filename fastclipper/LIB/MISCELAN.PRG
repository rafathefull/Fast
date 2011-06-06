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
#include "language.ch"
#include "\libs\clipapi\version.ch"

FAST_VERSION


static _fastlWrite


Function FastMemo( nY1, nX1, nY2, nX2, cMemo, cTitulo, cColBro, lSombra, lWrite )
Local nY      := Row()
Local nX      := Col()
Local cPanta  := SaveScreen( nY1, nX1, nY2 + 1, nX2 + 2 )
Local cColor  := SetColor( cColBro )
Local nCursor := SetCursor( 1 )
    _fastlWrite := lWrite
    Window( nY1, nX1, nY2, nX2, cTitulo, "ÚÄ¿³ÙÄÀ³ ", If( lSombra == Nil, .T., lSombra ) )
    cMemo := MemoEdit( cMemo, nY1 + 1, nX1 + 2, nY2 - 1, nX2 - 2, If( lWrite == Nil, .T., lWrite ), "FastMemoUDF" )
    SetColor( cColor )
    SetCursor( nCursor )
    RestScreen( nY1, nX1, nY2 + 1, nX2 + 2, cPanta )
    SetPos( nY, nX )
Return ( cMemo )


Function FastMemoUDF( nMode, nLin, nCol )
Local nKey  := LastKey()
Local nRet  := 0
    If nKey == K_ESC
      If _fastlWrite .AND. ! BoxQuery( GiveMsg( MSG_MEMO_CANCEL ) )
        nRet := 32
      EndIf
    ElseIf nKey == K_F10
      If ! _fastlWrite
        nRet := K_ESC
      ElseIf BoxQuery( GiveMsg( MSG_MEMO_SAVE ) )
        nRet := K_CTRL_W
      EndIf
    EndIf
Return( nRet )

