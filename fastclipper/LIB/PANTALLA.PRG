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

CREA_FAST_VERSION


#define APLICRIGHT   ")D*!2::3.:6!Nbov!Spjcbm"
#define APLICVERSION "GBTU/mjc!Gps!Dmjqqfs!w5/11"


INIT PROCEDURE Init( cParam )
    If cParam != Nil .And. "/ROIBAL" $ UPPER( cParam )
      ? AsciiAdd( APLICRIGHT, -1 ) + ", " + AsciiAdd( APLICVERSION, -1 )
      Inkey( 0 )
    EndIf
    vInitVideo( VideoMode() )
    SetEnglish()
Return


Function Message( nY, nX, cMensaje, cColor )
    DevPos( nY, nX )
    DevOut( cMensaje, cColor )
Return ( Nil )


Function GetChar ( nY, nX )
Return( SubStr ( SaveScreen ( nY, nX, nY, nX ), 1, 1 ) )


Function Screen ( cMens, cColor )
Local cMessage := ""
Local cRest
Local nInd
    While Len( cMessage ) < MaxCol() + 1
      cMessage += cMens
    End
    DispBegin()
    For nInd := 0 To MaxRow()
      cRest    := SubStr( cMessage, MaxCol() + 2, Len( cMessage ) )
      cMessage := SubStr( cMessage, 1, MaxCol() + 1 )
      @ nInd, 0 Say cMessage Color cColor
      cMessage := cRest + cMessage
    Next
    DispEnd()
Return( Nil )


Function NewBox( nY1, nX1, nY2, nX2, cTitulo, cMarco, lSombra, cColor, ;
                 nSaltos, nDelay )
    OtherBox( nY1, nX1, nY2, nX2, cTitulo, cMarco, lSombra, cColor, ;
              nSaltos, nDelay, Color2Num( cColor ) )
Return( Nil )


FUNCTION FastRight()
RETURN AsciiAdd( APLICRIGHT, -1 )


FUNCTION FastVersion()
RETURN AsciiAdd( APLICVERSION, -1 )



