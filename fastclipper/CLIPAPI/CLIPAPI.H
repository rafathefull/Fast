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


/*
>>>>>>>>>>>>>>>>>>>>>>     Clipper API ver 1.0 <<<<<<<<<<<<<<<<<<<<<<<<<<<<
*/


#define INT_PRINTSCR    0x5
#define INT_VIDEO       0x10
#define INT_VESA        0x10
#define INT_EQUIPMENT   0x11
#define INT_DISK        0x13
#define INT_COMM        0x14
#define INT_COMS        0x15
#define INT_KEYBOARD    0x16
#define INT_PRINTER     0x17
#define INT_CLOCK       0x1A
#define INT_DOS         0x21
#define INT_IDLE        0x28
#define INT_LAN         0x2A
#define INT_MISCEL      0x2F
#define INT_DPMI        0x31
#define INT_MOUSE       0x33
#define INT_EMS         0x67


#ifndef _CLIPAPI_H
#define _CLIPAPI_H

/* Types for wType in generic struct CLIPVAR */
#define NULL            0L
#define NIL             0x0000
#define NUMERIC         0x0002   /* DWORD */
#define NUM_FLOAT       0x0008
#define DATE            0x0020
#define LOGICAL         0x0080
#define CHARACTER       0x0400
#define BLOCK           0x1000
#define ARRAY           0x8000
#define OBJECT          ARRAY

#define BY_REF          0x2000   /* Locals and Statics Ref's */
#define BY_REF_MEM      0x4000   /* MemVars Ref's */


#define MK_FP( seg,ofs )( (void _seg * )( seg ) +( void near * )( ofs ))
#define FP_SEG( fp )( (unsigned )( void _seg * )( void far * )( fp ))
#define FP_OFF( fp )( (unsigned )( fp ))


#define ANYREF          0x6000   /* Mask Any referenced type. */
#define ANYNUMBER       0x000A   /* Mask any Numerical type. 0x0002 & 0x0008 */
#define ALLTYPES        0xFFFF   /* Mask all types. */

#define CLIPPER void pascal
#define INDEX   unsigned int
#define HIDE    static

#ifndef __WINDOWS_H

typedef signed   char STR;
typedef unsigned char BYTE;
typedef unsigned int  WORD;
typedef signed   long LONG;
typedef unsigned long DWORD;
typedef double        DOUBLE;

typedef BYTE far  * LPBYTE;
typedef STR  far  * LPSTR;
typedef int  * PINT;       /* ¨ Punteros cortos ¢ largos ? OJO */
typedef int  far * LPINT;
typedef WORD * PWORD;      /* ¨ Punteros cortos ¢ largos ? OJO */
typedef WORD far * LPWORD;
typedef LONG * PLONG;
typedef LONG far * LPLONG;
typedef DWORD* PDWORD;
typedef DWORD far * LPDWORD;

typedef unsigned short USHORT;
typedef USHORT HANDLE;


typedef void far * FARP;
typedef FARP far * FARPP;

typedef enum{ FALSE, TRUE } BOOL;

#define MAKELONG(low, high) ((DWORD)(((WORD)(low)) | \
                            (((DWORD)((WORD)(high))) << 16)))

#endif



typedef struct
{
   WORD  wType;
   WORD  w2;
   WORD  w3;
   LPBYTE pPointer1;
   LPBYTE pPointer2;
} CLIPVAR;              /* sizeof( CLIPVAR )  --> 14 bytes */


/* Una especie de herencia del struct CLIPVAR para types NUMERIC */
typedef struct
{
   WORD wType;
   LONG lDummy1;
   LONG lnNumber;
   LONG lDummy2;
     
} CLV_LONG;


typedef struct
{
   WORD wFloat[ 4 ];
} CLIP_FLOAT;


/* Una especie de herencia del struct CLIPVAR para types NUM_FLOAT
   aun est  por desarrollar. Son las funciones _dv..... */
typedef struct
{
   WORD wType;
   LONG lDummy1;
   CLIP_FLOAT fFloat;
     
} CLV_FLOAT;

/* Estructura CLV_WORD para NUMERIC (WORD) y para los LOGICAL (BOOL). */
typedef struct
{
    WORD wType;
    LONG lDummy;
    WORD wWord;       /* Para clipvars LOGICAL -> Casting a (BOOL) */
    WORD wDummy[ 3 ];

} CLV_WORD;

/* Estructura VITEMCHAR para VITEM's CHAR. */
typedef struct
{
    WORD wType;
    WORD wLen;
    WORD wDummy[ 5 ];

} CLV_CHAR;


typedef CLIPVAR near * PCLIPVAR;
typedef CLIPVAR far * LPCLIPVAR;

typedef void ( pascal * PCLIPFUNC )( void );

typedef struct
{
   BYTE cName[ 11 ];
   BYTE cType;
   LPBYTE * pSymbol;    /* Is a LPCLIPSYMBOL. You must cast. */
} CLIPNAME;             /* 16 bytes */

typedef CLIPNAME * PCLIPNAME;
typedef CLIPNAME far * LPCLIPNAME;

