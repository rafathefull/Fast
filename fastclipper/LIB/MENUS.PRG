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


// Programs.......: Menus.prg
// Library........: FastSuites
// Author.........: Manuel Roibal
// Modificada Por.: Williams E. Nasser  E-mail: wencs@telcel.net.ve
//                : Wen Computer Soft, C.A. 
// Fecha..........: 3:32pm Oct 08,1997         



#include "inkey.ch"
#include "c:\libs\clipapi\version.ch"
//#include "version.ch"

FAST_VERSION

Static nStTecla := { { 286, "K_ALT_A" }, ;
                     { 304, "K_ALT_B" }, ;
                     { 302, "K_ALT_C" }, ;
                     { 288, "K_ALT_D" }, ;
                     { 274, "K_ALT_E" }, ;
                     { 289, "K_ALT_F" }, ;
                     { 290, "K_ALT_G" }, ;
                     { 291, "K_ALT_H" }, ;
                     { 279, "K_ALT_I" }, ;
                     { 292, "K_ALT_J" }, ;
                     { 293, "K_ALT_K" }, ;
                     { 294, "K_ALT_L" }, ;
                     { 306, "K_ALT_M" }, ;
                     { 305, "K_ALT_N" }, ;
                     { 280, "K_ALT_O" }, ;
                     { 281, "K_ALT_P" }, ;
                     { 272, "K_ALT_Q" }, ;
                     { 275, "K_ALT_R" }, ;
                     { 287, "K_ALT_S" }, ;
                     { 276, "K_ALT_T" }, ;
                     { 278, "K_ALT_U" }, ;
                     { 303, "K_ALT_V" }, ;
                     { 273, "K_ALT_W" }, ;
                     { 301, "K_ALT_X" }, ;
                     { 277, "K_ALT_Y" }, ;
                     { 300, "K_ALT_Z" } }



Function NewMenu ( aOps, aColor, lShadow )
Local aMenu  := {}
Local nInd   := 0
Local nPos   := 1
Local cOpt   := ""
Local nMarca := 0
Local nOpc   := 0
Local cTecla := ""
    For nInd := Len( aColor ) To 9
      aAdd( aColor, Nil )
    Next
    aAdd( aColor, If( lShadow == Nil, .F., lShadow ) )
    aAdd( aMenu, aColor )
    For nInd := 1 To Len ( aOps )
      nMarca := At ( "^", aOps [ nInd ] )
      cTecla := "K_ALT_"
      If nMarca == 0
        cTecla += "0"
        cOpt   := aOps [ nInd ]
      Else
        cTecla += Upper ( SubStr ( aOps [ nInd ], nMarca + 1, 1 ) )
        cOpt   := SubStr ( aOps [ nInd ], 1, nMarca - 1 ) + ;
                  SubStr ( aOps [ nInd ], nMarca + 1 )
      EndIf
      aAdd ( aMenu, { cOpt, nPos, nMarca - 1, cTecla, {} } )
      nPos += Len ( aOps [ nInd ] ) + 1
    Next
Return ( aMenu )


Function AddItem ( aMenu, nPos, cItem, cMens, nIns, aSubMenu )
Local nInd
    If cItem == Nil .Or. nPos == Nil .Or. aMenu == Nil .Or. ++nPos > Len ( aMenu )
      Return ( Nil )
    EndIf
    nIns  := If ( nIns == Nil, Len ( aMenu [ nPos, 5 ] ) + 1, nIns )
    cMens := If ( cMens == Nil, "", cMens )
    aSize ( aMenu [ nPos, 5 ], Len ( aMenu [ nPos, 5 ] ) + 1 )
    aIns ( aMenu [ nPos, 5 ], nIns )
    If aSubMenu != Nil
      For nInd := 1 To Len( aSubMenu )
        aSubMenu[ nInd ] := " " + aSubMenu[ nInd ] + " "
      Next
    EndIf
    aMenu [ nPos, 5, nIns ] := {  " " + cItem, 1, cMens, aSubMenu }
Return ( Nil )


Function AddLine ( aMenu, nPos )
    If nPos == Nil .Or. aMenu == Nil .Or. ++nPos > Len ( aMenu )
      Return ( Nil )
    EndIf
    aAdd ( aMenu [ nPos, 5 ], { "", 0, Nil, Nil } )
Return ( Nil )


