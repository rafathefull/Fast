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



Function Tetris()
Local nX        := Col ()
Local nY        := Row ()
Local cPantalla := SaveScreen ( 0, 0, 24, 79 )
Local cColor    := SetColor ( "N/W" )
    Fascinate ( "BG", "G" )
    TetPartida ()
    SetPos ( nY, nX )
    SetColor ( cColor )
    RestScreen( 0, 0, 24, 79, cPantalla )
Return ( Nil )


Static Function TetPartida ()
Local nRelx       := 26
Local nRely       := 3
Local anTablero   := Array ( 20, 13 )
Local anPosic     := {}
Local nCursor     := SetCursor ( 0 )
Local nDecimales  := Set ( _SET_DECIMALS, 2 )
Local lNueva      := .T.
Local nLineas     := 0
Local nTipoFigura
Local nTipoAux
Local nSubeVeloc  := 0
Local aBoton1     := BoxOpen( nRely - 2, nRelx,      nRely + 19, nRelx + 27, "B", .3 )
Local aBoton2     := BoxOpen( nRely - 1, nRelx + 30, nRely + 16, nRelx + 52, "W", .3 )
Local nVeloc      := 0
Local lSonido     := IsSound()
Local cQuery
    SetBlink ( .F. )
    @ nRely +  1, nRelx + 32 Say "Difficulty :" + Str ( 0, 7 )                     Color "B/W"
    @ nRely +  2, nRelx + 32 Say "Num. Lines :" + Str ( 0, 7 )                     Color "B/W"
    @ nRely +  4, nRelx + 32 Say Chr ( 27 ) + Chr ( 26 ) + "        Move"          Color "R/W"
    @ nRely +  5, nRelx + 32 Say Chr ( 25 ) +             "         Down"          Color "R/W"
    @ nRely +  6, nRelx + 32 Say "Space     Rotate"                                Color "R/W"
    @ nRely +  7, nRelx + 32 Say "Alt-P     Pause"                                 Color "R/W"
    @ nRely +  8, nRelx + 32 Say "Alt-S     Sound " + If( IsSound(), "On", "Off" ) Color "R/W"
    @ nRely + 10, nRelx + 32 Say "Next Figure"                                     Color "B/W"
    While ( lNueva )
      aEval ( anTablero, { | aEle | aEle := Afill ( aEle, 0 ) } )
      nLineas := 0
      Siguiente ( nRelx, nRely, nTipoFigura := nRandom ( 6 ) + 1 )
      If ( nVeloc := Velocidad ( nRelx, nRely ) ) == 0
        Exit
      EndIf
      While .T.
        @ nRely + 1, nRelx + 44 Say Str ( nVeloc,  7 ) Color "B/W"
        @ nRely + 2, nRelx + 44 Say Str ( nLineas, 7 ) Color "B/W"
        TetPantalla ( nRelx, nRely, 1 )
        If nSubeVeloc++ > 75
          speakgame( 4000 )
          nVeloc := Min ( 9, ++nVeloc )
          nSubeVeloc := 0
          @ nRely + 1, nRelx + 44 Say Str ( nVeloc, 7 ) Color "B/W"
        EndIf
        If ! NuevaFigura ( nRelx, nRely, @anPosic, @anTablero, nTipoFigura )
          If ! BoxQuery ( GiveMsg( MSG_GAME_FINAL ) )
            lNueva := .F.
          EndIf
          Exit
        EndIf
        Siguiente ( nRelx, nRely, nTipoAux := nRandom ( 6 ) + 1 )
        If ! DibujaFigura ( nRelx, nRely, @anPosic, @anTablero, nTipoFigura, @nVeloc, @nLineas )
          If ! BoxQuery( GiveMsg( MSG_GAME_FINAL ) )
            lNueva := .F.
          EndIf
          Exit
        EndIf
        nTipoFigura := nTipoAux
      End
      BoxDelete( aBoton1 )
    End
    BoxClose( aBoton1 )
    BoxClose( aBoton2 )
    Set ( _SET_DECIMALS, nDecimales )
    SetCursor ( nCursor )
    SetCursor ( nCursor )
    IsSound( lSonido )
Return ( Nil )