typedef struct
{
   BYTE Dummy[ 8 ];
   PCLIPNAME pName;
   PCLIPFUNC pFunc;
} CLIPSYMBOL;                        /* 16 bytes */

typedef CLIPSYMBOL * PCLIPSYMBOL;
typedef CLIPSYMBOL far * LPCLIPSYMBOL;

extern PCLIPSYMBOL _SymEval;         /* == _Get_Sym( "EVAL" ) */
                                     /* SymSys init           */


/*
>>>>>>>>> EXTEND Module - Clipper Extend system functions <<<<<<<<<<<<<<<<
*/

extern WORD   _parinfo( WORD );
extern WORD   _parinfa( WORD, WORD );
extern LPSTR  _parc( WORD wParam, ... );
extern WORD   _parclen( WORD wParam, ... );
extern BOOL   _parl( WORD wParam, ... );
extern WORD   _parni( WORD wParam, ... );
extern LONG   _parnl( WORD wParam, ... );
extern double _parnd( double wParam, ... );
extern void   _retc( LPSTR );
extern void   _retds( LPSTR );
extern void   _retclen( LPSTR, WORD );
extern void   _retl( BOOL );
extern void   _retni( WORD wNumber );
extern void   _retnl( DWORD lNumber );
extern void   _retnd( double ndNumber );
extern void   _ret( void );
extern void   _reta( WORD wArrayLen );      /* Creates and returns an Array */
extern BOOL   _storc( LPSTR, WORD, ... );
extern BOOL   _storclen( LPSTR, WORD, WORD, ... );
extern BOOL   _storl( BOOL, WORD, ... );
extern BOOL   _storni( WORD, WORD, ... );
extern BOOL   _stornl( LONG, WORD, ... );
extern void   _xunlock( void );
extern LPBYTE _xgrab( WORD wSize );
extern LPBYTE _xalloc( WORD wSize );
extern void   _xfree( LPBYTE );

#define  ISCHAR( c )     ( ( _lbase + c + 1 )->wType & CHARACTER )
#define  ISNUM( c )      ( ( _lbase + c + 1 )->wType & ANYNUMBER )
#define  ISLOGICAL( c )  ( ( _lbase + c + 1 )->wType & LOGICAL )
#define  ISARRAY( c )  ( ( _lbase + c + 1 )->wType & ARRAY )
#define  ISDATE( c )  ( ( _lbase + c + 1 )->wType & DATE )
#define  ISBLOCK( c )  ( ( _lbase + c + 1 )->wType & BLOCK )
#define  ISBYREF( c )  ( ( _lbase + c + 1 )->wType & ANYREF )



/* Retrieves any parameter checking type. Use ALLTYPES #define for no test. */
extern PCLIPVAR _param( WORD wParam, WORD wType );

/* Number of parameters */
extern WORD _pcount;

#define PCOUNT _parinfo(0)

typedef struct
{
   BYTE Red, Green, Blue, Attr;       /* Four bytes */
} RGB;

/*
>>>>>>>>>>>>>>>>>>>>> COLOR Module - Colors Control <<<<<<<<<<<<<<<<<<<<<<
*/

/* General Terminal */
typedef struct
{                         /*  R   G   B   +* */
   RGB Fore;              /*  FF  FF  FF  00 */
   RGB Back;              /*  FF  FF  FF  00 */
} COLOR;

extern COLOR * _colors;       /* _colors[ 5 ]             */
extern WORD _ColorCount;      /* Number of colors used ¨? */
void _xSetColor( PCLIPVAR );  /* String dBase Colors      */
void CParse( LPSTR cColor, LPWORD nColor, COLOR * Color );

/*
>>>>>>>>>>>>>>>>>>    GT Module - General Terminal  <<<<<<<<<<<<<<<<<<<<<<<
*/

typedef struct
{
   WORD wTop;
   WORD wLeft;
   WORD wHeight;
   WORD wWidth;
} RECT;            /* as¡ no hay conflicto con el rect de windows.h */

typedef RECT * PRECT;

typedef struct
{
   BYTE cMasc1;
   BYTE cMasc2;
   BYTE cMasc3;
   WORD nY;
   WORD nX;
   BYTE reserved[ 9 ];
} gtIcon;

typedef gtIcon * LPgtIcon;

typedef struct
{
   WORD wTop, wLeft, wHeight, wWidth;
   BYTE RGBColor[ 8 ];
   BYTE bDummy1[ 8 ];
   LPBYTE p34Bytes;
   BYTE bDummy2[ 10 ];
} WINDOW;

typedef WINDOW * HWND;
typedef HWND *   PHWND;

typedef struct {
    BYTE   VESASignature[ 4 ];
    BYTE   VESAVersion[ 2 ];
    LPBYTE OEMStringPtr;
    BYTE   Capabilities[ 4 ];
    LPBYTE VideoModePtr;
    WORD   TotalMemory;
    BYTE   Reserved[ 236 ];
} VESA_INFO;


