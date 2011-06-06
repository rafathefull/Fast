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


Function Stars ()
Local cPan    := SaveScreen ( 0, 0, MaxRow(), MaxCol() )
Local nInd
Local aPunto  := { "ú", "ù", "" }
Local cColor  := SetColor ( "W/N" )
Local nCursor := SetCursor (0)
Local nStars  := 50
Local nX      := MaxCol()
Local nY      := MaxRow()
Local aPos    := Array ( nStars )
Local nAux
Local nAcumX
Local nAcumY
Local nRelX
Local nRelY
    Cls
    For nInd := 1 To nStars
      NoZero( @nAcumY, @nAcumX, @nRelY, @nRelX, { 6, 3 }, { 10, 5 } )
      aPos [ nInd ] := { nY / 2 + nRelY, ;
                         nX / 2 + nRelX, ;
                         nAcumY, ;
                         nAcumX, ;
                         0 }
      DevPos( aPos [ nInd, 1 ], aPos [ nInd, 2 ] )
      DevOut( "ú", "W/N" )
    Next
    While Inkey ( .01 ) == 0
      For nInd := 1 To nStars
        Message( aPos [ nInd, 1 ], aPos [ nInd, 2 ], " " )
        aPos[ nInd, 1 ] += aPos[ nInd, 3 ]
        aPos[ nInd, 2 ] += aPos[ nInd, 4 ]
        aPos[ nInd, 5 ] ++
        If aPos[ nInd, 1 ] < 0 .Or. aPos[ nInd, 1 ] > nY .Or. ;
           aPos[ nInd, 2 ] < 0 .Or. aPos[ nInd, 2 ] > nX
          NoZero( @nAcumY, @nAcumX, @nRelY, @nRelX, { 6, 3 }, { 10, 5 } )
          aPos [ nInd ] := { nY / 2 + nRelY, ;
                             nX / 2 + nRelX, ;
                             nAcumY, ;
                             nAcumX, ;
                             0 }
        EndIf
        DevPos( aPos [ nInd, 1 ], aPos [ nInd, 2 ] )
        nAux := Max( Min( aPos[ nInd, 5 ] / 8, 3 ), 1 )
        DevOut( aPunto[ nAux ], "W/N" )
      Next
    End
    SetColor ( cColor )
    SetCursor ( nCursor )
    RestScreen ( 0, 0, MaxRow(), MaxCol(), cPan )
Return ( Nil )


Function ScreenSave ( cColorIni, cMens )
Local nCursor := SetCursor( 0 )
Local cColor  := SetColor ( If( cColorIni == Nil, "BG/N", cColorIni ) )
Local cPanta  := SaveScreen ( 0, 0, MaxRow(), MaxCol() )
Local nX      := Col ()
Local nY      := Row ()
    cMens := If( cMens == Nil, FastRight() + " " + FastVersion(), cMens )
    Cls
    While ( ! MsgScroll( nRandom( MaxRow() ), 0, 80, cMens, SetColor(), 1 ) )
    End
    SetCursor ( nCursor )
    SetColor ( cColor )
    RestScreen ( 0, 0, MaxRow(), MaxCol(), cPanta )
    SetPos ( nY, nX )
Return ( Nil )


Static Function NoZero( nY, nX, nRelY, nRelX, aY, aX )
Local lRet := .T.
    nY := 0
    nX := 0
    While lRet
      nY := nRandom( aY[ 1 ] ) - aY[ 2 ]
      nX := nRandom( aX[ 1 ] ) - aX[ 2 ]
      If nY != 0 .Or. nX != 0
        lRet := .F.
      EndIf
    End
    nRelY := nRandom( 4 ) * if( nY < 0, -1, 1 )
    nRelX := nRandom( 8 ) * if( nX < 0, -1, 1 )
Return( Nil )

