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


Function GetPass ( nLin, nCol, cMens, nLong )
Local cRet    := ""
Local nTecla  := 0
Local nTotal  := nCol + Len ( cMens ) + 1
Local nColGet := nTotal
    @ nLin, nCol Say cMens + Space ( 1 + nLong )
    While ( .T. )
      nTecla := FastInkey( 0 )
      If nTecla == K_ESC .Or. nTecla == K_RETURN
        Exit
      ElseIf nTecla == K_BS
        If nColGet > nTotal
          cRet := SubStr ( cRet, 1, Len ( cRet ) - 1 )
          nColGet--
          @ nLin, nColGet Say " "
        Else
          Pitido()
        EndIf
      ElseIf nTecla > 32 .And. nTecla <= 255
        If nColGet < nTotal + nLong
          cRet += Chr ( nTecla )
          @ nLin, nColGet Say "þ"
          nColGet++
        Else
          Pitido()
        EndIf
      EndIf
    End
    @ nLin, nCol Say cMens + Space ( 1 + nLong )
Return ( If ( nTecla == K_ESC, "", AllTrim ( cRet ) ) )

