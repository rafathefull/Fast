//  
// ------------------------------------------------------------------------
// FASTlib for Clipper, including all source code, examples and any other 
// file has been donated to Open Source community
// 
// Manu Roibal. Bilbao, May 7 2011
// 
// ------------------------------------------------------------------------
// Please, contact me at		manuroibal@gmail.com
// Follow me at Twitter			@manuroibal
// My Linkedin profile			www.linkedin.com/manuroibal
// 
// Or visit my web site Tons of IT at	www.tonsofit.com
// 


#include "fast.ch"
#include "inkey.ch"



/********************************************************************
*      Fast Library For Clipper Demo Program
*
*      (c) 1992-95 Manu Roibal
*
*      Compile with : clipper demo /A /M /N /W
*
*      Link with rtlink      : tlink FI demo LIB fast, apistd
*                blinker < 3 : blinker FI demo LIB fast, apistd
*                blinker 3   : blinker FI demo LIB fast, apibli
*                exospace    : exospace FI demo LIB fast PAC int10, mouse
*/


FUNCTION Main()
LOCAL nX := Col ()
LOCAL nY := Row ()
LOCAL cColor  := SetColor()
LOCAL nCursor := SetCursor( 0 )
LOCAL nInd
LOCAL aE

    SET DATE TO AMERICAN
    Set ( _SET_SCOREBOARD, .F. )
    SetColor ( "W+/B" )
    BoxWarning( { FastVersion(), ;
                  "", ;
                  "The best library ever created for Clipper", ;
                  "", ;
                  FastRight(), ;
                  "", ;
                  "De omni re scibili et quibusdam aliis" } )
    DemoScreen( .T. )
    DemoScreen( .F. )
    aE := GaugeNew ( 8, "Fast Library For Clipper. L'enfant Terrible", "B" )
    FOR nInd := 1 TO 30
      GaugeUpdate( aE, 1 / 30 )
      Delay( 0.01 )
    NEXT
    TxtMode()
    SetFont ( "Roman.Fon" )
    Banner()
    Screen ( "Å", "B+/B" )
    Clock( .T., 0, 71, "B+/B" )
    BoxWarning( "To register, read the file REGISTER.DOC" )
    SetColor ( "N/BG,N/W" )
    NewBox ( 3, 22, 22, 59, "Fast Library Demo Program", "ÉÍ»º¼ÍÈº ", .T. )
    @  4, 59 SAY CHR( 24 )
    @ 21, 59 SAY CHR( 25 )
    aChoice ( 5, 25, 21, 56, ;
              { " 1. PCX & GIF in 256 color modes", ;
                " 2. PCX in EGA-VGA", ;
                " 3. Calculator", ;
                " 4. Autodesk FLI animations!!!", ;
                " 5. Calendar", ;
                " 6. Serpent game", ;
                " 7. Screen Saver", ;
                " 8. Clipper Notes", ;
                " 9. 3D Graph Bar Demo", ;
                "10. 3D Graph Bar Demo", ;
                "11. 3D Graph Bar Demo", ;
                "12. 3D Graph Bar Demo", ;
                "13. 3D Graph Bar Demo", ;
                "14. 3D Graph Bar Demo", ;
                "15. 3D Graph Line Demo", ;
                "16. 3D Graph Zone Demo", ;
                "17. 3D Graph Tart Demo", ;
                "18. 3D Graph Ellipse Demo", ;
                "19. File Manager", ;
                "20. Backup", ;
                "21. Restore", ;
                "22. Window System Demo", ;
                "23. Directory Structure", ;
                "24. Load INI files", ;
                "25. Load and modify INI files", ;
                "26. A little Text Editor", ;
                "27. Windows with light focus", ;
                "28. GET Password", ;
                "29. Encrypt string", ;
                "30. Deencrypt string", ;
                "31. Huffman Compression", ;
                "32. Choose Color", ;
                "33. Keyboard demo", ;
                "34. Menu System Demo", ;
                "35. System information", ;
                "36. Mouse demo", ;
                "37. Font Editor", ;
                "38. Footing with Clipper", ;
                "39. Big Clock", ;
                "40. Puzzle", ;
                "41. A mini debugger", ;
                "42. Ascii Table", ;
                "43. A message with scroll", ;
                "44. Sound Blaster demo", ;
                "45. Parallel DAC demo", ;
                "46. Speaker demo", ;
                "47. New Memo edit function", ;
                "48. More Speed please", ;
                "49. Fast Icons", ;
                "50. CD Audio Support!!!", ;
                "51. GraySumming", ;
                "52. Chaos", ;
                "53. A real star field simulator", ;
                "54. Light effects", ;
                "55. FM sounds", ;
                "56. Graphic Boxes", ;
                "57. Disk Information", ;
                "58. BMP decoder" }, ;
              .T., "USERFUNC" )
    DemoScreen ( .F. )
    SetPos ( nY, nX )
    SetColor ( cColor )
    SetCursor ( nCursor )
    SetFont ( "Standard.Fon" )
RETURN NIL