typedef struct {
    /* v1.0 */
    WORD   ModeAttributes;
    BYTE   WinAAtributtes;
    BYTE   WinBAtributtes;
    WORD   WinGranularity;
    WORD   WinSize;
    WORD   WinASegment;
    WORD   WinBSegment;
    LPBYTE WinFuncPtr;
    WORD   BytesPerScanLine;
    /* opcional en versiones 1.0 y 1.1 */
    WORD   XResolution;
    WORD   YResolution;
    BYTE   XCharSize;
    BYTE   YCharSize;
    BYTE   NumberOfPlanes;
    BYTE   BitsPerPixel;
    BYTE   NumberOfBanks;
    BYTE   MemoryModel;
    BYTE   BankSize;
    BYTE   NumberOfImagePages;
    BYTE   Reserved;
    /* v1.2 */
    BYTE   RedMaskSize;
    BYTE   RedFieldPosition;
    BYTE   GreenMaskSize;
    BYTE   GreenFieldPosition;
    BYTE   BlueMaskSize;
    BYTE   BlueFieldPosition;
    BYTE   RsvdMaskSize;
    BYTE   DirectColorModeInfo;
    BYTE   Reserved20[ 216 ];
} VESA_MODE_INFO;


#define CLR_STRLEN  64

#define _B_SINGLE          "ÚÄ¿³ÙÄÀ³ "
#define _B_DOUBLE          "ÉÍ»º¼ÍÈº "
#define _B_SINGLE_DOUBLE    "ÖÄ·º½ÄÓº "
#define _B_DOUBLE_SINGLE    "ÕÍ¸³¾ÍÔ³ "


#define  GT_MODE_VESA  1
#define  GT_MODE_VGA   2
#define  GT_MODE_TXT   3


WORD _gtBox( WORD, WORD, WORD, WORD, LPBYTE );
WORD _gtColorSelect( WORD wColor );      /* __color() in 5.01 */
WORD _gtMaxRow( void );
WORD _gtMaxCol( void );
WORD _gtGetColorStr( LPBYTE cColor );
WORD _gtSetColorStr( LPBYTE cColor );
WORD _gtGetCursor( LPWORD nCursor );
WORD _gtSetCursor( WORD nCursor );
WORD _gtSetColor( COLOR * pColors );
WORD _gtGetColor( COLOR * pColors );
WORD _gtSetPos( WORD wRow, WORD wCol );
WORD _gtGetPos( LPWORD pwRow, LPWORD pwCol );
WORD _gtScroll( WORD, WORD, WORD, WORD, int, ... );
WORD _gtWriteAt( WORD wRow, WORD wCol, LPBYTE szText, WORD wLen );
WORD _gtWrite( LPBYTE szText, WORD wLen );
WORD _gtWriteCon( LPBYTE szText, WORD wLen );
WORD _gtSave( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight, LPBYTE pBuffer );
WORD _gtScrDim( LPWORD pwRows, LPWORD pwCols );
WORD _gtRest( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight, LPBYTE pBuffer );
WORD _gtRectSize( WORD wTop, WORD wLeft, WORD wBottom, WORD wRight, LPWORD wResult );
WORD _gtRepChar( WORD wRow, WORD wCol, WORD wChar, WORD wTimes );
WORD _gtPreExt( void );
WORD _gtPostExt( void );
WORD _gtDispBegin( void );
WORD _gtDispEnd( void );

/* Undocumented Windowing System !!! */
void _gtWCreate( PRECT rctCoors, PHWND hWnd );
void _gtWDestroy( HWND hWnd );
void _gtWCurrent( HWND hWnd );
BOOL _gtWVis( HWND hWnd, WORD wStatus );
BOOL _gtWFlash( void );
void _gtWApp( PHWND hWndApp );
void _gtWPos( HWND hWnd, PRECT rctCoors );

/* Selects a color - Clipper calling conventions */
extern void _color( void );

