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



public  FORMAT, CHKDSK

extrn   __parl:far
extrn   __parni:far
extrn   __parinfo:far
extrn   __retni:far


dgroup  group   datasg

datasg  segment public  'DATA'

bDisco          db      0
wModo           dw      0
bMaximo         db      0
bPista          db      0
bCabeza         db      0
bBase           db      0
FastFormat      db      0
TablaParam      db      72 DUP (0)
BootSector      db      0EBh, 03Eh, 090h
                db      '(C) MANU'
                db      000h, 002h, 002h, 001h, 000h, 002h, 070h, 000h
                db      0D0h, 002h, 0FDh, 002h, 000h, 009h, 000h, 002h
                db      36 DUP (0)
                db      090h, 0FAh, 0B8h, 030h, 000h, 08Eh, 0D0h, 0BCh
                db      0FCh, 000h, 0FBh, 00Eh, 01Fh, 0BBh, 007h, 000h
                db      0BEh, 076h, 07Ch, 090h, 08Ah, 004h, 046h, 03Ch
                db      000h, 074h, 008h, 0B4h, 00Eh, 056h, 0CDh, 010h
                db      05Eh, 0EBh, 0F1h, 0B4h, 001h, 0CDh, 016h, 074h
                db      006h, 0B4h, 000h, 0CDh, 016h, 0EBh, 0F4h, 0B4h
                db      000h, 0CDh, 016h, 033h, 0D2h, 0CDh, 019h
                db      13, 10, "Este disco no tiene Boot"
                db      13, 10, 10
                db      "(C) 1993 Manu Roibal"
                db      13, 10
                db      "Fast Library For Clipper"
                db      13, 10, 10
                db      "Cambie el disco y pulse una tecla"
                db      13, 10, 10, 10
                db      510 - ( $ - BootSector ) DUP (0)
                db      055h, 0AAh
FatSect         db      3   DUP (0)
SectorIni       db      512 DUP (0)

datasg  ends


_FAST   segment WORD PUBLIC 'CODE'
        assume  cs:_FAST, ds:dgroup, es:dgroup, ss:nothing

FORMAT          proc    far
                push    bp
                mov     bp, sp
                push    ds
                push    es
                push    si
                push    di
                xor     ax, ax
                push    ax
                call    __parinfo
                add     sp, 2
                cmp     al, 2
                je      GetDriveFormat
                cmp     al, 3
                je      GetDriveFormat
                jmp     Ferror
GetDriveFormat: mov     ax, 1
                push    ax
                call    __parni
                add     sp, 2
                cmp     al, 0
                jz      GetMode
                cmp     al, 1
                jz      GetMode
                jmp     Ferror
GetMode:        mov     bDisco, al
                mov     ax, 2
                push    ax
                call    __parni
                add     sp, 2
                mov     wModo, 2709h
                mov     bMaximo, 27h
                cmp     al, 1
                je      FormatParamOk
                mov     wModo, 4F09h
                mov     bMaximo, 4Fh
                cmp     al, 2
                je      FormatParamOk
                mov     wModo, 4F0Fh
                mov     bMaximo, 4Fh
                cmp     al, 3
                je      FormatParamOk
                mov     wModo, 4F12h
                mov     bMaximo, 4Fh
                cmp     al, 4
                je      FormatParamOk
                jmp     Ferror
FormatParamOk:  mov     ax, 3
                push    ax
                call    __parl
                add     sp, 2
                mov     FastFormat, al
                mov     ax, dgroup
                mov     es, ax
                push    es
                xor     ax, ax
                int     13h
                mov     ah, 8
                mov     dl, bDisco
                int     13h
                mov     ah, 18h
                mov     dl, bDisco
                mov     cx, wModo
                int     13h
                xor     ax, ax
                int     13h
                pop     es
                clc
FmtPrep:        call    SetDisk
                mov     bx, OFFSET dgroup:TablaParam
                cmp     FastFormat, 1
                je      FmtEnd
                mov     bPista, 0
                mov     bCabeza, 0
FmtLoop:        mov     dh, bCabeza
                mov     dl, bDisco
                mov     ch, bPista
                mov     cl, 0
                call    TablePrep
                mov     ax, wModo
                mov     ah, 5
                call    MiInt13h
                jnc     FmtNext
                jmp     Ferror
