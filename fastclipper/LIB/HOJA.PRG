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


Static nRow

Function Notes( cColor, cColorBro, cFichero )
Local tbB           := TBrowseNew ( 5, 4, MaxRow() - 4, MaxCol() - 5 )
Local tbC           := TBrowseNew ( 5, 4, MaxRow() - 4, MaxCol() - 5 )
Local tbW           := tbB    
Local nInd          := 0
Local nKey          := 0
Local lAutoCalc     := .T.
Local lNeedToReCalc := .F.
Local aArray        := {}
Local aFormu        := {}
Local aBlock        := {}
Local cColores      := SetColor ( cColor )
Local nCursor       := SetCursor ( 0 )
Local cPantalla     := SaveScreen ( 0, 0, MaxRow(), MaxCol() )
Local nX            := Col ()    
Local nY            := Row ()
Local cAutoCalc     := "Off"
Local cEditar       := GiveMsg( MSG_HOJA_FORMULA )
Local lCambios      := .F.
Local Column
Local k
Local aAyuda
    cColor    := If ( cColor    == Nil, "W/B,N/BG",              cColor )
    cColorBro := If ( cColorBro == Nil, "W/B,N/BG,G/B,W/B,R+/B", cColorBro )
    cFichero  := If ( cFichero  == Nil, "HOJACALC.HC",           cFichero )
    nRow := 1
    If ! lLeeHoja ( @aArray, @aFormu, @aBlock, cFichero )
      Return ( Nil )
    EndIf
    uCalcula ( aArray, aFormu, aBlock )
    DispBegin ()
    Window(  4, 3, MaxRow() - 2, MaxCol() - 4, cFichero, "ÉÍ»º¼ÍÈº ", .T., , .F. )
    Window( MaxRow() - 4, 3, MaxRow() - 2, MaxCol() - 4, , "ÌÍ¹º¼ÍÈº ", .T., , .F. )
    @  6,  3 Say "Ì"
    @  6, MaxCol() - 4 Say "¹"
    DispEnd ()
    tbB:SkipBlock     := tbC:SkipBlock := { | x | k := If ( Abs ( x ) >= If ( x >= 0, Len ( aArray ) - nRow, nRow - 1 ), ;
                                                    If (x >= 0, Len ( aArray ) - nRow, 1 - nRow), x ), nRow += k, k }
    tbB:GoTopBlock    := tbC:GoTopBlock    := { || nRow := 1 }
    tbB:GoBottomBlock := tbC:GoBottomBlock := { || nRow := Len ( aArray ) }
    tbB:ColorSpec     := tbC:ColorSpec     := cColorBro
    tbB:FootSep       := tbC:FootSep       := "ÏÍ"
    tbB:HeadSep       := tbC:HeadSep       := "ÑÍ"
    tbB:ColSep        := tbC:ColSep        := "³"
    For nInd := 1 TO 12
      Column := tbColumnNew ( PadL ( Chr ( Asc ( "A" ) + nInd - 1 ), 10 ), ABrowseBlock ( aArray, nInd ) )
      Column:Width      := 10
      Column:ColorBlock := { | x | If ( x < 0, { 5, 2 }, If ( x > 0, { 8, 2 }, { 4, 2 } ) ) }
      tbB:addColumn ( Column )
      Column := tbColumnNew ( PadL ( Chr ( Asc ( "A" ) + nInd - 1 ), 10 ), ABrowseBlock ( aFormu, nInd ) )
      Column:Width    := 10
      Column:DefColor := { 5, 7 }
      tbC:addColumn ( Column )
    Next
    tbB:insColumn ( 1, tbColumnNew ( "", { || Str ( nRow, 5 ) } ) )
    tbC:insColumn ( 1, tbColumnNew ( "", { || Str ( nRow, 5 ) } ) )
    tbB:freeze := tbC:freeze := 1
    tbW := tbB
    @ MaxRow() - 3, 5 Say GiveMsg( MSG_HOJA_FORMULA )
    aAyuda := GiveMsg( MSG_HOJA_AYUDA )
    aAyuda[ 2 ] += cAutoCalc
    aAyuda[ 4 ] += cEditar
    LinAyuda( aAyuda )
    While .T.
      If tbW:ColPos <= tbW:freeze               
      tbW:ColPos := tbW:freeze + 1
      EndIf
      DispBegin ()
      While ( ! tbW:stabilize () )
      End
      @ MaxRow() - 3, 14 Say Eval ( ( tbC:getColumn ( tbW:ColPos ) ):block )
      DispEnd()
      If tbW:stable()
        nKey := FastInkey( 0 )
      EndIf
      If nKey == K_DOWN 
        If nRow < Len ( aArray )
          tbW:down ()
        Else
          lCambios := .T.
          aAdd ( aArray, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } )
          aAdd ( aFormu, { Space ( 30 ), Space ( 30 ), Space ( 30 ), ;
                           Space ( 30 ), Space ( 30 ), Space ( 30 ), ;
                           Space ( 30 ), Space ( 30 ), Space ( 30 ), ;
                           Space ( 30 ), Space ( 30 ), Space ( 30 ) } )
          aAdd ( aBlock, { { | aArray | .T. }, { | aArray | .T. }, ;
                           { | aArray | .T. }, { | aArray | .T. }, ;
                           { | aArray | .T. }, { | aArray | .T. }, ;
                           { | aArray | .T. }, { | aArray | .T. }, ;
                           { | aArray | .T. }, { | aArray | .T. }, ;
                           { | aArray | .T. }, { | aArray | .T. } } )
          tbW:Down ()
          uCalcula ( aArray, aFormu, aBlock )
          tbW:RefreshAll ()
        EndIf
      ElseIf nKey == K_UP
        tbW:up ()
      ElseIf nKey == K_PGDN
        tbW:pageDown ()
      ElseIf nKey == K_PGUP
        tbW:pageUp ()
      ElseIf nKey == K_CTRL_PGUP
        tbW:goTop ()
      ElseIf nKey == K_CTRL_PGDN
        tbW:goBottom ()
      ElseIf nKey == K_RIGHT
        tbW:right ()
      ElseIf nKey == K_LEFT
        tbW:left ()
      ElseIf nKey == K_HOME
        tbW:home ()
      ElseIf nKey == K_END
        tbW:End ()
      ElseIf nKey == K_CTRL_HOME
        tbW:panHome ()
      ElseIf nKey == K_CTRL_END
        tbW:panEnd ()
      ElseIf nKey == K_RETURN
        lCambios := .T.
        If ( tbW == tbB ) .And. ! Empty ( Eval ( ( tbC:getColumn ( tbW:ColPos ) ):block ) )
          Loop
        EndIf
        lNeedToReCalc := lEditaColumna ( tbW )
        If lAutoCalc .And. lNeedToReCalc
          uCalculaBlock ( aArray, aBlock )
          tbW:refreshAll ()
          lNeedToReCalc := .F.
        EndIf
      ElseIf nKey == K_ESC
        If BoxQuery ( GiveMsg( MSG_HOJA_SALIR ) )
          If lCambios .And. BoxQuery ( GiveMsg( MSG_HOJA_SALVAR ) )
            uSalvaHoja ( aArray, aFormu, cFichero )
          EndIf
          Exit
        EndIf
      ElseIf nKey == K_F6
        If ( tbW == tbB )
          lAutoCalc := !lAutocalc
          If lAutoCalc
            cAutoCalc := "Off"
          Else
            cAutoCalc := "On"
          EndIf
          aAyuda[ 2 ] := "Calc " + cAutoCalc
          LinAyuda ( aAyuda )
        EndIf
      ElseIf nKey == K_F7
        If ( tbW == tbB )
          lAutoCalc := .F.
          tbW := tbC
          tbW:ColPos := tbB:ColPos
          tbW:RowPos := tbB:RowPos
          cEditar := GiveMsg( MSG_HOJA_NUMERO )
        Else
          lAutoCalc := .T.
          uCalcula ( aArray, aFormu, aBlock )
          tbW := tbB
          tbW:ColPos := tbC:ColPos
          tbW:RowPos := tbC:RowPos
          cEditar := GiveMsg( MSG_HOJA_FORMULA )
        EndIf
        Eval ( tbW:goTopBlock )
        tbW:refreshAll ()
        aAyuda[ 4 ] := GiveMsg( MSG_HOJA_EDITAR ) + cEditar
        LinAyuda ( aAyuda )
      ElseIf nKey == K_F8
        If ( tbW == tbB )
          uCalcula ( aArray, aFormu, aBlock )
          tbW:refreshAll()
        EndIf
      EndIf  
    End
    SetColor ( cColores )
    SetCursor ( nCursor )
    SetPos ( nY, nX )
    RestScreen ( 0, 0, MaxRow(), MaxCol(), cPantalla )
