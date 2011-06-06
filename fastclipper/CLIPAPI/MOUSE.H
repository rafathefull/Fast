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


#define mtMOVE         1
#define LEFTBPRESS     2
#define LEFTBRELEASE   4
#define RIGHTBPRESS    8
#define RIGHTBRELEASE 16
#define MIDBPRESS     32
#define MIDBRELEASE   64

#define LEFTBDOWN  1
#define RIGHTBDOWN 2
#define MIDBDOWN   4

struct minforectype
  {
  WORD buttonstat;
  WORD cx, cy;
  };

#define mtINFOREC struct minforectype

extern LPWORD MouseArrow;
extern LPWORD MouseMove;
extern LPWORD MouseHori;
extern LPWORD MouseVerti;
extern LPWORD MouseTotalL;
extern LPWORD MouseTotalR;

