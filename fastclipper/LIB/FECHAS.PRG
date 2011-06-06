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
#include "fast.ch"

FAST_VERSION


FUNCTION dToDMY( dDate )
RETURN( StrZero( DAY  ( dDate ), 2 ) + "/" + ;
        StrZero( MONTH( dDate ), 2 ) + "/" + ;
        AllTrim( STR( YEAR ( dDate ) ) ) )


FUNCTION dToMDY( dDate )
RETURN( StrZero( MONTH( dDate ), 2 ) + "/" + ;
        StrZero( DAY  ( dDate ), 2 ) + "/" + ;
        AllTrim( STR( YEAR ( dDate ) ) ) )


FUNCTION dAddMonth ( dDate, nMonths )
LOCAL nMonthAdd
LOCAL nMonth   := MONTH ( dDate )
LOCAL nDay     := DAY ( dDate )
LOCAL nYear    := YEAR ( dDate )
   nYear += INT ( nMonths / 12 )
   IF INT ( nMonths % 12 ) >= 12 - nMonth + 1
      nYear++
   ENDIF
   nMonthAdd := nMonths % 12 
   nMonth    := ( nMonth + nMonthAdd ) % 12
   nMonth    := IIF( nMonth == 0, 12, nMonth )
RETURN ( cTod ( STR ( nMonth, 2 ) + "/" + ;
                STR ( nDay, 2 )   + "/" + ;
                STR ( nYear, 4 ) ) )


FUNCTION cGetMonth( nMes )
RETURN IIF( nMes > 0 .AND. nMes < 13, GiveMsg( MSG_DATA_MESES )[ nMes ], "" )


FUNCTION Sec2Days ( nSeconds )
RETURN INT( nSeconds / 86400 )


FUNCTION LastDay( dDate )
    DEFAULT dDate = DATE()
RETURN ( dDate += 45 - DAY( dDate ) ) - DAY( dDate )


FUNCTION FirstDay( dDate )
    DEFAULT dDate = DATE()
RETURN ( dDate - ( DAY( dDate ) - 1 ) )


FUNCTION lLeap ( dDate )
LOCAL nY := YEAR( dDate )
RETURN ( ( nY % 4 ) == 0 ) .AND. ( ( ( nY % 100 ) != 0 ) .OR. ( ( nY % 400 ) == 0 ) )