Return ( Nil )


Static Function ABrowseBlock ( a, x )
Return ( { | p | If ( PCount() == 0, a [ nRow, x ], a [ nRow, x ] := p ) } )


Static Function lLeeHoja ( aArray, aFormu, aBlock, cFichero )
Local k := 1
Local nWorkArea := Select ()
Local nContador := 1
    If File ( cFichero )
      dbUseArea ( .T., , cFichero, "Hoja", .F., .F. )
      While NetErr ()
        dbUseArea ( .T., , cFichero, "Hoja", .F., .F. )
        If nContador++ >= 1000
          If BoxQuery ( GiveMsg( MSG_HOJA_SHARE ) )
            nContador := 1
          Else
            Return ( .F. )
          EndIf
        EndIf
        nContador ++
      End
      dbEval ( { || aAdd ( aArray, { Hoja->Col1,  Hoja->Col2, ;
                                     Hoja->Col3,  Hoja->Col4, ;
                                     Hoja->Col5,  Hoja->Col6, ;
                                     Hoja->Col7,  Hoja->Col8, ;
                                     Hoja->Col9,  Hoja->Col10, ;
                                     Hoja->Col11, Hoja->Col12 } ), ; 
                    aAdd ( aFormu, { Hoja->For1,  Hoja->For2, ;
                                     Hoja->For3,  Hoja->For4, ;
                                     Hoja->For5,  Hoja->For6, ;
                                     Hoja->For7,  Hoja->For8, ;
                                     Hoja->For9,  Hoja->For10, ;
                                     Hoja->For11, Hoja->For12 } ), ;
                    aAdd ( aBlock, { { | aArray | .T. }, { | aArray | .T. }, ;
                                     { | aArray | .T. }, { | aArray | .T. }, ;
                                     { | aArray | .T. }, { | aArray | .T. }, ;
                                     { | aArray | .T. }, { | aArray | .T. }, ;
                                     { | aArray | .T. }, { | aArray | .T. }, ;
                                     { | aArray | .T. }, { | aArray | .T. } } ) } )
      dbCloseArea ()
      dbSelectArea ( nWorkArea )
    Else
      aAdd ( aArray, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 } )
      aAdd ( aFormu, { Space ( 30 ), Space ( 30 ), ;
                       Space ( 30 ), Space ( 30 ), ;
                       Space ( 30 ), Space ( 30 ), ;
                       Space ( 30 ), Space ( 30 ), ;
                       Space ( 30 ), Space ( 30 ), ;
                       Space ( 30 ), Space ( 30 ) } )
      aAdd ( aBlock, { { | aArray | .T. }, { | aArray | .T. }, ;
                       { | aArray | .T. }, { | aArray | .T. }, ;
                       { | aArray | .T. }, { | aArray | .T. }, ;
                       { | aArray | .T. }, { | aArray | .T. }, ;
                       { | aArray | .T. }, { | aArray | .T. }, ;
                       { | aArray | .T. }, { | aArray | .T. } } )
    EndIf