Function DelItem ( aMenu, nPos, nItem )
    If nPos == Nil .Or. aMenu == Nil .Or. ++nPos > Len ( aMenu ) .Or. nItem > Len ( aMenu [ nPos, 5 ] )
      Return ( Nil )
    EndIf
    aDel ( aMenu [ nPos, 5 ], nItem )
    aSize ( aMenu [ nPos, 5 ], Len ( aMenu [ nPos, 5 ] ) - 1 )
Return ( Nil )


Function OffItem ( aMenu, nPos, nItem )
    If nPos == Nil .Or. aMenu == Nil .Or. ++nPos > Len ( aMenu ) .Or. nItem > Len ( aMenu [ nPos, 5 ] )
      Return ( Nil )
    EndIf
    If aMenu [ nPos, 5, nItem, 2 ] == 1
      aMenu [ nPos, 5, nItem, 2 ] := 2
    EndIf
Return ( Nil )


Function OnItem ( aMenu, nPos, nItem )
    If nPos == Nil .Or. aMenu == Nil .Or. ++nPos > Len ( aMenu ) .Or. nItem > Len ( aMenu [ nPos, 5 ] )
      Return ( Nil )
    EndIf
    If aMenu [ nPos, 5, nItem, 2 ] == 2
      aMenu [ nPos, 5, nItem, 2 ] := 1
    EndIf
Return ( Nil )


Function DispMenu ( aMenu, nInit ,vInit) // aMenu, nInit ,vInit=Posici¢n de la linea
Local nInd    := 0
Local nTecla  := 0
Local nRet    := 0
Local nAnt    := 0
Local nCursor := SetCursor (0)
Local nPos    := 0
Local aOpc    := {}
Local nOpc    := 0
Local nPmenu  := 0
    DispBegin ()
    Message( nPmenu, 0, Space( MaxCol() + 1 ), aMenu [ 1, 1 ] )
    For nInd := 2 To Len ( aMenu )
      Message( nPmenu, aMenu [ nInd, 2 ], aMenu [ nInd, 1 ], aMenu [ 1, 1 ] )
      If aMenu [ nInd, 3 ] >= 0
        Message( nPmenu, aMenu [ nInd, 2 ] + aMenu [ nInd, 3 ], SubStr ( aMenu [ nInd, 1 ], aMenu [ nInd, 3 ] + 1, 1 ), aMenu [ 1, 2 ] )
      EndIf
    Next
    DispEnd()
    nInd := 2
    nAnt := 2
    If nInit != Nil
      nInd += nInit - 1
      nAnt += nInit - 1
      Keyboard Chr ( K_RETURN )
      nInd := If ( nInd < 2, 2, nInd )
      nInd := If ( nInd > Len ( aMenu ), Len ( aMenu ), nInd )
      nAnt := If ( nAnt < 2, 2, nAnt )
      nAnt := If ( nAnt > Len ( aMenu ), Len ( aMenu ), nAnt )
    EndIf
    While .T.
      DispBegin()
      Message( nPmenu, aMenu [ nAnt, 2 ] - 1, Space ( 1 ) + aMenu [ nAnt, 1 ] + Space ( 1 ), aMenu [ 1, 1 ] )
      If aMenu [ nAnt, 3 ] >= 0
        Message( nPmenu, aMenu [ nAnt, 2 ] + aMenu [ nAnt, 3 ], SubStr ( aMenu [ nAnt, 1 ], aMenu [ nAnt, 3 ] + 1, 1 ), aMenu [ 1, 2 ] )
      EndIf
      nAnt := nInd
      Message( nPmenu, aMenu [ nInd, 2 ] - 1, Space ( 1 ) + aMenu [ nInd, 1 ] + Space ( 1 ), aMenu [ 1, 3 ] )
      If aMenu [ nInd, 3 ] >= 0
        Message( nPmenu, aMenu [ nInd, 2 ] + aMenu [ nInd, 3 ], SubStr ( aMenu [ nInd, 1 ], aMenu [ nInd, 3 ] + 1, 1 ), aMenu [ 1, 4 ] )
      EndIf
      DispEnd()
      nTecla := FastInkey( 0, .F. )

      If nTecla == K_LEFT
        nInd --
      ElseIf nTecla == K_RIGHT
        nInd ++
      ElseIf nTecla == K_ESC
        nRet := 0
        Exit
      ElseIf nTecla == K_DOWN .Or. nTecla == K_RETURN
        aOpc := EditWin ( aMenu [ nInd, 2 ], aMenu [ nInd, 5 ],         aMenu [ 1, 5 ], ;
                          aMenu [ 1, 6 ],    aMenu [ 1, 7 ],            aMenu [ 1, 8 ], ;
                          aMenu [ 1, 9 ],    Len ( aMenu [ nInd, 1 ] ), aMenu ,vInit)
        vInit:=0
        nOpc := aOpc[ 1 ]
        If nOpc == -1
          nInd ++
          Keyboard Chr ( K_RETURN )
        ElseIf nOpc == -2
          nInd --
          Keyboard Chr ( K_RETURN )
        ElseIf nOpc == -3
          nTecla := LastKey()
          nPos := aScan ( nStTecla, { | aX | nTecla == aX [ 1 ] } )
          nInd := aScan ( aMenu, { | aX | aX [ 4 ] == nStTecla [ nPos, 2 ] }, 2 )
          Keyboard Chr ( K_RETURN )
        ElseIf nOpc != 0
          nRet := ( nInd - 1 ) * 10000 + nOpc * 100 + aOpc[ 2 ]
          Exit
        EndIf
      ElseIf ( nPos := aScan ( nStTecla, { | aX | nTecla == aX [ 1 ] } ) ) != 0
        nPos := aScan ( aMenu, { | aX | aX [ 4 ] == nStTecla [ nPos, 2 ] }, 2 )
        If nPos != 0
          nInd := nPos
        EndIf
      EndIf
      nInd := If ( nInd < 2, Len ( aMenu ), nInd )
      nInd := If ( nInd > Len ( aMenu ), 2, nInd )
    End
    SetCursor ( nCursor )
