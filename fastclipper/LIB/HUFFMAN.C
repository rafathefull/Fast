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


#define EOF             ( _terror != 0 )
#define EXIT_WRITERR    3
#define EXIT_READERR    2
#define EXIT_FAILURE    1
#define EXIT_SUCCESS    0
#define BUFF_LEN        1024
#define N               1024
#define F               60
#define THRESHOLD       2
#define LEAF            N
#define N_CHAR          ( 256 - THRESHOLD + F )
#define T               ( N_CHAR * 2 - 1 )
#define R               ( T - 1 )
#define MAX_FREQ        0x8000


typedef struct {
    FHANDLE handle;
    unsigned long textsize;
    unsigned int pointer;
    BYTE mode;
    BYTE buffer[ BUFF_LEN ];
} STREAM;



static STREAM   HuffmanInFile;
static STREAM   HuffmanOutFile;
static DWORD    textsize   = 0;
static DWORD    codesize   = 0;
static DWORD    printcount = 0;
static LPWORD   freq;
static LPINT    prnt;
static LPINT    son;
static LPBYTE   text_buf;
static int      match_position, match_length;
static LPINT    lson, rson, dad;
static unsigned getbuf = 0;
static BYTE     getlen = 0;
static unsigned putbuf = 0;
static BYTE     putlen = 0;
static unsigned code, len;


static BYTE p_len[64] = {
	0x03, 0x04, 0x04, 0x04, 0x05, 0x05, 0x05, 0x05,
	0x05, 0x05, 0x05, 0x05, 0x06, 0x06, 0x06, 0x06,
	0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
	0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
	0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08
};

static BYTE p_code[64] = {
	0x00, 0x20, 0x30, 0x40, 0x50, 0x58, 0x60, 0x68,
	0x70, 0x78, 0x80, 0x88, 0x90, 0x94, 0x98, 0x9C,
	0xA0, 0xA4, 0xA8, 0xAC, 0xB0, 0xB4, 0xB8, 0xBC,
	0xC0, 0xC2, 0xC4, 0xC6, 0xC8, 0xCA, 0xCC, 0xCE,
	0xD0, 0xD2, 0xD4, 0xD6, 0xD8, 0xDA, 0xDC, 0xDE,
	0xE0, 0xE2, 0xE4, 0xE6, 0xE8, 0xEA, 0xEC, 0xEE,
	0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7,
	0xF8, 0xF9, 0xFA, 0xFB, 0xFC, 0xFD, 0xFE, 0xFF
};

static BYTE d_code[256] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
	0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
	0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
	0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
	0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
	0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
	0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
	0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
	0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09,
	0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A,
	0x0B, 0x0B, 0x0B, 0x0B, 0x0B, 0x0B, 0x0B, 0x0B,
	0x0C, 0x0C, 0x0C, 0x0C, 0x0D, 0x0D, 0x0D, 0x0D,
	0x0E, 0x0E, 0x0E, 0x0E, 0x0F, 0x0F, 0x0F, 0x0F,
	0x10, 0x10, 0x10, 0x10, 0x11, 0x11, 0x11, 0x11,
	0x12, 0x12, 0x12, 0x12, 0x13, 0x13, 0x13, 0x13,
	0x14, 0x14, 0x14, 0x14, 0x15, 0x15, 0x15, 0x15,
	0x16, 0x16, 0x16, 0x16, 0x17, 0x17, 0x17, 0x17,
	0x18, 0x18, 0x19, 0x19, 0x1A, 0x1A, 0x1B, 0x1B,
	0x1C, 0x1C, 0x1D, 0x1D, 0x1E, 0x1E, 0x1F, 0x1F,
	0x20, 0x20, 0x21, 0x21, 0x22, 0x22, 0x23, 0x23,
	0x24, 0x24, 0x25, 0x25, 0x26, 0x26, 0x27, 0x27,
	0x28, 0x28, 0x29, 0x29, 0x2A, 0x2A, 0x2B, 0x2B,
	0x2C, 0x2C, 0x2D, 0x2D, 0x2E, 0x2E, 0x2F, 0x2F,
	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
	0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F,
};