FUNCTION UserFunc ( nMode, nElement, nRel )
LOCAL aScr
LOCAL nRet   := 2
LOCAL nInd
LOCAL cMemo  := "To be or not to be, that's the fastquestion"
LOCAL cColor
    IF Lastkey () == K_ESC
      IF BoxQuery( "Are you sure you want to exit to DOS?", 20 )
        RETURN( 0 )
      ELSE
        RETURN( 32 )
      ENDIF
    ELSEIF Lastkey () == K_RETURN
      aScr := SaveScr ( , , , , 1 + nRandom ( 3 ) )
      DemoScreen ( .F. )
      Do CASE
        CASE nElement == 1
          BoxWarning( "An image in full screen" )
          SetVGA256()
          IF GIFShow256( "demo.gif" )
            rCursorOn()
            rInkey( 0 )
            rCursorOff()
            TxtMode()
            BoxWarning( "The same image 5 times" )
            SetVGA256()
            PCXShow256( "demo.pcx", , ,   0,   0 )
            PCXShow256( "demo.pcx", , , 160,   0 )
            PCXShow256( "demo.pcx", , ,   0, 100 )
            PCXShow256( "demo.pcx", , , 160, 100 )
            PCXShow256( "demo.pcx", , ,  80,  50 )
            Inkey( 0 )
          ENDIF
          TxtMode()
          SetBlink(.F.)
        CASE nElement == 2
          PCXDemo()
        CASE nElement == 3
          Calculator ( "N/W", "G+/N", "R+/N" )
        CASE nElement == 4
          FliEver( "fast.fli" )
        CASE nElement == 5
          Calendar ( 5, 20, "N/BG", "R/BG", "GR+/B" )
        CASE nElement == 6
          Serpent ( "W+/B*", "R+/B*", "G+/B*" )
        CASE nElement == 7
          ScreenSave ( "BG+/N", "Fast Library For Clipper. (C) 1995 Manu Roibal" )
        CASE nElement == 8
          Notes( "W/B,N/BG", "W/B,N/BG,G/B,W/B,R+/B", "HojaCalc.hc" )
        CASE nElement == 9
          BarDemo( 0 )
        CASE nElement == 10
          BarDemo( 1 )
        CASE nElement == 11
          BarDemo( 2 )
        CASE nElement == 12
          BarDemo( 3 )
        CASE nElement == 13
          Graph2Demo()
        CASE nElement == 14
          Graph3Demo()
        CASE nElement == 15
          GraphLineDemo( 1 )
        CASE nElement == 16
          GraphLineDemo( 2 )
        CASE nElement == 17
          TartDemo()
        CASE nElement == 18
          EllipseDemo ()
        CASE nElement == 19
          Manager ( "N/W,N/BG", "N/BG", "*.*" )
        CASE nElement == 20
          Backup ( Date (), Time (), "Root", "A:\", ;
                   { { "C:\DOS\",      "*.*"   }, ;
                     { "C:\OS2\MDOS\", "*.COM" } }, ;
                   .T., "N/W,N/W" )
        CASE nElement == 21
          Restore ( "A:\", { "D:\DOS" }, "N/W,N/W" )
        CASE nElement == 22
          DemoWindows ()
        CASE nElement == 23
          TreeDemo ( "C:\", "\*.*" )
        CASE nElement == 24
          LoadIniFile( "FAST", "MANU", "CPUTYPE" )
        CASE nElement == 25
          ChangeIniFile( "FAST", "MANU", "TIMESLIZE" )
        CASE nElement == 26
          Editor ( "Fast.Ini", "W/B" )
        CASE nElement == 27
          DemoFocus()
        CASE nElement == 28
          GivePass()
        CASE nElement == 29
          TopSecret()
        CASE nElement == 30
          TopSecret()
        CASE nElement == 31
          Huffman()
        CASE nElement == 32
          SetBlink( .F. )
          cColor := ChooseColor()
          IF cColor != Nil
            BoxWarning( "The selected color is: "+ cColor )
          ENDIF
        CASE nElement == 33
          KeyDemo()
        CASE nElement == 34
          Menues ()
        CASE nElement == 35
          ClipMem()
        CASE nElement == 36
          DemoMouse()
        CASE nElement == 37
          FontEdit( "cubo.fon" )
        CASE nElement == 38
          Footing()
        CASE nElement == 39
          BigClock()
        CASE nElement == 40
          BoxWarning( "The winner is... " + IIF( Puzzle( , , "W" ), "the User", "the Computer" ) )
        CASE nElement == 41
          MiniDebug( 7, "Replicate( 'Fast ', 2 )" )
        CASE nElement == 42
          AsciiTab()
          AsciiTabPro()
        CASE nElement == 43
          MsgScroll( 10, 20, 30, "Fast Library For Clipper, the best Clipper extender", "GR+/B" )
        CASE nElement == 44
          IF sbInit()
            sbVocPlay ( "Fast.voc", 11025 )
          ENDIF
        CASE nElement == 45
          IF BoxQuery( "Do you have a Parallel DAC in LPT2?", 20 )
            dacPort( 2 )
            dacVocPlay( "Fast.voc", 11025 )
         ENDIF
        CASE nElement == 46
          spkVocPlay( "Fast.voc", 11025 )
        CASE nElement == 47
          cMemo := FastMemo( 10, 10, 20, 60, cMemo, "Demo", "W+/B", .T., .T. )
        CASE nElement == 48
          MoreSpeed()
        CASE nElement == 49
          DemoIcons()
        CASE nElement == 50
          cdDemo()
        CASE nElement == 51
          GraySumming()
        CASE nElement == 52
          Chaos()
        CASE nElement == 53
          RealStars( 4 )
        CASE nElement == 54
          LightEffects()
        CASE nElement == 55
          FMSounds()
        CASE nElement == 56
          gBoxes()
        CASE nElement == 57
          DiskInfo()
        CASE nElement == 58
          BMPDemo()
      ENDCASE
      SetFont ( "Roman.Fon" )
      SetCursor ( 1 )
      SetCursor ( 0 )
      RestScr ( , , , , aScr )
    ELSEIF LastKey () == K_ESC
      nRet := 0
    ENDIF
RETURN ( nRet )


STATIC FUNCTION DemoScreen ( lModo )
Static cScr
    IF lModo
      cScr := SaveScreen ( 0, 0, MaxRow(), MaxCol() )
    ELSE
      RETURN ( Implode ( 0, 0, MaxRow(), MaxCol(), cScr ) )
    ENDIF
RETURN NIL


STATIC FUNCTION GivePass()
LOCAL cScreen := SaveScreen ( 0, 0, 24, 79 )
LOCAL nCursor := SetCursor ( 0 )
LOCAL cColor  := SetColor ( "W+/B" )
LOCAL cPass
    NewBox ( 5, 5, 11, 74, "Security", "ÉÍ»º¼ÍÈº ", .T. )
    cPass := GetPass ( 7, 12, "Input your access key (15 letters Max.):", 15 )
    @ 9, 12 SAY "You have pressed: " + cPass
    Inkey( 0 )
    SetColor ( cColor )
    SetCursor ( nCursor )
    Implode ( 0, 0, 24, 79, cScreen )
RETURN NIL


STATIC FUNCTION TopSecret()
LOCAL cScreen  := SaveScreen ( 0, 0, 24, 79 )
LOCAL nCursor := SetCursor ( 0 )
LOCAL cColor  := SetColor ( "W+/B" )
LOCAL cEncrip
LOCAL cDeEncrip
    NewBox ( 5, 5, 10, 74, "De/Encrypt", "ÉÍ»º¼ÍÈº ", .T. )
    cEncrip := Encrypt( "Manu Roibal", "Password" )
    Message ( 7, 12, "<Manu Roibal> -> encrypt -> " + cEncrip )
    cDeEncrip := DeEncrypt( cEncrip, "Password" )
    Message ( 8, 12, "<" + cEncrip + "> -> deEncrypt -> " + cDeEncrip )
    Inkey (0)
    SetColor ( cColor )
    SetCursor ( nCursor )
    Implode ( 0, 0, 24, 79, cScreen )
RETURN NIL


STATIC FUNCTION TreeDemo ( cDisk, cMask )
LOCAL cScreen  := SaveScreen ( 0, 0, 24, 79 )
LOCAL nCursor := SetCursor ( 0 )
LOCAL cColor  := SetColor ( "W+/B,N/W" )
LOCAL aDisk   := DirTree ( cMask, cDisk )
    Window ( 4, 0, 22, 29, "Directory " + cDisk, "ÉÍ»º¼ÍÈº ", .T. )
    Achoice ( 5, 2, 21, 27, aDisk, .T. )
    SetColor ( cColor )
    SetCursor ( nCursor )
    Implode ( 0, 0, 24, 79, cScreen )
RETURN NIL


STATIC FUNCTION DemoWindows ()
LOCAL aColor := { "N/BG", "W+/R", "R/W",  "G/W",  "B/W",  "W/B", ;
                  "G+/W", "W+/G", "BG/N", "N/BG", "R+/B", "GR+/N" }
LOCAL nType
LOCAL cColor
LOCAL nInd := 0
LOCAL nX1  := 0
LOCAL nY1  := 0
LOCAL nX2  := 0
LOCAL nY2  := 0
LOCAL aScr := {}
LOCAL cScr := ""
    FOR nInd := 1 TO 25
      nX1 := nRandom ( 77 ) + 1
      nY1 := nRandom ( 22 ) + 1
      nX2 := nRandom ( 78 - nX1 ) + nX1 + 1
      nY2 := nRandom ( 23 - nY1 ) + nY1 + 1
      cColor  := aColor [ nRandom ( 12 ) + 1 ]
      nType := nRandom ( 3 ) + 1
      IF nX2 - nX1 < 22
        nType := 4
      ENDIF
      IF nType == 1
        IF Seconds () % 2 == 0
          Window ( nY1, nX1, nY2, nX2, "Window with shadow", "ÉÍ»º¼ÍÈº ", .T., cColor )
        ELSE
          NewBox ( nY1, nX1, nY2, nX2, "NewBox with shadow", "ÉÍ»º¼ÍÈº ", .T., cColor )
        ENDIF
      ELSEIF nType == 2
        IF Seconds () % 2 == 0
          Window ( nY1, nX1, nY2, nX2, "Window without shadow", "ÉÍ»º¼ÍÈº ", .F., cColor )
        ELSE
          NewBox ( nY1, nX1, nY2, nX2, "NewBox without shadow", "ÉÍ»º¼ÍÈº ", .F., cColor )
        ENDIF
      ELSEIF nType == 3
        Wall ( nY1, nX1, nY2, nX2, cColor )
      ELSE
        IF Seconds () % 2 == 0
          Window ( nY1, nX1, nY2, nX2, , "ÉÍ»º¼ÍÈº ", .T., cColor )
        ELSE
          NewBox ( nY1, nX1, nY2, nX2, , "ÉÍ»º¼ÍÈº ", .T., cColor )
        ENDIF
      ENDIF
    NEXT
    Inkey(5)
    Stars()
    cScr := SaveScreen ( 0, 0, 24, 79 )
    Fascinate( "G", "BG" )
    Inkey(0)
    aScr := SaveScr ( , , , , 1 )
    RestScreen ( 0, 0, 24, 79, cScr )
    RestScr ( , , , , aScr )
    aScr := SaveScr ( , , , , 2 )
    RestScreen ( 0, 0, 24, 79, cScr )
    RestScr ( , , , , aScr )
    aScr := SaveScr ( , , , , 3 )
    RestScreen ( 0, 0, 24, 79, cScr )
    RestScr ( , , , , aScr )
    aScr := SaveScr ( , , , , 4 )
    RestScreen ( 0, 0, 24, 79, cScr )
    RestScr ( , , , , aScr )
RETURN NIL


STATIC FUNCTION LoadIniFile( cFile, cApplication, cData )
LOCAL cValue
LOCAL cScreen  := SaveScreen ( 0, 0, 24, 79 )
LOCAL aIniFile := IniLoad ( cFile, cApplication )
    cValue := IniSearch( aIniFile, cData, "386SX" )
    Window ( 9, 15, 16, 64, "Configuration", "ÉÍ»º¼ÍÈº ", .T., "N/BG" )
    Message ( 11, 20, "The .Ini shows CPU Type -> " + cValue, "N/BG" )
    Message ( 12, 20, "Default value is        -> 386SX" , "N/BG" )
    Message ( 14, 20, "For more information read Fast.ini", "N/BG" )
    Inkey ( 0 )
    Implode ( 0, 0, 24, 79, cScreen )
RETURN NIL


STATIC FUNCTION ChangeIniFile( cFile, cApplication, cData )
LOCAL cValue
LOCAL cNew
LOCAL cScreen  := SaveScreen ( 0, 0, 24, 79 )
LOCAL aIniFile := IniLoad ( cFile, cApplication )
    cValue := IniSearch( aIniFile, cData, "50" )
    Window ( 9, 15, 16, 64, "Configuration", "ÉÍ»º¼ÍÈº ", .T., "N/BG" )
    Message ( 11, 20, "The .Ini shows Time Slize -> " + cValue, "N/BG" )
    cNew := TransForm ( nRandom ( 99 ), "99" )
    IniSave( aIniFile, cData, cNew )
    IniWrite( aIniFile, cFile, cApplication )
    Message ( 12, 20, "New value will be         -> " + cNew, "N/BG" )
    Message ( 14, 20, "For more information read Fast.ini", "N/BG" )
    Inkey ( 0 )
    Implode ( 0, 0, 24, 79, cScreen )
RETURN NIL


STATIC FUNCTION DemoFocus()
LOCAL aButton
    aButton := BoxOpen ( 3, 10, 5, 50, "B", .1 )
    Message ( 4, 13, "- Original idea by Urbano Garc¡a -", "W+/B" )
    While Inkey ( 0 ) != K_ESC
      BoxPush ( aButton )
    END
    BoxClose ( aButton )
RETURN NIL


STATIC FUNCTION BarDemo( nType )
    SetVGA ()
    GraphBar ( "This is a VGA special effects demo", ;
               { "Item 1",          { 2481, 3212, 4212, 1266, 1699, 6312 } }, ;
               { "Item 2",          { 4000, 2000, 4000, 2000, 8000, 9000 } }, ;
               { "Item 3",          { 2481, 3212, 4212, 1266, 1699, 6312 } }, ;
               { "Item 4 and last", { 2281, 3332, 3212, 2557, 7499, 2612 } }, ;
               nType )
    Inkey (0)
    Degrade( GetPalette() )
    TxtMode ()
    SetBlink (.F.)
RETURN NIL


STATIC FUNCTION Graph2Demo ()
    SetVGA ()
    GraphBar2( "This is a VGA special effects demo", ;
                { { 9481, 4212, 5212, 4266, 8699, 9442, 9298, 9481, 4212, 5212, 4266, 8699 }, ;
                  { 2481, 3212, 4212, 1266, 1699, 6312, 7921, 7481, 2212, 5412, 3266, 4699 }, ;
                  { 2281, 3332, 3212, 2557, 7499, 2612, 3120, 6481, 1212, 3212, 4266, 7699 }, ;
                  { 7481, 1212, 4642, 1234, 6542, 9312, 1921, 8481, 3212, 4212, 2266, 6699 } } )
    Legend (  20, 420, 15,  9, "Fast Library" )
    Legend ( 340, 420, 15, 10, "Other" )
    Legend (  20, 450, 15, 11, "Other" )
    Legend ( 340, 450, 15, 12, "Other" )
    Inkey (0)
    Degrade( GetPalette() )
    TxtMode ()
    SetBlink (.F.)
RETURN NIL


STATIC FUNCTION Graph3Demo ()
    SetVGA ()
    GraphBar3 ( "This is a VGA special effects demo", ;
               { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", ;
                 "Item 7", "Item 8", "Item 9", "Item A", "Item B", "Item C", ;
                 "Item D", "Item E", "Item F", "Item 0" }, ;
               {     9481,     4212,     5212,     4266,     8699,     9442, ;
                    19481,    23212,     5212,     2166,     1699,    19442, ;
                     7212,    12266,      699,    22442 } )
    Inkey (0)
    Degrade( GetPalette() )
    TxtMode ()
    SetBlink (.F.)
RETURN NIL


STATIC FUNCTION GraphLineDemo( nMode )
    SetVGA ()
    IF nMode == 1
      GraphLine( "This is a VGA special effects demo", ;
                 { { 1481, 1212, 2642, 1234, 1542, 1312, 1921, 2481, 1212, 2212, 2266, 2699 }, ;
                   { 2281, 3332, 3212, 2557, 2499, 2612, 3120, 2481, 1312, 3212, 4266, 3699 }, ;
                   { 2481, 3212, 4212, 1266, 1699, 6312, 7921, 7481, 2212, 5412, 3266, 4699 }, ;
                   { 9481, 6212, 5212, 4266, 8699, 9442, 9298, 9481, 5212, 6212, 5266, 8699 } } )
    ELSE
      GraphZone( "This is another title", ;
                 { { 1481, 1212, 2642, 1234, 1542, 1312, 1921, 2481, 1212, 2212, 9999, 2699 }, ;
                   { 2281, 3332, 3212, 2557, 2499, 2612, 3120, 2481, 1312, 3212, 4266, 3699 }, ;
                   { 2481, 3212, 4212, 1266, 1699, 6312, 7921, 7481, 2212, 5412, 3266, 4699 }, ;
                   { 9481, 6212, 5212, 4266, 8699, 9442, 9298, 9481, 5212, 6212, 5266, 8699 } } )
    ENDIF
    SetFont ( "Roman.Fon", .T. )
    Legend (  20, 420, 15,  9, "Other" )
    Legend ( 340, 420, 15, 10, "Other" )
    Legend (  20, 450, 15, 11, "Other" )
    Legend ( 340, 450, 15, 12, "Fast Library" )
    Inkey (0)
    Degrade( GetPalette() )
    TxtMode ()
    SetBlink (.F.)
RETURN NIL


STATIC FUNCTION TartDemo()
LOCAL cTitulo := "Statistics"
    SetVGA ()
    GraphTart ( 540, 60, 40, { 17, 3, 15, 60, 15 } )
    GraphTart ( 80, 120, 30, { 17, 3, 15, 60, 15 } )
    fgBox ( 210, 130, 430, 350, 10 )
    GraphTart ( 320, 240, 100, { 17, 3, 15, 60, 15 } )
    DispStr ( cTitulo, 320 - Len ( cTitulo ) * 4, 370, 15, 0 )
    Legend ( 320, 460, 15, 4, "Fast Library For Clipper" )
    Inkey (0)
    Degrade( GetPalette() )
    TxtMode ()
    SetBlink (.F.)
RETURN NIL


STATIC FUNCTION EllipseDemo ()
LOCAL cTitulo := "Statistics"
    SetVGA ()
    GraphEllipse ( 540, 60, 40, { 17, 3, 15, 60, 15, 21, 21, 23, 54 } )
    GraphEllipse ( 80, 120, 30, { 17, 3, 15, 60, 15, 21, 47, 11, 11, 64, 11 } )
    fgBox ( 210, 130, 430, 350, 10 )
    GraphEllipse ( 320, 240, 100, { 17, 23, 12, 72, 3, 15, 60, 21, 15 } )
    DispStr ( cTitulo, 320 - Len ( cTitulo ) * 4, 370, 15, 0 )
    Legend ( 320, 460, 15, 4, "Fast Library For Clipper" )
    Inkey (0)
    Degrade( GetPalette() )
    TxtMode ()
    SetBlink (.F.)
RETURN NIL


STATIC FUNCTION DemoMouse()
LOCAL aInfo
LOCAL aTypes := { "bus", "serial", "InPort", "PS/2", "HP" }
    Cls
    IF rIsMouse()
      aInfo := rVersion()
      ? "Mouse driver version " + aInfo[ 1 ]
      ? "IRQ number " + ALLTRIM( STR( aInfo[ 2 ] ) )
      ? aTypes[ aInfo[ 3 ] ] + " mouse installed"
      ? "Well, you have a mouse; Then, press any key or mouse button"
      rSoftCur()
      rInkey(0)
      rCursorOn ()
      rSetPos ( 12, 39 )
      ? "Now mouse cursor is on 12,39"
      rSetPos ( 12, 39 )
      rInkey(0)
      rCursorOff ()
      ? "good bye mouse"
      rInkey(0)
      rCursorOn()
      ? "hello mouse"
      rInkey(0)
      ? "Now, press any key or mouse button"
      rInkey(0)
      rCursorOff()
    ELSE
      BoxWarning ( "There is no mouse on system" )
    ENDIF
RETURN NIL


STATIC FUNCTION Menues ()
LOCAL aMenu
LOCAL nOpt
LOCAL cColor   := "W+/BG,N+/BG"
LOCAL cGet1    := "Manu Roibal                 "
LOCAL cGet2    := "Fast Library For Clipper "
LOCAL GetList  := {}
LOCAL nChoice1 := 2
LOCAL nChoice2 := 1
LOCAL nChoice3 := 1
LOCAL nChoice4 := 2
LOCAL nChoice5 := 2
    Fascinate ( "GR", "BG" )
    Set wrap On
    Set message TO 24 Center
    @ 24, 0 SAY Space ( 80 ) Color "N/W"
    aMenu := NewMenu( { "^System", "^Tools", "^States", "^Last" }, ;
                      { "N/W", "R/W", "N/G", "R/G", "N/W", "N/G", "N+/W", ;
                        "R/W", "R/G" }, ;
                      .T. )
    AddItem ( aMenu, 1, "^New", "Nothing" )
    AddItem ( aMenu, 1, "^Open" )
    AddLine ( aMenu, 1 )
    AddItem ( aMenu, 1, "^Save", "More messages", , { "Item 1", "Item 2", "Item 3" } )
    AddItem ( aMenu, 1, "^Discard", , , { "First Item", "Second Item", "Third Item" } )
    AddLine ( aMenu, 1 )
    AddItem ( aMenu, 1, "Good m^orning sir", , 3 )
    AddItem ( aMenu, 1, "^Quit", "Are you sure you want exit from here?" )
    DelItem ( aMenu, 1, 3 )
    OffItem ( aMenu, 1, 2 )
    AddItem ( aMenu, 2, "^Cut" )
    AddItem ( aMenu, 2, "^Paste" )
    AddItem ( aMenu, 2, "^Copy" )
    AddItem ( aMenu, 3, "^Search" )
    AddItem ( aMenu, 3, "^Replace" )
    AddItem ( aMenu, 4, "^Help" )
    AddItem ( aMenu, 4, "And ^more Help" )
    AddItem ( aMenu, 4, "And more, ^and more..." )
    AddLine ( aMenu, 4 )
    AddItem ( aMenu, 4, "Little rabbit ^Duracell", , , { "1 Item", "2 Item", "3 Item" } )
    nOpt := DispMenu ( aMenu, 3 )
    BoxWarning ( "And the winner is... " + STR ( nOpt ) )
    Cls
    SetCursor ( 1 )
    @  4,  5 SAY "GET Normal 1:" ;
             GET cGet1
    @  6,  5 SAY "Clipper Lib" ;
             GET nChoice1 ;
             VALID nChoice1 == 3 ;
             COLOR cColor ;
             WITH RADIOBUTTONS { "Option1", "No buttons", "Not Selected" }
    @  6, 40 SAY "Fast Library" ;
             GET nChoice2 when nChoice1 != 2 ;
             COLOR cColor ;
             WITH RADIOBUTTONS { "Adios", "Agur", "Bye bye", "Adeu" }
    @  7, 60 GET nChoice3 ;
             COLOR cColor ;
             WITH RADIOBUTTONS { "Fast", "Normal", "Slow" } ;
             NOBOX
    @ 12,  5 SAY "GET Normal 2:" ;
             GET cGet2
    @ 15,  5 SAY "Buttons 4:"
    @ 15, col() + 1 GET nChoice4 ;
             COLOR cColor ;
             WITH RADIOBUTTONS { "first", "second" } ;
             NOBOX ;
             HORIZONTAL
    @ 17,  5 SAY "Buttons 5:" ;
             GET nChoice5 ;
             COLOR cColor ;
             WITH RADIOBUTTONS { "One", "Two", "Three" } ;
             DOUBLE ;
             HORIZONTAL
    READ
RETURN NIL


STATIC FUNCTION MoreSpeed()
LOCAL nTime
LOCAL aButton
LOCAL nInd
    aButton := BoxOpen ( 8, 2, 14, 76, "B", .1 )
    @ 10, 10 SAY "Writes 1 to 15,000 with @ SAY ->" Color "W+/B"
    nTime := Seconds()
    FOR nInd := 1 to 15000
      @ 10, 40 SAY Str( nInd ) Color "W+/B"
    NEXT
    @ 10, 60 SAY Str( Seconds() - nTime ) Color "GR+/B"
    @ 12, 10 SAY "Writes 1 to 15,000 with Fast  ->" Color "W+/B"
    nTime := Seconds()
    FOR nInd := 1 to 15000
      FastPrint( 12, 40, Str( nInd ), 31 )
    NEXT
    @ 12, 60 SAY Str( Seconds() - nTime ) Color "GR+/B"
    Inkey(0)
    BoxClose( aButton )
RETURN NIL


STATIC FUNCTION DemoIcons()
LOCAL aExit, aCube, aLine
    Cls
    SetFont( "Cubo.Fon" )
    Screen( Chr( 235 ), "N+/W" )
    aExit := BoxOpen( 5, 30, 7, 34, "B", 0.2 )
    @ 6, 31 SAY "ðóò" Color "GR+/B"
    aCube := BoxOpen( 5, 38, 7, 42, "B", 0.2 )
    @ 6, 39 SAY " ô " Color "GR+/B"
    aLine := BoxOpen( 5, 46, 7, 50, "B", 0.2 )
    @ 6, 47 SAY " ÚÛ" Color "GR+/B"
    Inkey( 0 )
    BoxPush( aExit )
    Inkey( 0 )
    BoxPush( aCube )
    Inkey( 0 )
    BoxPush( aLine )
    SetFont( "Standard.Fon" )
RETURN NIL


STATIC FUNCTION Footing()
LOCAL nI      := 0
LOCAL nCont   := 1
LOCAL cC      := ""
LOCAL nN      := 1
LOCAL cColor  := setcolor( "Gr+/B" )
LOCAL aWords  := {}
LOCAL cMsg    := "Fast-Fonts Demo ideated by ÷Yosu Unibaso"
LOCAL nLenMsg := Len( cMsg ) + 12 - 1
LOCAL aBox
    aWords := Array( 80 )
    aFill( aWords, " " )
    FOR nI := 12 TO nLenMsg
      aWords[ nI ] := SubStr( cMsg, nI - 11, 1 )
    NEXT
    SetFont( "cubo.fon" )
    aBox := BoxOpen( 4, 0, 6, 79, "b", 0.2 )
    @ 5, 2 SAY "î"
    FOR nI := 2 TO 78
      IF nCont == 1
        cC := "ñ"
      ELSEIF nCont == 2
        cC := "î"
      ELSEIF nCont == 3
        cC := "ö"
      ELSEIF nCont == 4
        cC := "î"
      ENDIF
      @ 5, nI SAY cC
      nCont := IIF( nCont < 4, ++nCont, 1 )
      Delay( 0.01 )
      @ 5, nI SAY aWords[ nI ]
    NEXT
    cC := "ÜÝ"
    FOR nI := 2 TO 77
      @ 5, nI SAY cC
      Delay( 0.01 )
      @ 5, nI SAY "  "
    NEXT
    BoxPush( aBox )
    BoxClose( aBox )
    SetFont( "standard.fon" )
    SetColor( cColor )
RETURN NIL


STATIC FUNCTION KeyDemo()
    Cls
    While Inkey() != K_ESC
      @  1, 2 SAY "Insert     " + IIF( IsInsert(), "Yes", "No " )
      @  2, 2 SAY "Caps       " + IIF( IsCaps(),   "Yes", "No " )
      @  3, 2 SAY "Num        " + IIF( IsNum(),    "Yes", "No " )
      @  4, 2 SAY "Scroll     " + IIF( IsScroll(), "Yes", "No " )
      @  5, 2 SAY "Alt        " + IIF( IsAlt(),    "Yes", "No " )
      @  6, 2 SAY "Ctrl       " + IIF( IsCtrl(),   "Yes", "No " )
      @  7, 2 SAY "lShift     " + IIF( IsLShift(), "Yes", "No " )
      @  8, 2 SAY "rShift     " + IIF( IsRShift(), "Yes", "No " )
      @ 10, 2 SAY "Joystick 1 " + IIF( jButton1(), "Yes", "No " )
      @ 11, 2 SAY "Joystick 2 " + IIF( jButton2(), "Yes", "No " )
      @ 14, 2 SAY "Push Esc to exit"
    END
RETURN Nil


STATIC FUNCTION cdDemo()
LOCAL nKey
LOCAL aButtons := Array( 6 )
LOCAL aTracks
LOCAL nInd
LOCAL nVolume  := 12
LOCAL cColor   := SetColor( "GR+/B" )
LOCAL aStatus
LOCAL aTime
   sbCDVolR( nVolume )
   sbCDVolL( nVolume )
   BoxOpen( 1, 1, 8, 70, "B" )
   @  3, 3 SAY "CD Install & ready : " + if( cdInstall(), "Yes", "No" )
   @  4, 3 SAY "MSCDEX Version     : " + MSCDEXVer()
   @  5, 3 SAY "First CD unit      : " + cdDrive()
   @  6, 3 SAY "Volume             : " + STR( nVolume, 2 )
   aButtons[ 1 ] := BoxMessage( "<F1>  Start the CD ", 11,  5 )
   aButtons[ 2 ] := BoxMessage( "<F2>  Stop the CD  ", 15,  5 )
   aButtons[ 3 ] := BoxMessage( "<F3>  Resume the CD", 11, 40 )
   aButtons[ 4 ] := BoxMessage( "<F4>  Open/Close CD", 15, 40 )
   aButtons[ 5 ] := BoxMessage( "<Esc> Exit         ", 19,  5 )
   aButtons[ 6 ] := BoxMessage( " +/-  Change Volume", 19, 40 )
   While ( nKey := Inkey( 0.2 ) ) != K_ESC
     aStatus := cdStatus()
     aTime   := cdTime()
     @  3, 40 SAY "Door open?     " + IIF( aStatus[ 1 ], "Yes", "No " )
     @  4, 40 SAY "Playing?       " + IIF( aStatus[ 2 ], "Yes", "No " )
     @  5, 40 SAY "Disk in drive? " + IIF( aStatus[ 3 ], "Yes", "No " )
     @  6, 40 SAY "Song " + STRZERO( aTime[ 1 ], 2 ) + ;
                  " - " + STRZERO( aTime[ 2 ], 2 ) + ":" + STRZERO( aTime[ 3 ], 2 )
     if nKey == K_F1
       BoxPush( aButtons[ 1 ] )
       cdPlay( 1 )
     ELSEIF nKey == K_F2
       BoxPush( aButtons[ 2 ] )
       cdStop()
     ELSEIF nKey == K_F3
       BoxPush( aButtons[ 3 ] )
       cdResume()
     ELSEIF nKey == K_F4
       IF ! aStatus[ 2 ]
         BoxPush( aButtons[ 4 ] )
         IF ! aStatus[ 1 ]
           cdEject()
         ELSE
           cdClose()
         ENDIF
       ENDIF
     ELSEIF CHR( nKey ) == "-" .OR. CHR( nKey ) == "+"
       BoxPush( aButtons[ 6 ] )
       IF CHR( nKey ) == "-"
         nVolume := MAX( nVolume - 1, MIN_SB_VOLUME )
       ELSE
         nVolume := MIN( nVolume + 1, MAX_SB_VOLUME )
       ENDIF
       sbCDVolR( nVolume )
       sbCDVolL( nVolume )
       @ 6, 24 SAY STR( nVolume, 2 )
     ENDIF
   END
   BoxPush( aButtons[ 4 ] )
   SetColor( cColor )
RETURN NIL


STATIC FUNCTION PCXDemo ()
LOCAL i
    SetVGA()
    fgCls( 1 )
    PCXShow ( "fast.pcx", .F., 100,  10 )
    DispStr ( "This's a hardware move", 260, 60, 15, 0 )
    While Inkey() == 0
      FOR i := 0 TO -240 STEP -2
        Origin( 0, i )
      NEXT
      FOR i := -240 TO 0 STEP +2
        Origin( 0, i )
      NEXT
      Origin( 0, 0 )
    END
    CLEAR TYPEAHEAD
    TxtMode ()
    SetBlink(.F.)
RETURN NIL


STATIC FUNCTION ClipMem()
LOCAL aBox       := BoxOpen( 3, 3, 22, 76, "B" )
LOCAL cColor     := SETCOLOR( "GR+/B" )
LOCAL cProcessor
LOCAL aProcessor  := { "8088",    "8086",    "80286", "80386", "80486", ;
                       "Pentium", "6tium",   "7tium", "8tium", "9tium", ;
                       "NEC V20", "NEC V30", "80188", "80186" ;
                      }
    cProcessor := aProcessor[ CpuType() + 1 ]
    @  5,  5 SAY FastVersion()
    @  6,  5 SAY FastRight()
    @  8,  5 SAY "Processor          " + cProcessor
    @  9,  5 SAY "CoProcessor        " + IIF( IsCopro(), "Yes", "No" )
    @ 11,  5 SAY "Parallel ports     " + Str( NumParallel(), 1 )
    @ 12,  5 SAY "Serial ports       " + Str( NumSerial(),  1 )
    @ 14,  5 SAY "Disk Serial Number " + DiskSerNum( 0 )
    @ 15,  5 SAY "Disk Volume Label  " + GetLabel( 0 )
    @ 17,  5 SAY "DPMI Version       " + DPMIVersion()
    @ 18,  5 SAY "WIN 3 Version      " + WinVersion()
    @ 19,  5 SAY "DESQVIEW Version   " + DesqVer()
    @ 20,  5 SAY "MSCDEX Version     " + MSCDEXVer()
    @  5, 45 SAY "Data Memory  (Kb)  " + Str( memory( 0 ) )
    @  6, 45 SAY "Longer block (Kb)  " + Str( memory( 1 ) )
    @  7, 45 SAY "Run Memory   (Kb)  " + Str( memory( 2 ) )
    @  9, 45 SAY "PRINT    loaded  " + IF( IsPrint(),    "Yes", "No" )
    @ 10, 45 SAY "ANSI     loaded  " + IF( IsAnsi(),     "Yes", "No" )
    @ 11, 45 SAY "KEYB     loaded  " + IF( IsKeyb(),     "Yes", "No" )
    @ 12, 45 SAY "QEMM     loaded  " + IF( IsQEMM(),     "Yes", "No" )
    @ 13, 45 SAY "SHARE    loaded  " + IF( IsShare(),    "Yes", "No" )
    @ 14, 45 SAY "SMARTDRV loaded  " + IF( IsSmartDrv(), "Yes", "No" )
    @ 15, 45 SAY "XMS Drv. loaded  " + IF( IsXMS(),      "Yes", "No" )
    @ 17, 45 SAY "NOVELL present   " + IF( IsNovell(),   "Yes", "No" )
    @ 18, 45 SAY "MSLAN  present   " + IF( IsMSLAN(),    "Yes", "No" )
    @ 20, 45 SAY "Computer Type    " + STR( BiosModel(), 3 ) + STR( BiosSubMod(), 3 ) + STR( BiosRev(), 3 )
    INKEY( 0 )
    SETCOLOR( cColor )
RETURN NIL


STATIC FUNCTION GraySumming()
LOCAL cPalette := GetPalette()
    BoxMessage( "This is a test for SetGray() funcion", 2 )
    BoxWarning( "Now, i'm going to change your monitor to b/w" )
    SetGray( .T. )
    BoxWarning( "And... Now, the monitor will return to your original state" )
    SetGray( .F. )
    SetPalette( cPalette )
    BoxWarning( { "This function allows to test an application in a system with", ;
                  "a color monitor or in a system with a B/W monitor" } )
RETURN NIL


STATIC FUNCTION Banner()
    CLS
    BigString  (  6,  7, "FAST.lib",   "G+/B" )
    SmallString(  0,  0, "Welcome to", "GR+/B" )
    SmallString( 18, 23, "4.00",       "W+/B" )
    Inkey( 0 )
RETURN NIL



STATIC FUNCTION Huffman()
LOCAL cInFile  := "demo.prg"
LOCAL cOutFile := "demo.pr_"
     BoxOpen( 6, 20, 16, 60, "B" )
     @  8, 22 SAY "Compressing file : " + cInFile COLOR "GR+/B"
     @ 10, 22 SAY "Bytes  " COLOR "GR+/B"
     @ 11, 22 SAY "Rate % " COLOR "GR+/B"
     Compress( cInFile, cOutFile, .T., ;
               { |x, y| setpos( 10, 29 ), ;
                        devout( ALLTRIM( STR( x ) ), "W+/B" ), ;
                        setpos( 11, 29 ), ;
                        devout( ALLTRIM( STR( y ) ), "W+/B" ) } )
     @ 13, 22 SAY "Initial Size " + STR( fSize( cInFile  ) ) COLOR "G+/B"
     @ 14, 22 SAY "Final Size   " + STR( fSize( cOutFile ) ) COLOR "G+/B"
     Inkey(0)
     fDel( cOutFile )
RETURN nil


STATIC FUNCTION LightEffects()
LOCAL cPalette := GetPalette()
    Degrade( cPalette )
    Upgrade( cPalette )
RETURN NIL




STATIC FUNCTION FMSounds()
/* Chromatic scale starting from C# */
LOCAL aNotes  := { 363, 385, 408, 432, 458, 485, 514, 544, 577, 611, 647, 686 }
LOCAL nInd
LOCAL aSBI    := FMLoadSBI( "piano.sbi" )

    IF sbInit()
      BoxMessage( "FM sounds created with FAST.lib. C# Chromatic scale" )
      FMReset()
      FMSetVoice( 0, aSBI[ 2 ] )
      FMSetVoice( 1, aSBI[ 2 ] )
      FMSetVoice( 2, aSBI[ 2 ] )
      FMSetVoice( 3, aSBI[ 2 ] )
      FOR nInd := 1 TO 12
        FMKeyOn( 0, aNotes[ nInd ], 2 )
        FMKeyOn( 1, aNotes[ nInd ], 3 )
        FMKeyOn( 2, aNotes[ nInd ], 3 )
        FMKeyOn( 3, aNotes[ nInd ], 3 )
        FMDelay( 5 )    // 1/4 second; a second is aproximatelly 18 ticks
      NEXT
      FMKeyOff( 0 )
      FMKeyOff( 1 )
      FMKeyOff( 3 )
      FMKeyOff( 4 )
      FMReset()
    ELSE
      BoxMessage( "Sorry, Sound Blaster not found" )
    ENDIF
RETURN NIL



STATIC FUNCTION gBoxes()
LOCAL cFile := "fast.pcx"

    SetVGA()
    fgCls( 7 )

    fgWinBox( 410, 55, 425 + pcxX2( cFile ), 65 + pcxY2( cFile ), 1 )
    PCXShow ( cFile, .F., 420, 60 )
    DispStr( "16 colors PCX image", 410, 80 + pcxY2( cFile ), 15, 7 )

    DispStr( "Graphic Boxes created with FAST.lib", 320, 20, 1, 7 )
    DispStr( "-----------------------------------", 320, 36, 1, 7 )

    fgBox(  10,  10, 100, 100, 15 )
    fgBox( 110,  10, 200, 100,  8 )
    DispStr( "fgBox()", 220, 20, 15, 7 )

    fgBox3D(  10, 110, 100, 200, 15, 8 )
    fgBox3D( 110, 110, 200, 200, 8, 15 )
    DispStr( "fgBox3D() on/off", 220, 120, 14, 7 )

    fgFrame(  10, 210, 100, 300, 15, 8 )
    fgFrame( 110, 210, 200, 300, 8, 15 )
    DispStr( "fgFrame() on/off", 220, 220, 4, 7 )

    fgFrame3D(  10, 310, 100, 400, 15, 8 )
    fgFrame3D( 110, 310, 200, 400, 8, 15 )
    DispStr( "fgFrame3D() on/off", 220, 320, 1, 7 )

    fgWinBox( 10, 410, 200, 470, 1 )
    DispStr( "fgWinBox()", 220, 420, 15, 7 )

    Inkey(0)
    TXTMode()

RETURN NIL


STATIC FUNCTION DiskInfo()
LOCAL aDisk1 := LowDiskInfo( 0 )
LOCAL aDisk2 := LowDiskInfo( 1 )

    BoxWarning( { "Number of hard disks: " + STR( NumDisks(), 1 ), ;
                  "", ;
                  "DISK 1 information", ;
                  "", ;
                  "Number of Heads            : " + STR( aDisk1[ 1 ], 3 ), ;
                  "Number of Cylinders        : " + STR( aDisk1[ 2 ], 3 ), ;
                  "Number of Sectors per Track: " + STR( aDisk1[ 3 ], 3 ), ;
                  "", ;
                  "DISK 2 information", ;
                  "", ;
                  "Number of Heads            : " + STR( aDisk2[ 1 ], 3 ), ;
                  "Number of Cylinders        : " + STR( aDisk2[ 2 ], 3 ), ;
                  "Number of Sectors per Track: " + STR( aDisk2[ 3 ], 3 ) ;
                } )

RETURN NIL


STATIC FUNCTION BMPDemo()
LOCAL nX, nY
    BoxWarning( "The same BMP image a lot of times" )
    SetVGA256()
    IF FILE( "color256.bmp" )
      FOR nY = 0 TO 4
        FOR nX = 0 TO 4
          bmpShow256( "color256.bmp", .T., nX * 80, nY * 50 )
        NEXT
      NEXT
      INKEY( 0 )
    ENDIF
    TxtMode()
    SetBlink(.F.)
RETURN NIL

