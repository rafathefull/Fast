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



#include "fast.ch"
#include "language.ch"
#include "\libs\clipapi\version.ch"

FAST_VERSION

#define nX      90
#define nY      320
#define nAncho  549


FUNCTION BackGraph( cTitulo, nMax, nSombra, nMin )
LOCAL nInd     := 0
LOCAL cPicture := IIF( GiveMsg( MSG_ANGLOSAJON ), ;
                          "999,999,999,999", ;
                       "@E 999,999,999,999" )
    DEFAULT nMin = 0
    BackG( cTitulo, nSombra )
    IF nMin >= 0
      FOR nInd := 1 TO 4
        DispStr( PadL ( AllTrim ( Transform ( nMax / 4 * nInd, cPicture ) ), 15 ), ;
                 nX + nAncho - 15 * 8, nY - 16 - nInd * 62, 0, 11 )
      NEXT
    ELSE
      nMax := Max( nMax, Abs(nMin) )
      nMin := -nMax
      FOR nInd := 1 TO 2
        DispStr( PadL ( AllTrim ( Transform ( -nMax / 2 * (3-nInd), cPicture ) ), 15 ), ;
                 nX + nAncho - 15 * 8, nY - 16 - (nInd-1) * 62, 0, 11 )
      NEXT
      DispStr( PadL ( AllTrim ( Transform ( 0, cPicture ) ), 15 ), ;
               nX + nAncho - 15 * 8, nY - 16 - (3-1) * 62, 0, 11 )
      FOR nInd := 1 TO 2
        DispStr( PadL ( AllTrim ( Transform ( nMax / 2 * nInd, cPicture ) ), 15 ), ;
                 nX + nAncho - 15 * 8, nY - 16 - (nInd+3-1) * 62, 0, 11 )
      NEXT
    endif
RETURN NIL

