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



FUNCTION PCXShow256( cFile, lPaleta, lEnciende, nInicX, nInicY )
RETURN Show256( cFile, lPaleta, lEnciende, nInicX, nInicY, 320, 200, .F. )



FUNCTION PCXShowVESA( cFile, lPaleta, lEnciende, nInicX, nInicY )
LOCAL lRet   := .F.
LOCAL nX
LOCAL nY
LOCAL aX     := { 640, 640, 800, 1024 }
LOCAL aY     := { 400, 480, 600,  768 }
LOCAL aModes := { 256, 257, 259,  261 }
LOCAL nMode  := VESAMode()
LOCAL nInd   := aScan( aModes, nMode )
    IF nInd > 0
      nX   := aX[ nInd ]
      nY   := aY[ nInd ]
      lRet := Show256( cFile, lPaleta, lEnciende, nInicX, nInicY, nX, nY, .T. )
    ENDIF
RETURN lRet



STATIC FUNCTION Show256 ( cFile, lPaleta, lEnciende, nInicX, nInicY, ;
                          nMaxX, nMaxY, lVESA )
LOCAL cBuf
LOCAL cPaleta := SPACE( 768 )
LOCAL nHandle := fOpen( cFile, 64 )
LOCAL nTot
LOCAL nPos    := 0
LOCAL nLong   := 0
LOCAL lRet    := .F.
LOCAL cHeader
LOCAL nBPP
LOCAL nSize
LOCAL nX1
LOCAL nX2
LOCAL lMode   := .T.

    DEFAULT lPaleta   = .T.
    DEFAULT lEnciende = .F.
    DEFAULT nInicX    = 0
    DEFAULT nInicY    = 0

    IF nHandle != -1
      cHeader := SPACE ( 128 )
      fRead ( nHandle, @ cHeader, 128 )
      If SubStr ( cHeader, 1, 1 ) == CHR ( 10 )
        nBPP := Asc   ( SubStr ( cHeader, 4, 1 ) )
        nX1  := Bin2w ( SubStr ( cHeader, 5, 2 ) )
        nX2  := Bin2w ( SubStr ( cHeader, 9, 2 ) )
        nSize := nX2 - nX1 + 1
        IF nBPP == 8 .AND. IsVGA ()
          nTot := fSeek ( nHandle, -768, 2 ) - 128
          fread( nHandle, @cPaleta, 768 )
          fseek( nHandle, 128, 0 )
          IF lPaleta
            IF lEnciende
              SetPalette( Replicate( CHR( 0 ), 768 ) )
            ELSE
              SetPalette( _PcxVga( cPaleta ) )
            ENDIF
          ENDIF
          cBuf := SPACE ( 16384 )
          WHILE nPos < nTot
            nPos += ( nLong := fRead ( nHandle, @cBuf, Len ( cBuf ) ) )
            IF nPos > nTot
              nLong -= ( nPos - nTot )
            ENDIF
            Deco256( nLong, cBuf, nInicX, nInicY, nSize, nMaxX, nMaxY, lMode, lVESA )
            lMode := .F.
          END
          IF lPaleta .AND. lEnciende
            Upgrade( _PcxVga( cPaleta ) )
          ENDIF
          lRet := .T.
        ENDIF
      ENDIF
      fClose ( nHandle )
    ENDIF

RETURN ( lRet )

