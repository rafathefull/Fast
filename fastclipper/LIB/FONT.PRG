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


Function FontEdit( cNomFich )
Local GetList  := {}
Local nCursor  := SetCursor( 0 )
Local cColor   := SetColor( "gr+/b" )
Local cPant    := SaveScreen( 0, 0, 24, 79 )
Local aEditar  := {}
Local aNext    := {}
Local aPrev    := {}
Local aNumber  := {}
Local aTabla   := {}
Local aExit    := {}
Local cOld     := ""
Local cOp      := ""
Local nOp      := 0
Local aTablac
Local aTablam
Local cMapa
Local nKey := 1
    SetMode( 43, 80 )
    cls
    aTablac := Array( 16, 8 )
    aTablam := Array( 16, 8 )
    Window( 0, 0, 42, 79, "Fonts Editor", "ÉÍ»º¼ÍÈº ", .F., "GR+/B" )
    BoxMessage( "Filename :              ", 39, 50 )
    While ! File( cNomFich )
      cNomFich := Space( 8 )
      SetCursor( 1 )
      @ 40, 63 Get cNomFich Picture "@!XXXXXXXX" Color "GR+/B"
      Read
      SetCursor( 0 )
      If Lastkey() == K_ESC
        SetMode( 25, 80 )
        SetColor( cColor )
        SetCursor( nCursor )
        RestScreen( 0, 0, 24, 79, cPant )
        Return( Nil )
      EndIf
    End
    cMapa := MemoRead( cNomFich )
    @ 40, 63 Say cNomFich
    aTablac := LeerMapa( nKey, aTablac, cMapa )
    BoxOpen( 2,  2, 4, 17, "b", 0.2 )
    BoxOpen( 2, 18, 4, 29, "b", 0.2 )
    aTablam := VerMalla( aTablam, aTablac, nKey )
    While nOp != K_ESC
      aEditar := BoxMessage( "  (E)dit Character  ",  4, 50, "b" )
      aNext   := BoxMessage( "  (N)ext Character  ",  8, 50, "b" )
      aPrev   := BoxMessage( "(P)revious Character", 12, 50, "b" )
      aNumber := BoxMessage( " (C)haracter Number ", 16, 50, "b" )
      aTabla  := BoxMessage( "   (A)scii Table    ", 20, 50, "b" )
      aExit   := BoxMessage( "     (Esc) Exit     ", 24, 50, "b" )
      While nOp != K_ESC
        nOp := FastInkey( 0 )
        cOp := Upper( Chr( nOp ) )
        If nOp == K_ESC
          BoxPush( aExit )
          If BoxQuery ( GiveMsg( MSG_HOJA_SALVAR ) )
            MemoWrit( cNomFich, cMapa )
          EndIf
        ElseIf cOp == "A"
          BoxPush( aTabla )
          cOld := SaveScreen( 0, 0, MaxRow(), MaxCol() )
          SetMode( 25, 80 )
          Cls
          _Font( cMapa )
          AsciiTab()
          TxtMode()
          SetMode( 43, 80 )
          RestScreen( 0, 0, MaxRow(), MaxCol(), cOld )
        ElseIf cOp == "C"
          BoxPush( aNumber )
          SetCursor( 1 )
          @ 3, 25 Get nKey Picture "999" Color "GR+/B" Range 0, 255
          Read
          SetCursor( 0 )
          aTablac := LeerMapa( nKey, aTablac, cMapa )
          aTablam := VerMalla( aTablam, aTablac, nKey )
        ElseIf cOp == "E"
          BoxPush( aEditar )
          BoxClose( aEditar )
          BoxClose( aNext )
          BoxClose( aPrev )
          BoxClose( aNumber )
          BoxClose( aTabla )
          BoxClose( aExit )
          cMapa := EditarC( aTablam, aTablac, nKey, cMapa )
          Exit
        ElseIf cOp == "N"
          BoxPush( aNext )
          If nKey < 255
            nKey ++
          Else
            nKey := 0
          EndIf
          aTablac := LeerMapa( nKey, aTablac, cMapa )
          aTablam := VerMalla( aTablam, aTablac, nKey )
        ElseIf cOp == "P"
          BoxPush( aPrev )
          If nKey > 0
            nKey --
          Else
            nKey := 255
          EndIf
          aTablac := LeerMapa( nKey, aTablac, cMapa )
          aTablam := VerMalla( aTablam, aTablac, nKey )
        EndIf
      End
    End
    SetMode( 25, 80 )
    SetColor( cColor )
    SetCursor( nCursor )
    RestScreen( 0, 0, 24, 79, cPant )
Return( Nil )


