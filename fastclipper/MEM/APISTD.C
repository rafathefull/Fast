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


#include "\libs\clipapi\clipapi.h"
#include "\borlandc\include\dos.h"
#include "\libs\clipapi\asmrules.h"
#include "\libs\clipapi\linker.h"



int ExoFreeSelector( unsigned int selector )
  {
  return( FALSE );
  }


int ExoIsDPMI( void )
  {
  return( FALSE );
  }


int ExoIsExoSpace( void )
  {
  return( FALSE );
  }


int ExoIsPM( void )
  {
  return( FALSE );
  }


void * ExoProtectedPtr( void * pmptr, unsigned int sizebytes )
  {
  return( pmptr );
  }


void * ExoRealPtr( void * rmptr )
  {
  return( rmptr );
  }


int ExoReside( void *pmptr )
  {
  return( FALSE );
  }


#pragma inline

#pragma option -r+

HIDE void Interruptus( WORD int_type, RMREGS *preg )
  {
  void    (far * Vector)(void);
  char    Code[14];

#if defined(__HUGE__)
#define WhereIsBP       -36
#else
#define WhereIsBP       -34
#endif

  asm     push    bp
  asm     push    ds
  asm     pushf

  asm     lea     cx, Code
  asm     mov     word ptr Vector, cx
  asm     mov     word ptr Vector+2, ss

  asm     mov     word ptr Code, 06E8Bh
  asm     mov     byte ptr Code+2, WhereIsBP
  asm     mov     byte ptr Code+3, 0CDh
  asm     mov     ax, int_type
  asm     mov     byte ptr Code+4, al
  asm     cmp     al, 025h
  asm     jb      NormalIntr
  asm     cmp     al, 026h
  asm     ja      NormalIntr
  asm     mov     byte ptr Code+5, 036h
  asm     mov     word ptr Code+6, 00068Fh
  asm     mov     word ptr Code+8, cx
  asm     mov     byte ptr Code+10, 0CAh
  asm     mov     word ptr Code+11, 2
  asm     jmp     SetRegs

  asm     popf_proc proc near
  asm     iret
  asm     popf_proc endp

NormalIntr:
  asm     mov     byte ptr Code+5, 0CAh
  asm     mov     word ptr Code+6, 2

SetRegs:
  asm     LDS_    di, preg
  asm     push    ds
  asm     push    di

  asm     mov     ax,[di].r_ax
  asm     mov     bx,[di].r_bx
  asm     mov     cx,[di].r_cx
  asm     mov     dx,[di].r_dx
  asm     push    word ptr [di].r_bp
  asm     mov     si,[di].r_si
  asm     mov     es,[di].r_es
  asm     lds     di,[di].r_di

  (* Vector)();

  asm     push    ds
  asm     push    di
  asm     push    bp
  asm     pushf

  asm     mov     bp,sp
  asm     lds     di,[bp+8]
  asm     mov     [di].r_ax,ax
  asm     mov     [di].r_bx,bx
  asm     mov     [di].r_cx,cx
  asm     mov     [di].r_dx,dx
  asm     mov     [di].r_si,si
  asm     mov     [di].r_es,es
  asm     pop     [di].r_flags
  asm     pop     [di].r_bp
  asm     pop     [di].r_di
  asm     pop     [di].r_ds

  asm     add     sp,4

  asm     push    cs
  asm     call    popf_proc

  asm     pop     ds
  asm     pop     bp

  }

#pragma option -r.




int ExoRMInterrupt( int intno, EXOREGS *inregs, EXOREGS *outregs)
  {
  RMREGS sRegs;

  sRegs.ax = inregs->ax;
  sRegs.bx = inregs->bx;
  sRegs.cx = inregs->cx;
  sRegs.dx = inregs->dx;
  sRegs.bp = inregs->bp;
  sRegs.si = inregs->si;
  sRegs.di = inregs->di;
  sRegs.ds = inregs->ds;
  sRegs.es = inregs->es;
  Interruptus( intno, & sRegs );
  outregs->ax = sRegs.ax;
  outregs->bx = sRegs.bx;
  outregs->cx = sRegs.cx;
  outregs->dx = sRegs.dx;
  outregs->bp = sRegs.bp;
  outregs->si = sRegs.si;
  outregs->di = sRegs.di;
  outregs->ds = sRegs.ds;
  outregs->es = sRegs.es;
  return( sRegs.flags );
  }


void ( *ExoSegCSAlias( void *pmptr))()
  {
  return( pmptr );
  }


void *ExoSegDSAlias( void *pmptr() )
  {
  return( pmptr );
  }


void * _xalloclow( unsigned int nBytes )
  {
  return( _xgrab( nBytes ) );
  }


void _xfreelow( void * cPointer )
  {
  _xfree( cPointer );
  }


