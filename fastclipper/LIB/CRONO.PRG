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


Function Chrono ( nCrono, lModo )
Static nCrono1
Static nCrono2
Static nCrono3
Local  nRet
     nCrono1 := Seconds()
     nCrono2 := Seconds()
     nCrono3 := Seconds()
     nCrono := If ( nCrono == Nil,   1, nCrono )
     lModo  := If ( lModo  == Nil, .F., lModo )
     If nCrono == 1
       nRet    := Seconds() - nCrono1
       nCrono1 := If ( lModo, Seconds(), nCrono1 )
     ElseIf nCrono == 2
       nRet    := Seconds () - nCrono2
       nCrono2 := If ( lModo, Seconds(), nCrono2 )
     ElseIf nCrono == 3
       nRet    := Seconds () - nCrono3
       nCrono3 := If ( lModo, Seconds(), nCrono3 )
     EndIf
Return ( nRet )