Static Function NuevaFigura ( nRelx, nRely, anPosic, anTablero, nFigura )
Local lRetorno := .T.
    Do Case
      Case nFigura == 1
        anPosic := { { 7, 1 }, { 7, 2 }, { 7, 3 }, { 7, 4 } }
      Case nFigura == 2
        anPosic := { { 6, 1 }, { 7, 1 }, { 7, 2 }, { 7, 3 } }
      Case nFigura == 3
        anPosic := { { 8, 1 }, { 7, 1 }, { 7, 2 }, { 7, 3 } }
      Case nFigura == 4
        anPosic := { { 6, 1 }, { 7, 1 }, { 7, 2 }, { 8, 2 } }
      Case nFigura == 5
        anPosic := { { 8, 1 }, { 7, 1 }, { 7, 2 }, { 6, 2 } }
      Case nFigura == 6
        anPosic := { { 6, 1 }, { 7, 1 }, { 8, 1 }, { 7, 2 } }
      Case nFigura == 7
        anPosic := { { 6, 1 }, { 7, 1 }, { 6, 2 }, { 7, 2 } }
    EndCase
    aEval ( anPosic, ;
            { | aEle | If ( anTablero [ aEle [ 2 ], aEle [ 1 ] ] == 1, ;
                         lRetorno := .F., ;
                         anTablero [ aEle [ 2 ], aEle [ 1 ] ] := 1 ) } )
    Pinta ( nRelx, nRely, anPosic, nFigura )
Return ( lRetorno )


Static Function DibujaFigura ( nRelx, nRely, anPosic, anTablero, nTipoFigura, nVeloc, nLineas )
Local nModoFig  := 1
Local nMovs     := 0
Local lRetorno  := .F.
Local lPuedoMov := .T.
Local nTecla    := 0
Local cColor
Local nInd
Local nInx      := 0
Local nInY      := 0
Local nEspera   := ( 10 - nVeloc ) / 30
    While ! lRetorno
      nInx := nInY := 0
      If nMovs == 4
        nMovs  := 0
      Else
        nTecla := InKey ( nEspera )
      EndIf
      If nTecla == K_ESC .And. BoxQuery( GiveMsg( MSG_TETR_CANCELAR ) )
        Return ( .F. )
      ElseIf nTecla == K_ALT_P
        BoxWarning ( GiveMsg( MSG_GAME_PAUSA ) )
      ElseIf nTecla == K_ALT_S
        IsSound( ! IsSound() )
        @ nRely + 8, nRelx + 48 Say If( IsSound(), "On ", "Off" ) Color "R/W"
        Loop
      ElseIf nTecla == 32
        lPuedoMov := Giro ( anPosic, anTablero, nTipoFigura, @nModoFig, nRelx, nRely )
        nMovs ++
      ElseIf nTecla == K_RIGHT
        lPuedoMov := Puedo ( anPosic, anTablero, 1, 0 )
        nInx := 1
        nMovs ++
      ElseIf nTecla == K_LEFT
        lPuedoMov := Puedo ( anPosic, anTablero, -1, 0 )
        nInx := -1
        nMovs ++
      ElseIf nTecla == K_DOWN
        nInY := 0
        While Puedo ( anPosic, anTablero, 0, nInY )
          nInY ++
        End
        nInY --
        If nInY == 0
          lRetorno  := .T.
        Else
          lPuedoMov := .T.
        EndIf
      Else
        lPuedoMov := Puedo ( anPosic, anTablero, 0, 1 )
        lRetorno  := ! lPuedoMov
        nInY     := 1
      EndIf
      nTecla := 0
      If lPuedoMov
        aEval ( anPosic, { | aEle | anTablero [ aEle [ 2 ], aEle [ 1 ] ] := 0, ; 
                                    aEle [ 1 ] += nInx, aEle [ 2 ] += nInY } )
        Pinta ( nRelx, nRely, anPosic, nTipoFigura )
        aEval ( anPosic, { | aEle | anTablero [ aEle [ 2 ], aEle [ 1 ] ] := 1 } )
      EndIf
    End
    CompruebaLin ( nRelx, nRely, @anTablero, @nLineas )
Return ( .T. )


Static Function Puedo ( anPosic, anTablero, nInx, nInY )
Local lRetorno := .T.
    aEval ( anPosic, { | aEle | If ( aEle [ 2 ] + nInY > 20 .or. ;
                                  aEle [ 1 ] + nInx < 1  .or. ;
                                  aEle [ 1 ] + nInx > 13, lRetorno := .F., ) } )
    If lRetorno
      aEval ( anPosic, { | aEle | anTablero [ aEle [ 2 ], aEle [ 1 ] ] := 0 } )
      aEval ( anPosic, ;
              { | aEle | If ( anTablero [ aEle [ 2 ] + nInY, aEle [ 1 ] + nInx ] == 1, lRetorno := .F., ) } )
      aEval ( anPosic, { | aEle | anTablero [ aEle [ 2 ], aEle [ 1 ] ] := 1 } )
    EndIf
