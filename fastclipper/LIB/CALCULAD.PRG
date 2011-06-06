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
#include "\libs\clipapi\version.ch"

FAST_VERSION


#define CERO            "0"
#define VACIO           0
#define SUMAR           1
#define RESTAR          2
#define MULTIPLICAR     3
#define DIVIDIR         4
#define PORCIENTO       5

Function Calculator ( cColor, cColorNum, cColorMem )
Local cOp1       := CERO
Local cOp2       := CERO
Local cMem       := CERO
Local nModo      := VACIO
Local nTecla     := 0
Local cDisplay   := CERO
Local cScan      := CERO
Local nCursor    := SetCursor ( 1 )
Local nY         := 9
Local nX         := 53
Local lBandera   := .T.
Local nYOld      := Row ()
Local nXOld      := Col ()
Local cCalcuPant := cPantaCalcu ( nY, nX, cColor, cColorNum )
Local nDecimales := Set ( _SET_DECIMALS, 2 )
Local aOpera     := { PadR ( "Fast Calc", 21 ), PadR ( "Calc On", 21 ), Space ( 21 ) }
    cScan := Upper ( Chr ( nTecla := InKey () ) )
    While nTecla != K_ESC .And. nTecla != K_F10
      If ( nTecla == K_PGUP )
        lBandera := .T.
        RestScreen ( nY, nX, nY + 15, nX + 26, cCalcuPant )
        nY := 0
        nX := 0
        cCalcuPant := cPantaCalcu ( nY, nX, cColor, cColorNum  )
      ElseIf ( nTecla == K_PGDN )
        lBandera := .T.
        RestScreen ( nY, nX, nY + 15, nX + 26, cCalcuPant )
        nY := 10
        nX := 55
        cCalcuPant := cPantaCalcu ( nY, nX, cColor, cColorNum  )
      ElseIf ( nTecla == K_UP )
        If nY > 0
          lBandera := .T.
          RestScreen ( nY, nX, nY + 15, nX + 26, cCalcuPant )
          nY --
          cCalcuPant := cPantaCalcu ( nY, nX, cColor, cColorNum  )
        EndIf
      ElseIf ( nTecla == K_DOWN )
        If nY < MaxRow() - 14
          lBandera := .T.
          RestScreen ( nY, nX, nY + 15, nX + 26, cCalcuPant )
          nY ++
          cCalcuPant := cPantaCalcu ( nY, nX, cColor, cColorNum  )
        EndIf
      ElseIf ( nTecla == K_LEFT )
        If nX > 0
          lBandera := .T.
          RestScreen ( nY, nX, nY + 15, nX + 26, cCalcuPant )
          nX --
          cCalcuPant := cPantaCalcu ( nY, nX, cColor, cColorNum  )
        EndIf
      ElseIf ( nTecla == K_RIGHT )
        If nX < MaxCol() - 24
          lBandera := .T.
          RestScreen ( nY, nX, nY + 15, nX + 26, cCalcuPant )
          nX ++
          cCalcuPant := cPantaCalcu ( nY, nX, cColor, cColorNum  )
        EndIf
      ElseIf ( cScan == "A" )
        nTecla := FastInkey( 0 )
        cScan := Upper ( Chr ( nTecla ) )
        If cScan == "C"
          lBandera := .T.
          If nModo == VACIO
            cOp1 := CERO
          Else
            cOp2 := CERO
          EndIf
        Else
          KEYBOARD ( cScan )
        EndIf
      ElseIf ( cScan == "C" )
        lBandera := .T.
        aOpera [ 1 ] := ""
        aOpera [ 2 ] := ""
        aOpera [ 3 ] := ""
        cOp1 := cOp2 := CERO
        nModo := VACIO
        Keyboard ( Chr ( K_RETURN ) )
      ElseIf ( cScan == "M" )
        nTecla := FastInkey( 0 )
        cScan := Upper ( Chr ( nTecla ) )
        If cScan == "+"
          lBandera := .T.
          If nModo == VACIO
            cMem := AllTrim ( Str ( Val ( cMem ) + Val ( cOp1 ) ) )
          Else
            cMem := AllTrim ( Str ( Val ( cMem ) + Val ( cOp2 ) ) )
          EndIf
        ElseIf cScan == "-"
          lBandera := .T.
          If nModo == VACIO
            cMem := AllTrim ( Str ( Val ( cMem ) - Val ( cOp1 ) ) )
          Else
            cMem := AllTrim ( Str ( Val ( cMem ) - Val ( cOp2 ) ) )
          EndIf
        ElseIf cScan == "*"
          lBandera := .T.
          If nModo == VACIO
            cMem := AllTrim ( Str ( Val ( cMem ) * Val ( cOp1 ) ) )
          Else
            cMem := AllTrim ( Str ( Val ( cMem ) * Val ( cOp2 ) ) )
          EndIf
        ElseIf cScan == "/"
          If nModo == VACIO
            If Val ( cOp1 ) != 0
              lBandera := .T.
              cMem := AllTrim ( Str ( Val ( cMem ) / Val ( cOp1 ) ) ) 
            EndIf
          Else
            If Val ( cOp2 ) != 0 
              lBandera := .T.
              cMem := AllTrim ( Str ( Val ( cMem ) / Val ( cOp2 ) ) )
            EndIf
          EndIf
        ElseIf cScan == "R"
          lBandera := .T.
          If nModo == VACIO
            cOp1 := cMem 
          Else
            cOp2 := cMem 
          EndIf
        ElseIf cScan == "C"
          lBandera := .T.
          cMem := CERO
        Else
          KEYBOARD ( cScan )
        EndIf
      ElseIf ( cScan == "+" )
        If nModo != VACIO
          KEYBOARD ( Chr ( K_RETURN ) + cScan )
        Else
          lBandera := .T.
          nModo := SUMAR
          aOpera [1] := aOpera[3]
          aOpera [2] := PadR ( "+", 21 )
        EndIf
      ElseIf ( cScan == "-" )
        If nModo != VACIO
          KEYBOARD ( Chr ( K_RETURN ) + cScan )
        Else
          lBandera := .T.
          nModo := RESTAR
          aOpera [1] := aOpera[3]
          aOpera [2] := PadR ( "-", 21 )
        EndIf
      ElseIf ( cScan == "*" )
        If nModo != VACIO
          KEYBOARD ( Chr ( K_RETURN ) + cScan )
        Else
          lBandera := .T.
          nModo := MULTIPLICAR
          aOpera [1] := aOpera[3]
          aOpera [2] := PadR ( "*", 21 )
        EndIf
      ElseIf ( cScan == "/" )
        If nModo != VACIO
          KEYBOARD ( Chr ( K_RETURN ) + cScan )
        Else
          lBandera := .T.
          nModo := DIVIDIR
          aOpera [1] := aOpera[3]
          aOpera [2] := PadR ( "/", 21 )
        EndIf
      ElseIf ( cScan == "%" )
        If nModo != VACIO
          KEYBOARD ( Chr ( K_RETURN ) + cScan )
        Else
          lBandera := .T.
          nModo := PORCIENTO
          aOpera [1] := aOpera[3]
          aOpera [2] := PadR ( "%", 21 )
        EndIf
      ElseIf ( nTecla == K_BS )
        If ( nModo == VACIO ) 
          lBandera := .T.
          cOp1 := SubStr ( cOp1, 1, Len ( cOp1 ) - 1 )
          If Len ( cOp1 ) == 0
            cOp1 := CERO
          EndIf
        Else
          lBandera := .T.
          cOp2 := SubStr ( cOp2, 1, Len ( cOp2 ) - 1 )
          If Len ( cOp2 ) == 0
            cOp2 := CERO
          EndIf
        EndIf
      ElseIf ( cScan == "." )
        If ( nModo == VACIO )
          If AT ( ".", cOp1 ) == 0
            lBandera := .T.
            cOp1 += cScan
          EndIf
        Else
          If AT ( ".", cOp2 ) == 0
            lBandera := .T.
            cOp2 += cScan
          EndIf
        EndIf
      ElseIf ( cScan >= CERO .And. cScan <= "9" ) 
        If ( nModo == VACIO ) 
          If Val ( cOp1 ) == 0 .And. Len ( cOp1 ) == 1
            If cScan != CERO
              lBandera := .T.
              cOp1 := cScan
            EndIf
          ElseIf Len ( cOp1 ) < 14
            lBandera := .T.
            cOp1 += cScan
          EndIf
        Else
          If Val ( cOp2 ) == 0 .And. Len ( cOp2 ) == 1
            If cScan != CERO
              lBandera := .T.
              cOp2 := cScan
            EndIf
          ElseIf Len ( cOp2 ) < 14
            lBandera := .T.
            cOp2 += cScan
          EndIf
        EndIf
      ElseIf ( nTecla == K_RETURN )
        If ! Empty ( cOp2 ) 
          lBandera := .T.
          If ( nModo == SUMAR )
            cOp1 := Str ( Val ( cOp1 ) + Val ( cOp2 ) ) 
          ElseIf ( nModo == RESTAR )
            cOp1 := Str ( Val ( cOp1 ) - Val ( cOp2 ) ) 
          ElseIf ( nModo == MULTIPLICAR )
            cOp1 := Str ( Val ( cOp1 ) * Val ( cOp2 ) ) 
          ElseIf ( nModo == DIVIDIR )
            cOp1 := Str ( Val ( cOp1 ) / Val ( cOp2 ) ) 
          ElseIf ( nModo == PORCIENTO )
            cOp1 := Str ( Val ( cOp1 ) * Val ( cOp2 ) / 100 ) 
          EndIf
          aOpera [1] := aOpera[3]
          aOpera [2] := PadR ( "=", 21 )
          nModo := VACIO
          cOp2 := CERO
        EndIf
      EndIf
      cOp1 := AllTrim ( cOp1 )
      cOp2 := AllTrim ( cOp2 )
      If nModo == VACIO    
        If ( Len ( cOp1 ) > 15 )
          cDisplay := PadL ( "Error", 21 )
        Else
          cDisplay := PADL ( cOp1, 21 )
        EndIf
      Else                  
        cDisplay := PADL ( cOp2, 21 )
      EndIf
      If lBandera == .T.
        aOpera[3] := cDisplay
        @ nY + 1, nX + 2 Say aOpera[1] Color cColorNum
        @ nY + 2, nX + 2 Say aOpera[2] Color cColorNum
        @ nY + 3, nX + 2 Say aOpera[3] Color cColorNum
        If Val ( cMem ) != 0 
          @ nY + 3, nX + 2 Say "M" Color cColorMem
        Else
          @ nY + 3, nX + 2 Say " " Color cColorMem
        EndIf  
        lBandera := .F.
      EndIf
      If cDisplay == PadL ( "Error", 21 )
        cDisplay := cOp1 := cOp2 := CERO
        nModo := VACIO
      EndIf
      SetPos ( nY + 3, nX + 22 )
      nTecla := FastInkey( 0 )
      cScan := Upper ( Chr ( nTecla ) )
    End
    SET ( _SET_DECIMALS, nDecimales )
    RestScreen ( nY, nX, nY + 15, nX + 26, cCalcuPant )
    SetCursor ( nCursor )
    SetPos ( nYOld, nXOld )
