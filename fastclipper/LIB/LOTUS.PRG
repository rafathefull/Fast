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


#define LOT_BOF          chr( 0) + chr(0) + chr( 2) + chr(0) + chr(4) + chr(4)
#define LOT_EOF          chr( 1) + chr(0) + chr( 0) + chr(0)
#define LOT_LABELHDR     chr(15) + chr(0)
#define LOT_NUMBERHDR    chr(14) + chr(0) + chr(13) + chr(0)

#define LEFT_JUSTIFY     chr( 39)
#define RIGHT_JUSTIFY    chr( 34)
#define CENTERED         chr( 94)
#define REPEATING        chr( 92)
#define PROTECTED        chr(128)
#define UNPROTECTED      chr(  0)
#define FIXED            0
#define SCIENTIFIC       1
#define CURRENCY         2
#define PERCENT          3
#define COMMA            4
#define UNUSED1          5
#define UNUSED2          6
#define SPECIAL          7
#define STANDARD_FORMAT  chr(255)



FUNCTION Clp2Wks( cName, aWorkSheet )
LOCAL fHandle
LOCAL nCol
LOCAL nRow
LOCAL nLen1
LOCAL nLen2
LOCAL xAux
    IF !( "." $ cName )
      cName += ".WKS"
    ENDIF
    fHandle := fCreate( cName )
    fWrite( fHandle, LOT_BOF )
    nLen1 := Len( aWorkSheet )
    FOR nRow := 1 TO nLen1
      nLen2 := Len( aWorkSheet[ nRow ] )
      FOR nCol := 1 TO nLen2
        xAux := aWorkSheet[ nRow, nCol ]
        DO CASE
          CASE ValType( xAux ) == "C"
            LOTStr( fHandle, xAux, nRow, nCol )
          CASE ValType( xAux ) == "N"
            LOTNum( fHandle, xAux, nRow, nCol )
        ENDCASE
      NEXT
    NEXT
    fWrite( fHandle, LOT_EOF )
    fClose( fHandle )
RETURN NIL


STATIC FUNCTION LOTStr( fHandle, ostr, nRow, nCol )
LOCAL r
LOCAL Just := "L"
    ostr := trim( ostr )
    if ostr == ""
      return( .t. )
    endif
    r := fwrite( fHandle, LOT_LABELHDR )
    r += fwrite( fHandle, chr( ( len( trim( ostr ) ) + 7 ) % 256 ) )
    r += fwrite( fHandle, chr( ( len( trim( ostr ) ) + 7 ) / 256 ) )
    r += fwrite( fHandle, STANDARD_FORMAT )
    r += LOTcoord( fHandle, nRow, nCol )
    do case
      case just == "R"
        r += fwrite( fHandle, RIGHT_JUSTIFY )
      case just == "L"
        r += fwrite( fHandle, LEFT_JUSTIFY )
      case just == "C"
        r += fwrite( fHandle, CENTERED )
      case just == "R"
        r += fwrite( fHandle, REPEATING )
    endcase
    r += fwrite( fHandle, ostr, len( ostr ) )
    r += fwrite( fHandle, chr(0), 1)
RETURN( r == 11 + len( ostr ) )


STATIC FUNCTION LOTNum( fHandle, num, nRow, nCol )
LOCAL r
    r := fwrite( fHandle, LOT_NUMBERHDR )
    r += fwrite( fHandle, STANDARD_FORMAT )
    r += LOTcoord( fHandle, nRow, nCol )
    r += fwrite( fHandle, dec2ieee( num ) )
RETURN( r == 17 )


STATIC FUNCTION LOTCoord( fHandle, nRow, nCol )
RETURN( fWrite( fHandle, chr( nCol-1 )+chr(0)+chr( nRow-1 )+chr(0) ) )


STATIC FUNCTION dec2ieee( num )
LOCAL ieeea := { 0, 0, 0, 0, 0, 0, 0, 0 }, F, exponent, e1, e2, e3, sign, i, part
    if num != 0
      sign := IIF( num < 0, 1, 0 )
      if sign != 0
        num *= -1
      endif
      if log(num)/log(2)<0
        exponent := int(log(num)/log(2)-1)+1023
      else
        exponent := int(log(num)/log(2))+1023
      endif
      F := ( num / 2^(exponent-1023) - 1 ) * 2^52
      e1 := int(exponent/256)
      e2 := int((exponent-e1*256)/16)
      e3 := exponent-e1*256-e2*16
      ieeea[8] := (sign*128)+e1*16+e2
      ieeea[7] := e3*16
      for i=6 to 0 step -1
        part := int( F / 256^i )
        ieeea[i+1] += part
        F -= part*256^i
      next
    endif
RETURN( chr( ieeea[1] ) + chr( ieeea[2] ) + chr( ieeea[3] ) + chr( ieeea[4] ) + ;
        chr( ieeea[5] ) + chr( ieeea[6] ) + chr( ieeea[7] ) + chr( ieeea[8] ) )