/* extended GT - FastGT */
void _gtInfo( LPBYTE, WORD );
WORD _gtInstallation( void );
BYTE _gtClrGet( BYTE wColor, BYTE nMode );
void _gtLineX( WORD nY, WORD nX1, WORD nX2, BYTE nColor );
void _gtLineY( WORD nX, WORD nY1, WORD nY2, BYTE nColor );
void _gtLineYX( WORD nY1, WORD nX1, WORD nY2, WORD nX2, BYTE nColor );
BYTE _gtGetPixel( WORD nY, WORD nX );
void _gtSetPixel( WORD nY, WORD nX, BYTE nColor );
WORD _gtBank( void );
void _gtSetBank( WORD nBanco );
void _gtArea( WORD nY1, WORD nX1, WORD nY2, WORD nX2, BYTE nColor );
void _gtGetBank( WORD nY, WORD nX, LPWORD nBank, LPWORD nPos );
WORD _gtIsVESA( void );
LPBYTE _gtVESAVer( void );
LPBYTE _gtVESAOEM( void );
WORD _gtVESAMEM( void );
BYTE _gtGetSpeed( void );
void _gtSetSpeed( BYTE nSpeed );
void _gtStart( WORD nRow, WORD nCol );
BYTE _gtGetFont( void );
void _gtSetFont( BYTE nFont );
void _gtUserFont( LPBYTE cFont );
WORD _gtGetVESA( void );
BOOL _gtSetVESA( WORD nMode, WORD lNoFill );
void _gtFastWrite( WORD wRow, WORD wCol, LPBYTE szText, WORD wLen, BYTE bClrFore, BYTE bClrBack, WORD nSpace, WORD nSizeH, WORD nSizeW );
void _gtWriteTxt( WORD wRow, WORD wCol, LPBYTE szText, WORD wLen );
void _gtSetZone( WORD nY1, WORD nX1, WORD nY2, WORD nX2, LPBYTE cBuffer );
void _gtGetZone( WORD nY1, WORD nX1, WORD nY2, WORD nX2, LPBYTE cBuffer );
void _gtWriteZone( WORD nY1, WORD nX1, WORD nY2, WORD nX2, LPBYTE cBuffer );
void _gtReadZone( WORD nY1, WORD nX1, WORD nY2, WORD nX2, LPBYTE cBuffer );
void _gtSetDAC( LPBYTE cPaleta, WORD nInic, WORD nColors );
void _gtGetDAC( LPBYTE cPaleta, WORD nInic, WORD nColors );
void SetPixel16( WORD, WORD, WORD );
WORD GetPixel16( WORD, WORD );
WORD GetBlock16( WORD, WORD, WORD, WORD, FARP );
void SetBlock16( WORD, WORD, WORD, WORD, FARP );
void DispChar16( WORD, WORD, WORD, BYTE, BYTE, BYTE );
void DrawLine16( WORD, WORD, WORD, WORD, BYTE );
BOOL _gtSetSpeedVESA( WORD, WORD, WORD, WORD, LPBYTE );
BOOL _gtGetSpeedVESA( WORD, WORD, WORD, WORD, LPBYTE );
void _gtSetLowVESA( WORD, WORD, WORD, WORD, LPBYTE );
void _gtGetLowVESA( WORD, WORD, WORD, WORD, LPBYTE );

/* extended GT Mouse - FastGT */
WORD _gtMouseInstall( void );
WORD _gtGetMouseX( void );
WORD _gtGetMouseY( void );
void _gtSetMouseX( WORD nPos );
void _gtSetMouseY( WORD nPos );
WORD _gtMouseButtons( void );
WORD _gtMouseIs( void );
void _gtMouseOn( void );
void _gtMouseOff( void );
void _gtSetInterrupt( WORD nMasc );
void _gtMouseInit( void );
void _gtMouseDraw( WORD nY, WORD nX );
void _gtMouseSave( WORD nY, WORD nX );
void _gtMouseRest( WORD nY, WORD nX );
void _gtMousePoint( void );
void _gtMouseClock( void );
WORD _gtMouseKey( void );
extern WORD _gtCapture;
extern WORD _gtModeActive;

/*
>>>> STACK and OM Module - Clipper internal stack and ClipVars management <<<<
*/

/* it stores the return value of a function return ... */
extern PCLIPVAR _eval;

/* _lbase + 1  --> Self from within Methods ! Reach it with _par...( 0, ... ) !
   _lbase + 2  --> First parameter
   _lbase + 3  --> Second parameter
   ... */
extern PCLIPVAR _lbase;      /* LOCAL BASE */

/* statics */
extern PCLIPVAR _sbase;      /* STATIC BASE */

/* Clipper Stack   tos = TO S tack */
extern PCLIPVAR _tos;


/* They automatically update _tos. */
extern void _PutC( LPSTR szText );
extern void _PutCL( LPSTR szText, WORD wLen );
extern void _PutQ( WORD wNumber );
extern void _PutLN( LONG lNumber );
extern void _PutL( BOOL );

/* Places any CLIPVAR at Clipper Stack.  Pass ClipVars by value.
   Automatically updates _tos */
extern void _xPushM( LPCLIPVAR );    


/* calling Clipper from C */
extern void _PutSym( PCLIPSYMBOL );
/* ( ++_tos )->wType = NIL;      <- We place nil at Self !!!
   we place other params with _Put... */
extern void _xDo( WORD wParams );


/* executing CodeBlocks */

/* _PutSym( _symEVAL ); */
extern void _xEval( WORD wNumberOfParameters );

extern void _cEval0( PCLIPVAR CodeBlock ); /* evalua codeblock sin parametros. */
extern void _cEval1( PCLIPVAR CodeBlock, PCLIPVAR Param1 ); /* idem con un par metro. */


extern PCLIPVAR _GetGrip( PCLIPVAR ); /* allocates new clipvar in high stack pos. */
extern void    _DropGrip( PCLIPVAR ); /* free it. */


/* Returns pointer to _lbase of calls stack, 0->this, 1->previous, ... */
extern PCLIPVAR _ActInfo( WORD wIndex );


extern WORD  _sptoq( PCLIPVAR );   /* Returns the value of a number placed at _tos */
                                   /* By value or by ref as WORD */