Return ( If( Lastkey () == K_ESC, Nil, Val( cDisplay ) ) )


Static Function cPantaCalcu ( nY, nX, cColor, cColorNum )
Local cPantalla
    DispBegin()
    cPantalla := SaveScreen ( nY, nX, nY + 15, nX + 26 )
    @ nY,      nX Say "иммммммммммммммммммммммм╩" Color cColor
    @ nY +  1, nX Say "╨                       ╨" Color cColor
    @ nY +  2, nX Say "╨                       ╨" Color cColor
    @ nY +  3, nX Say "╨                       ╨" Color cColor
    @ nY +  4, nX Say "лмммямммямммямммямммяммм╧" Color cColor
    @ nY +  5, nX Say "╨ % Ё / Ё * Ё - Ё C Ё AC╨" Color cColor
    @ nY +  6, nX Say "гдддедддедддедддедддеддд╤" Color cColor
    @ nY +  7, nX Say "╨ 7 Ё 8 Ё 9 Ё   Ё M+Ё MR╨" Color cColor
    @ nY +  8, nX Say "гдддедддеддд╢ + цдддеддд╤" Color cColor
    @ nY +  9, nX Say "╨ 4 Ё 5 Ё 6 Ё   Ё M-Ё MC╨" Color cColor
    @ nY + 10, nX Say "гдддедддедддедддедддеддд╤" Color cColor
    @ nY + 11, nX Say "╨ 1 Ё 2 Ё 3 Ё   Ё M*ЁEsc╨" Color cColor
    @ nY + 12, nX Say "гдддадддеддд╢ <ыцдддеддд╤" Color cColor
    @ nY + 13, nX Say "╨   0   Ё . Ё   Ё M/ЁF10╨" Color cColor
    @ nY + 14, nX Say "хмммммммомммомммомммоммм╪" Color cColor
    @ nY + 1,  nX + 1 Say "                       " Color cColorNum
    @ nY + 2,  nX + 1 Say "                       " Color cColorNum
    @ nY + 3,  nX + 1 Say "                       " Color cColorNum
    DispEnd()
Return ( cPantalla )



