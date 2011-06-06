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




#include "language.ch"
#include "\libs\clipapi\version.ch"

FAST_VERSION


Function fbOpen ( cFich, nModo )
Local nHand
    While ( nHand := fopen ( cFich, nModo ) ) == -1
      If ! BoxQuery ( GiveMsg( MSG_FILE_ACCESS, { cFich } ) )
        Exit
      EndIf
    End
Return ( nHand )


Function fbCreate( cFich )
Local nHand
    While ( nHand := fcreate ( cFich, 0 ) ) == -1
      If ! BoxQuery ( GiveMsg( MSG_FILE_CREATE, { cFich } ) )
        Exit
      EndIf
    End
Return ( nHand )


Function fbRead( nHand, cBuffer, nBuffer, nLeidos, cFich, lForzar )
Local lRetorno
    cBuffer += Space ( nBuffer - Len ( cBuffer ) )
    While .T.
      nLeidos := fread ( nHand, @cBuffer, nBuffer )
      If ferror () != 0 .Or. ( lForzar .And. nBuffer != nLeidos )
        If ! BoxQuery ( GiveMsg( MSG_FILE_LOAD, { cFich } ) )
          fbClose ( { nHand } )
          lRetorno := .F.
          Exit
        EndIf
      Else
        lRetorno := .T.
        Exit
      EndIf
    End
Return ( lRetorno )


Function fbWrite ( nHand, cBuffer, nBuffer, nEscritos, cFich, lForzar )
Local lRetorno
    While .T.
      nEscritos := fwrite ( nHand, cBuffer, nBuffer )
      If ferror () != 0 .Or. ( lForzar .And. nBuffer != nEscritos )
        If ! BoxQuery ( GiveMsg( MSG_FILE_WRITE, { cFich } ) )
          fbClose ( { nHand } )
          lRetorno := .F.
          Exit
        EndIf
      Else
        lRetorno := .T.
        Exit
      EndIf
    End
Return ( lRetorno )


Function fbClose ( aFichs )
    aEval ( aFichs, { | nHandle | fclose ( nHandle ) } )
Return ( Nil )



