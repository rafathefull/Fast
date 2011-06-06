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


FUNCTION Manager ( cColor, cColorHigh, cMascara )
LOCAL nTop    :=  4
LOCAL nLeft   := 38
LOCAL nBottom := 18
LOCAL nRight  := 75
LOCAL cColour := SetColor ()
LOCAL nCursor := SetCursor ( 0 )
LOCAL nY      := Row ()
LOCAL nX      := Col ()
LOCAL cScr    := SaveScreen ( 0, 0, 24, 79)
LOCAL lReconf := .F.
LOCAL nSubs   := 1
LOCAL k       := 0
LOCAL nLen    := 1
LOCAL aDir
LOCAL b
LOCAL nKey
LOCAL column
LOCAL cWork
LOCAL cNombre

    DEFAULT cMascara   = "*.*"
    DEFAULT cColor     = "N/W,N/BG"
    DEFAULT cColorHigh = "N/BG"

    aDir := aMyDirec ( @nLen, cMascara )
    SetColor ( cColor )
    b := TBrowseNew ( nTop, nLeft, nBottom + 1, nRight )
    Window ( nTop - 2, nLeft - 1, nBottom + 4, nRight + 1, "FILE MANAGER", "赏缓纪群 ", .T., , .F. )
    Window ( nBottom + 2, nLeft - 1, nBottom + 4, nRight + 1, , "掏购纪群 ", .T., , .F. )
    LinAyuda( GiveMsg( MSG_MANA_AYUDA ) )
    b:colSep    := Chr ( 179 )
    b:skipBlock := { | x | k := IIF( Abs ( x ) >= IIF( x >= 0, ;
                        nLen - nSubs, nSubs - 1 ), ;
                        IIF( x >= 0, nLen - nSubs, 1 ;
                        - nSubs ), x ), nSubs += k, k }
    b:goTopBlock    := { || nSubs := 1 }
    b:goBottomBlock := { || nSubs := nLen }
    column := TBColumnNew ( "Name", { || aDir [ nSubs, 1 ] } )
    column:width := 12
    b:addColumn ( column )
    column := TBColumnNew ( "Size", { || aDir [ nSubs, 2 ] } )
    column:width :=  9
    b:addColumn ( column )
    column := TBColumnNew ( "Date", { || aDir [ nSubs, 3 ] } )
    column:width :=  8
    b:addColumn ( column )
    column := TBColumnNew ( "Time", { || aDir [ nSubs, 4 ] } )
    column:width :=  8
    b:addColumn ( column )
    b:freeze := 3
    WHILE .T.
      b:colorRect ( { b:rowPos, 1, b:rowPos, b:colCount }, { 1, 1 } )
      WHILE ! B:stabilize ()
      END
      IF b:stable ()
        b:colorRect ( { b:rowPos, 1, b:rowPos, b:colCount }, { 2, 2 } )
        @ 21, nLeft      Say Eval ( b:getColumn(1):block )
        @ 21, nLeft + 13 Say Eval ( b:getColumn(2):block )
        @ 21, nLeft + 23 Say Eval ( b:getColumn(3):block )
        @ 21, nLeft + 32 Say Eval ( b:getColumn(4):block )
        nKey := FastInkey( 0 )
        IF ! lMovIt ( nKey, b )
          IF nKey == K_ESC
            IF BoxQuery ( GiveMsg( MSG_MANA_SALIR ) )
              SetCursor ( nCursor )
              SetColor ( cColour )
              RestScreen ( 0, 0, 24, 79, cScr )
              SetPos ( nY, nX )
              Exit
            ENDIF
          ELSEIF nKey == K_RETURN
            cWork := Eval( (b:getColumn(2)):block )
            IF ( cWork == "UP--DIR" )
              DirChange( ".." )
              lReconf := .T.
            ELSEIF ( cWork == "SUB-DIR" )
              cWork := cUnPad( b )
              DirChange( cWork )
              lReconf := .T.
            ENDIF
          ELSEIF nKey == K_F5 .And. ! (Chr(17) $ Eval((b:getColumn(2)):block))
            cNombre := cPickBox ( { GiveMsg( MSG_MANA_COPY ), ;
                                    GiveMsg( MSG_MANA_COPY ), ;
                                    cUnPad ( b ), ;
                                    GiveMsg( MSG_MANA_COPY ), ;
                                    GiveMsg( MSG_MANA_CANCEL ) }, ;
                                    cColor, cColorHigh )
            IF ! Empty ( cNombre )
              cNombre := StrTran( cNombre + "\", "\\", "\" )
              COPY FILE ( cUnPad ( b ) ) TO ( cNombre + cUnPad( b ) )
              lReconf := .T.
            ENDIF
          ELSEIF nKey == K_F6 .And. ! (Chr(17) $ Eval((b:getColumn(2)):block))
            cNombre := cPickBox ( { GiveMsg( MSG_MANA_RENAME ), ;
                                    GiveMsg( MSG_MANA_RENAME ), ;
                                    cUnPad ( b ), ;
                                    GiveMsg( MSG_MANA_RENAME ), ;
                                    GiveMsg( MSG_MANA_CANCEL ) }, ;
                                  cColor, cColorHigh )
            IF ! Empty ( cNombre )
              lReconf := ( Frename ( cUnPad ( b ), cNombre ) == 0 )
            ENDIF
          ELSEIF nKey == K_F8 .And. ! (Chr(17) $ Eval((b:getColumn(2)):block))
            IF BoxQuery ( GiveMsg( MSG_MANA_DELETE, { cUnPad ( b ) } ) )
              lReconf := ( Ferase ( cUnPad ( b ) ) == 0 )
            ENDIF
          ENDIF
        ENDIF
        IF lReconf
          lReconf := .F.
          aDir := aMyDirec ( @nLen, cMascara )
          b:goTop()
          b:configure()
          b:refreshAll()
        ENDIF
      ENDIF
    END

RETURN NIL


STATIC FUNCTION cUnPad ( bObj )
LOCAL cVal := Eval( ( bObj:getColumn( 1 ) ):block )
LOCAL cExt := AllTrim ( SubStr ( cVal, 10, 3 ) )
    cVal := AllTrim ( SubStr ( cVal, 1, 8 ) ) + IIF( Empty ( cExt ), "", "." + cExt )
RETURN ( cVal )


STATIC FUNCTION uPadIt ( aArray, nArrLen )
LOCAL nPos, nALen, nNewALen, cTemp
LOCAL i := 1
    WHILE i <= Len ( aArray )
      IF ( "D" $ aArray [ i, 5 ] )
        IF ( aArray [ i, 1 ] == "." )
          Adel ( aArray, i )
          aArray := Asize ( aArray, Len ( aArray ) - 1 )
          Loop
        ELSEIF ( aArray [ i, 1 ] == ".." )
          aArray [ i, 1 ] := PadR ( aArray [i, 1 ], 12 )
          aArray [ i, 2 ] := Chr ( 16 ) + "UP--DIR" + Chr ( 17 )
        Else
          aArray [i, 2 ] := Chr ( 16 ) + "SUB-DIR" + Chr ( 17 )
          nPos := AT ( ".",aArray [i, 1 ] )
          IF nPos != 0
            aArray [ i, 1 ] := PadR ( SubStr ( aArray [ i, 1 ], 1, nPos - 1 ), 9 ) +;
                               PadR ( SubStr ( aArray [ i, 1 ], nPos + 1, 3 ), 3 )
          Else
            aArray [ i, 1 ] := PadR ( aArray [ i, 1 ], 12 )
          ENDIF
        ENDIF
      Else
        nPos := AT ( ".",aArray [ i, 1 ] )
        IF nPos != 0
          aArray [ i, 1 ] := PadR ( SubStr ( aArray [ i, 1 ], 1, nPos - 1 ), 9 ) +;
                             PadR ( SubStr ( aArray [ i, 1 ], nPos + 1, 3 ), 3 )
        Else
          aArray [ i, 1 ] := PadR ( aArray [ i, 1 ], 12 )
        ENDIF
        aArray [ i, 1 ] := Lower ( aArray [ i, 1] )
        aArray [ i, 2 ] := Str ( aArray [ i, 2 ], 9 )
      ENDIF
      aArray [ i, 4 ] := SubStr ( aArray [ i, 4 ], 1, 5 )
      cTemp := Val ( SubStr ( aArray [ i, 4 ], 1, 2 ) )
      aArray [ i, 4 ] += IIF( cTemp >= 12 .And. cTemp <= 23, "p", "a" )
      cTemp := IIF( cTemp > 12, cTemp % 12, cTemp )
      cTemp := Str ( cTemp, 2, 0 )
      aArray [ i, 4 ] := cTemp + SubStr ( aArray [ i, 4 ], 3, 4 )
      i++
    END
    nArrLen := Len ( aArray )
RETURN NIL


STATIC FUNCTION aMyDirec ( nLen, cMascara )
LOCAL nStartAt := 1, aDir
    aDir := Directory ( cMascara, "HSD" )
    nLen := Len ( aDir )
    aSort ( aDir, , , { | x, y | x[5] == "D" } )
    aEval ( aDir, { | x, i | nStartAt := IIF( "D" $ x[5], i, nStartAt ) } )
    aSort ( aDir,1, nStartAt, { | x, y | x[1] < y[1] } )
    nStartAt++
    aSort ( aDir, nStartAt, , { | x, y | x[1] < y[1] } )
    uPadIt ( aDir, @nLen )
RETURN ( aDir )


STATIC FUNCTION lMovIt ( nKey, oObj )
LOCAL nFound, aKeys := { K_DOWN      , { |b| b:down()     }, ;
                         K_UP        , { |b| b:up()       }, ;
                         K_PGDN      , { |b| b:pageDown() }, ;
                         K_PGUP      , { |b| b:pageUp()   }, ;
                         K_CTRL_PGUP , { |b| b:goTop()    }, ;
                         K_CTRL_PGDN , { |b| b:goBottom() }, ;
                         K_HOME      , { |b| b:home()     }, ;
                         K_END       , { |b| b:end()      }, ;
                         K_CTRL_HOME , { |b| b:panHome()  }, ;
                         K_CTRL_END  , { |b| b:panEnd()   } }
    nFound := ASCAN ( aKeys, nKey )
    IF ( nFound != 0 )
      Eval ( aKeys [ ++nFound ], oObj )
    ENDIF
RETURN ( nFound != 0 )


STATIC FUNCTION cPickBox ( aOpt, cColor, cColorHigh )
LOCAL nLeft, nRight, nOpt, cPath, cScr, cLin, GetList := {}, nCursor
    cLin := SaveScreen( MaxRow(), 0, MaxRow(), MaxCol() )
    LinAyuda ( GiveMsg( MSG_PICK_AYUDA ) )
    nOpt    := 1
    nLeft   := 5
    nRight  := 74
    cScr := SaveScreen( 5, nLeft, 12, nRight + 2 )
    Window ( 5, nLeft, 11, nRight, aOpt [ 1 ], "赏缓纪群 ", .T., , .F. )
    @ 7, 8 Say aOpt[2] + " " + aOpt[3] + GiveMsg( MSG_PICK_HACIA )
    cPath := SPACE ( 64 )
    nCursor := SetCursor( 1 )
    @ 8, 8 Get cPath Picture "@!"
    Read
    cPath := AllTrim( cPath )
    SetCursor( nCursor )
    IF LastKey() == K_ESC .or. ! Updated ()
      nOpt := 2
    ENDIF
    nOpt := nBotones ( aOpt[4], aOpt[5], 10, nOpt, cColor, cColorHigh )
    RestScreen( MaxRow(), 0, MaxRow(), MaxCol(), cLin )
    RestScreen( 5, nLeft, 12, nRight + 2, cScr )
RETURN ( IIF( nOpt == 1, cPath, "" ) )


STATIC FUNCTION nBotones ( cBoton1, cBoton2, Fila, nDefecto, cColor, cColorHigh )
LOCAL nBoton1
LOCAL nBoton2
LOCAL cEstado := SaveScreen( MaxRow(), 0, MaxRow(), MaxCol() )
LOCAL nPos    := IIF( nDefecto == Nil, 1, nDefecto )
LOCAL nTecla  := 0
    LinAyuda( GiveMsg( MSG_BUTO_AYUDA ) )
    cBoton1 := " " + cBoton1 + " "
    nBoton1 := 38 - Len ( cBoton1 )
    cBoton2 := " " + cBoton2 + " "
    nBoton2 := 40
    WHILE ( nTecla != K_ESC .And. nTecla != K_RETURN )
      IF nTecla == K_RIGHT
        nPos := 2
      ELSEIF nTecla == K_LEFT
        nPos := 1
      ENDIF
      @ Fila, nBoton1 Say cBoton1 Color IIF( nPos == 1, cColorHigh, cColor )
      @ Fila, nBoton2 Say cBoton2 Color IIF( nPos == 2, cColorHigh, cColor )
      nTecla := FastInkey( 0 )
    END
    IF LastKey () == K_ESC
      nPos := 2
    ENDIF
    RestScreen( MaxRow(), 0, MaxRow(), MaxCol(), cEstado )
RETURN ( nPos )



