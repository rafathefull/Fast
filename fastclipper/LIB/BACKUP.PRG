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


Static aDskBak    := {}

Function Backup ( dFecha, cTime, cUser, cDestino, aDir, lRecur, cColor, bBlock )
Local nInd      := 0
Local nFich     := 0
Local nHandIn   := 0
Local nHandOut  := 0
Local cTamano   := ""
Local cHuella   := ""
Local nLeidos   := 0
Local nEscritos := 0
Local cBuffer   := ""
Local nBuffer   := 32768
Local cFichero  := ""
Local lBandera  := .T.
Local nDisco    := 1
Local nBytes    := 0
Local nActual   := 0
Local nTotal    := 0
Local cFichBack := ""
Local nCursor   := SetCursor ( 0 )
Local nTiempo   := 0
Local cPantalla := SaveScreen ( 0, 0, 24, 79 )
    aDskBak  := {}
    cDestino := If ( cDestino == Nil, "A:\",   cDestino )
    aDir     := If ( aDir     == Nil, {},      aDir     )
    lRecur   := If ( lRecur   == Nil, .T.,     lRecur   )
    dFecha   := If ( dFecha   == Nil, Date (), dFecha   )
    cTime    := If ( cTime    == Nil, Time (), cTime    )
    cUser    := If ( cUser    == Nil, "Root",  cUser    )
    bBlock   := If ( bBlock   == Nil, {||.T.}, bBlock   )
    If ValType ( aDir ) != "A"
      Return ( Nil )
    EndIf
    For nInd := 1 To Len ( aDir )
      aRecur ( aDir [ nInd, 1 ], aDir [ nInd, 2 ], lRecur )
    Next
    aEval ( aDskBak, { | aX | nBytes += aX [ 2 ] } )
    Window ( 5, 3, 16, 76, GiveMsg( MSG_BACK_ESTADISTICAS ), "赏缓纪群 ", .T., cColor )
    Message (  9, 10, GiveMsg( MSG_BACK_ACOPIAR ),   cColor )
    Message (  9, 43, GiveMsg( MSG_BACK_BYTESFILE ), cColor )
    Message ( 10, 10, GiveMsg( MSG_BACK_BYTESCOP ),  cColor )
    Message ( 10, 43, GiveMsg( MSG_BACK_BYTESCOPF ), cColor )
    Message ( 12, 10, GiveMsg( MSG_BACK_NUMFILES ),  cColor )
    Message ( 12, 43, GiveMsg( MSG_BACK_SALVADOS ),  cColor )
    Message ( 14, 10, GiveMsg( MSG_BACK_TIEMPO ),    cColor )
    Message ( 14, 43, GiveMsg( MSG_BACK_REALIZADO ), cColor )
    Message (  9, 27, TransForm ( nBytes, "@E 999,999,999" ),       cColor )
    Message ( 12, 27, TransForm ( Len ( aDskBak ), "@E 999,999,999" ), cColor )
    BoxWarning( GiveMsg( MSG_BACK_INSERTE, { cDestino } ) )
    If ! Eval ( bBlock )
      Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
    EndIf
    If ( nHandOut := fbCreate ( cDestino + "BACKUP.001" ) ) == -1
      Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
    End
    cFichBack := "BACKUP." + PadL ( AllTrim ( Str ( nDisco ) ), 3, "0" )
    If ! fbWrite ( nHandOut, PadR ( dToC ( dFecha ) + cTime + cUser, 100 ), 100, 100, cFichBack, .T. )
      Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
    EndIf
    For nFich := 1 To Len ( aDskBak )
      cTamano := Str ( aDskBak [ nFich, 2 ] )
      cFichero := aDskBak [ nFich, 1 ]
      Message (  7, 10, PadR( GiveMsg( MSG_BACK_SALVANDO ) + cFichero, 65 ),  cColor )
      Message (  9, 60, TransForm ( Val ( cTamano ), "@E 999,999,999" ), cColor )
      Message ( 10, 60, TransForm ( 0,               "@E 999,999,999" ), cColor )
      If ( nHandIn := fbOpen ( cFichero, 64 ) ) == -1
        fbClose ( { nHandOut } )
        Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
      EndIf
      cHuella := PadR ( cFichero, 128 ) + cTamano
      If ! fbWrite ( nHandOut, cHuella, 138, 138, cFichBack, .T. )
        fbClose ( { nHandIn } )
        Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
      EndIf
      nLeidos  := -1
      lBandera := .T.
      nActual  := 0
      While lBandera
        If Inkey () == K_ESC .And. BoxQuery ( GiveMsg( MSG_BACK_CANCELAR ) )
          fbClose ( { nHandIn, nHandOut } )
          Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
        EndIf
        cBuffer := Space ( nBuffer )
        If ! fbRead ( nHandIn, @cBuffer, nBuffer, @nLeidos, cFichero, .F. )
          fbClose ( { nHandOut } )
          Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
        ElseIf nLeidos == 0
          lBandera := .F.
        EndIf
        While .T.
          nEscritos := nLeidos
          If ! fbWrite ( nHandOut, cBuffer, nEscritos, @nEscritos, cFichBack, .F. )
            fbClose ( { nHandIn } )
            Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
          Else
            nActual += nEscritos
            nTotal  += nEscritos
            Message ( 10, 27, TransForm ( nTotal,  "@E 999,999,999" ), cColor )
            Message ( 10, 60, TransForm ( nActual, "@E 999,999,999" ), cColor )
            Message ( 12, 60, TransForm ( nFich,   "@E 999,999,999" ), cColor )
            Message ( 14, 60, TransForm ( Round ( nTotal / nBytes * 100, 0 ), "999" ) + " %", cColor )
            nTiempo := ( nBytes - nTotal ) / 2900
            Message ( 14, 27, SubStr ( Str ( Int ( nTiempo / 3600 % 24 ) + 10 ^ 2, 2 + 1 ), 2 ) + ":" + ;
                              SubStr ( Str ( Int ( nTiempo / 60 % 60 )   + 10 ^ 2, 2 + 1 ), 2 ) + ":" + ;
                              SubStr ( Str ( Int ( nTiempo % 60 )        + 10 ^ 2, 2 + 1 ), 2 ), cColor )
            If nEscritos == nLeidos
              Exit
            Else
              nLeidos -= nEscritos
              fbClose ( { nHandOut } )
              BoxWarning ( GiveMsg( MSG_BACK_INSERTE, { cDestino } ) )
              If ! Eval ( bBlock )
                fbClose ( { nHandIn } )
                Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
              EndIf
              cFichBack := "BACKUP." + PadL ( AllTrim ( Str ( ++nDisco ) ), 3, "0" )
              If ( nHandOut := fbCreate ( cDestino + cFichBack ) ) == -1
                fbClose ( { nHandIn } )
                Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
              EndIf
            EndIf
          EndIf
        End
      End
      fbClose ( { nHandIn } )
    Next
    If ! fbWrite ( nHandOut, PadR ( "XXXXXXXX.XXXX", 138 ), 138, 138, cFichBack, .T. )
      Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
    EndIf
    fbClose ( { nHandOut } )
Return ( lDevuelve ( nCursor, cPantalla, .T. ) )


Function Restore ( cOrigen, aMascara, cColor )
Local nHandIn   := 0
Local nHandOut  := 0
Local nDisco    := 1
Local cFichBack := ""
Local cHuella   := ""
Local cCab      := ""
Local cBuffer   := ""
Local nBuffer   := 32768
Local nLeidos   := 0
Local nEscritos := 0
Local cFichero  := ""
Local nTamano   := 0
Local nBytes    := 0
Local nTotal    := 0
Local nInd      := 0
Local nAux      := 0
Local lBandera  := .F.
Local nPointer  := 0
Local nSalto    := 0
Local nFinFich  := 0
Local nCursor   := SetCursor ( 0 )
Local cPantalla := SaveScreen ( 0, 0, 24, 79 )
Local nSave
    cOrigen  := If ( cOrigen  == Nil, "A:\",  cOrigen  )
    aMascara := If ( aMascara == Nil, { "" }, aMascara )
    If ValType ( aMascara ) != "A"
      Return ( Nil )
    EndIf
    dbCloseAll ()
    BoxWarning( GiveMsg( MSG_REST_INSERTE, { "BACKUP.001" } ) )
    If ( nHandIn := fbOpen ( cOrigen + "BACKUP.001", 0 ) ) == -1
      Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
    EndIf
    cFichBack := "BACKUP." + PadL ( AllTrim ( Str ( nDisco ) ), 3, "0" )
    cCab      := Space ( 100 )
    If ! fbRead ( nHandIn, @cCab, 100, 100, cFichBack, .T. )
      Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
    EndIf
    Window ( 5, 3, 15, 76, GiveMsg( MSG_BACK_ESTADISTICAS ), "赏缓纪群 ", .T., cColor )
    Message (  7, 10, GiveMsg( MSG_REST_FECHA ) + SubStr ( cCab, 1, 8 ) + " " + SubStr ( cCab, 9, 8 ), cColor )
    Message (  8, 10, GiveMsg( MSG_REST_CREADOR ) + AllTrim ( SubStr ( cCab, 17 ) ), cColor )
    Message ( 12, 10, GiveMsg( MSG_BACK_BYTESCOPF ), cColor )
    Message ( 12, 43, GiveMsg( MSG_BACK_BYTESFILE ), cColor )
    Message ( 13, 43, GiveMsg( MSG_BACK_BYTESCOP ),  cColor )
    If ! BoxQuery ( GiveMsg( MSG_REST_CONTINUE ) )
      fbClose ( { nHandIn } )
      Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
    EndIf
    nTotal := 0
    While .T.
      cHuella := Space ( 138 )
      If ! fbRead ( nHandIn, @cHuella, 138, 138, cFichBack, .T. )
        Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
      EndIf
      cFichero := AllTrim ( SubStr ( cHuella,   1, 128 ) )
      nTamano  := Val     ( SubStr ( cHuella, 129, 138 ) )
      nBytes   := 0
      If cFichero == "XXXXXXXX.XXXX"
        Exit
      EndIf
      lBandera := .F.
      For nInd := 1 To Len ( aMascara )
        If Upper ( aMascara [ nInd ] ) == Upper ( SubStr ( cFichero, 1, Len ( aMascara [ nInd ] ) ) )
          lBandera := .T.
        EndIf
      Next
      Message ( 12, 27, TransForm ( nTotal,  "@E 999,999,999" ), cColor )
      Message ( 12, 60, TransForm ( nTamano, "@E 999,999,999" ), cColor )
      Message ( 13, 60, TransForm ( nBytes,  "@E 999,999,999" ), cColor )
      If Inkey () == K_ESC .And. BoxQuery ( GiveMsg( MSG_BACK_CANCELAR ) )
        fbClose ( { nHandIn, nHandOut } )
        Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
      EndIf
      If ! lBandera
        Message ( 10, 10, PadR ( GiveMsg( MSG_REST_SALTANDO ) + cFichero, 65 ), cColor )
        nSalto := nPointer := 0
        While nTamano > 0
          nPointer := fseek ( nHandIn, 0, 1 )
          nFinFich := fseek ( nHandIn, 0, 2 )
          nPointer := fseek ( nHandIn, nPointer, 0 )
          nSalto   := Min ( nPointer + nTamano, nFinFich ) - nPointer
          fseek ( nHandIn, nSalto, 1 )
          If nSalto < nTamano
            nTamano -= nSalto
            fbClose ( { nHandIn } )
            nDisco ++
            cFichBack := "BACKUP." + PadL ( AllTrim ( Str ( nDisco ) ), 3, "0" )
            BoxWarning ( GiveMsg( MSG_REST_INSERTE, { cFichBack } ) )
            IF ( nHandIn := fbOpen ( cOrigen + cFichBack, 0 ) ) == -1
              fbClose ( { nHandOut } )
              Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
            EndIf
          Else
            nTamano -= nSalto
          EndIf
        End
        Loop
      EndIf
      Message ( 10, 10, PadR ( GiveMsg( MSG_REST_RESTAURA ) + cFichero, 65 ), cColor )
      If ( nHandOut := fbCreate ( cFichero ) ) == -1
        fbClose ( { nHandIn } )
        Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
      EndIf
      While nTamano > nBytes
        nAux    := Min ( nBuffer, nTamano - nBytes )
        cBuffer := Space ( nAux )
        If ! fbRead ( nHandIn, @cBuffer, nAux, @nLeidos, cFichBack, .F. )
           fbClose ( { nHandOut } )
           Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
        Else
          nSave  := nLeidos
          nBytes += nLeidos
          nTotal += nLeidos
          While .T.
            If ! fbWrite ( nHandOut, cBuffer, nLeidos, @nEscritos, cFichero, .F. )
              fbClose ( { nHandIn } )
              Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
            Else
              If nEscritos == nLeidos
                Exit
              Else
                nLeidos -= nEscritos
                cBuffer := SubStr ( cBuffer, nEscritos )
              EndIf
            EndIf
          End
        EndIf
        Message ( 12, 27, TransForm ( nTotal, "@E 999,999,999" ), cColor )
        Message ( 13, 60, TransForm ( nBytes, "@E 999,999,999" ), cColor )
        If nSave != nAux
          fbClose ( { nHandIn } )
          cFichBack := "BACKUP." + PadL ( AllTrim ( Str ( ++nDisco ) ), 3, "0" )
          BoxWarning ( GiveMsg( MSG_REST_INSERTE, { cFichBack } ) )
          If ( nHandIn := fbOpen ( cOrigen + cFichBack, 0 ) ) == -1
            fbClose ( { nHandOut } )
            Return ( lDevuelve ( nCursor, cPantalla, .F. ) )
          EndIf
        EndIf
      End
      fbClose ( { nHandOut } )
    End
    fbClose ( { nHandIn } )
Return ( lDevuelve ( nCursor, cPantalla, .T. ) )


Static Function lDevuelve ( nCursor, cPantalla, lRet )
    SetCursor ( nCursor )
    RestScreen ( 0, 0, 24, 79, cPantalla )
Return ( lRet )


Static Function aRecur ( cPath, cWillCard, lRecur )
Local aDir, nI
  aDir := aDirec ( cPath, cWillCard, lRecur )
  if ! Empty ( aDir )
    For nI := 1 to len ( aDir )
      If aDir [ nI, 5 ] != "D"
        aadd ( aDskBak, { cPath + aDir [ nI, 1 ], aDir [ nI, 2 ] } )
      Else
        aRecur ( cPath + aDir [ nI, 1 ] + "\", cWillCard, lRecur )
      EndIf
    Next
  endif
Return ( Nil )


Static Function aDirec ( cPath, cWillCard, lRecur )
Local aDir, nI
    cPath := StrTran( cPath + "\", "\\", "\" ) + cWillCard
    aDir := Directory ( cPath, If ( lRecur, "D", "" ) )
    For nI := 1 To Len ( aDir )
      If aDir [ nI, 1 ] == "." .Or. aDir [ nI, 1 ] == ".."
        aDir := aDel ( aDir, nI )
        aDir := aSize ( aDir, Len ( aDir ) - 1 )
        nI --
      Endif
    Next
Return ( aDir )



