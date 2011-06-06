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


Function ArjFile( cFich )
Local retval  := {}
Local nHandle
Local nPos
Local cFecha  := Set( _SET_DATEFORMAT, "dd/mm/yy" )
    cFich  := Upper( AllTrim( cFich ) )
    cFich  += If ( At( ".", cFich ) == 0, ".ARJ", "" )
    nHandle := fopen( cFich, 2 )
    If nHandle # -1
      If Right( cFich, 4 ) == ".EXE"
//        nPos := flocate( nHandle, "`ê" )
      Else
        fseek( nHandle, 0, 0 )
      EndIf
      LeeCabArj( nHandle )
      retval := LeeFileArj( nHandle, "NDHTO" )
      fclose( nHandle )
    EndIf
    Set( _SET_DATEFORMAT, cFecha )
Return( retval )


Static Function LeeCabArj( nHandle )
Local retval := .T.
Local cCab   := space(4)
Local nSalto
    fread( nHandle, @cCab, 4 )
    nSalto := Bin2w( SubStr( cCab, 3, 2 ) )
    fseek( nHandle, nSalto+5, 1 )
    cCab := FreadStr( nHandle, 1 )
    If Asc( cCab ) > 0
      fseek( nHandle, 4, 1 )
    EndIf
Return( retval )


Static Function LeeFileArj( nHandle, cParam )
Local retval := {}, cCab, cTama, nTCompri, nTreal, cNombre, cChar,;
      aBin := { "0", "1"}, cFecha, cHora, cBinario, nAno, nMes, nDia,;
      nHora, nMinuto, nSegundo, nSalto, dDate, n, nPosNom, cDatos
    While .T.
      cCab := Space( 4 )
      FRead( nHandle, @cCab, 4 )
      nSalto := Bin2w( SubStr( cCab, 3, 2 ) )
      If asc( SubStr( cCab, 3, 1 ) ) = 0
        exit
      EndIf
      cDatos := Space( nSalto )
      Fread( nHandle, @cDatos, nSalto )
      cFecha   := SubStr( cDatos, 9, 4 )
      cBinario := Dec2Base( Bin2l( cFecha ), aBin, 32 )
      nAno     := Base2Dec( SubStr( cBinario, 1, 7 ), aBin )
      nMes     := Base2Dec( SubStr( cBinario, 8, 4 ), aBin )
      nDia     := Base2Dec( SubStr( cBinario, 12,5 ), aBin )
      dDate    := cTod( StrZero(nDia,2) + "/" + StrZero(nMes,2) + "/" + StrZero(nAno+1980,4) )
      nHora    := Base2Dec( SubStr( cBinario, 17,5 ), aBin )
      nMinuto  := Base2Dec( SubStr( cBinario, 22,6 ), aBin )
      nSegundo := Base2Dec( SubStr( cBinario, 28,5 ), aBin ) * 2
      cHora    := StrZero(nHora,2) + ":" + StrZero(nMinuto,2) + ":" + StrZero(nSegundo,2)
      cTama    := SubStr( cDatos, 13, 4 )
      If Len( cTama ) > 2
        nTCompri := Bin2l( cTama )
      Else
        nTCompri := Bin2w( cTama )
      EndIf
      cTama := SubStr( cDatos, 17, 4 )
      If len( cTama ) > 2
        nTReal := Bin2l( cTama )
      Else
        nTReal := Bin2w( cTama )
      EndIf
      nPosNom := Bin2w( SubStr( cDatos, 1, 1 ) )
      n := 0
      cNombre := ""
      While Asc( ( cChar := SubStr( cDatos, nPosNom + ( ++n ), 1 ) ) ) # 0
        cNombre += cChar
      End
      aAdd( retval, {} )
      aAdd( aTail( retval ), cNombre )
      aAdd( aTail( retval ), nTCompri )
      aAdd( aTail( retval ), nTReal )
      aAdd( aTail( retval ), nTCompri / nTReal  )
      aAdd( aTail( retval ), dDate )
      aAdd( aTail( retval ), cHora )
      fseek( nHandle, nTcompri + 6, 1 )
   End
Return( retval )