Return ( lRetorno )


Static Function Giro ( anPosic, anTablero, nTipoFigura, nModoFig, nRelx, nRely )
Local lRetorno := .F.
Local nAuxX    := anPosic [ 2, 1 ]
Local nAuxY    := anPosic [ 2, 2 ]
    aEval ( anPosic, { | aEle | anTablero [ aEle [ 2 ], aEle [ 1 ] ] := 0 } )
    Do Case
      Case nTipoFigura == 1
        If nModoFig == 1 .or. nModoFig == 3
          If nAuxX - 1 > 0 .And. nAuxX + 2 < 14 .And. ;
             anTablero [ nAuxY, nAuxX - 1 ] == 0 .And. ;
             anTablero [ nAuxY, nAuxX + 1 ] == 0 .And. ;
             anTablero [ nAuxY, nAuxX + 2 ] == 0
            anPosic [ 1 ] := { nAuxX - 1, nAuxY }
            anPosic [ 3 ] := { nAuxX + 1, nAuxY }
            anPosic [ 4 ] := { nAuxX + 2, nAuxY }
            nModoFig ++
            lRetorno := .T.
          EndIf
        Else
          If nAuxY - 1 > 0 .And. nAuxY + 2 < 21  .And. ;
             anTablero [ nAuxY - 1, nAuxX ] == 0 .And. ;
             anTablero [ nAuxY + 1, nAuxX ] == 0 .And. ;
             anTablero [ nAuxY + 2, nAuxX ] == 0
            anPosic [ 1 ] := { nAuxX, nAuxY - 1 }
            anPosic [ 3 ] := { nAuxX, nAuxY + 1 }
            anPosic [ 4 ] := { nAuxX, nAuxY + 2 }
            nModoFig ++
            lRetorno := .T.
          EndIf
        EndIf
      Case nTipoFigura == 2
        Do Case
          Case nModoFig == 1
            If nAuxX + 1 < 14 .And. ;
               anTablero [ nAuxY + 1, nAuxX - 1 ] == 0 .And. ;
               anTablero [ nAuxY,     nAuxX + 1 ] == 0
              anPosic [ 1 ] := { nAuxX - 1, nAuxY + 1 }
              anPosic [ 2 ] := { nAuxX - 1, nAuxY     }
              anPosic [ 3 ] := { nAuxX,     nAuxY     }
              anPosic [ 4 ] := { nAuxX + 1, nAuxY     }
              nModoFig ++
              lRetorno := .T.
            EndIf
          Case nModoFig == 2
            If nAuxY - 1 > 0 .And. ;
               anTablero [ nAuxY - 1, nAuxX     ] == 0 .And. ;
               anTablero [ nAuxY + 1, nAuxX + 1 ] == 0
              anPosic [ 1 ] := { nAuxX + 1, nAuxY + 1 }
              anPosic [ 2 ] := { nAuxX,     nAuxY + 1 }
              anPosic [ 3 ] := { nAuxX,     nAuxY     }
              anPosic [ 4 ] := { nAuxX,     nAuxY - 1 }
              nModoFig ++
              lRetorno := .T.
            EndIf
          Case nModoFig == 3
            If nAuxX - 1 > 0 .And. ;
               anTablero [ nAuxY,     nAuxX - 1 ] == 0 .And. ;
               anTablero [ nAuxY - 1, nAuxX + 1 ] == 0
              anPosic [ 1 ] := { nAuxX + 1, nAuxY - 1 }
              anPosic [ 2 ] := { nAuxX + 1, nAuxY     }
              anPosic [ 3 ] := { nAuxX,     nAuxY     }
              anPosic [ 4 ] := { nAuxX - 1, nAuxY     }
              nModoFig ++
              lRetorno := .T.
            EndIf
          Case nModoFig == 4
            If nAuxY + 1 < 20 .And. ;
               anTablero [ nAuxY - 1, nAuxX - 1 ] == 0 .And. ;
               anTablero [ nAuxY + 1, nAuxX     ] == 0
              anPosic [ 1 ] := { nAuxX - 1, nAuxY - 1 }
              anPosic [ 2 ] := { nAuxX,     nAuxY - 1 }
              anPosic [ 3 ] := { nAuxX,     nAuxY     }
              anPosic [ 4 ] := { nAuxX,     nAuxY + 1 }
              nModoFig ++
              lRetorno := .T.
            EndIf
        EndCase
      Case nTipoFigura == 3
        Do Case
          Case nModoFig == 1
            If nAuxX + 2 < 14 .And. ;
               anTablero [ nAuxY + 1, nAuxX + 1 ] == 0 .And. ;
               anTablero [ nAuxY + 1, nAuxX + 2 ] == 0
              anPosic [ 1 ] := { nAuxX,     nAuxY     }
              anPosic [ 2 ] := { nAuxX,     nAuxY + 1 }
              anPosic [ 3 ] := { nAuxX + 1, nAuxY + 1 }
              anPosic [ 4 ] := { nAuxX + 2, nAuxY + 1 }
              nModoFig ++
              lRetorno := .T.
            EndIf
          Case nModoFig == 2
            If nAuxY - 2 > 0 .And. ;
               anTablero [ nAuxY - 1, nAuxX + 1 ] == 0 .And. ;
               anTablero [ nAuxY - 2, nAuxX + 1 ] == 0
              anPosic [ 1 ] := { nAuxX,     nAuxY     }
              anPosic [ 2 ] := { nAuxX + 1, nAuxY     }
              anPosic [ 3 ] := { nAuxX + 1, nAuxY - 1 }
              anPosic [ 4 ] := { nAuxX + 1, nAuxY - 2 }
              nModoFig ++
              lRetorno := .T.
            EndIf
          Case nModoFig == 3
            If nAuxX - 2 > 0 .And. ;
               anTablero [ nAuxY - 1, nAuxX - 1 ] == 0 .And. ;
               anTablero [ nAuxY - 1, nAuxX - 2 ] == 0
              anPosic [ 1 ] := { nAuxX,     nAuxY     }
              anPosic [ 2 ] := { nAuxX,     nAuxY - 1 }
              anPosic [ 3 ] := { nAuxX - 1, nAuxY - 1 }
              anPosic [ 4 ] := { nAuxX - 2, nAuxY - 1 }
              nModoFig ++
              lRetorno := .T.
            EndIf
          Case nModoFig == 4
            If nAuxY + 2 < 20 .And. ;
               anTablero [ nAuxY + 1, nAuxX - 1 ] == 0 .And. ;
               anTablero [ nAuxY + 2, nAuxX - 1 ] == 0
              anPosic [ 1 ] := { nAuxX,     nAuxY     }
              anPosic [ 2 ] := { nAuxX - 1, nAuxY     }
              anPosic [ 3 ] := { nAuxX - 1, nAuxY + 1 }
              anPosic [ 4 ] := { nAuxX - 1, nAuxY + 2 }
              nModoFig ++
              lRetorno := .T.
            EndIf
        EndCase
      Case nTipoFigura == 4
        If nModoFig == 1 .or. nModoFig == 3
          If nAuxY - 1 > 0 .And. ;
             anTablero [ nAuxY - 1, nAuxX     ] == 0 .And. ;
             anTablero [ nAuxY + 1, nAuxX - 1 ] == 0
            anPosic [ 1 ] := { nAuxX,     nAuxY - 1 }
            anPosic [ 3 ] := { nAuxX - 1, nAuxY     }
            anPosic [ 4 ] := { nAuxX - 1, nAuxY + 1 }
            nModoFig ++
            lRetorno := .T.
          EndIf
        Else
          If nAuxX + 1 < 14 .And. ;
             anTablero [ nAuxY + 1, nAuxX     ] == 0 .And. ;
             anTablero [ nAuxY + 1, nAuxX + 1 ] == 0
            anPosic [ 1 ] := { nAuxX - 1, nAuxY     }
            anPosic [ 3 ] := { nAuxX,     nAuxY + 1 }
            anPosic [ 4 ] := { nAuxX + 1, nAuxY + 1 }
            nModoFig ++
            lRetorno := .T.
          EndIf
        EndIf
      Case nTipoFigura == 5
        If nModoFig == 1 .or. nModoFig == 3
          If nAuxY - 1 > 0 .And. ;
             anTablero [ nAuxY - 1, nAuxX     ] == 0 .And. ;
             anTablero [ nAuxY + 1, nAuxX + 1 ] == 0
            anPosic [ 1 ] := { nAuxX,     nAuxY - 1 }
            anPosic [ 3 ] := { nAuxX + 1, nAuxY     }
            anPosic [ 4 ] := { nAuxX + 1, nAuxY + 1 }
            nModoFig ++
            lRetorno := .T.
          EndIf
        Else
          If nAuxX - 1 > 0 .And. ;
             anTablero [ nAuxY + 1, nAuxX - 1 ] == 0 .And. ;
             anTablero [ nAuxY + 1, nAuxX     ] == 0
            anPosic [ 1 ] := { nAuxX + 1, nAuxY     }
            anPosic [ 3 ] := { nAuxX,     nAuxY + 1 }
            anPosic [ 4 ] := { nAuxX - 1, nAuxY + 1 }
            nModoFig ++
            lRetorno := .T.
          EndIf
        EndIf
      Case nTipoFigura == 6
        Do Case
          Case nModoFig == 1
            If nAuxY - 1 > 0 .And. anTablero [ nAuxY - 1, nAuxX ] == 0
              anPosic [ 1 ] := { nAuxX,     nAuxY + 1 }
              anPosic [ 3 ] := { nAuxX,     nAuxY - 1 }
              anPosic [ 4 ] := { nAuxX + 1, nAuxY     }
              nModoFig ++
              lRetorno := .T.
            EndIf
          Case nModoFig == 2
            If nAuxX - 1 > 0 .And. anTablero [ nAuxY, nAuxX - 1 ] == 0
              anPosic [ 1 ] := { nAuxX - 1, nAuxY     }
              anPosic [ 3 ] := { nAuxX + 1, nAuxY     }
              anPosic [ 4 ] := { nAuxX,     nAuxY - 1 }
              nModoFig ++
              lRetorno := .T.
            EndIf
          Case nModoFig == 3
            If nAuxY + 1 < 20 .And. anTablero [ nAuxY + 1, nAuxX ] == 0
              anPosic [ 1 ] := { nAuxX,     nAuxY + 1 }
              anPosic [ 3 ] := { nAuxX,     nAuxY - 1 }
              anPosic [ 4 ] := { nAuxX - 1, nAuxY     }
              nModoFig ++
              lRetorno := .T.
            EndIf
          Case nModoFig == 4
            If nAuxX + 1 < 14 .And. anTablero [ nAuxY, nAuxX + 1 ] == 0
              anPosic [ 1 ] := { nAuxX - 1, nAuxY     }
              anPosic [ 3 ] := { nAuxX + 1, nAuxY     }
              anPosic [ 4 ] := { nAuxX,     nAuxY + 1 }
              nModoFig ++
              lRetorno := .T.
            EndIf
        EndCase
      Case nTipoFigura == 7
        lRetorno := .T.
    EndCase
    aEval ( anPosic, { | aEle | anTablero [ aEle [ 2 ], aEle [ 1 ] ] := 1 } )
    nModoFig := If ( nModoFig == 0, 4, nModoFig )
    nModoFig := If ( nModoFig == 5, 1, nModoFig )
