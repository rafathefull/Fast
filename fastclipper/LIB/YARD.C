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



CLIPPER nCM2CYd()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) * 1.308 );
  }


CLIPPER nCYd2CM()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) / 1.308 );
  }


CLIPPER nMt2Yd()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) * 1.0936 );
  }


CLIPPER nYd2Mt()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) / 1.0936 );
  }


