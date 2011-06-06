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


#define ES_FILE         1
#define ES_TEXT         2
#define ES_TOP          3
#define ES_LEFT         4
#define ES_BOTTOM       5
#define ES_RIGHT        6
#define ES_WIDTH        7
#define ES_TABSIZE      8
#define ES_SCROLL       9
#define ES_WRAP         10
#define ES_INS          11
#define ES_ROW          12
#define ES_COL          13
#define ES_RELROW       14
#define ES_RELCOL       15
#define ES_CHANGED      16
#define ES_LASTKEY      17
#define ES_PATTERN      18
#define ES_LENGTH       18


static aEdita


FUNCTION EDITOR( cFile, cColorEd, nColumns )
LOCAL nKey
LOCAL lDone   := .F.
LOCAL cScreen := SaveScreen ( 0, 0, MaxRow(), MaxCol() )
LOCAL cColor  := SetColor ()
LOCAL nCursor := SetCursor ( 1 )
LOCAL nX      := Col ()
LOCAL nY      := Row ()
    cFile    := IIF( cFile    == NIL .OR. Empty( cFile ), "NONAME.TXT", cFile )
    cColorEd := IIF( cColorEd == NIL, "W/B", cColorEd )
    nColumns := IIF( nColumns == NIL, 132, nColumns )
    SetColor( cColorEd )
    aEdita                := ARRAY( ES_LENGTH )
    aEdita [ ES_FILE ]    := Lower( cFile )
    aEdita [ ES_TEXT ]    := MemoRead( cFile )
    aEdita [ ES_TOP ]     := 1
    aEdita [ ES_LEFT ]    := 0
    aEdita [ ES_BOTTOM ]  := MaxRow() - 1
    aEdita [ ES_RIGHT ]   := MaxCol()
    aEdita [ ES_WIDTH ]   := nColumns
    aEdita [ ES_TABSIZE ] := 4
    aEdita [ ES_SCROLL ]  := .T.
    aEdita [ ES_WRAP ]    := .F.
    aEdita [ ES_INS ]     := Set ( _SET_INSERT )
    aEdita [ ES_ROW ]     := 1
    aEdita [ ES_COL ]     := 0
    aEdita [ ES_RELROW ]  := 0
    aEdita [ ES_RELCOL ]  := 0
    aEdita [ ES_CHANGED ] := .F.
    aEdita [ ES_LASTKEY ] := 0
    aEdita [ ES_PATTERN ] := ""
    LinAyuda( GiveMsg( MSG_EDIT_AYUDA ) )
    @ 0, 0 Say Space ( 80 ) Color "N/W"
    @ 0, 1 Say GiveMsg( MSG_EDIT_FICHERO ) + aEdita [ ES_FILE ] Color "N/W"
    StatMsg ()
    While ( ! lDone )
      DoEditing ()
      nKey := aEdita [ ES_LASTKEY ]                                    
      Do Case
        Case ( nKey == K_F4 )
          Search ()
        Case ( nKey == K_F5 )
          SearchAgain ()
        Case ( nKey == K_F6 )
          EditWrite ()
          NewName ()
        Case ( nKey == K_F8 )
          EditWrite ()
        Case ( nKey == K_F10 )
          EditWrite ()
          lDone := .T.
      End
    End
    RestScreen ( 0, 0, MaxRow(), MaxCol(), cScreen )
    SetColor ( cColor )
    SetCursor ( nCursor )
    SetPos ( nY, nX )
Return ( Nil )


Static Function DoEditing ()
    aEdita [ ES_WRAP ] := .T.
    aEdita [ ES_TEXT ] := MemoEdit ( aEdita [ ES_TEXT ],   aEdita [ ES_TOP ], ;
                                     aEdita [ ES_LEFT ],   aEdita [ ES_BOTTOM ], ;
                                     aEdita [ ES_RIGHT ],  .T., ;
                                    "UFUNC",               aEdita [ ES_WIDTH ], ;
                                    aEdita [ ES_TABSIZE ], aEdita [ ES_ROW ], ;   
                                    aEdita [ ES_COL ],     aEdita [ ES_RELROW ], ;
                                    aEdita [ ES_RELCOL ] )
