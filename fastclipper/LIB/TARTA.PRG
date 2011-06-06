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


Function GraphTart ( nX, nY, nRadio, aVals )
Local nTot  := 0
Local nInd
Local nAux  := 0
Local aOtro := Array ( Len ( aVals ) )
Local nAng
Local nSen
Local nCos
Local nColor
LOCAL nLen
    aEval ( aVals, { | x | nTot += x } )
    For nInd := 1 To Len ( aVals )
      nAux += 6.283184 * ( aVals[nInd] / nTot )
      aOtro [ nInd ] := nAux
    Next
    nAux := 0
    nLen := LEN( aOtro )
    FOR nInd := 1 TO nLen
      nColor := nInd % 16
      FOR nAng := nAux TO aOtro [ nInd ] STEP 0.01
        nSen := nX + nRadio * Sin( nAng )
        nCos := nY + nRadio * Cos( nAng )
        fgLine ( nX, nY, nSen, nCos,     nColor )
        fgLine ( nX, nY, nSen, nCos + 1, nColor )
      NEXT
      nAux := aOtro [ nInd ]
    NEXT
RETURN NIL


Function GraphEllipse ( nX, nY, nRadio, aVals )
Local nTot  := 0
Local nInd
Local nAux  := 0
Local aOtro := Array ( Len ( aVals ) )
Local nAng
Local nSen
Local nCos
Local nColor
LOCAL nLen
    aEval ( aVals, { |x| nTot += x } )
    FOR nInd := 1 TO Len ( aVals )
      nAux += ( 2 * NumPi() ) * ( aVals[nInd] / nTot )
      aOtro [ nInd ] := nAux
    NEXT
    nAux := 0
    nLen := LEN( aOtro )
    FOR nInd := 1 TO nLen
      nColor := nInd % 16
      FOR nAng := nAux TO aOtro [ nInd ] STEP 0.01
        nSen := nX + nRadio * Sin( nAng )
        nCos := nY + nRadio * Cos( nAng ) * 0.3
        fgLine ( nX, nY, nSen, nCos,     nColor )
        fgLine ( nX, nY, nSen, nCos + 1, nColor )
        IF nAng < 1.57 .OR. nAng > 4.7123880
          fgLine ( nSen, nCos, nSen, nCos + nRadio / 5, nColor )
        ENDIF
      NEXT
      nAux := aOtro [ nInd ]
    NEXT
    fgEllipse( nX, nY, nRadio + 1, nRadio * 0.3 + 1, 0 )
RETURN NIL



