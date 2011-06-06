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



typedef struct
  {
  WORD ax, bx, cx, dx;
  WORD bp, si, di, ds, es, flags;
  } RMREGS ;


typedef struct
  {
  unsigned ds, es;
  unsigned di, si, bp, sp;
  unsigned bx, dx, cx, ax;
  } EXOREGS;


int    ExoFreeSelector(unsigned int selector);
int    ExoIsDPMI(void);
int    ExoIsExoSpace(void);
int    ExoIsPM(void);
int    ExoIsVMM(void);
void  *ExoProtectedPtr(void *rmptr, unsigned int sizebytes);
void  *ExoRealPtr(void *pmptr);
int    ExoReside(void *pmptr);
int    ExoRMInterrupt(int intno, EXOREGS *inregs, EXOREGS *outregs);
void (*ExoSegCSAlias(void *pmptr))();
void  *ExoSegDSAlias(void *pmptr());
void  *_xalloclow(unsigned int sizebytes);
void   _xfreelow(void *lowmemory);


