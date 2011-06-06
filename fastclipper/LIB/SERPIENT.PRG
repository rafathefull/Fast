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


Function Serpent ( cColor, cColorCab, cColorMark )
Local anSerp   := Array( 6, 3 )
Local nDirec   := 1
Local lNueva   := .T.
Local nCursor  := SetCursor( 0 )
Local lParpa   := SetBlink ( .F. )
Local cColores := SetColor( cColor )
Local cPanta   := SaveScreen ( 0, 0, 24, 79 )
Local nOldDir
Local nInY
Local nIncx
Local cCar
Local nTecla
Local nMarky
Local nMarkx
Local nConta
Local nTicks
Local aAyuda
    While( lNueva )
      DispBox ( 1, 0, 24, 79, Space ( 9 ) )
      nTicks  := 500
      nInY    := -1
      nIncx   := 0
      cCar    := "Û"
      nDirec  := 1
      nConta  := 0
      anSerp  := { { 15, 39, cCar }, { 16, 39, cCar }, { 17, 39, cCar }, ;
                   { 18, 39, cCar }, { 19, 39, cCar }, { 20, 39, cCar } }
      aAyuda := GiveMsg( MSG_SERP_AYUDA )
      aAyuda[ 4 ] := Str( nConta, 4 )
      LinAyuda( aAyuda )
      uMarcas ( @nMarky, @nMarkx, anSerp, cColorMark )
      While .T.
        If ! lMuestra( @anSerp, @nInY, @nIncx, cCar, nDirec, @nMarky, @nMarkx, ;
                       @nConta, cColor, cColorCab, cColorMark )
          If ! BoxQuery ( GiveMsg( MSG_GAME_FINAL ) )
            lNueva := .F.
          EndIf
          Exit
        EndIf
        nOldDir := nDirec
        If nRandom( 10 ) == 5
          nTicks := if ( nTicks > 1, --nTicks, nTicks )
        EndIf
        nTecla := InKey ()
        oneMoment( Max ( nTicks, 5 ) )
        If nTecla == Asc( "p" ) .or. nTecla == Asc( "P" )
          BoxWarning( GiveMsg( MSG_GAME_PAUSA ) )
        ElseIf nTecla == K_UP    .And. nDirec % 2 == 0
          nDirec := 1
          If anSerp [ 1, 3 ] == "Ü"
            nInY  := 0
            nIncx  := If ( nOldDir == 2, 1, -1 )
          Else
            nInY := -1
            nIncx := 0
          EndIf  
          cCar := "Û"
        ElseIf nTecla == K_RIGHT .And. nDirec % 2 == 1
          nDirec := 2
          cCar := If ( nOldDir == 1, "Ü", "ß" )
        ElseIf nTecla == K_DOWN  .And. nDirec % 2 == 0
          nDirec := 3
          If anSerp [ 1, 3 ] == "Ü"
            nInY := 1
            nIncx := 0
          Else
            nInY := 0             
            nIncx  := If ( nOldDir == 2, 1, -1 )
          EndIf  
          cCar := "Û"
        ElseIf nTecla == K_LEFT  .And. nDirec % 2 == 1
          nDirec := 4
          cCar := If ( nOldDir == 1, "Ü", "ß" )
        EndIf
      End
    End
    RestScreen( 0, 0, 24, 79, cPanta )
    SetCursor ( nCursor )
    SetColor ( cColores )
    SetBlink ( lParpa )
Return( Nil )


Static Function lMuestra ( anSerp, nInY, nIncx, cCar, nDirec, nMarky, nMarkx, nConta, ;
                    cColor, cColorCab, cColorMark, aQuery )
Local nInd
Local lRetorno := .T.
Local aUltimo  := {}   
Local nLen
Local aAyuda
    aUltimo := aClone( anSerp [ Len( anSerp ) ] )
    Message( anSerp [ Len( anSerp ), 1 ], anSerp [ Len( anSerp ), 2 ], " " )
    nLen := Len( anSerp )
    For nInd := nLen To 2 Step -1
      aCopy( anSerp [ nInd - 1 ], anSerp [ nInd ] )
    Next
    anSerp [ 1, 1 ] += nInY
    anSerp [ 1, 2 ] += nIncx
    anSerp [ 1, 3 ] := cCar
    If anSerp [ 1, 1 ] > 23 .or. anSerp [ 1, 1 ] < 1 .or. ;
       anSerp [ 1, 2 ] > 79 .or. anSerp [ 1, 2 ] < 0 .or. ;
       lMiraCabeza ( anSerp, cColorCab )
      lRetorno := .F.
    Else
      DispBegin()
      DevPos ( anSerp [ 1, 1 ], anSerp [ 1, 2 ] )
      DevOut ( anSerp [ 1, 3 ], cColor )
      DispEnd()
      If anSerp [ 1, 1 ] == nMarky .And. anSerp [ 1, 2 ] == nMarkx
        nConta ++
        speakgame( 2000 )
        aAyuda := GiveMsg( MSG_SERP_AYUDA )
        aAyuda[ 4 ] := Str( nConta, 4 )
        LinAyuda( aAyuda )
        aAdd( anSerp, aUltimo )
        uMarcas ( @ nMarky, @ nMarkx, anSerp, cColorMark )
      EndIf
      nIncx := nInY := 0
      If nDirec == 1
        nInY := -1
      Elseif nDirec == 2
        nIncx := 1
      Elseif nDirec == 3
        nInY := 1
      Else
        nIncx := -1
      EndIf
    EndIf
Return ( lRetorno )


Static Function uMarcas ( nMarky, nMarkx, anSerp, cColorMark )
Local lMientras := .F.
    While ! lMientras
      lMientras := .T.
      nMarky    := nRandom ( 21 ) + 1
      nMarkx    := nRandom ( 77 ) + 1
      aEval ( anSerp, { | aX | If ( aX [ 1 ] == nMarky .And. aX [ 2 ] == nMarkx, ;
                                    lMientras := .F., ) } )
    End
    @ nMarky, nMarkx SAY "þ" COLOR cColorMark
Return ( Nil )


Static Function lMiraCabeza ( anSerp, cColorCab )
Local lRetorno := .F.
Local nY
Local nX
LOCAL nInd
LOCAL nLen
    nY := anSerp [ 1, 1 ]
    nX := anSerp [ 1, 2 ]
    nLen := LEN( anSerp )
    FOR nInd := 2 TO nLen
      IF anSerp[ nInd, 1 ] == nY .AND. anSerp[ nInd, 2 ] == nX
        lRetorno := .T.
        EXIT
      ENDIF
    NEXT
    IF lRetorno
      DevPos ( nY, nX )
      DevOut ( "Û", cColorCab )
    ENDIF
Return ( lRetorno )