static BYTE d_len[256] = {
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
	0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
	0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
	0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
	0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
	0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
	0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
	0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
	0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
	0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
	0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
	0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
	0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
	0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
	0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
	0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
	0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
	0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
	0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
	0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
	0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
	0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
	0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
	0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
};


HIDE WORD openstream( STREAM *Channel, LPBYTE cName, WORD nMode )
  {
  Channel->handle = _topen( (LPSTR)cName, nMode );
  Channel->textsize = _tlseek( Channel->handle, 0L, 2 );
  _tlseek( Channel->handle, 0L, 0 );
  Channel->pointer = BUFF_LEN;
  Channel->mode = 0;
  return Channel->handle;
  }



HIDE WORD createstream( STREAM *Channel, LPBYTE cName, WORD nMode )
  {
  Channel->handle = _tcreat( (LPSTR)cName, nMode );
  Channel->textsize = 0;
  Channel->pointer = 0;
  Channel->mode = 1;
  return Channel->handle;
  }



HIDE WORD closestream( STREAM *Channel )
  {
  if ( Channel->mode == 1 && Channel->pointer > 0 )
    _terror = ( _twrite( Channel->handle,
                         (LPBYTE)( Channel->buffer ),
                         Channel->pointer ) < Channel->pointer );
  return _tclose( Channel->handle );
  }



HIDE BYTE readchars( STREAM *Channel )
  {
  static unsigned int CharsRead;

  if ( Channel->pointer == BUFF_LEN )
    {
    CharsRead = _tread( Channel->handle, (LPBYTE)Channel->buffer, BUFF_LEN );
    Channel->pointer = 0;
    }
  _terror = ( ( Channel->pointer + 1 ) > CharsRead );
  return ( Channel->buffer[ Channel->pointer++ ] );
  }



HIDE void writechars( int c, STREAM *Channel )
  {
  if ( Channel->pointer == BUFF_LEN )
    {
    _terror = ( _twrite( Channel->handle, (LPBYTE)Channel->buffer, BUFF_LEN ) < BUFF_LEN );
    Channel->pointer = 0;
    }
  else
    _terror = 0;
  Channel->buffer[ Channel->pointer++ ] = c;
  return ;
  }



HIDE void InitTree(void)
  {
  INDEX i;

  for (i = N + 1; i <= N + 256; i++)
    rson[i] = LEAF;
  for (i = 0; i < N; i++)
    dad[i] = LEAF;
  }


HIDE void InsertNode(int r)
  {
  register int  i;
  int    p, cmp;
  LPBYTE key;
  WORD   c;

  cmp = 1;
  key = &text_buf[r];
  p = N + 1 + key[0];
  rson[r] = lson[r] = LEAF;
  match_length = 0;
  for ( ; ; )
    {
    if (cmp >= 0)
      {
      if (rson[p] != LEAF)
        p = rson[p];
      else
        {
        rson[p] = r;
        dad[r] = p;
        return;
        }
      }
    else
      {
      if (lson[p] != LEAF)
        p = lson[p];
      else
        {
        lson[p] = r;
        dad[r] = p;
        return;
        }
      }
    for (i = 1; i < F; i++)
      if ( ( cmp = key[i] - text_buf[p + i]) != 0 )
        break;
    if (i > THRESHOLD)
      {
      if (i > match_length)
        {
        match_position = ((r - p) & (N - 1)) - 1;
        if ((match_length = i) >= F)
          break;
        }
      if (i == match_length)
        {
        if ((c = ((r - p) & (N - 1)) - 1) < match_position)
          {
          match_position = c;
          }
        }
      }
    }
  dad[r] = dad[p];
  lson[r] = lson[p];
  rson[r] = rson[p];
  dad[lson[p]] = r;
  dad[rson[p]] = r;
  if (rson[dad[p]] == p)
    rson[dad[p]] = r;
  else
    lson[dad[p]] = r;
  dad[p] = LEAF;
  }