Return ( lRetorno )

          
Static Function Pinta ( nRelx, nRely, anPosic, nTipoFigura )
Local cColor    
    Do Case
      Case nTipoFigura == 1
        cColor := "R/R*"
      Case nTipoFigura == 2
        cColor := "RB/RB*"
      Case nTipoFigura == 3
        cColor := "W/W*"
      Case nTipoFigura == 4
        cColor := "BG/BG*"
      Case nTipoFigura == 5
        cColor := "G/G*"
      Case nTipoFigura == 6
        cColor := "GR/GR*"
      Case nTipoFigura == 7
        cColor := "B/B*"
    EndCase
    DispBegin ()
    TetPantalla ( nRelx, nRely, 2 )
    aEval ( anPosic, { | aEle | Message( nRely + aEle [ 2 ] - 2, nRelx - 1 + 2 * aEle [ 1 ], "  ", cColor ) } )
    DispEnd ()
Return ( Nil )


Static Function Siguiente ( nRelx, nRely, nFigura )
Local cColor  := ""
Local anPosic := {}
Static cPantalla
    cPantalla := If ( cPantalla == Nil, SaveScreen ( nRely + 11, nRelx + 30, nRely + 15, nRelx + 52 ), cPantalla )
    RestScreen ( nRely + 11, nRelx + 30, nRely + 15, nRelx + 52, cPantalla )
    Do Case
      Case nFigura == 1
        cColor := "R/R*"
        anPosic := { { 7, 1 }, { 7, 2 }, { 7, 3 }, { 7, 4 } }
      Case nFigura == 2
        cColor := "RB/RB*"
        anPosic := { { 7, 1 }, { 8, 1 }, { 8, 2 }, { 8, 3 } }
      Case nFigura == 3
        cColor := "W/W*"
        anPosic := { { 7, 1 }, { 6, 1 }, { 6, 2 }, { 6, 3 } }
      Case nFigura == 4
        cColor := "BG/BG*"
        anPosic := { { 6, 1 }, { 7, 1 }, { 7, 2 }, { 8, 2 } }
      Case nFigura == 5
        cColor := "G/G*"
        anPosic := { { 8, 1 }, { 7, 1 }, { 7, 2 }, { 6, 2 } }
      Case nFigura == 6
        cColor := "GR/GR*"
        anPosic := { { 6, 1 }, { 7, 1 }, { 8, 1 }, { 7, 2 } }
      Case nFigura == 7
        cColor := "B/B*"
        anPosic := { { 7, 1 }, { 8, 1 }, { 7, 2 }, { 8, 2 } }
    EndCase
    DispBegin ()
    aEval ( anPosic, { | aEle | Message( nRely + aEle [ 2 ] + 11, nRelx + 26 + 2 * aEle [ 1 ], "  ", cColor ) } )
    DispEnd ()