FmtNext:        cmp     bCabeza, 1
                je      NewTrack
                mov     bCabeza, 1
                jmp     FmtLoop
NewTrack:       inc     bPista
                mov     ah, bPista
                cmp     ah, bMaximo
                ja      FmtEnd
                mov     bCabeza, 0
                jmp     FmtLoop
FmtEnd:         call    EscribeBoot
                jc      Ferror
                call    EscribeFat
                jc      Ferror
                call    EscribeRoot
                jc      Ferror
                xor     ax, ax
                jmp     FormatExit
Ferror:         mov     ax, -1
FormatExit:     call    ReSetDisk
                push    ax
                call    __retni
                add     sp, 2
                pop     di
                pop     si
                pop     es
                pop     ds
                pop     bp
                ret
FORMAT          endp


TablePrep       proc    near
                push    di
                push    cx
                push    ax
                mov     di, bx
                mov     cx, wModo
                and     cx, 00FFh
                xor     ax, ax
                cld
PrepLoop:       mov     al, bPista
                stosb
                mov     al, bCabeza
                stosb
                inc     ah
                mov     al, ah
                stosb
                mov     al, 2
                stosb
                loop    PrepLoop
                pop     ax
                pop     cx
                pop     di
                ret
TablePrep       endp


MiInt13h        proc    near
                push    bx
                push    es
                push    ax
                int     13h
                jnc     BiosRet
                xor     ax, ax
                int     13h
                pop     ax
                pop     es
                push    es
                push    ax
                int     13h
                jnc     BiosRet
                xor     ax, ax
                int     13h
                pop     ax
                pop     es
                push    es
                push    ax
                int     13h
BiosRet:        pop     bx
                pop     es
                pop     bx
                ret
MiInt13h        endp


EscribeBoot     proc    near
                push    di
                mov     di, OFFSET dgroup:BootSector
                mov     ax, wModo
Boot1:          cmp     ax, 2709h
                jne     Boot2
                mov     BYTE PTR[ di+00Dh ], 002h
                mov     BYTE PTR[ di+011h ], 070h
                mov     WORD PTR[ di+013h ], 02D0h
                mov     BYTE PTR[ di+015h ], 0FDh
                mov     BYTE PTR[ di+016h ], 002h
                mov     BYTE PTR[ di+018h ], 009h
                jmp     BootOk
Boot2:          cmp     ax, 4F09h
                jne     Boot3
                mov     BYTE PTR[ di+00Dh ], 002h
                mov     BYTE PTR[ di+011h ], 070h
                mov     WORD PTR[ di+013h ], 05A0h
                mov     BYTE PTR[ di+015h ], 0F9h
                mov     BYTE PTR[ di+016h ], 003h
                mov     BYTE PTR[ di+018h ], 009h
                jmp     BootOk
Boot3:          cmp     ax, 4F0Fh
                jne     Boot4
                mov     BYTE PTR[ di+00Dh ], 001h
                mov     BYTE PTR[ di+011h ], 0E0h
                mov     WORD PTR[ di+013h ], 0960h
                mov     BYTE PTR[ di+015h ], 0F9h
                mov     BYTE PTR[ di+016h ], 007h
                mov     BYTE PTR[ di+018h ], 00Fh
                jmp     BootOk
Boot4:          mov     BYTE PTR[ di+00Dh ], 001h
                mov     BYTE PTR[ di+011h ], 0E0h
                mov     WORD PTR[ di+013h ], 0B40h
                mov     BYTE PTR[ di+015h ], 0F0h
                mov     BYTE PTR[ di+016h ], 009h
                mov     BYTE PTR[ di+018h ], 012h
BootOk:         xor     dx, dx
                mov     dl, bDisco
                mov     cx, 0001h
                mov     bx, di
                mov     ax, 0301h
                call    MiInt13h 
                pop     di
                ret
EscribeBoot     endp


EscribeFat      proc    near
                push    di
                mov     di, OFFSET dgroup:FatSect
                mov     ax, wModo
