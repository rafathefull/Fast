;  
; ------------------------------------------------------------------------
; FASTlib for Clipper, including all source code, examples and any other 
; file has been donated to Open Source community
; 
; Manu Roibal. Bilbao, May 7 2011
; 
; ------------------------------------------------------------------------
; Please, contact me at			manuroibal@gmail.com
; Follow me at Twitter			@manuroibal
; My Linkedin profile			www.linkedin.com/manuroibal
; 
; Or visit my web site Tons of IT at	www.tonsofit.com
; 


        TITLE   rand.c

	.8086
	.8087

_TEXT	SEGMENT	WORD PUBLIC 'CODE'
_TEXT	ENDS

_DATA	SEGMENT	WORD PUBLIC 'DATA'
_DATA	ENDS

CONST	SEGMENT	WORD PUBLIC 'CONST'
CONST	ENDS

_BSS	SEGMENT	WORD PUBLIC 'BSS'
_BSS	ENDS

DGROUP	GROUP	CONST, _BSS, _DATA


EXTRN       __aFlmul:NEAR
EXTRN       __acrtused:ABS

PUBLIC      __fastInternalRandInit
PUBLIC      __fastInternalRand


_TEXT	SEGMENT
	assume	cs: _TEXT


__fastInternalRandInit:
        push    bp
        mov     bp,sp
        mov     ax,[bp+006h]
        assume  ds: DGROUP
	mov	$S1,ax
	mov	word ptr $S2,0000h
	pop	bp
	retf
	nop
__fastInternalRand:
        mov     ax,43FDh
	mov	dx,0003h
	push	dx
	push	ax
	push	$S2
	push	$S1
	call	far ptr __aFlmul
	add	ax,9EC3h
	adc	dx,+026h
	mov	$S1,ax
	mov	$S2,dx
	mov	ax,dx
	and	ah,7Fh
	retf


_TEXT	ENDS

_DATA	SEGMENT


$S1	dw	00001h
$S2	dw	00000h

_DATA	ENDS

        END