Return ( nRet )


Static Function EditWin ( nPos, aOps, cColor1, cColor2, cColor3, cColor4, cColor5, nLong, aMenu ,vInit)
Local cPanta
Local nMax   := 0
Local cColor := SetColor ( cColor1 + "," + cColor2 + ", , ," + cColor1 )
Local nRet   := 0
Local aArrO  := {}
Local aArrL  := {}
Local nInd   := 0
Local nCol   := 0
Local aOpts  := {}
Local nMsg   := Set ( _SET_MESSAGE )
Local lMsg   := Set ( _SET_MCENTER )
Local nAnt   := 0
Local nKey   := 0
Local nAux   := 0
Local nSub   := 0
Local Ropc   := 0
Local nY1, nX1, nY2, nX2
    If ! Empty ( aOps )
      aEval ( aOps, { | aM | nMax := Max ( nMax, Len ( aM [ 1 ] ) ) } )
      If nPos + nMax + 3 < MaxCol()
        nY1 := 1 
        nX1 := nPos - 1 
        nY2 := Len( aOps ) + 2 
        nX2 := nPos + nMax + 2
        nCol := nPos
      Else
        nY1 := 1 
        nX1 := nPos + nLong - nMax - 3
        nY2 := Len( aOps ) + 2
        nX2 := nPos + nLong
        nCol := nPos + nLong - nMax - 2
      EndIf
      cPanta := SaveScreen( nY1, nX1, nY2 + 1, nX2 + 2 )
      Window( nY1, nX1, nY2, nX2, "", "ÚÄ¿³ÙÄÀ³ ", aMenu[ 1, 10 ], cColor1, .F. )
      nRet := nAnt := 1
      MenosVinit:=0
      For nInd := 1 To Len ( aOps )
        If aOps [ nInd, 2 ] == 0
          @ 1 + nInd, nCol Say Replicate ( "Ä", nMax + 2 )
        ElseIf aOps [ nInd, 2 ] == 1
          WriteStr( PadR ( aOps [ nInd, 1 ], nMax + 1 ), 1 + nInd, nCol, cColor1, cColor4 )
          @ nMsg,     0    Say If( lMsg, PadC( aOps [ nInd, 3 ], 80 ), aOps[ nInd, 3 ] )
          aAdd( aOpts, nInd )
          If aOps[ nInd, 4 ] != Nil
            @ 1 + nInd, nCol + nMax + 1 Say "" Color cColor1
          EndIf
        Else
          WriteStr( PadR ( aOps [ nInd, 1 ], nMax + 1 ), 1 + nInd, nCol, cColor3, cColor3 )
          If aOps[ nInd, 4 ] != Nil
            @ 1 + nInd, nCol + nMax + 1 Say "" Color cColor3
          EndIf
        EndIf
        // aqui para tomar en cuenta la resta de las opciones no habiles
        if VInit>=nInd
           If aOps[ nInd, 2 ] == 2
              MenosVinit++
           EndIf
        endif
      Next
      if len(aOpts)>0
         WriteStr( PadR ( aOps [ aOpts[ nRet ], 1 ], nMax + 1 ), 1 + aOpts[ nRet ], nCol, cColor2, cColor5 )
         @ nMsg, 0 Say If( lMsg, PadC( aOps [ aOpts[ nRet ], 3 ], 80 ), aOps[ aOpts[ nRet ], 3 ] )
      endif
      vInit:=vInit-MenosVinit
      While .T.
        // Corregido posici•n de ventana por WEN Computer Soft
        if vInit>1
           Keyboard Chr(24)
           nKey := FastInkey( 3, .F. )
           vInit--
         else
          nKey := FastInkey( 3, .F. )
        Endif
        // end Corregido posici¢n de ventana 
        if .not. ValidnKey(nKey)
           Loop
        endif
        If nKey == 0
           if len(aOpts)>0
             If aOps[ aOpts[ nRet ], 4 ] != Nil
               nSub := EditSubWin( aOps, aOpts[ nRet ], nCol, nMax, cColor2, aMenu[ 1, 10 ] )
               If nSub < 0
                 nRet := nSub
                 Exit
               ElseIf nSub > 0
                 Keyboard( Chr( K_RETURN ) )
               EndIf
             Else
               nKey := FastInkey( 0, .F. )
             EndIf
            Else
             loop
           endif
        EndIf
        If nKey == K_ESC
          nRet := 0
          Exit
        ElseIf nKey == K_LEFT
          nRet := -2
          Exit
        ElseIf nKey == K_RIGHT
          nRet := -1
          Exit
        ElseIf nKey == K_PGUP .Or. nKey == K_HOME
          nRet := 1
        ElseIf nKey == K_PGDN .Or. nKey == K_END
          nRet := Len( aOpts )
        ElseIf nKey == K_UP
          nRet := If( nRet > 1, nRet - 1, Len( aOpts ) )
        ElseIf nKey == K_DOWN
          nRet := If( nRet < Len( aOpts ), nRet + 1, 1 )
        ElseIf ( nAux := aScan ( nStTecla, { | aX | nKey == aX [ 1 ] } ) ) != 0
          nAux := aScan ( aMenu, { | aX | aX [ 4 ] == nStTecla [ nAux, 2 ] }, 2 )
          If nAux != 0
            nRet := -3
            Exit
          EndIf
        ElseIf ( nAux := ReadStr( aOps, aOpts, Chr( nKey ) ) ) != 0
          nRet := nAux
          Keyboard( Chr( K_RETURN ) )
        ElseIf nKey == K_RETURN .and. len(aOpts)>0 
          If aOps[ aOpts[ nRet ], 4 ] != Nil .And. nSub == 0
            nSub := EditSubWin( aOps, aOpts[ nRet ], nCol, nMax, cColor2, aMenu[ 1, 10 ] )
            If nSub < 0
              nRet := nSub
              Exit
            ElseIf nSub > 0
              Keyboard( Chr( K_RETURN ) )
            EndIf
          Else
            Exit
          EndIf
        EndIf
        if vInit<=1
           if len(aOpts)>0 
              WriteStr( PadR ( aOps [ aOpts[ nAnt ], 1 ], nMax + 1 ), 1 + aOpts[ nAnt ], nCol, cColor1, cColor4 )
              WriteStr( PadR ( aOps [ aOpts[ nRet ], 1 ], nMax + 1 ), 1 + aOpts[ nRet ], nCol, cColor2, cColor5 )
              @ nMsg, 0 Say If( lMsg, PadC( aOps [ aOpts[ nRet ], 3 ], 80 ), aOps[ aOpts[ nRet ], 3 ] )
           endif
           nAnt := nRet
        endif
      End
    EndIf
    If nRet > 0
       Ropc   := nAnt
    endif
    if nRet > 0
      nAnt := nRet
      For nInd := 1 To Min( Len( aOps ), nAnt )
        If aOps [ nInd, 2 ] == 2
          nRet++
        EndIf
      Next
    EndIf
    RestScreen ( nY1, nX1, nY2 + 1, nX2 + 2, cPanta )
    SetColor ( cColor )
    If Ropc > 0
       vInit:= vInit - Ropc
       nRet:= aOpts[Ropc]    
    endif
