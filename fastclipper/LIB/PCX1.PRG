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




#include "fast.ch"
#include "\libs\clipapi\version.ch"

FAST_VERSION


Function PCXShow( cFile, lPaleta, nInicX, nInicY )
Local cBuf
Local nHandle := fopen ( cFile, 64 )
Local nTot
Local nPos    := 0
Local nLong   := 0
Local lRet    := .F.
Local cHeader
Local nX1
Local nX2
Local cPaleta
Local nAux
LOCAL lMode   := .T.

    DEFAULT lPaleta = .T.
    DEFAULT nInicX  = 0
    DEFAULT nInicY  = 0

    if nHandle != -1
      cHeader := Space ( 128 )
      fread ( nHandle, @cHeader, 128 )
      If SubStr ( cHeader, 1, 1 ) == Chr ( 10 )
        nX1     := Bin2w ( SubStr ( cHeader, 5, 2 ) )
        nX2     := Bin2w ( SubStr ( cHeader, 9, 2 ) )
        cPaleta := SubStr ( cHeader, 17, 48 )
        nTot    := fseek ( nHandle, 0, 2 ) - 128
        fseek ( nHandle, 128, 0 )
        nAux :=  ( nX2 - nX1 + 1 ) / 8 + If ( ( nX2 - nX1 + 1 ) % 8 > 0, 1, 0 )
        WHILE nPos < nTot
          cBuf := Space ( 16384 )
          nPos += ( nLong := fread ( nHandle, @cBuf, Len ( cBuf ) ) )
          If nPos > nTot
            nLong -= ( nPos - nTot )
          EndIf
          DecoEGAVGA( nLong, cBuf, nInicX / 8, nInicY * 80, nAux, lMode )
          lMode := .F.
        END
        HidePlane()
        If lPaleta
          SetPalette( _PcxVga( cPaleta ) )
        EndIf
        lRet := .T.
      EndIf
      fClose ( nHandle )
    EndIf
Return ( lRet )



