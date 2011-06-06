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
#include "fast.ch"
#include "\libs\clipapi\version.ch"

FAST_VERSION


Function Calendar ( BaseY, BaseX, cColor, cFestivo, cColorHigh )
Local dFecha
Local nTecla, nCursor, cPantalla, nJuliano, nTipoano, nTipodia, ;
      nX, nY, nNumdias, nInd, nMesFecha, nAnoFecha, ;
      lEstable, lEstableD, GetList := {}, ;
      nPosX, nPosY, nEleg, cCadena, nElegX, nElegY, cFormato, ;
      anDias := { 1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335 }

    DEFAULT BaseY       = 5
    DEFAULT BaseX      = 20
    DEFAULT cColor     = "N/BG"
    DEFAULT cFestivo   = "R/BG"
    DEFAULT cColorHigh = "R+/B"

    nX        := Col ()
    nY        := Row ()
    cPantalla := SaveScreen ( BaseY, BaseX, BaseY + 12, BaseX + 41 )
    nCursor   := SetCursor ( 0 )
    dFecha    := Date ()
    nMesFecha := Month ( dFecha )
    nAnoFecha := Year ( dFecha )
    nEleg     := Day ( dFecha )
    lEstable  := .F.
    lEstableD := .T.
    While nTecla != K_RETURN .And. nTecla != K_ESC
      if ! lEstable
        If lEstableD
          Window ( BaseY, BaseX, BaseY + 11, BaseX + 39, ;
                   cGetMonth ( nMesFecha ) + Str ( nAnoFecha, 5 ), ;
                   "ÉÍ»º¼ÍÈº ", .F., cColor, .F. )
        EndIf
        nJuliano := anDias [ nMesFecha ]
        nJuliano += if ( nAnoFecha % 4 == 0 .And. nMesFecha > 2, 1, 0 )
        nTipodia := if ( nJuliano < 7, nJuliano, nJuliano % 7 )
        nTipoano := if ( nAnoFecha < 28, nAnoFecha, nAnoFecha % 28 )
        if nTipoano == 3  .or. nTipoano == 14 .or. ;
           nTipoano == 20 .or. nTipoano == 25
          nTipodia ++
        Elseif nTipoano == 4  .or. nTipoano == 9  .or. ;
               nTipoano == 15 .or. nTipoano == 26
          nTipodia += 2
        Elseif nTipoano == 10 .or. nTipoano == 16 .or. ;
               nTipoano == 21 .or. nTipoano == 27
          nTipodia += 3
        Elseif nTipoano == 0  .or. nTipoano == 5  .or. ;
               nTipoano == 11 .or. nTipoano == 22
          nTipodia += 4
        Elseif nTipoano == 6  .or. nTipoano == 12 .or. ;
               nTipoano == 17 .or. nTipoano == 23
          nTipodia += 5
        Elseif nTipoano == 1  .or. nTipoano == 7  .or. ;
               nTipoano == 18 .or. nTipoano == 24
          nTipodia += 6
        EndIf
        nTipodia -= if ( nTipodia > 6, 7, 0 )
        nTipodia := if ( nTipodia == 0, 7, nTipodia )
        if nMesFecha ==  2
          nNumdias := 28 + if ( nAnoFecha % 4 == 0, 1, 0 )
        Elseif nMesFecha == 4 .or. nMesFecha == 6 .or. ;
               nMesFecha == 9 .or. nMesFecha == 11
          nNumdias := 30
        Else
          nNumdias := 31
        EndIf
        @ BaseY + 2, BaseX + 7 SAY GiveMsg( MSG_CAL_DIAS )        COLOR cColor
        @ BaseY + 3, BaseX + 6 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" COLOR cColor
        If GiveMsg( MSG_ANGLOSAJON )
          nTipodia++
          nTipodia -= if ( nTipodia > 6, 7, 0 )
          nTipodia := if ( nTipodia == 0, 7, nTipodia )
        EndIf
        nEleg   := if ( nEleg > nNumDias, nNumDias, nEleg )
        nEleg   := if ( nEleg < 1, 1, nEleg )
        nPosX   := ( nTipoDia - 1 ) * 4 + 7 + BaseX
        nPosY   := BaseY + 4
        cCadena := ""
        DispBegin ()
        FOR nInd := 1 TO nNumDias
          if nEleg == nInd
            nElegX := nPosx + Len ( cCadena )
            nElegY := nPosy
          EndIf
          cCadena += Str ( nInd, 2 ) + Space ( 2 )
          IF ( ( nTipoDia + nInd - 1 ) % 7 ) == 0 .OR. nInd == nNumDias
            cCadena := " " + cCadena + " "
            IF GiveMsg( MSG_ANGLOSAJON )
              @ nPosy, nPosx - 1 ;
                SAY SubStr ( cCadena, 1, 5 ) ;
                COLOR IIF( nInd > 7 .OR. nTipoDia % 7 == 1, cFestivo, cColor )
              @ nPosy, nPosx + 3 ;
                SAY SubStr ( cCadena, 5 ) ;
                COLOR cColor
            ELSE
              @ nPosy, nPosx - 1 ;
                SAY SubStr ( cCadena, 1, Len ( cCadena ) - 4 ) ;
                COLOR cColor
              @ nPosy, nPosx + Len ( cCadena ) - 6 ;
                SAY SubStr ( cCadena, Len ( cCadena ) - 4 ) ;
                COLOR IIF( ( nTipoDia + nInd - 1 ) % 7 == 0, cFestivo, cColor )
            ENDIF
            cCadena := ""
            nPosy++
            nPosx := BaseX + 7
          ENDIF
        NEXT
        @ nElegY, nElegX - 1 ;
            SAY " " + STR( nEleg, 2 ) + " " ;
            COLOR cColorHigh
        DispEnd ()
        lEstable  := .T.
        lEstableD := .T.
      EndIf
      nTecla := FastInkey( 0 )
      If nTecla == K_HOME
        nEleg     := 1
        lEstableD := .F.
        lEstable  := .F.
      ElseIf nTecla == K_END
        nEleg     := nNumDias
        lEstableD := .F.
        lEstable  := .F.
      ElseIf nTecla == K_CTRL_HOME
        nEleg     := 1
        nMesFecha := 1
        lEstable  := .F.
      ElseIf nTecla == K_CTRL_END
        nEleg     := nNumDias
        nMesFecha := 12
        lEstable  := .F.
      ElseIf nTecla == K_RIGHT
        nEleg ++
        if nEleg > nNumdias
          nEleg := 1
          nMesFecha ++
          if nMesFecha > 12
            nMesFecha := 1
            nAnoFecha ++
          EndIf
        Else
          lEstableD := .F.
        EndIf
        lEstable := .F.
     Elseif nTecla == K_LEFT
        nEleg --
        if nEleg < 1
          nEleg := 32
          nMesFecha --
          if nMesFecha < 1
            nMesFecha := 12
            nAnoFecha --
          EndIf
        Else  
          lEstableD := .F.
        EndIf
        lEstable := .F.
      ElseIf nTecla == K_DOWN
        nEleg += 7
        if nEleg > nNumdias
          nEleg -= nNumdias
          nMesFecha ++
          if nMesFecha > 12
            nMesFecha := 1
            nAnoFecha ++
          EndIf
        Else
          lEstableD := .F.
        EndIf
        lEstable := .F.
     Elseif nTecla == K_UP
        nEleg -= 7
        if nEleg < 1
          nEleg := 31 + nEleg
          nMesFecha --
          if nMesFecha < 1
            nMesFecha := 12
            nAnoFecha --
          EndIf
        Else  
          lEstableD := .F.
        EndIf
        lEstable := .F.
     Elseif nTecla == K_PGDN
        nMesFecha ++
        if nMesFecha > 12
          nMesFecha := 1
          nAnoFecha ++
        EndIf
        lEstable := .F.
      Elseif nTecla == K_PGUP
        nMesFecha --
        if nMesFecha < 1
          nMesFecha := 12
          nAnoFecha --
        EndIf
        lEstable := .F.
      Elseif nTecla == K_CTRL_PGUP
        nAnoFecha --
        lEstable := .F.
      Elseif nTecla == K_CTRL_PGDN
        nAnoFecha ++
        lEstable := .F.
      EndIf
    End
    RestScreen ( BaseY, BaseX, BaseY + 12, BaseX + 41, cPantalla )
    SetCursor ( nCursor )
    SetPos ( nY, nX )
    If nTecla != K_ESC
      cFormato := Set( _SET_DATEFORMAT, "DD/MM/YYYY" )
      dFecha := cTod ( Transform ( nEleg, "99" )     + "/" + ;
                       Transform ( nMesFecha, "99" ) + "/" + ;
                       Transform ( nAnoFecha, "9999" ) )
      Set( _SET_DATEFORMAT, cFormato )
    Else
      dFecha := Nil
    EndIf
Return( dFecha )