HIDE void DeleteNode(int p)
  {
  int  q;

  if (dad[p] == LEAF)
    return ;
  if (rson[p] == LEAF)
    q = lson[p];
  else
    if (lson[p] == LEAF)
      q = rson[p];
    else
      {
      q = lson[p];
      if (rson[q] != LEAF)
        {
        do
          {
          q = rson[q];
          } while (rson[q] != LEAF);
        rson[dad[q]] = lson[q];
        dad[lson[q]] = dad[q];
        lson[q] = lson[p];
        dad[lson[p]] = q;
        }
      rson[q] = rson[p];
      dad[rson[p]] = q;
      }
  dad[q] = dad[p];
  if (rson[dad[p]] == p)
    rson[dad[p]] = q;
  else
    lson[dad[p]] = q;
  dad[p] = LEAF;
  }




HIDE int GetBit(void)
  {
  register int nInd;

  while (getlen <= 8)
    {
    if ((nInd = readchars( &HuffmanInFile), EOF ))
      nInd = 0;
    getbuf |= nInd << (8 - getlen);
    getlen += 8;
    }
  nInd = getbuf;
  getbuf <<= 1;
  getlen--;
  return (nInd < 0);
  }



HIDE int GetByte(void)
  {
  INDEX nInd;

  while (getlen <= 8)
    {
    if (( nInd = readchars( &HuffmanInFile), EOF ) )
      nInd = 0;
    getbuf |= nInd << (8 - getlen);
    getlen += 8;
    }
  nInd = getbuf;
  getbuf <<= 8;
  getlen -= 8;
  return nInd >> 8;
  }





HIDE int Putcode(int l, unsigned c)
  {
  putbuf |= c >> putlen;
  if ((putlen += l) >= 8)
    {
    writechars(putbuf >> 8, &HuffmanOutFile);
    if ( EOF )
      {
      return EXIT_WRITERR;
      }
    if ((putlen -= 8) >= 8)
      {
      writechars(putbuf, &HuffmanOutFile);
      if ( EOF )
        {
        return EXIT_WRITERR;
        }
      codesize += 2;
      putlen -= 8;
      putbuf = c << (l - putlen);
      }
    else
      {
      putbuf <<= 8;
      codesize++;
      }
    }
  return EXIT_SUCCESS;
  }



HIDE void StartHuff(void)
  {
  register int i,j;

  for (i = 0; i < N_CHAR; i++)
    {
    freq[i] = 1;
    son[i] = i + T;
    prnt[i + T] = i;
    }
  i = 0; j = N_CHAR;
  while (j <= R)
    {
    freq[j] = freq[i] + freq[i + 1];
    son[j] = i;
    prnt[i] = prnt[i + 1] = j;
    i += 2;
    j++;
    }
  freq[T] = 0xffff;
  prnt[R] = 0;
  }




HIDE void reconst(void)
  {
  register int i, j, k;
  unsigned f, l;

  j = 0;
  for (i = 0; i < T; i++)
    {
    if (son[i] >= T)
      {
      freq[j] = (freq[i] + 1) / 2;
      son[j] = son[i];
      j++;
      }
    }
  for (i = 0, j = N_CHAR; j < T; i += 2, j++)
    {
    k = i + 1;
    f = freq[j] = freq[i] + freq[k];
    for (k = j - 1; f < freq[k]; k--);
      k++;
    l = (j - k) * 2;
    _bmove( (LPBYTE)( & freq[k + 1] ), (LPBYTE)( & freq[k] ), l );
    freq[k] = f;
    _bmove( (LPBYTE)( & son[k + 1] ), (LPBYTE)( & son[k] ), l );
    son[k] = i;
    }
  for (i = 0; i < T; i++)
    {
    if ((k = son[i]) >= T)
      {
      prnt[k] = i;
      }
    else
      {
      prnt[k] = prnt[k + 1] = i;
      }
    }
  }