Return ( Nil )


Static Function Prompt ( cSay, cGet )
Local GetList  := {}
Local bInsSave := SetKey ( K_INS, { || SetCursor ( If ( Set ( _SET_INSERT, ! Set ( _SET_INSERT ) ), 1, 2 ) ) } )
Local cColor   := SetColor ( "N/W" )
    @ MaxRow(), 0 Say Space ( 80 )
    @ MaxRow(), 1 Say cSay Get cGet Picture "@KS50"
    Read
    SetColor ( cColor )
    SetKey ( K_INS, bInsSave )
    aEdita [ ES_INS ] := Set ( _SET_INSERT )
Return ( cGet )


Static Function NewOutput ()
Local cEstado := SaveScreen ( MaxRow(), 0, MaxRow(), MaxCol() )
Local cName   := Prompt ( GiveMsg( MSG_EDIT_OUTPUT ), PadR ( aEdita [ ES_FILE ], 64 ) )
    cName := Lower ( Alltrim ( cName ) )
    If ( ! Empty ( cName ) .And. cName != aEdita [ ES_FILE ] )
      aEdita [ ES_FILE ]    := cName
      aEdita [ ES_CHANGED ] := .T.
    End
    RestScreen ( MaxRow(), 0, MaxRow(), MaxCol(), cEstado )
    @ 0, 0 Say Space ( 80 ) Color "N/W"
    @ 0, 1 Say GiveMsg( MSG_EDIT_FICHERO ) + aEdita [ ES_FILE ] Color "N/W"
    StatMsg ()
Return ( Nil )


Static Function NewName ()
Local cEstado := SaveScreen ( MaxRow(), 0, MaxRow(), MaxCol() )
Local cName   := Prompt ( GiveMsg( MSG_EDIT_NEW ), PadR ( aEdita [ ES_FILE ], 64 ) )
    cName := Lower ( AllTrim ( cName ) )
    If ( ! Empty ( cName ) .and. cName != aEdita [ ES_FILE ] )
      aEdita [ ES_FILE ]    := cName
      aEdita [ ES_CHANGED ] := .F.
      aEdita [ ES_TEXT ]    := MemoRead ( aEdita [ ES_FILE ] )
      aEdita [ ES_ROW ]     := 1
      aEdita [ ES_COL ]     := 0
      aEdita [ ES_RELROW ]  := 0
      aEdita [ ES_RELCOL ]  := 0
    EndIf
    RestScreen ( MaxRow(), 0, MaxRow(), MaxCol(), cEstado )
    @ 0, 0 Say Space ( 80 ) Color "N/W"
    @ 0, 1 Say GiveMsg( MSG_EDIT_FICHERO ) + aEdita [ ES_FILE ] Color "N/W"
    StatMsg ()
Return ( Nil )


Static Function xSearch ( x )
Local nRow, Pos, OffSet, NewCol, a
    IF ( ! Empty ( aEdita [ ES_PATTERN ] ) )
      nRow := aEdita [ ES_ROW ]
      Pos := x + mlcToPos ( aEdita [ ES_TEXT ], aEdita [ ES_WIDTH ],   aEdita [ ES_ROW ], ;
                            aEdita [ ES_COL ],  aEdita [ ES_TABSIZE ], aEdita [ ES_WRAP ] )
      OffSet := Pos + At ( aEdita [ ES_PATTERN ], SubStr ( aEdita [ ES_TEXT ], Pos ) ) - 1
      If ( OffSet >= Pos )
        a := mPosToLc ( aEdita [ ES_TEXT ],    aEdita [ ES_WIDTH ], OFFSET, ;
                        aEdita [ ES_TABSIZE ], aEdita [ ES_WRAP ] )
        aEdita [ ES_ROW ] := a [ 1 ]
        NewCol := a [ 2 ]
        aEdita [ ES_RELCOL ] := aEdita [ ES_RELCOL ] + NewCol - aEdita [ ES_COL ]
        aEdita [ ES_COL ] := NewCol
        If ( aEdita [ ES_ROW ] - nRow <= aEdita [ ES_BOTTOM ] - aEdita [ ES_TOP ] - aEdita [ ES_RELROW ] )
          aEdita [ ES_RELROW ] := aEdita [ ES_RELROW ] + aEdita [ ES_ROW ] - nRow
        End
      EndIf
    EndIf
    StatMsg ()