Return ( Nil )


Static Function CompruebaLin ( nRelx, nRely, anTablero, nLineas )
Local anCompletas := {}
Local nInd1
Local nInd2
Local lCompleta
Local cPantalla
    For nInd1 := 1 To 20
      lCompleta := .T.
      For nInd2 := 1 To 13
        If anTablero [ nInd1, nInd2 ] == 0
          lCompleta := .F.
        EndIf
      Next 
      If lCompleta == .T.
        aAdd ( anCompletas, nInd1 )
      EndIf
    Next
    nLineas += Len ( anCompletas )
    For nInd1 := 1 To Len ( anCompletas )
      cPantalla := SaveScreen ( nRely - 1, nRelx, nRely - 3 + anCompletas [ nInd1 ], nRelx + 27 )
      For nInd2 := anCompletas [ nInd1 ] To 2 Step -1
        aCopy ( anTablero [ nInd2 - 1 ], anTablero [ nInd2 ] )
      Next
      anTablero [ 1 ] := aFill ( AnTablero [ 1 ], 0 )
      speakgame( 2000 )
      RestScreen ( nRely, nRelx, nRely - 2 + anCompletas [ nInd1 ], nRelx + 27, cPantalla )
    Next
    TetPantalla ( nRelx, nRely, 1 )
