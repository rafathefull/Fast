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


Function fSearch( cFile, cBusca )
Local cBuf
Local nHandle := fopen ( cFile, 64 )
Local nTot    := 0
Local nPos    := 0
Local nBusca  := 0
Local nLong   := 0
Local aRet    := {}
Local nConta  := 0
    if nHandle != -1
      If cBusca != Nil
        nTot := fseek ( nHandle, 0, 2 )
        fseek ( nHandle, 0, 0 )
        While nPos < nTot .And. fError () == 0
          cBuf   := Space ( 32000 )
          nConta := nPos
          nPos   += ( nLong := fread ( nHandle, @cBuf, Len ( cBuf ) ) )
          If nPos > nTot
            nLong -= ( nPos - nTot )
          EndIf
          While ( nBusca := At ( Upper ( cBusca ), Upper ( cBuf ) ) ) != 0
            cBuf   := SubStr ( cBuf, nBusca + Len ( cBusca ) )
            nConta += nBusca
            nConta --
            aAdd ( aRet, nConta )
            nConta += Len ( cBusca )
          End
        End
      EndIf
      fClose ( nHandle )
    EndIf
Return ( aRet )