Fat1:           cmp     ax, 2709h
                jne     Fat2
                mov     BYTE PTR[ di+000h ], 0FDh
                mov     WORD PTR[ di+001h ], 0FFFFh
                xor     dx, dx
                mov     dl, bDisco
                mov     cx, 0002h
Fat1Loop:       mov     bx, di
                mov     ax, 0301h
                call    MiInt13h
                jnc     Fat1T1
                jmp     FatOk
Fat1T1:         inc     cl
                cmp     cl, 06
                jb      Fat1T2
                jmp     FatOk
Fat1T2:         mov     di, OFFSET dgroup:SectorIni
                cmp     cl, 04
                jne     Fat1Loop
                mov     di, OFFSET dgroup:FatSect
                jmp     Fat1Loop
Fat2:           cmp     ax, 4F09h
                jne     Fat3
                mov     BYTE PTR[ di+000h ], 0F9h
                mov     WORD PTR[ di+001h ], 0FFFFh
                xor     dx, dx
                mov     dl, bDisco
                mov     cx, 0002h
Fat2Loop:       mov     bx, di
                mov     ax, 0301h
                call    MiInt13h
                jnc     Fat2T1
                jmp     FatOk
Fat2T1:         inc     cl
                cmp     cl, 08
                jb      Fat2T2
                jmp     FatOk
Fat2T2:         mov     di, OFFSET dgroup:SectorIni
                cmp     cl, 05
                jne     Fat2Loop
                mov     di, OFFSET dgroup:FatSect
                jmp     Fat2Loop
Fat3:           cmp     ax, 4F0Fh
                jne     Fat4
                mov     BYTE PTR[ di+000h ], 0F9h
                mov     WORD PTR[ di+001h ], 0FFFFh
                xor     dx, dx
                mov     dl, bDisco
                mov     cx, 0002h
Fat3Loop:       mov     bx, di
                mov     ax, 0301h
                call    MiInt13h
                jnc     Fat3T1
                jmp     FatOk
Fat3T1:         inc     cl
                cmp     cl, 010h
                jb      Fat3T2
                jmp     FatOk
Fat3T2:         mov     di, OFFSET dgroup:SectorIni
                cmp     cl, 09
                jne     Fat3Loop
                mov     di, OFFSET dgroup:FatSect
                jmp     Fat3Loop
Fat4:           mov     BYTE PTR[ di+000h ], 0F0h
                mov     WORD PTR[ di+001h ], 0FFFFh
                xor     dx, dx
                mov     dl, bDisco
                mov     cx, 0002h
Fat4Loop:       mov     bx, di
                mov     ax, 0301h
                call    MiInt13h
                jnc     Fat4T1
                jmp     FatOk
Fat4T1:         cmp     dh, 01
                je      FatOk
                mov     di, OFFSET dgroup:SectorIni
                inc     cl
                cmp     cl, 013h
                jb      Fat4T2
                mov     dh, 01
                mov     cl, 01
                jmp     Fat4Loop
Fat4T2:         cmp     cl, 0Bh
                jne     Fat4Loop
                mov     di, OFFSET dgroup:FatSect
                jmp     Fat4Loop
FatOk:          pop     di
                ret
EscribeFat      endp


EscribeRoot     proc    near
                push    di
                mov     di, OFFSET dgroup:SectorIni
                mov     ax, wModo
Root1:          cmp     ax, 2709h
                jne     Root2
                xor     dx, dx
                mov     dl, bDisco
                mov     cx, 0006h
Root1Loop:      mov     bx, di
                mov     ax, 0301h
                call    MiInt13h
                jnc     Root1T1
                jmp     RootOk
Root1T1:        inc     cl
                cmp     dh, 01
                je      Root1T2
                cmp     cl, 0Ah
                jb      Root1Loop
                mov     dh, 01
                mov     cl, 01
                jmp     Root1Loop
Root1T2:        cmp     cl, 04
                jb      Root1Loop
                jmp     RootOk
Root2:          cmp     ax, 4F09h
                jne     Root3
                xor     dx, dx
                mov     dl, bDisco
                mov     cx, 0008h
Root2Loop:      mov     bx, di
                mov     ax, 0301h
                call    MiInt13h
                jnc     Root2T1
                jmp     RootOk
