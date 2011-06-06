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


Function Color2Num ( cExpr )
Local cTinta
Local cFondo
Local lIntenso
Local lParpadeo
Local cTabla    := "N úB úG úBGúR úRBúGRúW "
  cExpr  := Upper ( If ( cExpr == Nil, SetColor(), cExpr ) )
  cExpr  := If ( "," $ cExpr, SubStr ( cExpr, 1, At ( ",", cExpr ) - 1 ), cExpr )
  cTinta := SubStr( cExpr, 1, At( "/", cExpr ) - 1 )
  cFondo := SubStr( cExpr, At( "/", cExpr ) + 1 )
  lIntenso  := If( "+" $ cTinta, .T., .F. )
  lParpadeo := If( "*" $ cTinta, .T., .F. )
  cTinta := StrTran( cTinta, "+", "" )
  cTinta := StrTran( cTinta, "*", "" )
  cTinta += If( Len( cTinta ) == 1, " ", "" )
  cTinta += If( Len( cTinta ) == 1, " ", "" )
Return ( ( At( cTinta, cTabla ) - 1 ) / 3 ) + ;
         ( ( At( cFondo, cTabla ) - 1 ) / 3 * 16 ) + ;
         If( lIntenso, 8, 0 ) + If( lParpadeo, 128, 0 )


Function Num2Color ( nNumero )
Local cIntenso  := ""
Local cParpadeo := ""
Local cTabla    := "N úB úG úBGúR úRBúGRúW "
Local nFondo    := Int( nNumero / 16 )
Local nTinta    := nNumero - ( nFondo * 16 )
    If nFondo > 7
      cParpadeo := "*"
      nFondo -= 8
    EndIf
    If nTinta > 7
      cIntenso := "+"
      nTinta -= 8
    EndIf
Return ( Rtrim( SubStr( cTabla, ( nTinta * 3 ) + 1, 2 ) ) + cIntenso + ;
         cParpadeo + "/" + Rtrim( SubStr( cTabla, ( nFondo * 3 ) + 1, 2 ) ) )



