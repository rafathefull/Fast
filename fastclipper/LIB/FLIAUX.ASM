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


        public _FliUnBrun
        public _FliRegFcUnComp
        public _FliMemFcUnComp
        public _FliUnLcComp
        public _FliGetClock


CMODE   EQU     043h
CDATA   EQU     040h


_TEXT   SEGMENT  BYTE PUBLIC 'CODE'
_TEXT   ENDS
_DATA   SEGMENT  WORD PUBLIC 'DATA'
_DATA   ENDS
CONST   SEGMENT  WORD PUBLIC 'CONST'
CONST   ENDS
_BSS    SEGMENT  WORD PUBLIC 'BSS'
_BSS    ENDS
DGROUP  GROUP   CONST,  _BSS,   _DATA
        ASSUME  CS: _TEXT, DS: DGROUP, SS: DGROUP, ES: DGROUP


_TEXT      SEGMENT


_FliUnBrun      PROC far
linect equ word ptr[bp+12+2]
        push bp
        mov bp,sp
        sub sp,4
        push es
        push ds
        push si
        push di
        push bx
        push cx
        cld
        lds si,[bp+4+2]
        les di,[bp+8+2]
        mov dx,di
        xor ah,ah
linelp:
        mov di,dx
        lodsb
        mov bl,al  
        test bl,bl
        jmp endulcloop
ulcloop:
        lodsb
        test al,al
        js ucopy
        mov cx,ax
        lodsb
        rep stosb
        dec bl
        jnz ulcloop
        jmp ulcout
ucopy:
        neg al
        mov cx,ax
        rep movsb 
        dec bl
endulcloop:
        jnz ulcloop
ulcout:
        add dx,320
        dec linect
        jnz linelp
        pop cx
        pop bx
        pop di
        pop si
        pop ds
        pop es
        mov sp,bp
        pop bp
        ret     
_FliUnBrun      ENDP


_FliRegFcUnComp proc far
        push bp
        mov bp,sp
        push ds
        push si
        push di
        push cx
        push bx
        cld
        lds si,[bp+4+2]
        mov di,0
        lodsw
        mov bx, ax
        test bx,bx
        jmp endcu
cu:
        lodsb
        add di,ax
        lodsb
        mov cx,ax
        or  cx,cx
        jnz set1c
        mov cx,256
set1c:
        mov dx,3c8h
        mov ax,di
        out dx,al
        inc di
        inc dx
s1:
        lodsb
        out dx,al
s2:
        lodsb
        out dx,al
s3:
        lodsb
        out dx,al
        loop set1c
        dec bx
endcu:
        jnz cu
        pop bx
        pop cx
        pop di
        pop si
        pop ds
        pop bp
        ret     
_FliRegFcUnComp endp


_FliMemFcUnComp proc far
        push bp
        mov bp,sp
        push ds
        push si
        push di
        push cx
        push bx
        cld
        lds si,[bp+4+2]
        les di,[bp+8+2]
        lodsw
        mov bx, ax
        test bx,bx
        jmp endu
u:
        lodsb
        add di,ax
        add di,ax
        add di,ax
        lodsb
        or  al,al
        jnz u2
        mov ax,256
u2:
        mov cx,ax
        add cx,ax
        add cx,ax
        rep movsb
        dec bx
endu:
        jnz u
        pop bx
        pop cx
        pop di
        pop si
        pop ds
        pop     bp
        ret     
_FliMemFcUnComp endp


_FliUnLcComp PROC far
linect equ word ptr[bp-2]
        push bp
        mov bp,sp
        sub sp,4
        push es
        push ds
        push si
        push di
        push bx
        push cx
        cld
        lds si,[bp+4+2]
        les di,[bp+8+2]
        lodsw
        mov dx,320
        mul dx
        add di,ax
        lodsw
        mov linect,ax
        mov dx,di
        xor ah,ah
linelp2:
        mov di,dx
        lodsb
        mov bl,al  
        test bl,bl
        jmp endulcloop2
ulcloop2:
        lodsb
        add di,ax
        lodsb
        test al,al
        js ulcrun2
        mov cx,ax
        rep movsb
        dec bl
        jnz ulcloop2
        jmp ulcout2
ulcrun2:
        neg al
        mov cx,ax
        lodsb
        rep stosb
        dec bl
endulcloop2:
        jnz ulcloop2
ulcout2:
        add dx,320
        dec linect
        jnz linelp2
        pop cx
        pop bx
        pop di
        pop si
        pop ds
        pop es
        mov sp,bp
        pop bp
        ret     
_FliUnLcComp ENDP


_FliGetClock PROC far
        push cx
        mov ah, 0
        int 1ah
        mov ah, dl
        mov dl, dh
        mov dh, cl
        mov al, 0
        out CMODE, al
        mov al, 1
        out CMODE, al
        in  al, CDATA
        in  al, CDATA
        neg al
        pop cx
        retf
_FliGetClock ENDP


_TEXT   ENDS
END

