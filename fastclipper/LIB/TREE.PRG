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


STATIC aDsk := {}


Function DirTree ( cMascara, cDisco )
Local cPanta := SaveScreen ( 10, 0, 10, MaxCol() )
    aDsk := {}
    DiskStruct ( cMascara, cDisco )
    RestScreen ( 10, 0, 10, MaxCol(), cPanta )
Return ( GeneraArbol () )


Static Function DiskStruct ( cPath, cDisco )
Local aDir, nI
Static nNiv
  If Len ( aDsk ) == 0
    aadd ( aDsk, { 1, cDisco } )
    nNiv := 2
  Else
    nNiv ++
  EndIf
  aDir := DimeDir ( StrTran ( cDisco + cPath, "\\", "\" ) )
  If ! Empty ( aDir )
    For nI := 1 to len ( aDir )
      aAdd ( aDsk, { nNiv, aDir [ nI, 1 ] } )
      @ 10, MaxCol() / 2 - 9 say Padc ( aDir [ nI, 1 ], 19 )
      DiskStruct ( if ( cPath == "\", ;
                    cPath, ;
                    left ( cPath, len ( cPath ) - 3 ) ) + aDir [ nI, 1 ] + "\*.*", cDisco )
      nNiv --
    Next
  endif
Return ( Nil )


Static Function DimeDir ( cPath )
Local aDir, nI
  aDir := Directory ( cPath, "D" )
  For nI := 1 To Len ( aDir )
    If aDir [ nI, 5 ] != "D" .or. aDir [ nI, 1 ] == "." .or. ;
       aDir [ nI, 1 ] == ".."
      aDir := aDel  ( aDir, nI )
      aDir := aSize ( aDir, Len ( aDir ) - 1 )
      nI --
    Endif
  Next
Return ( aDir )


Static Function GeneraArbol ()
Local nInd
Local nSkip
Local nI
Local nAux
Local lSwitch
Local aTb     := array ( len ( aDsk ) )
Local cCad    := ""
Local nElem   := 0
Local nNiv    := aDsk [ 1, 1 ]
Local nCon
Local nNivAux
    For nInd := 1 to Len(aDsk)
      if aDsk[nInd, 1] == nNiv
        aTb[++ nElem] := cCad
      elseif nNiv < aDsk[nInd,1]
        nSkip := aDsk[nInd,1]- nNiv
        nNiv := aDsk[nInd,1]
        nSkip := Rat("Ã", cCad)
        If Len ( cCad ) == 0
          cCad := Substr(cCad, 1, nSkip - 1)+ Space(2)+ "Ã"
        Else
          cCad := Substr(cCad, 1, nSkip - 1)+ "³" + Space(2)+ "Ã"
        EndIf
        aTb[++ nElem]:= cCad
      else
        nI   := 1
        nAux := aDsk[nInd,1]
        nCon := nInd - 1
        nNivAux := aDsk[nCon,1]
        While nAux < aDsk[nCon,1]
          If nNivAux == aDsk[nCon,1]
            nNivAux --
            nSkip := Rat("Ã", aTb[nElem - nI + 1])
            aTb[nElem - nI + 1]:= ;
              SubStr(aTb[nElem - nI + 1], 1, nSkip - 1)+ "À" + ;
              SubStr(aTb[nElem - nI + 1], nSkip+1,Len(aTb[nElem-nI+1]))
          EndIf
          nI++
          nCon--
        End
        cCad := substr(cCad, 1, len(cCad)-(nNiv - aDsk[nInd,1])* 4)+ ;
                space(if(nNiv-aDsk[nInd,1]>1,nNiv-aDsk[nInd,1]-1,0))+"Ã"
        if nNiv - aDsk[nInd, 1]> 1
          for nI := 2 to nNiv - aDsk[nInd, 1]
            lSwitch := .T.
            nAux := 0
            while lSwitch
              nSkip := Rat("³", aTb[nElem - nAux])
              If(nSkip - 1)/ 3 + 1 <= aDsk[nInd, 1]
                lSwitch := .F.
              elseif Len(aTb[nElem - nAux])<= Len(aTb[nElem])
                aTb[nElem - nAux]:= ;
                  SubStr(aTb[nElem-nAux],1,nSkip-1)+ " " + ;
                  SubStr(aTb[nElem-nAux],nSkip+1,Len(aTb[nElem-nAux]))
              else
                lSwitch := .F.
              endif
              nAux ++
            end
          next
        endif
        nNiv := aDsk[nInd, 1]
        nElem ++
        aTb[nElem]:= cCad
      endif
      aTb [ nElem ] += " " + PadR ( aDsk [ nInd, 2 ], 8 )
    next
    nSkip := At ( "Ã", aTb [ nElem ] )
    aTb [ nElem ] := SubStr ( aTb [ nElem ], 1, nSkip - 1 ) + "À" + ;
                     SubStr ( aTb [ nElem ], nSkip + 1 )
    If nSkip > 3
      For nElem := Len ( aTb ) to 1 Step -1
        nSkip := At ( "Ã", aTb [ nElem ] )
        If nSkip == 3
          aTb [ nElem ] := SubStr ( aTb [ nElem ], 1, nSkip - 1 ) + "À" + ;
                           SubStr ( aTb [ nElem ], nSkip + 1 )
          Exit
        Else
          aTb [ nElem ] := SubStr ( aTb [ nElem ], 1, 2 ) + " " + ;
                           SubStr ( aTb [ nElem ], 4 )
        EndIf
      Next
    EndIf
Return ( aTb )