Return ( .T. )


Static Function uSalvaHoja ( aArray, aFormu, cFichero )
Local aStructure 
Local k
Local lFile     := .F.
Local nWorkArea := Select ()
Local nContador := 1
Local nWork
    If ( lFile := ! File ( cFichero ) )
      aStructure := { { "Col1",  "N", 10, 0 }, ;
                      { "Col2",  "N", 10, 0 }, ;
                      { "Col3",  "N", 10, 0 }, ;
                      { "Col4",  "N", 10, 0 }, ;
                      { "Col5",  "N", 10, 0 }, ;
                      { "Col6",  "N", 10, 0 }, ;
                      { "Col7",  "N", 10, 0 }, ;
                      { "Col8",  "N", 10, 0 }, ;
                      { "Col9",  "N", 10, 0 }, ;
                      { "Col10", "N", 10, 0 }, ;
                      { "Col11", "N", 10, 0 }, ;
                      { "Col12", "N", 10, 0 }, ;
                      { "For1",  "C", 30, 0 }, ;
                      { "For2",  "C", 30, 0 }, ;
                      { "For3",  "C", 30, 0 }, ;
                      { "For4",  "C", 30, 0 }, ;
                      { "For5",  "C", 30, 0 }, ;
                      { "For6",  "C", 30, 0 }, ;
                      { "For7",  "C", 30, 0 }, ;
                      { "For8",  "C", 30, 0 }, ;
                      { "For9",  "C", 30, 0 }, ;
                      { "For10", "C", 30, 0 }, ;
                      { "For11", "C", 30, 0 }, ;
                      { "For12", "C", 30, 0 } }
      dbCreate ( cFichero, aStructure )
    EndIf
    dbUseArea ( .T., , cFichero, "Hoja", .F., .F. )
    While NetErr ()
      dbUseArea ( .T., , cFichero, "Hoja", .F., .F. )
      If nContador++ >= 1000
        If BoxQuery ( GiveMsg( MSG_HOJA_SHARE ) )
          nContador := 1
        Else
          Return ( Nil )
        EndIf
      EndIf
    End
    uReemplaza ( aArray, aFormu )
    dbCloseArea ()
    dbSelectArea ( nWorkArea )
