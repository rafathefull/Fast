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


Function BoxMessage ( cMensaje, nY, nX, cColor )
Local nPos    := MaxCol() / 2
Local nX1     := If ( nX != Nil, nX, nPos - 2 - Len ( cMensaje ) / 2 )
Local nX2     := If ( nX != Nil, nX + Len( cMensaje ) + 3, nPos + 3 + Len ( cMensaje ) / 2 )
Local aBoton
    nY      := If ( nY     == Nil,   7, nY )
    cColor  := If ( cColor == Nil, "B", cColor )
    aBoton  := BoxOpen( nY, nX1, nY + 2, nX2, cColor, .1 )
    Message( nY + 1, nX1 + 1, PadC ( cMensaje, nX2 - nX1 - 1 ), "W+/" + cColor )
Return ( aBoton )


Function BoxWarning( xMensaje, nRow )
Local cOther  := GiveMsg( MSG_BOX_TECLA )
Local nC      := SetCursor ( 0 )
Local nX1
Local nX2
Local aBoton
Local nInd    := 0
Local nLong   := 0
Local nPos    := MaxCol() / 2
    nRow := If( nRow == Nil, 7, nRow )
    If ValType( xMensaje ) == "C"
      nX1     := nPos - 2 - Max ( Len ( xMensaje ), Len ( cOther ) ) / 2
      nX2     := nPos + 3 + Max ( Len ( xMensaje ), Len ( cOther ) ) / 2
      aBoton  := BoxOpen( nRow, nX1, nRow + 4, nX2, "B", .2 )
      Message( nRow + 1, nX1 + 1, PadC ( xMensaje, nX2 - nX1 - 1 ), "W+/B" )
      Message( nRow + 3, nX1 + 1, PadC ( cOther,   nX2 - nX1 - 1 ), "W+/B" )
    Else
      aEval( xMensaje, { |x| nLong := Max( Len( x ), nLong ) } )
      nX1     := nPos - 2 - nLong / 2
      nX2     := nPos + 3 + nLong / 2
      aBoton  := BoxOpen( nRow, nX1, nRow + Len( xMensaje ) + 1, nX2, "B", .2 )
      For nInd := 1 To Len( xMensaje )
        Message( nRow + nInd, nX1 + 1, PadC ( xMensaje[ nInd ], nX2 - nX1 - 1 ), "W+/B" )
      Next
    EndIf
    Pitido ()
    FastInkey( 0 )
    BoxPush( aBoton )
    BoxClose( aBoton )
    SetCursor( nC )
Return( Nil )


Function BoxQuery( cMensaje, nRow )
Local cPregunta := "X"
Local nCursor   := SetCursor ( 1 )
Local nPos      := MaxCol() / 2
Local nX1       := nPos - 2 - Len ( cMensaje ) / 2
Local nX2       := nPos + 3 + Len ( cMensaje ) / 2
Local nX        := Col()
Local nY        := Row()
Local aB
Local cCadena   := GiveMsg( MSG_BOX_SN )
    nRow := If( nRow == Nil, 9, nRow )
    aB   := BoxOpen( nRow, nX1 - 1, nRow + 2, nX2 + 1, "R", .2 )
    Message( nRow + 1, nX1, PadC ( cMensaje, nX2 - nX1 - 1 ), "W+/R" )
    Pitido()
    While ! cPregunta $ cCadena
      SetPos ( nRow + 1, nX2 - 2 )
      cPregunta := Upper ( Chr ( FastInkey( 0 ) ) )
    End
    BoxPush ( aB )
    BoxClose ( aB )
    SetCursor ( nCursor )
    SetPos ( nY, nX )
Return ( cPregunta != SubStr( cCadena, 2, 1 ) )