HIDE void update(int c)
  {
  register int i, j, k, l;

  if (freq[R] == MAX_FREQ)
    {
    reconst();
    }
  c = prnt[c + T];
  do {
    k = ++freq[c];
    if (k > freq[l = c + 1])
      {
      while (k > freq[++l]);
        l--;
      freq[c] = freq[l];
      freq[l] = k;
      i = son[c];
      prnt[i] = l;
      if (i < T)
        prnt[i + 1] = l;
      j = son[l];
      son[l] = i;
      prnt[j] = c;
      if (j < T)
        prnt[j + 1] = c;
      son[c] = j;
      c = l;
      }
    } while ((c = prnt[c]) != 0);
  }



HIDE int EncodeChar(unsigned c)
  {
  INDEX        i = 0;
  register int j = 0;
  register int k = prnt[ c + T ];
  register int lOk;

  do {
    i >>= 1;
    if (k & 1)
      i += 0x8000;
    j++;
    } while ((k = prnt[k]) != R);
  if ( ( lOk = Putcode(j, i) ) == 0 )
    {
    code = i;
    len = j;
    update(c);
    }
  return( lOk );
  }



HIDE int EncodePosition(unsigned c)
  {
  INDEX        nInd = c >> 6;
  register int lOk  = Putcode(p_len[ nInd ], (unsigned)p_code[ nInd ] << 8);

  if ( lOk == 0 )
    lOk = Putcode(6, (c & 0x3f) << 10);
  return ( lOk );
  }



HIDE int EncodeEnd(void)
  {
  if (putlen)
    {
    if (writechars(putbuf >> 8, &HuffmanOutFile), EOF)
      {
      return EXIT_WRITERR;
      }
    codesize++;
    }
  return EXIT_SUCCESS;
  }




HIDE int DecodeChar(void)
  {
  register unsigned c = son[R];

  while (c < T)
    {
    c += GetBit();
    c = son[c];
    }
  c -= T;
  update(c);
  return c;
  }



HIDE int DecodePosition(void)
  {
  unsigned i, j, c;

  i = GetByte();
  c = (unsigned)d_code[i] << 6;
  j = d_len[i] - 2;
  while (j--)
    i = (i << 1) + GetBit();
  return c | (i & 0x3f);
  }



HIDE void ExecCode( PCLIPVAR bBlock, unsigned long int bytes, long porc )
  {
  _PutSym( _SymEval );
  *( ++_tos ) = *bBlock;
  _PutLN( bytes );
  _PutLN( porc );
  _xEval( 2 );
  }



HIDE int Encode( PCLIPVAR bBlock )
  {
  int  i, c, len, r, s, last_match_length;

  textsize = HuffmanInFile.textsize;
  if ( _twrite( HuffmanOutFile.handle, ( LPBYTE ) &textsize, sizeof textsize ) < sizeof textsize )
    return EXIT_WRITERR;
  if (textsize == 0)
    return EXIT_SUCCESS;
  textsize = 0;
  StartHuff();
  InitTree();
  s = 0;
  r = N - F;
  for (i = s; i < r; i++)
    text_buf[i] = ' ';
  for (len = 0; len < F && (c = readchars( &HuffmanInFile), !EOF ); len++)
    text_buf[r + len] = c;
  textsize = len;
  for (i = 1; i <= F; i++)
    InsertNode(r - i);
  InsertNode(r);
  do {
    if (match_length > len)
      match_length = len;
    if (match_length <= THRESHOLD)
      {
      match_length = 1;
      if ( EncodeChar(text_buf[r]) )
        return EXIT_WRITERR;
      }
    else
      {
      if ( EncodeChar(255 - THRESHOLD + match_length) )
        return EXIT_WRITERR;
      if ( EncodePosition(match_position) )
        return EXIT_WRITERR;
      }
    last_match_length = match_length;
    for (i = 0; i < last_match_length && (c = readchars( &HuffmanInFile), !EOF ); i++)
      {
      DeleteNode(s);
      text_buf[s] = c;
      if (s < F - 1)
        text_buf[s + N] = c;
      s = (s + 1) & (N - 1);
      r = (r + 1) & (N - 1);
      InsertNode(r);
      }
    if ((textsize += i) > printcount)
      {
      ExecCode( bBlock, textsize, (long) ( codesize * 100 / textsize ) );
      printcount += BUFF_LEN;
      }
    while (i++ < last_match_length)
      {
      DeleteNode(s);
      s = (s + 1) & (N - 1);
      r = (r + 1) & (N - 1);
      if (--len)
        InsertNode(r);
      }
    } while (len > 0);
  ExecCode( bBlock, textsize, (long) ( codesize * 100 / textsize ) );
  return EncodeEnd();
  }