Return ( Nil )


Static Function Search ()
Local cEstado := SaveScreen ( MaxRow(), 0, MaxRow(), MaxCol() )
Local cPattern := Prompt ( GiveMsg( MSG_EDIT_SEARCH ), PadR ( aEdita [ ES_PATTERN ], 64 ) )
    cPattern := Alltrim ( cPattern )
    If ( ! Empty ( cPattern ) )
      aEdita [ ES_PATTERN ] := cPattern
      xSearch ( 0 )
    End
    RestScreen ( MaxRow(), 0, MaxRow(), MaxCol(), cEstado )
Return ( Nil )


Static Function SearchAgain ()
    xSearch ( 1 )
Return ( Nil )


Function uFunc ( nMode, nLine, nCol )
Local nKey
    aEdita [ ES_LASTKEY ] := nKey := LastKey ()
    aEdita [ ES_ROW ]     := nLine
    aEdita [ ES_COL ]     := nCol
    aEdita [ ES_RELROW ]  := Row () - aEdita [ ES_TOP ]
    aEdita [ ES_RELCOL ]  := Col () - aEdita [ ES_LEFT ]
    If ( nMode == 2 )
      aEdita [ ES_CHANGED ] := .T.
    End
    Do Case
      Case ( ( nKey >= 32 .OR. nKey <= 255 ) .and. nCol >= aEdita [ ES_WIDTH ] - 1 ) 
        Return ( K_RETURN )
      Case ( nKey == K_INS )
        aEdita [ ES_INS ] := ! Set ( _SET_INSERT )  
        SetCursor ( If ( aEdita [ ES_INS ], 2, 1 ) )
        Return ( nKey )
      Case ( nKey == K_F4 )
        aEdita [ ES_LASTKEY ] := K_F4
        Return ( K_CTRL_W )
      Case ( nKey == K_F5 )
        aEdita [ ES_LASTKEY ] := K_F5
        Return ( K_CTRL_W )
      Case ( nKey == K_F6 )
        aEdita [ ES_LASTKEY ] := K_F6
        Return ( K_CTRL_W )
      Case ( nKey == K_F7 )
        NewOutPut ()
      Case ( nKey == K_F8 )
        aEdita [ ES_LASTKEY ] := K_F8
        Return ( K_CTRL_W )
      Case ( nKey == K_F10 )
        aEdita [ ES_LASTKEY ] := K_F10
        Return ( K_CTRL_W )
      Case ( nKey == K_ESC )
        Return ( 32 )
      OtherWise
        StatMsg ()
    EndCase
Return ( 0 )


Static Function EditWrite ()
    If ( aEdita [ ES_CHANGED ] )
      If Query ( GiveMsg( MSG_EDIT_SAVE, { aEdita [ ES_FILE ] } ) )
        MemoWrit ( aEdita [ ES_FILE ], aEdita [ ES_TEXT ] )
        aEdita [ ES_CHANGED ] := .F.
      EndIf
    EndIf
Return ( Nil )


Static Function StatMsg ()
Local cLine   := PadR ( LTrim ( Str ( aEdita [ ES_ROW ] ) ), 6 )
Local cCol    := PadR ( LTrim ( Str ( aEdita [ ES_COL ] + 1 ) ), 3 )
Local nCursor := SetCursor ( 0 )
Local nRow    := Row ()
Local nCol    := Col ()
    @ 0, 60 Say "Lin: " + cLine + "Col: " + cCol Color "N/W"
    SetPos ( nRow, nCol )
    SetCursor ( nCursor )
Return ( Nil )



