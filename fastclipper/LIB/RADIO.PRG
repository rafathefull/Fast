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
#include "getexit.ch"
#include "\libs\clipapi\version.ch"

FAST_VERSION


#define HORIZSPACING 6
#define K_SPACEBAR 32

STATIC aAllButtons := {}

FUNCTION RadioNew( oGet, bWhen, nRow, nCol, cTitle, nChoice, ;
                   aChoices, lNoBox, lDblBox, lHoriz )
LOCAL cColorSpec
LOCAL n
LOCAL nWidth
    IF cTitle == NIL
      cTitle := ""
    ENDIF
    IF nChoice < 1 .or. nChoice > len( aChoices )
      nChoice := 1
    ENDIF
    aadd( aAllButtons, { oGet:Name, aChoices } )
    IF ! lNoBox
      IF lHoriz
        nWidth := 0
        aeval( aChoices, { |c| nWidth += len(c)+HORIZSPACING } )
        nWidth := max( nWidth, len(cTitle)+1 )
        dispbox( nRow, nCol, nRow+2, nCol+nWidth+1, ;
                 IIF( lDblBox, "ÉÍ»º¼ÍÈº ", "ÚÄ¿³ÙÄÀ³ " ), oGet:ColorSpec )
      ELSE
        nWidth := len( aChoices[1] )
        aeval( aChoices, { |c| nWidth := max(nWidth, len(c)) } )
        nWidth := max( nWidth+5, len(cTitle)+1 )
        dispbox( nRow, nCol, nRow+len(aChoices)+1, nCol+nWidth+2, ;
                 IIF( lDblBox, "ÉÍ»º¼ÍÈº ", "ÚÄ¿³ÙÄÀ³ " ),  oGet:ColorSpec )
      ENDIF
    ENDIF
    IF !empty( cTitle )
      IF lNoBox
        @ nRow, nCol say cTitle color oGet:ColorSpec
      ELSE
        @ nRow, nCol+1 say " "+cTitle+" " color oGet:ColorSpec
      ENDIF
    ENDIF
    IF ( bWhen == NIL ) .or. eval( bWhen, oGet )
      cColorSpec := oGet:ColorSpec
    ELSE
      cColorSpec := IIF( (n:=at(",",oGet:ColorSpec)) > 0, ;
                    substr(oGet:ColorSpec,n+1), ;
                    oGet:ColorSpec )
      nChoice := 0
    ENDIF
    DrawRadioButtons( nRow, nCol-IIF(lHoriz .and. lNoBox .and. empty(cTitle), 3, 0), ;
                      aChoices, nChoice, nChoice, cColorSpec, ;
                      lNoBox, lHoriz, empty(cTitle) )
RETURN ( Nil )


STATIC FUNCTION DrawRadioButtons( nRow, nCol, aChoices, nChoice, nCursor, ;
                                  cColorSpec, lNoBox, lHoriz, lNoTitle )
LOCAL nCursorPos := 0
LOCAL nOldCursor := SetCursor ( 0 )
LOCAL nInd
    dispbegin()
    IF lHoriz
      IF lNoBox
        SetPos( nRow + IIF( lNoTitle, 0, 1 ), nCol )
        FOR nInd := 1 TO LEN( aChoices )
          IIF( nInd == nCursor, nCursorPos := col(), )
          DispOut( "(" + ;
                   IIF( nInd == nChoice, "", " " ) + ;
                   ") " + aChoices[ nInd ] +" ", ;
                   cColorSpec )
        NEXT
        SetPos( nRow + IIF( lNoTitle, 0, 1 ), nCursorPos + 1 )
      ELSE
        SetPos( nRow + 1, nCol + 1 )
        aEval( aChoices, { |c,n| setpos(row(), col()), ;
                                 dispout(" ("+ ( IIF( n==nCursor, nCursorPos:=col(), ),;
                                                 IIF( n==nChoice, "", " " );
                                               ) +;
                                         ") "+c+" ", ;
                                         cColorSpec) } )
        setpos( nRow+1, nCursorPos+2 )
      ENDIF
    ELSE
      IF lNoBox
        setpos( nRow-IIF(lNoTitle,1,0), nCol )
        aeval( aChoices, { |c,n| setpos(row()+1, nCol), ;
                                 dispout("("+ ( IIF( n==nCursor, nCursorPos:=row(), ),;
                                                IIF( n==nChoice, "", " " );
                                              ) +;
                                         ") "+c, ;
                                         cColorSpec) } )
        setpos( nCursorPos, nCol+1 )
      ELSE
        setpos( nRow, nCol )
        aeval( aChoices, { |c,n| setpos(row()+1, nCol+2), ;
                                 dispout("("+ ( IIF( n==nCursor, nCursorPos:=row(), ),;
                                                IIF( n==nChoice, "", " " );
                                              ) +;
                                         ") "+c, ;
                                         cColorSpec) } )
        setpos( nCursorPos, nCol+3 )
      ENDIF
    ENDIF
    SetCursor ( nOldCursor )
    dispend()
RETURN ( Nil )


