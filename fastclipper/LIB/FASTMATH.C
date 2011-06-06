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


DWORD _fastuShr( DWORD nNumber, WORD nRota )
  {
  return( nNumber >> nRota );
  }

DWORD _fastuShl( DWORD nNumber, WORD nRota )
  {
  return( nNumber << nRota );
  }

DWORD _fastShr( DWORD nNumber, WORD nRota )
  {
  return( nNumber >> nRota );
  }

DWORD _fastShl( DWORD nNumber, WORD nRota )
  {
  return( nNumber << nRota );
  }

DWORD _fastDiv( DWORD nDividendo, DWORD nDivisor )
  {
  return( nDividendo / nDivisor );
  }

DWORD _fastMul( DWORD nOper1, DWORD nOper2 )
  {
  return( nOper1 * nOper2 );
  }

DWORD _fastMod( DWORD nNumber, DWORD nModulo )
  {
  return( nNumber % nModulo );
  }

double _fastDivd( double nOper1, double nOper2 )
  {
  return( nOper1 / nOper2 );
  }

double _fastMuld( double nOper1, double nOper2 )
  {
  return( nOper1 * nOper2 );
  }

double _fastAddd( double nOper1, double nOper2 )
  {
  return( nOper1 + nOper2 );
  }

double _fastSubd( double nOper1, double nOper2 )
  {
  return( nOper1 - nOper2 );
  }


