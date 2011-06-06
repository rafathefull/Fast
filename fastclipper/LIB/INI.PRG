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




#include "\libs\clipapi\version.ch"

FAST_VERSION


Function IniLoad ( cFileIni, cApplIni )
Local aTempFile := {}
Local nTempLineas
Local nN
Local aNombreIni := {}
Local aValorIni  := {}
Local aComenIni  := {}
    cFileIni := If ( At ( ".", cFileIni ) == 0, cFileIni + ".Ini" , cFileIni )
    If ! ( File ( cFileIni ) )
      Return ( Nil )
    EndIf
    aTempFile := aCar2Arr ( MemoTran ( StrTran ( MemoRead ( cFileIni ), Chr ( 9 ), "    " ), "@" ), "@" )
    nTempLineas := aScan ( aTempFile, "[" + Upper ( cApplIni ) + "]" ) + 1
    If ( nTempLineas > 1 )
      For nN := nTempLineas To Len ( aTempFile )
        If SubStr ( aTempFile [ nN ], 1, 1 ) != "#" .Or. AT ( "[", aTempFile [ nN ] ) == 0
          aAdd ( aNombreIni, SubStr ( aTempFile [ nN ], ;
                                        1, ;
                                        aT ( "=", aTempFile [ nN ] ) - 1 ) )
          aAdd ( aValorIni,  SubStr ( aTempFile [ nN ], ;
                                        aT ( "=", aTempFile [ nN ] ) + 1, ;
                                        If ( aT ( "#", aTempFile [ nN ] ) == 0, ;
                                             Len ( aTempFile [ nN ] ), ;
                                             aT ( "#", aTempFile [ nN ] ) - 1 - At ( "=", aTempFile [ nN ] ) ) ) )
          aAdd ( aComenIni,  SubStr ( aTempFile [ nN ], ;
                                        If ( aT ( "#", aTempFile [ nN ] ) == 0, Len ( aTempFile [ nN ] ) + 1, aT ( "#", aTempFile [ nN ] ) + 1 ), ;
                                        Len ( aTempFile [ nN ] ) - aT ( "#", aTempFile [ nN ] ) ) )
        ElseIf At ( "[", aTempFile [ nN ] ) != 0
          Exit
        EndIf
      Next
    EndIf
Return( { aNombreIni, aValorIni, aComenIni } )


Function IniWrite( aIni, cFileIni, cApplIni )
Local aNombreIni := aIni[ 1 ]
Local aValorIni  := aIni[ 2 ]
Local aComenIni  := aIni[ 3 ]
Local nInd
Local cFichero := "[" + cApplIni + "]" + Chr ( 13 ) + Chr ( 10 )
     For nInd := 1 To Len ( aNombreIni )
       cFichero+= aNombreIni [ nInd ] + "=" + ;
                  aValorIni  [ nInd ] + "#" + ;
                  aComenIni  [ nInd ] + Chr ( 13 ) + Chr ( 10 )
     Next
     cFileIni := If ( At ( ".", cFileIni ) == 0, cFileIni + ".Ini" , cFileIni )
     MemoWrit ( cFileIni, cFichero )
Return ( Nil )


Function IniSearch ( aIni, cBusca, cDefecto )
Local aNombreIni := aIni[ 1 ]
Local aValorIni  := aIni[ 2 ]
Local aComenIni  := aIni[ 3 ]
Local nPos := aScan ( aNombreIni, { | X | AllTrim ( Upper ( X ) ) == AllTrim ( Upper( cBusca ) ) } )
Return ( If ( nPos != 0, AllTrim ( aValorIni [ nPos ] ), cDefecto ) )


Function IniSave ( aIni, cBusca, cValor )
Local aNombreIni := aIni[ 1 ]
Local aValorIni  := aIni[ 2 ]
Local aComenIni  := aIni[ 3 ]
Local nPos := aScan ( aNombreIni, { | X | AllTrim ( Upper ( X ) ) == AllTrim ( cBusca ) } )
Local nEsp
    IF nPos != 0
      nEsp := Max ( Len ( cValor ), Len ( aValorIni [ nPos ] ) )
      aValorIni [ nPos ] := " " + cValor + Space ( nEsp - Len ( cValor ) - 1 )
    EndIf
Return ( Nil )

