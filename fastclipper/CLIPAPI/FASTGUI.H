/* 
------------------------------------------------------------------------
FASTlib for Clipper, including all source code, examples and any other 
file has been donated to Open Source community

Manu Roibal. Bilbao, May 7 2011

------------------------------------------------------------------------
Please, contact me at	manuroibal@gmail.com
Follow me at Twitter	@manuroibal 
My Linkedin profile	www.linkedin.com/manuroibal

Or visit my web site at	www.tonsofit.com
------------------------------------------------------------------------
*/

DWORD _mnuuShr( DWORD nNumber, int nRota );
DWORD _mnuuShl( DWORD nNumber, int nRota );
long _mnuShr( long nNumber, int nRota );
long _mnuShl( long nNumber, int nRota );
long _mnuDiv( long nDividendo, long nDivisor );
long _mnuMul( long nOper1, long nOper2 );
long _mnuMod( long nNumber, long nModulo );
double _mnuDivd( double nOper1, double nOper2 );
double _mnuMuld( double nOper1, double nOper2 );
double _mnuAddd( double nOper1, double nOper2 );
double _mnuSubd( double nOper1, double nOper2 );


extern LPBYTE vMenuText;
extern LPBYTE vMenuGraph;
extern LPBYTE vMenuBios;
extern LPBYTE vMenuInter;
extern LPBYTE vMenuFont;
extern LPBYTE vMenuHardCopy;

void waitRetrace( void );

