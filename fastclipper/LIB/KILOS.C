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


CLIPPER nGr2Oz()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) / 28.328 );
  }



CLIPPER nOz2Gr()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) * 28.328 );
  }



CLIPPER nKg2Lb()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) * 2.2046 );
  }



CLIPPER nLb2Kg()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) / 2.2046 );
  }