Return( { nRet, nSub } )


Static Function WriteStr( cCadena, nPosY, nPosX, cColor1, cColor2 )
Local nPos := At( "^", cCadena )
Local cStr
    If nPos == 0
      @ nPosY, nPosX Say cCadena Color cColor1
    Else
      cStr := SubStr( cCadena, 1, nPos - 1 ) + SubStr( cCadena, nPos + 1 )
      @ nPosY, nPosX Say cStr Color cColor1
      @ nPosY, nPosX + nPos - 1 Say SubStr( cCadena, nPos + 1, 1 ) Color cColor2
    EndIf
Return( Nil )


Static Function ReadStr( aCadena, aArray, cKey )
Local nPos
Local nInd
Local nRet := 0
    For nInd := 1 To Len( aArray )
      nPos := At( "^", aCadena[ aArray[ nInd ], 1 ] )
      If nPos != 0 .And. Upper( SubStr( aCadena[ aArray[ nInd ], 1 ], nPos + 1, 1 ) ) == Upper( cKey )
        nRet := nInd
        Exit
      EndIf
    Next
Return( nRet )


Static Function EditSubWin( aOps, nOpt, nPos, nMax, cColor, lShadow )
Local cPan
Local nInd
Local nTamY := Len( aOps[ nOpt, 4 ] )
Local nTam  := 0
Local nAct  := 1
Local nOld  := 1
Local lMore := .T.
Local nKey  := 0
Local nRet  := 1
Local nCol
Local nY1, nX1, nY2, nX2
    aEval( aOps[ nOpt, 4 ], { | cS | nTam := Max( nTam, Len( cS ) ) } )
    If nPos + nMax + nTam + 5 < MaxCol()
      nCol  := nPos + nMax + 3
    Else
      nCol  := nPos - nTam - 5
    EndIf
    nY1   := 1 + nOpt 
    nX1   := nCol
    nY2   := 1 + nOpt + nTamY + 1
    nX2   := nCol + nTam + 3
    cPan  := SaveScreen( nY1, nX1, nY2 + 1, nX2 + 2 )
    Window( nY1, nX1, nY2, nX2, "", "ÚÄ¿³ÙÄÀ³ ", lShadow, , .F. )
    For nInd := 1 To nTamY
      @ 1 + nOpt + nInd, nCol + 2 Say aOps[ nOpt, 4, nInd ]
    Next
    While lMore
      @ 1 + nOpt + nOld, nCol + 2 Say PadR( aOps[ nOpt, 4, nOld ], nTam )
      @ 1 + nOpt + nAct, nCol + 2 Say PadR( aOps[ nOpt, 4, nAct ], nTam ) Color cColor
      nOld := nAct
      nKey := FastInkey( 0, .F. )
      If nKey == K_PGUP .Or. nKey == K_HOME
        nAct := 1
      ElseIf nKey == K_PGDN .Or. nKey == K_END
        nAct := nTamY
      ElseIf nKey == K_UP
        nAct := If( nAct > 1, nAct - 1, nTamY )
      ElseIf nKey == K_DOWN
        nAct := If( nAct < nTamY, nAct + 1, 1 )
      ElseIf nKey == K_ESC
        nRet  := 0
        lMore := .F.
      ElseIf nKey == K_RETURN
        nRet  := nAct
        lMore := .F.
      EndIf
    End
    RestScreen( nY1, nX1, nY2 + 1, nX2 + 2, cPan )
Return( nRet )

Static Function ValidnKey(nKey)
       Local lReturn:=.f.
        if  nKey== 0      .Or. nKey== K_ESC   .Or. nKey== K_ESC    .Or.;
            nKey== K_LEFT .Or. nKey== K_RIGHT .Or. nKey== K_PGUP   .Or.;
            nKey== K_HOME .Or. nKey== K_PGDN  .Or. nKey== K_END    .Or.;
            nKey== K_UP   .Or. nKey== K_DOWN  .Or. nKey== K_RETURN .Or.;
            ( nAux := aScan ( nStTecla, { | aX | nKey == aX [ 1 ] } ) ) != 0
            lReturn:=.t.
         Endif
Return lReturn