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




#include "language.ch"
#include "\libs\clipapi\version.ch"

FAST_VERSION


Function Warning ( cMensaje, lEspera, cColor )
Local cEstado := SaveScreen ( MaxRow(), 0, MaxRow(), MaxCol() )
    cColor := If ( cColor == Nil, "N/W", cColor )
    @ MaxRow(), 0 Say Space ( MaxCol() + 1 ) Color cColor
    @ MaxRow(), 1 Say cMensaje               Color cColor
    lEspera := If ( lEspera == Nil, .T., lEspera )
    If lEspera
      FastInkey( 0 )
      RestScreen ( MaxRow(), 0, MaxRow(), MaxCol(), cEstado )
    EndIf
Return ( Nil )


Function LinAyuda ( aLinea )
Local nInd  := 0
Local nAcum := 0
    @ MaxRow(), 0 Say " " Color "N/W"
    For nInd := 1 To Len ( aLinea )
      If nInd % 2 == 0
        @ MaxRow(), 1 + nAcum Say aLinea [ nInd ] + "  " Color "N/W"
      Else
        @ MaxRow(), 1 + nAcum Say aLinea [ nInd ] + " "  Color "R/W"
      EndIf
      nAcum += Len ( aLinea [ nInd ] ) + 1
    Next
    @ MaxRow(), nAcum Say Space ( MaxCol() + 1 - nAcum ) Color "N/W"
Return ( Nil )


Function Query ( cPregunta, cColor )
Local cEstado  := SaveScreen ( MaxRow(), 0, MaxRow(), MaxCol() )
Local cTecla   := "X"
Local cColores := SetColor ( If ( cColor == Nil, "N/W", cColor ) )
Local nCursor  := SetCursor ( 1 )
Local cCadena  := GiveMsg( MSG_BOX_SN )
    Warning ( cPregunta, .F. )
    Pitido()
    __Keyboard ()
    While ! cTecla $ cCadena
      SetPos ( MaxRow(), 2 + Len ( cPregunta ) )
      @ Row (), Col () Say Space ( 1 )
      SetPos ( MaxRow(), 2 + Len ( cPregunta ) )
      cTecla := Upper ( Chr ( FastInkey( 0 ) ) )
    End
    RestScreen ( MaxRow(), 0, MaxRow(), MaxCol(), cEstado )
    SetColor ( cColores )
    SetCursor ( nCursor )
Return ( cTecla != SubStr( cCadena, 2, 1 ) )