Static Function EditarC( aTablam, aTablac, nKey, cMapa )
Local nX1
local nY1
Local nX       := 1
Local nY       := 1
Local nOpe     := 0
Local cOpe     := ""
Local aIlumina := BoxMessage( "    (Insert) On     ",  4, 50, "b" )
Local aApaga   := BoxMessage( "     (Supr) Off     ",  8, 50, "b" )
Local aGuarda  := BoxMessage( "   (S)ave Changes   ", 12, 50, "b" )
Local aExit    := BoxMessage( "    (Esc) Cancel    ", 16, 50, "b" )
    BoxTurn( aTablam[ nX, 8 - nY + 1 ], .F. )
    While .T.
      nOpe := FastInkey( 0 )
      cOpe := Upper( Chr( nOpe ) )
      if nOpe == K_ESC
        BoxTurn( aTablam[ nX, 8 - nY + 1 ], .T. )
        BoxPush( aExit )
        exit
      ElseIf nOpe == K_RIGHT
        If nY < 8
          BoxTurn( aTablam[ nX, 8 - nY + 1 ], .T. )
          nY++
          BoxTurn( aTablam[ nX, 8 - nY + 1 ], .F. )
        EndIf
      ElseIf nOpe == K_LEFT
        If nY > 1
          BoxTurn( aTablam[ nX, 8 - nY + 1 ], .T. )
          nY--
          BoxTurn( aTablam[ nX, 8 - nY + 1 ], .F. )
        EndIf
      ElseIf nOpe == K_DOWN
        If nX < 16
          BoxTurn( aTablam[ nX, 8 - nY + 1 ], .T. )
          nX++
          BoxTurn( aTablam[ nX, 8 - nY + 1 ], .F. )
        Endif
      ElseIf nOpe == K_UP
        If nX > 1
          BoxTurn( aTablam[ nX, 8 - nY + 1 ], .T. )
          nX--
          BoxTurn( aTablam[ nX, 8 - nY + 1 ], .F. )
        EndIf
      ElseIf nOpe == K_INS
        BoxPush( aIlumina )
        BoxTurn( aTablam[ nX, 8 - nY + 1 ], .T. )
        nX1 := ( ( ( nX - 1 ) * 2 ) + 7 )
        nY1 := ( ( ( nY - 1 ) * 3 ) + 4 )
        aTablam[ nX, 8 - nY + 1 ] := BoxOpen( nX1, nY1, nX1 + 1, nY1 + 2, "G", 0.2 )
        aTablac[ nX, nY] := 1
        BoxTurn( aTablam[ nX, 8 - nY + 1 ], .F. )
      ElseIf nOpe == K_DEL
        BoxPush( aApaga )
        BoxTurn( aTablam[ nX, 8 - nY + 1 ], .T. )
        nX1 := ( ( ( nX - 1 ) * 2 ) + 7 )
        nY1 := ( ( ( nY - 1 ) * 3 ) + 4 )
        aTablam[ nX, 8 - nY + 1 ] := BoxOpen( nX1, nY1, nX1 + 1, nY1 + 2, "B", 0.2 )
        aTablac[ nX, nY] := 0
        BoxTurn( aTablam[ nX, 8 - nY + 1 ], .F. )
      ElseIf cOpe == "S"
        BoxPush( aGuarda )
        cMapa := GuardaMapa( nKey, aTablac, cMapa )
      EndIf
    End
Return( cMapa )


Static Function VerMalla( aTablam, aTablac, nKey )
Local nI      := 0
Local nI1     := 0
Local nX      := 7
Local nY      := 4
Local nContac := 0
    @ 3,  4 say "Character: " + Chr( nKey )
    @ 3, 20 say "Num: " + Str( nKey, 3 )
    Window( 6, 2, 40, 29, "Character to Edit", "ÚÄ¿³ÙÄÀ³ ", .F., "GR+/B" )
    For nI := 1 to 16
      nContac := 9
      For nI1 := 1 to 8
        nContac--
        aTablam[ nI, nContac ] := BoxOpen( nX, nY, nX + 1, nY + 2, If( aTablac[ nI, nI1 ] == 1, "G", "B" ), 0.2 )
        nY += 3
      Next
      nX += 2
      nY := 4
    Next
Return( aTablam )


Static Function GuardaMapa( nKey, aTablac, cMapa )
Local nConta
Local cValor
Local nBit
Local nContac
Local nTecla    := ( nKey * 16 ) + 1
Local cCaracter := SubStr( cMapa, nTecla, 16 )
Local cBuffer   := ""
    For nConta := 1 To 16
      cValor  := Chr( 0 )
      nContac := 0
      For nBit := 7 To 0 step -1
        nContac++
        cValor := If( aTablac[ nConta, nContac ] == 1, SetBit( cValor, nBit ), DelBit( cValor, nBit ) )
      Next
      cBuffer += cValor
    Next
    cMapa := SubStr( cMapa, 1, nTecla - 1 ) + cBuffer + SubStr( cMapa, nTecla + 16 )
//    cMapa := Stuff( cMapa, nTecla, 16, cBuffer )
Return( cMapa )


Static Function LeerMapa( nKey, aTablac, cMapa )
Local nConta
Local cValor
Local nBit
Local nContac
Local nTecla    := ( nKey * 16 ) + 1
Local cCaracter := SubStr( cMapa, nTecla, 16 )
    For nConta := 1 To 16
      cValor := SubStr( cCaracter, nConta, 1 )
      nContac := 0
      For nBit := 7 to 0 Step -1
        nContac++
        aTablac[ nConta, nContac ] := If( IsBit( cValor, nBit ), 1, 0 )
      Next
    Next
Return( aTablac )
