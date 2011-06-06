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


CLIPPER nAcre2Ha()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) / 2.4711 );
  }


CLIPPER nHa2Acre()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) * 2.4711 );
  }


CLIPPER nAcre2M()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) * 4046.85 );
  }


CLIPPER nM2Acre()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) / 4046.85 );
  }

