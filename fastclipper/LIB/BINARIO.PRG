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


Function Base2dec(cLet, aBase)
local xx, nValChr, cPosChr
local nResult := 0
local nBas    := len(aBase)
local nDecPos := len(cLet)
    For xx := nDecPos to 1 step -1
      cPosChr := substr(cLet, xx, 1)
      nValChr := ascan(aBase, cPosChr)
      If nValChr > 0
        nValChr--
      EndIf
      nResult += nValChr * ( nBas ^ ( nDecPos - xx ) )
   next
Return ( nResult )


Function Dec2base(nDec, aBase, nLenOut)
Local cResult := ""
local nBas    := len(aBase)
local nDecPos
local i       := 0
local xx
local nResDec := nDec
    while ( int( nDec / ( nBas ^ ++i)) # 0 )
    end
    i--
    for xx := i to 0 step -1
      nDecPos := int( nResDec / ( nBas ^ xx ) )
      cResult += aBase[nDecPos + 1]
      nResDec -= ( nDecPos * ( nBas ^xx ) )
    next
    if nLenOut # Nil
      cResult := padl(cResult, nLenOut, aBase[1])
    EndIf
return ( cResult )


Function Hex2Dec( cHexNum )
local n
Local nDec := 0
Local nHexPower := 1
Local HexTable  := "0123456789ABCDEF"
    for n := len( cHexNum ) to 1 step -1
      nDec += ( at( subs( upper(cHexNum), n, 1 ), HexTable ) - 1 ) * nHexPower
      nHexPower *= 16
    Next
Return ( nDec )


Function Dec2Bin(x)
Local i, buffer := { '0', '0', '0', '0', '0', '0', '0', '0' }
    for i = 8 to 1 step -1
      if x >= 2 ^ (i - 1)
        x -= 2 ^ (i - 1)
        buffer[9 - i] = '1'
      endif
    next
Return ( buffer[1] + buffer[2] + buffer[3] + buffer[4] + ;
         buffer[5] + buffer[6] + buffer[7] + buffer[8] )


FUNCTION Byte2Hex(cByte)
local cHexTable := "0123456789ABCDEF"
local xHexString
    if valtype(cByte) != "C"
      xHexString := NIL
    else
      xHexString := substr(cHexTable, int(asc(cByte) / 16) + 1, 1) + ;
                    substr(cHexTable, int(asc(cByte) % 16) + 1, 1)
    endif
RETURN ( xHexString )


FUNCTION Byte2Bin(cByte)
local nCounter, xBitstring
   IF valtype(cByte) != "C"
     xBitString := NIL
   ELSE
     xBitString := ""
     FOR nCounter := 7 TO 0 step -1
        xBitString += iif( IsBit(cByte, nCounter), "1", "0")
     NEXT
   ENDIF
RETURN ( xBitString )



