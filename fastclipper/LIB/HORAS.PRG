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


Function Time2Time(cTIME1,cTIME2)
Local nTime1, nTime2, nDelSecs, nHrs, nMins, nSecs, nSecs1, nSecs2
    nSecs1 := Val( SubStr( cTime1, 1, 2 ) ) * 3600 + ;
              Val( SubStr( cTime1, 4, 2 ) ) * 60 + ;
              Val( SubStr( cTime1, 7 ) )
    nSecs2 := Val( SubStr( cTime2, 1, 2 ) ) * 3600 + ;
              Val( SubStr( cTime2, 4, 2 ) ) * 60 + ;
              Val( SubStr( cTime2, 7 ) )
    nDelSecs := Abs( nSecs2 - nSecs1 )
    nHrs     := Int(nDELSECS / 3600)
    nMins    := Int( ( nDelSecs - nHrs * 3600 ) / 60 )
    nSecs    := nDelSecs - ( nHrs * 3600 ) - ( nMins * 60 )
Return( Str( nHrs, 2 ) + ":" + Str( nMins, 2 ) + ":" + Str( nSecs, 2 ) )


Function TimeAMPM()
Local cTime := Time()
    If Val( cTime ) < 12
      cTime += " am"
    ElseIf Val( cTime ) == 12
      cTime += " pm"
    Else
      cTime := Str( Val( cTime ) - 12, 2 ) + SubStr( cTime, 3 ) + " pm"
    EndIf
Return( cTime )