FUNCTION RadioReader( oGet, lNoBox, lHoriz, cTitle )
LOCAL aChoices
LOCAL cGetVar
LOCAL cGreyColor
LOCAL cSavedScreen
LOCAL nChoice
LOCAL nCursor
LOCAL nKey
LOCAL nMaxChoices
LOCAL nOldChoice
LOCAL nOldCursor
LOCAL n, nX, nY
LOCAL bHotKey
    aChoices := aAllButtons[ ascan( aAllButtons, { |a| a[1] == oGet:Name } ), 2 ]
    IF ( GetBoxPreVal( oGet ) )
      n           := 0
      nChoice     := oGet:VarGet()
      nCursor     := nChoice
      nKey        := 0
      nMaxChoices := len( aChoices )
      dispbegin()
      cSavedScreen := savescreen( oGet:row, oGet:col, oGet:row, oGet:col )
      oGet:SetFocus()
      restscreen( oGet:row, oGet:col, oGet:row, oGet:col, cSavedScreen )
      DrawRadioButtons( oGet:Row, oGet:Col, aChoices, nChoice, nCursor, ;
                        oGet:ColorSpec, lNoBox, lHoriz, empty(cTitle) )
      dispend()
      while ( oGet:ExitState == GE_NOEXIT )
        while ( oGet:ExitState == GE_NOEXIT )
          nOldChoice := nChoice
          nOldCursor := nCursor
          nKey       := FastInkey( 0 )
          do CASE
          CASE nKey == K_ESC
            oGet:ExitState := GE_ESCAPE
          CASE nKey == K_SPACEBAR
            IF ! nCursor == nChoice
              nChoice := nCursor
            ELSE
              nCursor := nChoice := IIF( nChoice == nMaxChoices, 1, nChoice+1 )
            ENDIF
          CASE nKey == K_ENTER
            oGet:ExitState := GE_ENTER
          CASE nKey == K_UP
            IF lHoriz
              oGet:exitstate := GE_UP
            ELSE
              IF nCursor == 1
                nCursor := nMaxChoices
              ELSE
                nCursor--
              ENDIF
            ENDIF
          CASE nKey == K_DOWN
            IF lHoriz
              oGet:exitstate := GE_DOWN
            ELSE
              IF nCursor == nMaxChoices
                nCursor := 1
              ELSE
                nCursor++
              ENDIF
            ENDIF
          CASE nKey == K_LEFT
            IF lHoriz
              IF nCursor == 1
                nCursor := nMaxChoices
              ELSE
                nCursor--
              ENDIF
            ENDIF
          CASE nKey == K_RIGHT
            IF lHoriz
              IF nCursor == nMaxChoices
                nCursor := 1
              ELSE
                nCursor++
              ENDIF
            ENDIF
          CASE nKey == K_TAB
            oGet:exitstate := GE_DOWN
          CASE nKey == K_SH_TAB
            oGet:exitstate := GE_UP
          CASE nKey == K_PGUP
            oGet:ExitState := GE_WRITE
          CASE nKey == K_PGDN
            oGet:ExitState := GE_WRITE
          otherwise
            n := ascan( aChoices, ;
                        { |c| upper( left(c,1) ) == upper ( chr(nKey) ) },;
                         nChoice+1, nMaxChoices )
            IF n == 0
              n := ascan( aChoices, ;
                          { |c| upper( left(c,1) ) == upper ( chr(nKey) ) },;
                          1, nChoice - 1 )
            ENDIF
            nCursor := nChoice := IIF( n > 0, n, nChoice )
          ENDCASE
          IF ! nOldChoice == nChoice .or. ! nOldCursor == nCursor
            DrawRadioButtons( oGet:Row, oGet:Col, aChoices, nChoice, nCursor, ;
                              oGet:ColorSpec, lNoBox, lHoriz, empty(cTitle) )
          ENDIF
        END
        oGet:VarPut( nChoice )
        dispbegin()
        nX := Col()
        nY := Row()
        cSavedScreen := savescreen( oGet:row, oGet:col, oGet:row, oGet:col )
        oGet:KillFocus()
        restscreen( oGet:row, oGet:col, oGet:row, oGet:col, cSavedScreen )
        SetPos( nY, nX )
        DispEnd()
        IF oGet:ExitState != GE_ESCAPE
          IF ! GetBoxPostVal( oGet )
            oGet:ExitState := GE_NOEXIT
          ENDIF
        ENDIF
      END
    ELSE
      cGreyColor := IIF( (n:=at(",",oGet:ColorSpec)) > 0, ;
                     substr(oGet:ColorSpec,n+1), ;
                     oGet:ColorSpec )
      DrawRadioButtons( oGet:Row, oGet:Col, aChoices, nChoice, nCursor, ;
                        cGreyColor, lNoBox, lHoriz, empty(cTitle) )
    ENDIF
RETURN ( Nil )


STATIC FUNCTION GetBoxPreVal ( oGet )
LOCAL lWhen := .T.
     IF ( oGet:PreBlock != Nil )
       lWhen := Eval ( oGet:PreBlock, oGet )
     ENDIF
     IF ( ! lWhen )
       oGet:ExitState := GE_WHEN
     ELSE
       oGet:ExitState := GE_NOEXIT
     ENDIF
RETURN ( lWhen )


STATIC FUNCTION GetBoxPostVal( oGet )
LOCAL lValid := .T.
    IF ( oGet:ExitState == GE_ESCAPE )
      RETURN ( .T. )
    ENDIF
    oGet:Assign()
    oGet:Reset()
    IF ( oGet:PostBlock != Nil )
      lValid := Eval( oGet:PostBlock, oGet )
      oGet:UpdateBuffer()
    ENDIF
RETURN ( lValid )


FUNCTION KillButton()
    aAllButtons := {}
RETURN ( Nil )

