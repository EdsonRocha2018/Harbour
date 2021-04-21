#include "INKEY.CH"
#include "SET.CH"

procedure main 
local nevento:=0, ctela, ctelamax, lminimizada:=.f., lmaximizada:=.f.
clear screen 

?? "Pressione ESC para sair"

SET EVENTMASK TO INKEY_ALL

ctela=savescreen(3,2,10,40)

@ 3,2 to 10,40
@ 4,34 say "- [] X"
@ 5,3 say replicate(chr(196),37)

do while lastkey() <> K_ESC
   nevento := Inkey(0)
   nevento := LastKey( INKEY_KEYBOARD + INKEY_LUP )
   if nevento == 0
      loop
   end if
   @ 0, 0 clear to 1, maxcol()
   
   // Fechar janela
   if mrow()=4 .and. mcol()=39 .and. lastkey()=1002 .and. !lminimizada .and. !lmaximizada
      if alert("Deseja realmente fechar a janela?",{"Sim","Nao"})=1
         restscreen(3,2,10,40,ctela)
      end if
   // Minimizar janela
   elseif mrow()=4 .and. mcol()=34 .and. lastkey()=1002 .and. !lminimizada .and. !lmaximizada
      ctelamax=savescreen(3,2,10,40)
      restscreen(3,2,10,40,ctela)
      @ maxrow()-3,0 to maxrow()-1,10
      @ maxrow()-2,8 say "[]"
      lminimizada=.t.
   // Maximizar janela
   elseif mrow()=4 .and. mcol()>=36 .and. mcol()<=37 .and. lastkey()=1002 .and. !lminimizada .and. !lmaximizada
      ctelamax=savescreen(3,2,10,40)
      restscreen(3,2,10,40,ctela)
      @ 3,2 to maxrow()-2,75
      @ 5,3 say replicate(chr(196),72)
      @ 4,73 say "[]"
      lmaximizada=.t.
   // Restaurar janela minimizada
   elseif mrow()=maxrow()-2 .and. mcol()>=8 .and. mcol()<=9 .and. lastkey()=1002 .and. lminimizada
      @ maxrow()-3,0 clear to maxrow()-1,10
      restscreen(3,2,10,40,ctelamax)
      lminimizada=.f.
   // Restaurar janela maximizada
   elseif mrow()=4 .and. mcol()>=73 .and. mcol()<=74 .and. lastkey()=1002 .and. lmaximizada
      @ 3,2 clear to maxrow()-2,75
      restscreen(3,2,10,40,ctelamax)
      lmaximizada=.f.
   end if
   
   if nevento >= K_MINMOUSE
      @ 0,1 say "Linha do mouse :"
      ?? mrow()
      @ 1,1 say "Coluna do mouse:"
      ?? mcol()
   else
      @ 0,1 say "Codigo de tecla:"
      ?? nevento
   end if
   @ maxrow(),0 say str(lastkey())
enddo

return nil   
