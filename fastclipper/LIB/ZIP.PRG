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


#define INFO_SIZE       1
#define POS_YEAR_MON    2
#define POS_MON_DAY     3
#define POS_MINUTES     4 
#define POS_MIN_HOUR    5
#define POS_ORIGINAL    6
#define POS_PACKED      7
#define CB_FINISHED     8
#define CB_FILE_TYPE    9
#define CB_FILE_NAME    10

#define F_NAME_LONG     2
#define F_ORIGINAL      5
#define F_PACKED        6
#define F_RATIO         7
#define F_COMPRESS      8
#define F_NUMBER        9

Function ZipFile ( cCommandLine )
Local cInfo     := {}
Local aPacked   := {}
Local cFName    := ""
Local nNoOfRows := 0
   If File ( cCommandLine )
     cInfo := { 30, 14, 13, 11, 12, 23, 19,                                        ;
                { | cFiInf      | ( "PK"+ CHR( 3 ) + CHR( 4 ) ) $ cFiInf },  ;
                { | cFiInf      | ZipType( ASC( SUBS(cFiInf,9,1) ) )     },  ;
                { | cFiInf,nHand| cFName := SPACE( ASC( SUBS(cFiInf,27,1))), ;
                  FREAD(nHand,@cFName,LEN( cFName ) ),cFName }                     ;
              }
     nNoOfRows := PackInfo( cCommandLine, aPacked, cInfo)
     If nNoOfRows == 0
       aPacked := Nil
     EndIf
   EndIf
Return ( aPacked )


Static Function PackInfo( cCommandLine, aPacked, aInfo )
Local cFileInfo
Local cFName
Local nFileCount := 0
Local nHandle := fOpen ( cCommandLine, 64 )
    If nHandle != -1
      While .T.
        cFileInfo := Space( aInfo[ INFO_SIZE ] )
        fread( nHandle, @cFileInfo, aInfo[ INFO_SIZE ] )
        If ! Eval( aInfo[ CB_FINISHED ], cFileInfo )
          Exit
        EndIf
        nFileCount ++
        aAdd( aPacked, {} )
        cFName := Eval( aInfo[ CB_FILE_NAME ], cFileInfo, nHandle )
        aAdd(aPacked[ nFileCount ], SubS( cFName, Rat( '/', cFName ) + 1 ) )
        aAdd( aPacked[ nFileCount ], cFName )
        aAdd( aPacked[ nFileCount ],                                        ;
            ZipDate( Asc( SubStr( cFileInfo,                               ;
            aInfo[ POS_YEAR_MON ], 1 ) ),                                   ;
            Asc( SubStr( cFileInfo, aInfo[ POS_MON_DAY ],   1 ) ) ) )
        aAdd( aPacked[ nFileCount ],                                        ;
            ZipTime( Asc( SubStr( cFileInfo,                               ;
            aInfo[ POS_MINUTES ], 1 ) ),                                    ;
            Asc( SubStr( cFileInfo, aInfo[ POS_MIN_HOUR ],  1 ) ) ) )
        aAdd( aPacked[ nFileCount ],                                        ;
            Bin2L( SubStr( cFileInfo, aInfo[ POS_ORIGINAL ],4 ) ) )
        aAdd( aPacked[ nFileCount ],                                        ;
            Bin2L( SubStr( cFileInfo, aInfo[ POS_PACKED ],  4 ) ) )
        aAdd( aPacked[ nFileCount ],;
            ZipRatio( aPacked[ nFileCount, F_ORIGINAL ],                       ;
            aPacked[ nFileCount, F_PACKED ] ) )
        aAdd( aPacked[ nFileCount ], Eval( aInfo[ CB_FILE_TYPE ],           ;
            cFileInfo ) )
        aAdd( aPacked[ nFileCount ], nFileCount )
        fseek( nHandle, aPacked[ nFileCount, F_PACKED ], 1 )
      End
    EndIf
    fClose( nHandle )
Return ( nFileCount )


Static Function ZipRatio( nOriginal, nPacked )
Return ( STR( 100 - INT( ( nPacked / nOriginal ) * 100 ), 3 ) + "% " )


Static Function ZipType( nFileType )
Local cFileType
    Do Case
      Case nFileType == 9
        cFileType := " Squashed "
      Case nFileType == 8
        cFileType := " Deflated "
      Case nFileType == 6
        cFileType := " Implode  "
      Case nFileType == 3
        cFileType := " Packed   "
      Case nFileType == 1
        cFileType := " Shrunk   "
      Case nFileType == 0 .Or. nFileType == 2
        cFileType := " Stored   "
    EndCase
Return ( cFileType )


Static Function ZipDate( nYearMon, nMonDay )
Local nYearInt := If( nYearMon > 39,( ( nYearMon-40 )/ 2 ),( ( nYearMon/2 )+80 ) )
Local nMonth   := Int( ( nMonDay - 1 ) / 32 )
    IF ( nYearMon % 2 ) = 1
      nMonth += 8
    ENDIF
Return cTod( Str ( nMonth, 2 ) + "/"                    + ;
             Str ( ( nMonDay - 1 ) % 32 + 1, 2 ) + "/"  + ;
             Str ( nYearInt, 2 ) )


Static Function ZipTime( nMinutes, nHourMin )
Local nHour := INT( nHourMin / 8 )
    nMinutes /= 32
    nMinutes += ( nHourMin - ( nHour * 8 ) ) * 8
Return ( Str( nHour, 2 ) + ":" + Str( INT( nMinutes ), 2 ) )



