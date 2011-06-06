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


FUNCTION SaveArray ( aArray, cFileName, nErrorCode )
LOCAL fHandle
LOCAL lRet
    fHandle = fCreate ( cFileName )
    nErrorCode = FError()
    IF nErrorCode == 0
      lRet := _SaveInt ( aArray, fHandle, @nErrorCode )
      fClose ( fHandle )
      IF ( lRet ) .And. ( fError() # 0 )
        nErrorCode := fError()
        lRet = .F.
      ENDIF
    ELSE
      lRet = .F.
    ENDIF
RETURN ( lRet )


FUNCTION RestArray ( cFileName, nErrorCode )
LOCAL fHandle
LOCAL aArray
    fHandle := fOpen ( cFileName )
    nErrorCode := fError()
    IF nErrorCode = 0
      aArray := _RestInt ( fHandle, @nErrorCode )
      fClose ( fHandle )
    ELSE
      aArray := {}
    ENDIF
RETURN ( aArray )


STATIC FUNCTION _SaveInt ( xMemVar, fHandle, nErrorCode )
LOCAL cValType
LOCAL nLen
LOCAL cString
LOCAL lRet := .T.
LOCAL nInd
    cValType := ValType ( xMemVar )
    fWrite ( fHandle, cValType, 1 )
    IF fError() == 0
      Do CASE
        CASE cValType == "A"
          nLen := Len ( xMemVar )
          fWrite ( fHandle, L2Bin ( nLen ), 4 )
          IF fError() == 0
            For nInd := 1 To Len ( xMemVar )
              lRet := _SaveInt ( xMemVar [ nInd ], fHandle )
            Next
          ELSE
            lRet := .F.
          ENDIF
        CASE cValType == "B"
          lRet := .F.
        CASE cValType == "C"
          nLen := Len ( xMemVar )
          fWrite ( fHandle, L2Bin ( nLen ), 4 )
          fWrite ( fHandle, xMemVar )
        CASE cValType == "D"
          nLen := 8
          fWrite ( fHandle, L2Bin ( nLen ), 4 )
          fWrite ( fHandle, dToc ( xMemVar ) )
        CASE cValType == "L"
          nLen := 1
          fWrite ( fHandle, L2Bin ( nLen ), 4 )
          fWrite ( fHandle, IF ( xMemVar, "T", "F" ) )
        CASE cValType == "N"
          cString := Str ( xMemVar )
          nLen := Len ( cString )
          fWrite ( fHandle, L2Bin ( nLen ), 4 )
          fWrite ( fHandle, cString )
      ENDCASE
    ELSE
      lRet := .F.
    ENDIF
    nErrorCode := fError()
RETURN ( lRet )


STATIC FUNCTION _RestInt( fHandle, nErrorCode )
LOCAL cValType
LOCAL nLen
LOCAL cLenStr
LOCAL xMemVar
LOCAL cMemVar
LOCAL nk
    cValType := " "
    fRead( fHandle, @cValType, 1 )
    IF cValType != "U"
      cLenStr := SPACE( 4 )
      fRead( fHandle, @cLenStr, 4 )
      nLen := Bin2L( cLenStr )
      nErrorCode := FError()
      IF nErrorCode == 0
        DO CASE
          CASE cValType == "A"
            xMemVar := {}
            FOR nk := 1 TO nLen
              AADD( xMemVar, _RestInt( fHandle, nErrorCode ) )
            NEXT
          CASE cValType == "C"
            xMemVar := SPACE( nLen )
            fRead( fHandle, @xMemVar, nLen )
          CASE cValType == "D"
            cMemVar := SPACE( 8 )
            fRead( fHandle, @cMemVar,8 )
            xMemVar := CTOD( cMemVar )
          CASE cValType == "L"
            cMemVar := " "
            fRead( fHandle, @cMemVar, 1 )
            xMemVar := ( cMemVar == "T" )
          CASE cValType == "N"
            cMemVar := SPACE( nLen )
            fRead( fHandle, @cMemVar, nLen )
            xMemVar := VAL( cMemVar )
        ENDCASE
        nErrorCode := FERROR()
      ENDIF
    ENDIF
RETURN ( xMemVar )

