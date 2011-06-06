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



// Fast header file
// (C) 1992-95 Manu Roibal


#ifndef _FAST_CH

#define _FAST_CH


#command DEFAULT <Var1> = <DefValue1> [, <Var2> = <DefValue2> ] => ;
        <Var1>  = IIF( <Var1> == NIL, <DefValue1>, <Var1> ) ;;
        [<Var2> = IIF( <Var2> == NIL, <DefValue2>, <Var2> );]


#define COM_NONE    0
#define COM_EVEN    1
#define COM_ODD     2
#define COM_ZERO    3
#define COM_ONE     4


#command @ <row>, <col> [SAY <sayxpr>]                                     ;
                        GET <var>                                          ;
                        [COLOR <color>]                                    ;
                        [WHEN <when>]                                      ;
                        [VALID <valid>]                                    ;
                        [SEND <msg>]                                       ;
                        WITH RADIOBUTTONS <buttons>                        ;
                        [<horiz: HORIZONTAL>]                              ;
                        [<nobox: NOBOX>]                                   ;
                        [<double: DOUBLE>]                                 ;
                                                                           ;
      => setpos( <row>, <col> )                                            ;
       ; DispBegin()                                                       ;
       ; aadd( GetList, _GET_( <var>, <(var)>,"9", <{valid}>, <{when}> ) ) ;
      [; atail(GetList):colorDisp(<color>)]                                ;
      [; atail(GetList):<msg>]                                             ;
       ; dispout(" ")                                                      ;
       ; RadioNew( atail(getlist), <{when}>,                               ;
                  <row>, <col>, <sayxpr>, <var>,                           ;
                  <buttons>, <.nobox.>, <.double.>, <.horiz.> )            ;
       ; atail(getlist):reader := { |get| RadioReader( get,                ;
                                          <.nobox.>, <.horiz.>,            ;
                                          <sayxpr> ) }                     ;
       ; DispEnd()

#command READ                                                           ;
      => ReadModal(GetList)                                             ;
       ; GetList := {}                                                  ;
       ; KillButton()


#command CLEAR GETS                                                     ;
      => __KillRead()                                                   ;
       ; GetList := {}                                                  ;
       ; KillButton()


#define MAX_SB_VOLUME  15
#define MIN_SB_VOLUME   0

#endif

