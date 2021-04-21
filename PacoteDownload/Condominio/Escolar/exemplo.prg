/*
  Compilar usando: Hbmk2 exemplo.prg -lxhb
*/
#include "INKEY.CH"
#include "SET.CH"

Function Main()

 Local cAlgo := Space( 30 )
 Public nTask, nIdle

 Clear Screen

 nTask := HB_BackGroundAdd( {|| CaptaMouse() } )
 nIdle := HB_IdleAdd( {|| HB_BackGroundRun( nTask ) } )

 Inkey(0)

 HB_BackGroundDel( nTask )  // coloque antes de sair do sistema
 HB_IdleDel( nIdle )
 
 Clear Screen

Return Nil

FuncTion CaptaMouse()

  @ 2,2 say "Linha do Mouse...: " + Hb_NToS( MRow() )
  @ 4,2 say "Coluna do Mouse..: " + Hb_NToS( MCol() )
  
  If MLeftDown()
   @ 7,2 say "Botao ESQUERDO pressionado na Linha " + Hb_NToS( MRow() ) + ", coluna " + Hb_NToS( MCol() )
  ElseIf MRightDown()
   @ 7,2 say "Botao DIREITO pressionado na Linha  " + Hb_NToS( MRow() ) + ", coluna " + Hb_NToS( MCol() )
  EndIf
  
Return Nil