HIDE int Decode( PCLIPVAR bBlock )
  {
  int  i, j, k, r, c;
  unsigned long int  count;

  if ( _tread( HuffmanInFile.handle, ( LPBYTE ) &textsize, sizeof textsize ) < sizeof textsize )
    return EXIT_READERR;
  if (textsize == 0)
    return EXIT_SUCCESS;
  StartHuff();
  for (i = 0; i < N - F; i++)
    text_buf[i] = ' ';
  r = N - F;
  for (count = 0; count < textsize; )
    {
    c = DecodeChar();
    if (c < 256)
      {
      writechars(c, &HuffmanOutFile );
      if ( EOF )
        {
        return EXIT_WRITERR;
        }
      text_buf[r++] = c;
      r &= (N - 1);
      count++;
      }
    else
      {
      i = (r - DecodePosition() - 1) & (N - 1);
      j = c - 255 + THRESHOLD;
      for (k = 0; k < j; k++)
        {
        c = text_buf[(i + k) & (N - 1)];
        writechars(c, &HuffmanOutFile);
        if ( EOF )
          {
          return EXIT_WRITERR;
          }
        text_buf[r++] = c;
        r &= (N - 1);
        count++;
        }
      }
    if (count > printcount)
      {
      ExecCode( bBlock, count, (long) ( count * 100 / textsize ) );
      printcount += BUFF_LEN;
      }
    }
  ExecCode( bBlock, count, (long) ( count * 100 / textsize ) );
  return EXIT_SUCCESS;
  }



CLIPPER Compress()
  {
  int   nExit = EXIT_FAILURE;

  PCLIPVAR bBlock;
  PCLIPVAR mode;

  _fastForce();
  if ( _parinfo( 1 ) == 1 && _parinfo( 2 ) == 1 && _parinfo( 3 ) == 4 )
    {
    bBlock = _param( 4, BLOCK );
    mode   = _param( 3, LOGICAL );
    nExit = ( (LPBYTE)text_buf = _xalloc( (N + F - 1) ) )      == NULL
         || ( (LPBYTE)lson     = _xalloc( (N + 1) * 2 ) )      == NULL
         || ( (LPBYTE)rson     = _xalloc( (N + 257) * 2 ) )    == NULL
         || ( (LPBYTE)dad      = _xalloc( (N + 1) * 2 ) )      == NULL
         || ( (LPBYTE)freq     = _xalloc( (T + 1) * 2 ) )      == NULL
         || ( (LPBYTE)prnt     = _xalloc( (T + N_CHAR) * 2 ) ) == NULL
         || ( (LPBYTE)son      = _xalloc( T * 2 ) )            == NULL;
    if ( ! nExit )
      {
      nExit = nExit || (( openstream( &HuffmanInFile, ( LPBYTE ) _parc( 1 ), 0 ) == NULL)
                    || ( createstream( &HuffmanOutFile, ( LPBYTE ) _parc( 2 ), 0 ) == NULL));
      }
    if ( ! nExit )
      {
      textsize = 0;
      codesize = 0;
      printcount = 0;
      getbuf = 0;
      getlen = 0;
      putbuf = 0;
      putlen = 0;
      if ( ( ( CLV_WORD *) mode)->wWord )
        nExit = Encode( bBlock );
      else
        nExit = Decode( bBlock );
      }
    closestream( &HuffmanInFile );
    closestream( &HuffmanOutFile );
    _xfree( (LPBYTE)son );
    _xfree( (LPBYTE)prnt );
    _xfree( (LPBYTE)freq );
    _xfree( (LPBYTE)dad );
    _xfree( (LPBYTE)rson );
    _xfree( (LPBYTE)lson );
    _xfree( (LPBYTE)text_buf );
    }
  _retni( nExit );
  }

