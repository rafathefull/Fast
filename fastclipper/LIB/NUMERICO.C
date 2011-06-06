/* 
------------------------------------------------------------------------
FASTlib for Clipper, including all source code, examples and any other 
file has been donated to Open Source community

Manu Roibal. Bilbao, May 7 2011

------------------------------------------------------------------------
Please, contact me at	manuroibal@gmail.com
Follow me at Twitter	@manuroibal on Twitter
My Linkedin profile	www.linkedin.com/manuroibal

Or visit my web site at	www.tonsofit.com
------------------------------------------------------------------------
*/


#include "\libs\clipapi\clipapi.h"


CLIPPER Factorial()
  {
  long xRet = 0;
  long nInd;
  long nNumero = _parnl( 1 );

  if ( nNumero >= 0 )
    {
    xRet = 1;
    for ( nInd = 2; nInd <= nNumero; nInd++ )
      xRet *= nInd;
    _retnl( xRet );
    }
  }


CLIPPER Sum()
  {
  long xRet = 0;
  long nInd;
  long nNumero = _parnl( 1 );

  if ( nNumero >= 0 )
    {
    for ( nInd = 1; nInd <= nNumero; nInd++ )
      xRet += nInd;
    _retnl( xRet );
    }
  }


CLIPPER Exponent()
  {
  long xRet      = _parnl( 1 );
  long nNumero   = _parnl( 1 );
  long nInd;
  long nPotencia = _parnl( 2 );

  if ( PCOUNT == 1 )
    nPotencia = 2;
  if ( xRet >= 0 )
    {
    for ( nInd = 2; nInd <= nPotencia; nInd++ )
      xRet *= nNumero;
    _retnl( xRet );
    }
  }