extern LONG  _sptol( PCLIPVAR );   /* IDEM as LONG */


/* Copy wBytes from Source to Destination */
extern void _bcopy( LPBYTE pDest, LPBYTE pSource, WORD wBytes );

/* Move wBytes from Source to Destination */
extern void _bmove( LPBYTE pDest, LPBYTE pSource, WORD wBytes );

/* compare wBytes from Source to Destination */
extern WORD _bcmp( LPBYTE pDest, LPBYTE pSource, WORD wBytes );

/* Inicializes wLen Bytes with the value wValue */
extern void _bset( LPBYTE pStart, WORD wValue, WORD wLen );

/* Retrieves an element of an array */
extern void _cAt( PCLIPVAR vArray, WORD wIndex, WORD wFlag, PCLIPVAR vDest );

/* Changes an element of an array */
extern void _cAtPut( PCLIPVAR vArray, WORD wIndex, PCLIPVAR vSource );

/* Stores a String into an array element */
extern void _cAtPutStr( PCLIPVAR vArray, WORD wIndex, LPSTR szString,
                        WORD wStrLen );

/* Strings
   Creates a new String. Stores a CLIPVAR at _eval
*/
extern void pascal _BYTESNEW( WORD wLenBytes );

/* Locks a CLIPVAR String to access its bytes
   if need unlock returns TRUE
*/
extern BOOL pascal _VSTRLOCK( PCLIPVAR vString );

/* Gets the LPSTR of the String. It must be locked before with _VSTRLOCK */
extern LPSTR pascal _VSTR( PCLIPVAR vString );

/* UnLocks the String */
extern void pascal _VSTRUNLOCK( PCLIPVAR vString );


LPSTR _StrScan( LPSTR szSearchAt, LPSTR szSearchFor );

/* Arrays
   Retrieves the Len of an array
*/
extern WORD pascal _VARRAYLEN( PCLIPVAR vArray );

/* Creates and returns an Array in _eval */
extern void pascal _ARRAYNEW( WORD wLen );


/*
   Add a new element to an array
   _tos + 1  --> array
   _tos + 2  --> element
   _tos must be incremented
*/
extern void pascal __AADD( void );

/* Resizes an Array
   Parameters must be placed usign _tos
   pcount must be updated
*/
extern void pascal ASIZE( void );

/* Retrieves the Symbol of a String */
extern PCLIPSYMBOL _Get_Sym( LPSTR szName );

/*
>>>>>>>>>>>>>>>>>>>> SEND Module - OOPS Management ! <<<<<<<<<<<<<<<<<<<<
*/

/* Creates a new Class */
LONG _mdCreate( WORD wMethods, PCLIPNAME pClassName );

/* Adds a new Method to a ClassH */
extern _mdAdd( LONG lClassHandle, PCLIPSYMBOL pMethodName, PCLIPFUNC pMethod );

/* Gets the function address of a method
   Message info must be placed at ( _lbase + 0 )->pMsg
   Self must be placed at _lbase + 1
*/
extern PCLIPFUNC _isendp( void );

/* Retrieves the ClassH of an Object */
extern LONG _VDict( PCLIPVAR );

/* Changes the ClassH of an Object or Array */
extern void _VSetDict( PCLIPVAR, LONG );

void _xSend( WORD wNumberOfParameters );

#define INSTVAR(Name,pCode) _mdAdd(ulHandle,_get_sym(Name),pCode); _mdAdd(ulHandle,_get_sym("_"Name),pCode)
#define METHOD(Name,pCode) _mdAdd(ulHandle,_get_sym(Name),pCode)

/*********************************************************/


/*
   executes a CodeBlock
   lbase + 1  --> CodeBlock
   lbase + 2  --> First parameter
   lbase + 3  --> ...
*/
/* _pcount    --> Number of parameters */
/*   extern void _ixblock( void );     */
/*
                                   NO DEBE USARSE SIN guardar y preparar
                                   las variables de estado de plankton.
*/



/* Memory Management
   Alloc wBytes (fixed ¨?) */
extern LPBYTE _AllocF( WORD wBytes );


/*
>>>>>>>>> EVENT Module - Clipper internally is event-driven !!! <<<<<<<<<<
*/

typedef struct
{
   WORD wDymmy;
   WORD wMessage;
} EVENT;

typedef EVENT * PEVENT;

typedef void ( far * EVENTFUNCP ) ( PEVENT pEvent );

/* Register a new Event Handler */
extern WORD _evRegReceiverFunc( EVENTFUNCP pFunc, WORD wType );

extern void _evDeregReceiver( WORD wHandlerOrder );

extern void _evSendId( WORD wMessage, WORD wHandlerOrder ); /* 0xFFFF a Todos */
extern WORD _evRegType( DWORD, DWORD, WORD );
extern void _evPostId( WORD evId, WORD wReceiverHandle );
extern WORD _sysRegLow( void far * );
void   cdecl _evLow( WORD, void *, WORD );

extern void _Break_Cycle( void );

WORD _evModalRead( void );