Root2T1:        inc     cl
                cmp     dh, 01
                je      Root2T2
                cmp     cl, 0Ah
                jb      Root2Loop
                mov     dh, 01
                mov     cl, 01
                jmp     Root2Loop
Root2T2:        cmp     cl, 06
                jb      Root2Loop
                jmp     RootOk
Root3:          cmp     ax, 4F0Fh
                jne     Root4
                mov     dh, 01
                mov     dl, bDisco
                mov     cx, 0001h
Root3Loop:      mov     bx, di
                mov     ax, 0301h
                call    MiInt13h
                jnc     Root3T1
                jmp     RootOk
Root3T1:        inc     cl
                cmp     cl, 00Fh
                jb      Root3Loop
                jmp     RootOk
Root4:          mov     dh, 01
                mov     dl, bDisco
                mov     cx, 0002h
Root4Loop:      mov     bx, di
                mov     ax, 0301h
                call    MiInt13h
                jnc     Root4T1
                jmp     RootOk
Root4T1:        inc     cl
                cmp     cl, 010h
                jb      Root4Loop
RootOk:         pop     di
                ret
EscribeRoot     endp


SetDisk         proc    near
                push    ds
                push    es
                push    bx
                push    ax
                xor     ax, ax
                mov     es, ax
                mov     ax, wModo
                les     bx, es:[ 0078h ]
                mov     cl, es:[ bx+4 ]
                mov     bBase, cl
                mov     es:[ bx+4 ], al
                xor     ax, ax
                int     13h
                pop     ax
                pop     bx
                pop     es
                pop     ds
                ret
SetDisk         endp


ReSetDisk       proc    near
                push    ds
                push    es
                push    bx
                push    ax
                xor     ax, ax
                mov     es, ax
                mov     al, bBase
                les     bx, es:[ 0078h ]
                mov     es:[ bx+4 ], al
                xor     ax, ax
                int     13h
                pop     ax
                pop     bx
                pop     es
                pop     ds
                ret
ReSetDisk       endp


CHKDSK          proc    far
                push    bp
                mov     bp, sp
                push    ds
                push    es
                push    si
                push    di
                xor     ax, ax
                push    ax
                call    __parinfo
                add     sp, 2
                cmp     al, 1
                je      GetDriveCheck
                jmp     CheckError
GetDriveCheck:  mov     ax, 1
                push    ax
                call    __parni
                add     sp, 2
                cmp     al, 0
                jz      CheckParamOk
                cmp     al, 1
                jz      CheckParamOk
                jmp     CheckError
CheckParamOk:   mov     bDisco, al
                mov     ax, dgroup
                mov     es, ax
                xor     ax, ax
                int     13h
                call    TestBoot
                jmp     CheckExit
CheckError:     mov     ax, -2
CheckExit:      push    ax
                call    __retni
                add     sp, 2
                pop     di
                pop     si
                pop     es
                pop     ds
                pop     bp
                ret
CHKDSK          endp


TestBoot        proc    near
                push    di
                mov     di, OFFSET dgroup:BootSector
                xor     dx, dx
                mov     dl, bDisco
                mov     cx, 0001h
                mov     bx, di
                mov     ax, 0201h
                call    MiInt13h
                jnc     TestBoot1
                cmp     ah, 80h
                jne     TestBootNo
                mov     ax, -1
                jmp     TestBootEnd
TestBoot1:      cmp     WORD PTR[ di+013h ], 02D0h
                jne     TestBoot2
                mov     ax, 1
                jmp     TestBootEnd
TestBoot2:      cmp     WORD PTR[ di+013h ], 05A0h
                jne     TestBoot3
                mov     ax, 2
                jmp     TestBootEnd
TestBoot3:      cmp     WORD PTR[ di+013h ], 0960h
                jne     TestBoot4
                mov     ax, 3
                jmp     TestBootEnd
TestBoot4:      cmp     WORD PTR[ di+013h ], 0B40h
                jne     TestBootNo
                mov     ax, 4
                jmp     TestBootEnd
TestBootNo:     mov     ax, 0
TestBootEnd:    pop     di
                ret
TestBoot        endp


_FAST           ends
                end
