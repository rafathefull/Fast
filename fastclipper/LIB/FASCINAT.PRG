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


Function Fascinate( cColor1, cColor2 )
Local cCar1 := Space ( 80 )
Local cCar2 := Replicate ( "°", 80 )
Local cCar3 := Replicate ( "±", 80 )
Local cCar4 := Replicate ( "²", 80 )
Local cC1   := cColor2 + "+/" + cColor1 + "*"
Local cC2   := cColor1 + "+/" + cColor2 + "*"
    SetBlink( .F. )
    DispBegin()
    @ 0, 0 Say cCar1 Color cC2
    @ 1, 0 Say cCar1 Color cC2
    @ 2, 0 Say cCar1 Color cC2
    @ 3, 0 Say cCar2 Color cC2
    @ 4, 0 Say cCar2 Color cC2
    @ 5, 0 Say cCar2 Color cC2
    @ 6, 0 Say cCar4 Color cC1
    @ 7, 0 Say cCar4 Color cC1
    @ 8, 0 Say cCar4 Color cC1
    @ 9, 0 Say cCar3 Color cC2
    @10, 0 Say cCar3 Color cC2
    @11, 0 Say cCar3 Color cC2
    @12, 0 Say cCar3 Color cC1
    @13, 0 Say cCar3 Color cC1
    @14, 0 Say cCar3 Color cC1
    @15, 0 Say cCar4 Color cC2
    @16, 0 Say cCar4 Color cC2
    @17, 0 Say cCar4 Color cC2
    @18, 0 Say cCar2 Color cC1
    @19, 0 Say cCar2 Color cC1
    @20, 0 Say cCar2 Color cC1
    @21, 0 Say cCar1 Color cC1
    @22, 0 Say cCar1 Color cC1
    @23, 0 Say cCar1 Color cC1
    @24, 0 Say cCar1 Color cC1
    DispEnd()
Return ( Nil )