WORD _gtModalRead( void );

extern void ( * _evKbdEntry )( PEVENT pEvent );


/*
>>>>>>>>>>>>>>>>>>>>>> BEEP Module - Terminal Driver Module <<<<<<<<<<<<<<<<<
*/

void _beep_( void );


/*
>>>>>>>>>>>>>>>>>>> DYNC Module - Dynamic Linking Modules <<<<<<<<<<<<<<<<<<<<
*/

typedef struct
{
   WORD AX, BX, CX, DX;
} DLM_PARAMS;

typedef DLM_PARAMS * PDLM_PARAMS;

typedef WORD ( far * DLMSERVER )( PDLM_PARAMS pParams, WORD wService );
typedef DLMSERVER * PDLMSERVER;

void _DynLoadModule( PWORD pHandle, LPSTR szModule );
WORD _DynGetNamedAddr( WORD wHandle, LPSTR szEntryModule, PDLMSERVER pServer );
LONG _DynGetOrdAddr( WORD wHandle, WORD wService );


/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERROR <<<<<<<<<<<<<<<<<<<<<<<<<<<<
*/

void _ierror( WORD wError );  /* generates an internal error message and quit. */

/* YO ESTAS cuatro no las pon¡a */
void _CycleF( void );
WORD _osStackBase( void );
void _osAllocDefSeg( WORD*, WORD*, WORD* );
WORD _osAvail( void );   /* N§ de parrafos disponibles. */


/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> TB Module <<<<<<<<<<<<<<<<<<<<<<<<<<<
*/

LPSTR _tbname( PCLIPVAR, WORD );      /* Same as ProcName. 2§ param no matter */
                                      /* 1 param is _ActInfo( WORD )          */


/* LAS "DATE" */
extern void _year( void );    /* recibe fecha en _tos, retorna */
                              /* (CLV_LONG) a¤o en _tos        */
extern void _month( void );   /* idem.                         */
extern void _day( void );     /* idem.                         */

/*****

           CLIPPER MiYear()
           {
               _bcopy( ( FARP ) ( ++tos ),
                       ( FARP ) _param( 1, DATE ),
                       sizeof( CLIPVAR ) );

               _year();

               _bcopy( ( FARP ) _eval,
                       ( FARP ) ( _tos-- ),
                       sizeof( CLIPVAR ) );

           }
*****/

/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> TERM <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
*/

void pascal QOUT( void );
LPBYTE _getenv( LPBYTE );


/*
>>>>>>>>>>>>>>>>>>>>>>>>>> Clipper 5.01 API memory <<<<<<<<<<<<<<<<<<<<<<
*/

HANDLE _vAlloc(USHORT size, USHORT flags);
void   _vFree (HANDLE h);

FARP   _vLock  (HANDLE h);
FARP   _vWire  (HANDLE h);
void   _vUnLock(HANDLE h);
void   _vUnWire(HANDLE h);


/*
>>>>>>>>>>>>>>>>>>>>>>>>>> Clipper 5.2 API memory <<<<<<<<<<<<<<<<<<<<<<<<<
*/

HANDLE _xvalloc(USHORT size, USHORT flags);
void   _xvfree (HANDLE h);

HANDLE _xvrealloc(HANDLE h, USHORT size, USHORT flags);

FARP   _xvlock  (HANDLE h);
FARP   _xvwire  (HANDLE h);
void   _xvunlock(HANDLE h);
void   _xvunwire(HANDLE h);


/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> DOS parameters <<<<<<<<<<<<<<<<<<<<<<<<<<<
*/

extern WORD     __argc;
extern LPBYTE * __argv;
extern LPSTR * environ;
extern LPSTR * _environ;





/*
>>>>>>>>>>>>>> FILESYS Module - Low level Files Management <<<<<<<<<<<<<<
*/

typedef USHORT FHANDLE;
typedef FHANDLE fhandle;
typedef FHANDLE far * FHANDLEP;

extern WORD _terror, _horror;

FHANDLE _tcreat( LPSTR szFileName, WORD wMode );
FHANDLE _topen( LPSTR szFileName, WORD wMode );
WORD    _tclose( FHANDLE wHandle );
DWORD   _tlseek( FHANDLE wHandle, LONG lRecNo, WORD wPosition );
WORD    _tread( FHANDLE wHandle, LPBYTE cBuffer, WORD wBytes );
WORD    _twrite( FHANDLE wHandle, LPBYTE cBuffer, WORD wBytes );
WORD    _tunlink( LPBYTE cFile );
FHANDLE _tctemp( LPBYTE cPath, WORD nMode, LPBYTE cFile );
void    _tcommit( void );


/*
Solo en Clipper 5.2

WORD   _tchdir( LPBYTE cPath );
WORD   _trmdir( LPBYTE cPath );
WORD   _tmkdir( LPBYTE cPath );
LPBYTE _tcurdir( WORD nDrive );
*/

typedef struct
   {
   WORD FreeClusters;
   WORD SectorsByClusters;
   WORD Clusters;
   WORD BytesBySector;
   } dspace;