Return ( Nil )


Static Function uReemplaza ( aArray, aFormu )
Local nInd
    dbGoTop ()
    For nInd := 1 To LaStrec ()
      Hoja->Col1  := aArray [ nInd,  1 ]
      Hoja->Col2  := aArray [ nInd,  2 ]
      Hoja->Col3  := aArray [ nInd,  3 ]
      Hoja->Col4  := aArray [ nInd,  4 ]
      Hoja->Col5  := aArray [ nInd,  5 ]
      Hoja->Col6  := aArray [ nInd,  6 ]
      Hoja->Col7  := aArray [ nInd,  7 ]
      Hoja->Col8  := aArray [ nInd,  8 ]
      Hoja->Col9  := aArray [ nInd,  9 ]
      Hoja->Col10 := aArray [ nInd, 10 ]
      Hoja->Col11 := aArray [ nInd, 11 ]
      Hoja->Col12 := aArray [ nInd, 12 ]
      Hoja->For1  := aFormu [ nInd,  1 ]
      Hoja->For2  := aFormu [ nInd,  2 ]
      Hoja->For3  := aFormu [ nInd,  3 ]
      Hoja->For4  := aFormu [ nInd,  4 ]
      Hoja->For5  := aFormu [ nInd,  5 ]
      Hoja->For6  := aFormu [ nInd,  6 ]
      Hoja->For7  := aFormu [ nInd,  7 ]
      Hoja->For8  := aFormu [ nInd,  8 ]
      Hoja->For9  := aFormu [ nInd,  9 ]
      Hoja->For10 := aFormu [ nInd, 10 ]
      Hoja->For11 := aFormu [ nInd, 11 ]
      Hoja->For12 := aFormu [ nInd, 12 ]
      dbSkip ( 1 )
    Next
    For nInd := LaStrec () + 1 To Len ( aArray )
      dbAppEnd ()
      Hoja->Col1  := aArray [ nInd,  1 ]
      Hoja->Col2  := aArray [ nInd,  2 ]
      Hoja->Col3  := aArray [ nInd,  3 ]
      Hoja->Col4  := aArray [ nInd,  4 ]
      Hoja->Col5  := aArray [ nInd,  5 ]
      Hoja->Col6  := aArray [ nInd,  6 ]
      Hoja->Col7  := aArray [ nInd,  7 ]
      Hoja->Col8  := aArray [ nInd,  8 ]
      Hoja->Col9  := aArray [ nInd,  9 ]
      Hoja->Col10 := aArray [ nInd, 10 ]
      Hoja->Col11 := aArray [ nInd, 11 ]
      Hoja->Col12 := aArray [ nInd, 12 ]
      Hoja->For1  := aFormu [ nInd,  1 ]
      Hoja->For2  := aFormu [ nInd,  2 ]
      Hoja->For3  := aFormu [ nInd,  3 ]
      Hoja->For4  := aFormu [ nInd,  4 ]
      Hoja->For5  := aFormu [ nInd,  5 ]
      Hoja->For6  := aFormu [ nInd,  6 ]
      Hoja->For7  := aFormu [ nInd,  7 ]
      Hoja->For8  := aFormu [ nInd,  8 ]
      Hoja->For9  := aFormu [ nInd,  9 ]
      Hoja->For10 := aFormu [ nInd, 10 ]
      Hoja->For11 := aFormu [ nInd, 11 ]
      Hoja->For12 := aFormu [ nInd, 12 ]
    Next
Return ( Nil )


