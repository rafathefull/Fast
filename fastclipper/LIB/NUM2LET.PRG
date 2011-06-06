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




#include "\libs\clipapi\version.ch"

FAST_VERSION


Function Num2Txt( Numero, Genero )
#define  Y           'y '
#define  F           'as '
#define  M           'os '
#define  MIL         'mil '
#define  MILLON      'mill¢n '
#define  MILLONES    'millones '
#define  BILLON      'bill¢n '
#define  BILLONES    'billones '
LOCAL Grupos[5], aUnidad[10], aDecena[10,10], aCentena[10], Conector[5], ;
      EnLetra  , Grupo      , NumStr        , Unidad      , Decena     , ;
      Centena
    Genero := If ( Genero == Nil, .F., Genero )
    aUnidad[ 1] := {|| If(Numero=0.AND.Grupo=1,'cero',"")}
    aUnidad[ 2] := {|| If(Decena='1', aDecena[2, VAL(Unidad)+1],             ;
                       If(Grupos[Grupo]='001'.AND.(Grupo=2.OR.Grupo=4), "",;
                       If(Grupo>2, 'un ', If(Genero,'una ','uno '))))}
    aUnidad[ 3] := {|| If(Decena='1', aDecena[2,VAL(Unidad)+1], 'dos '   )}
    aUnidad[ 4] := {|| If(Decena='1', aDecena[2,VAL(Unidad)+1], 'tres '  )}
    aUnidad[ 5] := {|| If(Decena='1', aDecena[2,VAL(Unidad)+1], 'cuatro ')}
    aUnidad[ 6] := {|| If(Decena='1', aDecena[2,VAL(Unidad)+1], 'cinco ' )}
    aUnidad[ 7] := {|| If(Decena='1', aDecena[2,VAL(Unidad)+1], 'seis '  )}
    aUnidad[ 8] := {|| If(Decena='1', aDecena[2,VAL(Unidad)+1], 'siete ' )}
    aUnidad[ 9] := {|| If(Decena='1', aDecena[2,VAL(Unidad)+1], 'ocho '  )}
    aUnidad[10] := {|| If(Decena='1', aDecena[2,VAL(Unidad)+1], 'nueve ' )}
    aDecena[ 1, 1] := {|| ""}
    aDecena[ 2, 1] := {|| If(Unidad='0', 'diez ', "")}
    aDecena[ 2, 2] := 'once '
    aDecena[ 2, 3] := 'doce '
    aDecena[ 2, 4] := 'trece '
    aDecena[ 2, 5] := 'catorce '
    aDecena[ 2, 6] := 'quince '
    aDecena[ 2, 7] := 'dieciseis '
    aDecena[ 2, 8] := 'diecisiete '
    aDecena[ 2, 9] := 'dieciocho '
    aDecena[ 2,10] := 'diecinueve '
    aDecena[ 3, 1] := {|| If(Unidad='0', 'veinte ', 'veinti')}
    aDecena[ 4, 1] := {|| 'treinta '   + If(Unidad<>'0', Y, "")}
    aDecena[ 5, 1] := {|| 'cuarenta '  + If(Unidad<>'0', Y, "")}
    aDecena[ 6, 1] := {|| 'cincuenta ' + If(Unidad<>'0', Y, "")}
    aDecena[ 7, 1] := {|| 'sesenta '   + If(Unidad<>'0', Y, "")}
    aDecena[ 8, 1] := {|| 'setenta '   + If(Unidad<>'0', Y, "")}
    aDecena[ 9, 1] := {|| 'ochenta '   + If(Unidad<>'0', Y, "")}
    aDecena[10, 1] := {|| 'noventa '   + If(Unidad<>'0', Y, "")}
    aCentena[ 1] := {|| ""}
    aCentena[ 2] := {|| If(Decena+Unidad='00','cien ','ciento ')}
    aCentena[ 3] := {|| 'doscient'    + If(Grupo<3.AND.Genero, F, M)}
    aCentena[ 4] := {|| 'trescient'   + If(Grupo<3.AND.Genero, F, M)}
    aCentena[ 5] := {|| 'cuatrocient' + If(Grupo<3.AND.Genero, F, M)}
    aCentena[ 6] := {|| 'quinient'    + If(Grupo<3.AND.Genero, F, M)}
    aCentena[ 7] := {|| 'seiscient'   + If(Grupo<3.AND.Genero, F, M)}
    aCentena[ 8] := {|| 'setecient'   + If(Grupo<3.AND.Genero, F, M)}
    aCentena[ 9] := {|| 'ochocient'   + If(Grupo<3.AND.Genero, F, M)}
    aCentena[10] := {|| 'novecient'   + If(Grupo<3.AND.Genero, F, M)}
    Conector[1] := {|| ""}
    Conector[2] := {|| If(Grupos[2]>'000', MIL , "")}
    Conector[3] := {|| If(Grupos[3]>'000'.OR.Grupos[4]>'000',        ;
                       If(Grupos[3]='001', MILLON, MILLONES), "")}
    Conector[4] := {|| If(Grupos[4]>'000', MIL , "")}
    Conector[5] := {|| If(Grupos[5]>'000',                           ;
                       If(Grupos[5]='001', BILLON, BILLONES), "")}
    NumStr := ALLTRIM(STR(Numero,15,0))
    NumStr := REPLICATE('0', 15 - LEN(NumStr)) + NumStr
    FOR Grupo := 1 TO 5
      Grupos[5-Grupo+1] := SUBSTR(NumStr, (Grupo-1) * 3 + 1, 3)
    NEXT
    EnLetra := ""
    FOR Grupo := 5 TO 1 STEP -1
      Unidad  := RIGHT (Grupos[Grupo] , 1   )
      Decena  := SUBSTR(Grupos[Grupo] , 2, 1)
      Centena := LEFT  (Grupos[Grupo] , 1   )
      Enletra := EnLetra + EVAL(aCentena[VAL(Centena) + 1  ]) +;
                           EVAL(aDecena [VAL(Decena ) + 1,1]) +;
                           EVAL(aUnidad [VAL(Unidad ) + 1  ]) +;
                           EVAL(Conector[Grupo])
    NEXT
RETURN ( EnLetra )






