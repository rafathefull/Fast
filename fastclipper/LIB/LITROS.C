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


CLIPPER nCF2Ltr()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) * 28.3285 );
  }


CLIPPER nLtr2CF()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) / 28.3285 );
  }


CLIPPER nGal2Ltr()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) * 4.5454 );
  }


CLIPPER nLtr2Gal()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) / 4.5454 );
  }