Static Function cConvertIt ( cLinea, aArrayPrin )
Local cXlated := ""
Local cTemp   := ""
Local nLen    := 0
Local i       := 1
Local cAux    := ""
Local nAux    := 0
Local lError  := .F.
Local lSigno  := .F.
Local aArray
    If Empty ( cLinea )
      lError := .T.
    EndIf
    cLinea := StrTran ( cLinea, " ", "" )
    nLen   := Len ( cLinea )
    aArray := Array ( nLen )
    aEval ( aArray, { | x, i | aArray [ i ] := SubStr ( cLinea, i, 1 ) } )
    While ( i <= nLen )
      If aArray [ i ] $ "0123456789"
        cTemp += aArray [ i ]
        lError := .F.
        lSigno := .F.
      ElseIf aArray [ i ] $ "/+-*"
        lError := .T.
        If lSigno
          Exit
        EndIf
        cTemp += aArray [ i ]
        lSigno := .T.
      ElseIf aArray [ i ] $ "ABCDEFGHIJKL"
        cTemp += "aArray["
        nAux  := i
        cAux  := ""
        i++
        While i <= nLen .And. aArray [ i ] $ "0123456789"
          cAux += aArray [ i++ ]
        End
        --i
        If Val ( cAux ) > Len ( aArrayPrin ) .or. Val ( cAux ) == 0 .or. Len ( cAux ) == 0
          lError := .T.
          Exit
        Else 
          cTemp += cAux
          lError := .F.
          lSigno := .F.
        EndIf  
        cTemp += "," + Chr ( Asc ( "1" ) + Asc ( aArray [ nAux ] ) - Asc ( "A" ) ) + "]"
      Else
        lError := .T.
        Exit
      EndIf
      ++i
    End
    If lError
      cTemp := "{ | aArray | .T. }"
    Else
      cTemp := "{ | aArray | " + cTemp + " }"
    EndIf
Return ( cTemp )


Static Function uCalcula ( aArray, aFor, aBlock )
Local i, j, k
    aEval ( aFor, { | x, i | k := i, aEval ( x, { | y, j | aBlock [ k, j ] := &( cConvertIt ( y, aArray ) ) } ) } )
    uCalculaBlock ( aArray, aBlock )
Return ( Nil )


Static Function uCalculaBlock ( aArray, aBlock )
Local nInd1, nInd2, nInd3
    For nInd1 := 1 To Len ( aArray )
      For nInd2 := 1 To 6
        nInd3 := Eval ( aBlock [ nInd1, nInd2 ], aArray )
        If ValType ( nInd3 ) == "N"
          aArray [ nInd1, nInd2 ] := Val ( Str ( nInd3 ) )
        EndIf
      Next
    Next
Return ( Nil )


Static Function lEditaColumna ( tbW )
Local Column
Local get
Local lNeedToCalc := .F.
Local cEstado     := SaveScreen ( MaxRow(), 0, MaxRow(), MaxCol() )
    DispBegin  ()
    While ( ! tbW:stabilize () )
    End
    DispEnd ()
    Column := tbW:getColumn ( tbW:ColPos )
    Warning ( GiveMsg( MSG_HOJA_PIDE ), .F. )
    get := GetNew ( MaxRow(), 19, Column:block, Column:heading, ;
                    If ( ValType ( Eval ( Column:block ) ) == "N", ;
                      "@K9999999999", "@!K" ), SetColor () )
    lNeedToCalc := lMiModal ( get )
    tbW:refreshCurrent ()
    RestScreen ( MaxRow(), 0, MaxRow(), MaxCol(), cEstado )
Return ( lNeedToCalc )


Static Function lMiModal ( get )
Local lExitRequested := .F.
Local lUpdated       := .F.
Local nKey
Local cKey
Local nCursores      := SetCursor ( If ( ! Set ( _SET_INSERT ), 1, 2 ) )
    Get:setFocus()
    lExitRequested := Get:typeOut
    While ! lExitRequested
      nKey := FastInkey( 0 )
      If ( nKey == K_ESC )
        Get:undo ()
        Get:reset ()
        SetCursor ( 0 )
        Return ( lUpdated )
      ElseIf ( nKey == K_RETURN )
        lExitRequested := .T.
      ElseIf ( nKey == K_RIGHT )
        Get:right ()
      ElseIf ( nKey == K_HOME )
        Get:home ()
      ElseIf ( nKey == K_END )
        Get:End ()
      ElseIf ( nKey == K_LEFT )
        Get:left ()
      ElseIf ( nKey == K_DEL )
        Get:delete ()
      ElseIf ( nKey == K_BS )
        Get:backSpace ()
      ElseIf ( nKey == K_INS )
        Set ( _SET_INSERT, ! Set ( _SET_INSERT ) )
        SetCursor ( If ( Set ( _SET_INSERT ), 2, 1 ) )
      Else
        cKey := Upper ( Chr ( nKey ) )
        If ( Get:type == "N" .And. cKey $ "-0123456789" ) .or. ;
           ( Get:type == "C" .And. cKey $ "-+/*0123456789ABCDEFGHIJKL" ) 
          If Set ( _SET_INSERT )
            Get:Insert ( cKey )
          Else
            Get:OverStrike ( cKey )
          EndIf
        EndIf
      EndIf
    End
    If ( lUpdated := Get:changed )
      Get:assign ()
    EndIf
    Get:reset ()
    Get:killFocus ()
    SetCursor ( nCursores )
Return ( lUpdated )