extern int _dspace( WORD, dspace * );


struct blk
   {
   BYTE bDummy[ 21 ];
   BYTE bAttributes;
   WORD wTime;
   WORD wDate;
   DWORD dwSize;
   BYTE Name[ 13 ];
   };

int _f_first( LPBYTE, struct blk *, WORD );
int _f_next( struct blk * );

/*
Solo en Clipper 5.2

int  _tchdrv( WORD nDrive );
int  _tisdrv( WORD nDrive );
WORD _tcurdrv();
*/


/*
>>>>>>>>>>>>>>>>> Fecha y hora del sistema <<<<<<<<<<<<<<<<<<<<<<
*/

void _ostime( LPBYTE cBuffer );  /* hora minuto segundo decimas, 8 bytes */
void _osdate( LPBYTE cBuffer );  /* dia, mes, a¤o, diasemana             */


/*
>>>>>>>>>>>>>>>>> Internas de FastLib <<<<<<<<<<<<<<<<<<<<<<
*/

#define FAST_DIR_CREATE     0x39
#define FAST_DIR_DEL        0x3A
#define FAST_DIR_CHANGE     0x3B

void   _fastForce( void );
BOOL   _fastIsFastGT( void );
void   _fastSetFont( LPBYTE cMapa, WORD nChars, WORD nStart, BOOL lMode );
WORD   _fastMax( WORD, WORD );
WORD   _fastMin( WORD, WORD );
void   _fastWait( WORD );
void   _fastRetrace( void );
WORD   _fastRand( WORD );
void   _fastInternalRandInit( void );
WORD   _fastInternalRand( void );
BOOL   _fastKey( void );
void   _fastProcKey( void );
void   _fastColor( LPBYTE cColor, COLOR * sColor );
FARP   _fastGetVect( WORD );
void   _fastSetVect( WORD, FARP );
BOOL   _fastIsSound( void );
WORD   _fastVideoMode( WORD );
DWORD  _fastShr( DWORD, WORD );
DWORD  _fastShl( DWORD, WORD );
DWORD  _fastuShr( DWORD, WORD );
DWORD  _fastuShl( DWORD, WORD );
DWORD  _fastDiv( DWORD, DWORD );
DWORD  _fastMul( DWORD, DWORD );
DWORD  _fastMod( DWORD, DWORD );
double _fastDivd( double, double );
double _fastMuld( double, double );
double _fastAddd( double, double );
double _fastSubd( double, double );
void   _fastStr( LPBYTE, BYTE );
void   _fastStrHex( LPBYTE, BYTE );
void   _fastOutPortW( WORD, WORD );
void   _fastOutPortB( WORD, BYTE );
WORD   _fastInPortW( WORD );
BYTE   _fastInPortB( WORD );
void   _fastPokeB( WORD, WORD, BYTE );
void   _fastPokeW( WORD, WORD, WORD );
BYTE   _fastPeekB( WORD, WORD );
WORD   _fastPeekW( WORD, WORD );
void   _fastSetPalette( LPSTR, WORD );
void   _fastGetPalette( LPBYTE );

/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> FLI <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
*/

#define AA_SUCCESS          0          /* No Problem! */
#define AA_ERR_MISC        -1          /* Unclassified error */
#define AA_ERR_NOMEM       -2          /* Not enough memory */
#define AA_ERR_CANTFIND    -3          /* File doesn't exist */
#define AA_ERR_CANTMAKE    -4          /* Can't create file */
#define AA_ERR_BADTYPE     -5          /* File is not the right type */
#define AA_ERR_BADDATA     -6          /* File damaged internally */
#define AA_ERR_WRONGREZ    -7          /* File isn't 320x200 */
#define AA_ERR_SHORTREAD   -8          /* Not all of file is there */
#define AA_ERR_SHORTWRITE  -9          /* Couldn't write all of file */
#define AA_ERR_SEEK       -10          /* Error during file seek */


#define FLIH_MAGIC      0xaf11         /* File header Magic */
#define FLIF_MAGIC      0xf1fa         /* Frame Magic */


#define FLI_COLOR       11
#define FLI_LC          12
#define FLI_BLACK       13
#define FLI_BRUN        15
#define FLI_COPY        16


void FliGoClock(void);
long FliGetClock(void);


#define AA_CLOCK_HZ     4608
#define AA_MONITOR_HZ   70
#define AA_CLOCK_SCALE  ( AA_CLOCK_HZ / AA_MONITOR_HZ )


typedef int (*AAivec)( int, int );       /* pointer to an integer valued function */


typedef BYTE Cbuf;             /* compression buffer */


/* Graphics types */
typedef unsigned char Cmap;
typedef unsigned char Pixel;
typedef unsigned char Bitplane;


/* Constants pertaining to 320x200 256 color mode mostly */
#define AA_VGA_SCREEN   ( Pixel * )0xA0000000L
#define AA_XMAX         320
#define AA_YMAX         200
#define AA_BPR          320
#define AA_COLORS       256


/* This structure is something we can draw on.  A superset of Vcel
   (and keep it that way or things break!)  */
