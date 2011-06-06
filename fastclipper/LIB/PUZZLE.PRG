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
#include "fast.ch"
#include "\libs\clipapi\version.ch"

FAST_VERSION


FUNCTION Puzzle( nY, nX, cColor )
LOCAL aArray   := Array( 16 )
LOCAL nInic    := nRandom( 14 ) + 1
LOCAL nInd     := 0
LOCAL nVacio   := 0
LOCAL nKey     := 0
LOCAL lFin     := .F.
LOCAL nCursor  := SetCursor( 0 )

    DEFAULT nY     = 5
    DEFAULT nX     = 27
    DEFAULT cColor = "B"

    FOR nInd := 1 TO 16
      aArray[ nInd ] := nInic
      IF nInic == 0
        nVacio := nInd
      ENDIF
      nInic --
      nInic := IIF( nInic == -1, 15, nInic )
    NEXT
    BoxOpen( nY, nX, nY + 11, nX + 23, cColor )
    ReDrawPuzzle( nY, nX, aArray, cColor )
    WHILE ! lFin
      nKey := FastInkey( 0 )
      IF nKey == K_UP
        nVacio   := InterPuzzle( nY, nX, nVacio, nVacio + 4, aArray, cColor )
      ELSEIF nKey == K_DOWN
        nVacio   := InterPuzzle( nY, nX, nVacio, nVacio - 4, aArray, cColor )
      ELSEIF nKey == K_LEFT
        nVacio   := InterPuzzle( nY, nX, nVacio, nVacio + 1, aArray, cColor )
      ELSEIF nKey == K_RIGHT
        nVacio   := InterPuzzle( nY, nX, nVacio, nVacio - 1, aArray, cColor )
      ELSEIF nKey == K_ESC
        lFin := .T.
      ENDIF
      IF PuzzleCheck( aArray )
        lFin := .T.
      ENDIF
    END
    SetCursor( nCursor )
RETURN( LastKey() != K_ESC )


STATIC FUNCTION ReDrawPuzzle( nY, nX, aArray, cColor )
LOCAL nInd
    DispBegin()
    FOR nInd := 0 TO 15
      PuzzleBox( nY, nX, nInd, aArray, cColor )
    NEXT
    DispEnd()
RETURN( NIL )


STATIC FUNCTION InterPuzzle( nY, nX, nVacio, nNuevo, aArray, cColor )
LOCAL nInter
    IF ( nNuevo > 16 .OR. nNuevo < 1 ) .OR. ;
       ( Abs( nVacio - nNuevo ) == 1 .AND. PuzzleLin( nVacio, nNuevo ) )
      SpeakGame( 1000 )
    ELSE
      nInter := aArray[ nVacio ]
      aArray[ nVacio ] := aArray[ nNuevo ]
      aArray[ nNuevo ] := nInter
      PuzzleBox( nY, nX, nVacio - 1, aArray, cColor )
      PuzzleBox( nY, nX, nNuevo - 1, aArray, cColor )
      nVacio := nNuevo
    ENDIF
RETURN( nVacio )


STATIC FUNCTION PuzzleLin( nVacio, nNuevo )
RETURN( Int( ( nVacio - 1 ) / 4 ) != Int( ( nNuevo - 1 ) / 4 ) )


STATIC FUNCTION PuzzleBox( nY, nX, nPos, aArray, cColor )
LOCAL nCursor := SetCursor( 0 )
    DispBegin()
    IF aArray[ nPos + 1 ] != 0
      BoxOpen( nY + Int( ( nPos / 4 ) ) * 3,     nX + Int( ( nPos % 4 ) ) * 6, ;
               nY + Int( ( nPos / 4 ) ) * 3 + 2, nX + Int( ( nPos % 4 ) ) * 6 + 5, cColor )
      @ nY + Int( ( nPos / 4 ) ) * 3 + 1, nX + Int( ( nPos % 4 ) ) * 6 + 2 SAY Str( aArray[ nPos + 1 ], 2 ) COLOR "W+/" + cColor
    ELSE
      DispBox( nY + Int( ( nPos / 4 ) ) * 3,     nX + Int( ( nPos % 4 ) ) * 6, ;
               nY + Int( ( nPos / 4 ) ) * 3 + 2, nX + Int( ( nPos % 4 ) ) * 6 + 5, Space( 9 ), "W/" + cColor )
    ENDIF
    SetCursor( nCursor )
    DispEnd()
RETURN( NIL )


STATIC FUNCTION PuzzleCheck( aArray )
LOCAL nInd
LOCAL lRet := .T.
    FOR nInd := 1 TO 15
      lRet := If( aArray[ nInd ] != nInd, .F., lRet )
    NEXT
RETURN( lRet )
