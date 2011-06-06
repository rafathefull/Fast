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


#include <extend.h>


#define NUM_PI   3.141592
#define NUM_E    2.7182818285


static double _sin( double );
static double _cos( double );


CLIPPER Sin()
  {
  if ( PCOUNT == 1 )
    _retnd( _sin( _parnd( 1 ) ) );
  }


CLIPPER Cos()
  {
  if ( PCOUNT == 1 )
    _retnd( _cos( _parnd( 1 ) ) );
  }


CLIPPER Tan()
  {
  if ( PCOUNT == 1 )
    _retnd( _sin( _parnd( 1 ) ) / _cos( _parnd( 1 ) ) );
  }


CLIPPER CoTan()
  {
  if ( PCOUNT == 1 )
    _retnd( _cos( _parnd( 1 ) ) / _sin( _parnd( 1 ) ) );
  }


CLIPPER Sec()
  {
  if ( PCOUNT == 1 )
    _retnd( 1 / _sin( _parnd( 1 ) ) );
  }


CLIPPER CoSec()
  {
  if ( PCOUNT == 1 )
    _retnd( 1 / _cos( _parnd( 1 ) ) );
  }


CLIPPER Rad2Deg()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) * 180 / NUM_PI );
  }


CLIPPER Deg2Rad()
  {
  if ( PCOUNT == 1 )
    _retnd( _parnd( 1 ) * NUM_PI / 180 );
  }


CLIPPER NumPi()
  {
  _retnd( NUM_PI );
  }


CLIPPER NumE()
  {
  _retnd( NUM_E );
  }


static double _sin( double nNumero )
  {
  double nAprox  = nNumero;
  double nDifer  = nNumero;
  double nAbs    = nNumero;
  long   nRepet  = 1;
  long   nAux;

  nAbs = ( nAbs < 0 ) ? -nAbs : nAbs;
  while ( nAbs >= 0.00000001 )
    {
    nAux   = ( nRepet << 1 );
    nAprox += ( nDifer = ( nDifer * - ( nNumero * nNumero ) ) / ( nAux * ( nAux + 1 ) ) );
    nRepet++;
    nAbs = ( nDifer < 0 ) ? -nDifer : nDifer;
    }
  return( nAprox );
  }


static double _cos( double nNumero )
  {
  return( _sin( 1.5707 - nNumero ) );
  }