Return ( Nil )


Static Function Velocidad ( nRelx, nRely )
Local aBoton := BoxOpen( 5, 12, 9, 66, "R", 0.3 )
Local nTecla := 0
Local nPos   := 5
    @ 6, 13 Say PadC ( "Initial Difficulty", 53 ) Color "W+/R"
    While nTecla != K_RETURN .And. nTecla != K_ESC
      DispBegin ()
      @  8, 22 Say " 1   2   3   4   5   6   7   8   9 " Color "W+/R"
      @  8, 22 + 4 * ( nPos - 1 ) Say PadC ( Chr ( 48 + nPos ), 3 ) Color "W+/B"
      @  nRely + 1, nRelx + 44 Say Str ( nPos, 7 ) Color "B/W"
      DispEnd ()
      nTecla := FastInkey( 0 )
      If nTecla == K_RIGHT
        nPos := Min ( ++nPos, 9 )
      ElseIf nTecla == K_LEFT
        nPos := Max ( --nPos, 1 )
      EndIf
    End
    BoxPush( aBoton )
    BoxClose( aBoton )
Return ( If ( nTecla == K_RETURN, nPos, 0 ) )


Static Function TetPantalla ( nRelx, nRely, nModo )
Static cPantalla    
    If nModo == 1
      cPantalla := SaveScreen ( nRely - 1, nRelx + 1, nRely + 18, nRelx + 26 )
    ElseIf nModo == 2
      RestScreen ( nRely - 1, nRelx + 1, nRely + 18, nRelx + 26, cPantalla )
    EndIf
Return ( Nil )