struct vscreen
    {
    int x, y;       /* upper left corner in screen coordinates */
    unsigned w, h;  /* width, height */
    unsigned bpr;   /* bytes per row of image p */
    Pixel *p;       /* Starts on segment boundary */
    Cmap *cmap;
    long psize;     /* size of pixels */
    Pixel *allocedp;        /* for memory based screens only */
    };
typedef struct vscreen Vscreen;


typedef struct fli_frame
    {
    long size;
    WORD type;            /* = 0xf1fa FLIF_MAGIC */
    int chunks;
    char pad[8];
    } Fli_frame;


typedef struct fli_chunk
    {
    long size;
    int type;
    } Fli_chunk;


typedef struct fli_head
    {
    long size;
    WORD type;            /* = FLIH_MAGIC */
    WORD frame_count;
    WORD width;
    WORD height;
    WORD bits_a_pixel;
    int  flags;
    int  speed;
    long next_head;
    long frames_in_table;
    int file;               /* used by players.  Contains zeros on disk. */
    long frame1_off;        /* used by players.  Contains zeros on disk. */
    long strokes;           /* how many paint strokes etc. made. */
    long session;           /* stokes since file's been loaded. */
    char reserved[88];      /* all zeroes on disk */
    } Fli_head;


void FliZero(void *d, int words);           /* set some 16-bit-words to zero */
void FliCopy(void *s, void *d, int words);  /* copy 16-bit-words */
void *FliNormPtr(void *ptr);                /* fold offset into address */


void FliUnBrun(Cbuf *cbuf, Pixel *screen, int linect); /* 1st frame */
void FliUnLcComp(Cbuf *cbuf, Pixel *screen);           /* delta frames */
void FliMemFcUnComp(Cbuf *cbuf, Cmap *cmap);           /* colors to memory */
void FliRegFcUnComp(Cbuf *cbuf);                       /* colors to registers */


void FliWaitVblank(void);


int FliUntil( LPSTR fliname, int speed, AAivec until );


void *aa_malloc(unsigned);      /* heap allocator */
void aa_free(void *);           /* heap free'er */


void FliUnComp(Vscreen *f, Fli_frame *frame, Cbuf *cbuf, WORD see_colors);

extern Vscreen FliScreen;


WORD FliGetMode( void );
void FliSetMode( WORD nMode );


int FastFliPlay( LPSTR fliname );
int FastFliOnce( LPSTR fliname );

int FliNextFrame( FHANDLE ff);

FHANDLE FliOpen( LPSTR fliname, Fli_head *fh);



typedef struct VideoT
  {
  BYTE ascii;
  BYTE attrib;
  };

extern struct VideoT far *vPointerText;
extern LPBYTE             vPointerGraph;
extern LPBYTE             vPointerBios;
extern LPBYTE             vPointerInter;
extern LPBYTE             vPointerHardCopy;
extern LPBYTE             vGetPointerFont( BOOL lMode );

extern WORD _sbIOAddr;


/******************************************************
                      Item API
*******************************************************/

typedef void near * ITEM;

typedef struct
{
   USHORT type;
   USHORT paramCount;
   ITEM   item[ 10 ];
} EVALINFO;

typedef EVALINFO far * EVALINFOP;

extern ITEM    _itemNew( ITEM item );
               
extern USHORT  _itemType( ITEM item );
extern USHORT  _itemSize( ITEM item );

extern ITEM    _itemPutL ( ITEM item, BOOL log );
extern ITEM    _itemPutC ( ITEM item, LPBYTE str );
extern ITEM    _itemPutCL( ITEM item, LPBYTE str, USHORT len );
extern ITEM    _itemPutNL( ITEM item, long lnum );
extern ITEM    _itemPutND( ITEM item, DOUBLE nd );
extern ITEM    _itemPutDS( ITEM item, LPBYTE dstr );

extern BOOL    _itemGetL ( ITEM item );
extern LPBYTE  _itemGetC ( ITEM item );
extern long    _itemGetNL( ITEM item );
extern LPBYTE  _itemGetDS( ITEM item, LPBYTE buf );
extern DOUBLE  _itemGetND( ITEM item );

extern USHORT  _itemCopyC( ITEM item, LPBYTE buf, USHORT len );
extern BOOL    _itemFreeC( LPBYTE str );

extern ITEM    _itemArrayNew( USHORT uiSize );
extern ITEM    _itemArrayGet( ITEM itemArr, USHORT uiElem );
extern ITEM    _itemArrayPut( ITEM itemArr, USHORT uiElem, ITEM item );


extern ITEM    _itemParam ( USHORT uiParam );
extern ITEM    _itemReturn( ITEM item );

extern BOOL    _itemRelease( ITEM item );

extern BOOL    _evalNew     ( EVALINFOP evalP, ITEM eval );
extern BOOL    _evalPutParam( EVALINFOP evalP, ITEM param );
extern ITEM    _evalLaunch  ( EVALINFOP evalP );
extern BOOL    _evalRelease ( EVALINFOP evalP );


#endif
