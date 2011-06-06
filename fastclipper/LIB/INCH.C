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


CLIPPER nCm2Inch()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) / 2.5399 );
  }

CLIPPER nInch2Cm()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) * 2.5399 );
  }


CLIPPER nCC2Inch()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) / 16.39 );
  }


CLIPPER nCCInch2()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) * 16.39 );
  }


