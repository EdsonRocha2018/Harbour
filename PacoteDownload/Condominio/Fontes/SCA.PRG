#include "hbgtinfo.ch"
#include "INKEY.CH"

REQUEST HB_LANG_PT
REQUEST HB_CODEPAGE_PTISO //Em alguns sistemas é PT850
REQUEST HB_GT_WVT_DEFAULT

Procedure Main
Public LIN_MENU

HB_LANGSELECT('PT')
HB_CDPSELECT('PTISO') //Em alguns sistemas é PT850
HB_GtInfo( HB_GTI_FONTNAME, "Lucida Console" )  // fonte
hb_gtInfo( HB_GTI_FONTWIDTH, 10 )
hb_gtInfo( HB_GTI_FONTSIZE , 20 )
hb_gtInfo( HB_GTI_FONTQUALITY , .T. )
HB_GtInfo( HB_GTI_WINTITLE, "CONDOMÍNIO HANOVER - CONTAS A PAGAR E RECEBER" ) // titulo da tela
HB_GtInfo( HB_GTI_MAXIMIZED, .T. )
//HB_GtInfo( HB_GTI_ISFULLSCREEN, .T. )
hb_gtInfo( HB_GTI_ALTENTER, .T. )

SET(39,255)
SETMODE(25,80)
SET( _SET_EVENTMASK, INKEY_ALL)
RUN mode con cols=80 lines=25
RUN mode codepage select=850

set date british
set date format to "DD/MM/YYYY"
set epoch to (year(date()) - 89)
set century on
set bell on
set deleted on
set scoreboard off
set talk off
set wrap on
set cursor off
setblink(.f.)
*
if .not. file("Contas.dbf") .or. .not. file("Moviment.dbf")
    Criabase()
endif
*
FUNDO=1
DECLARE NOMECOR[12],CONTECOR[12]
NOMECOR[01]="FUNDO DA TELA"
NOMECOR[02]="MENU"
NOMECOR[03]="DESTAQUE DO MENU"
NOMECOR[04]="JANELA DE DIALOGO"
NOMECOR[05]="BOX DA JANELA DE DIALOGO"
NOMECOR[06]="BOTOES"
NOMECOR[07]="BOTAO EM DESTAQUE"
NOMECOR[08]="GETS"
NOMECOR[09]="GET EM DESTAQUE"
NOMECOR[10]="TELA DE APRESENTACAO"
NOMECOR[11]="CARACTERES AVULSOS"
NOMECOR[12]="CERCADURAS"
LIN_MENU=0
PUBL MENU_POS
DECLARE BOTOES[10]
ConfTela()
TELA_PRI=SAVESCREEN(LIN_MENU+1,00,23,79)
Q_BOTOES=1
MENU_P=1
X=1
PADRAO()
*
set wrap on
set bell off
set deleted on
set confirm on
set scoreboard off
set date british
set key -9 to calcu
set color to w+/b,n/w,n,w+
clear
cores := setcolor ()
@ 1, 0 to 23, 79 double
//@ 4, 00 say "â 
//@ 4, 79 say "¦"
@ 4, 1 to 4, 78 double
@ 2, 02 say 'CONDOMÍNIO HANOVER' 
@ 2, 62 say 'DATA: ' + dtoc (date ()) 
@ 3, 02 say 'SISTEMA DE CONTAS A PAGAR E RECEBER' 
@ 3, 62 say 'Rotina: '+PROCNAME()
*
do while .t.
   @ 5, 1 clear to 22, 77
   set message to 22 center
   w_men = '*** O P Ç Õ E S ***'
   @ 6, centra (w_men) say w_men
   w_men = space(80)
   imp_mens (w_men, 2)   
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   *
   @ 09, 30 prompt 'Cadastro de Contas     ' message 'Atualizaçao de Contas'
   @ 11, 30 prompt 'Movimento Mensal       ' message 'Digitaçao do Movimento Mensal'
   @ 13, 30 prompt 'Emissão dos Relatórios ' message 'Emissão dos Relatórios Gerenciais'
   @ 15, 30 prompt 'Manutenção de Tabelas  ' message 'Atualizacão de Tabelas'
   @ 17, 30 prompt 'Manutenção de Arquivos ' message 'Cópias, Restaura, Organiza arquivos'
   menu to op00
   *
   if lastkey () = 27
      if alert("Deseja realmente sair do sistema?",{"Sim","Nao"})=1
         Quit
      Endif
   endif
	*  
   do case
      case op00 = 1
         do scatel01
		 
      case op00 = 2

         do scatel02
      case op00 = 3

         do scatel04
      case op00 = 4

         do scatel05
      case op00 = 5

         do scatel06
   endcase

enddo

clear
clear all
close all
return


******************
procedure scatel01
******************      
do while .t.
   @ 5, 1 clear to 22, 77
   @ 3, 52 clear to 3, 77
   @ 3, 62 say 'Rotina: '+PROCNAME()
   set message to 22 center
   w_men = '*** P L A N O  D E  C O N T A S ***'
   @ 6, 2 clear to 6, 70
   @ 6, centra (w_men) say w_men 
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   @ 09, 35 prompt 'Inclusão ' message 'Incluir Contas'
   @ 11, 35 prompt 'Alteração' message 'Alterar Contas'
   @ 13, 35 prompt 'Exclusão ' message 'Excluir Contas'
   @ 15, 35 prompt 'Consulta ' message 'Consultar Contas'
   menu to op01
   if lastkey () = 27
      exit
   endif
   do case
      case op01 = 1
         do pdsca101
      case op01 = 2
         do pdsca101
      case op01 = 3
         do pdsca101
      case op01 = 4
         do ConsultaSocio
   endcase
enddo
return


******************
procedure pdsca101      
******************
SELECT 1
USE CONTAS
INDEX ON codigo TAG indice1 TO contas1

@ 3, 52 clear to 3, 77
@ 3, 62 say 'Rotina: '+PROCNAME()
do while .t.
   tela101 ()
   w_Codigo  := space(10)        //     w_empresa 
   w_Descri  := space(30)       //     w_matricul
   w_TipoCD  := space(07)      //     w_ccusto  
   w_modali  := space(09)     //     w_nome    
   w_Ativa   := space(03)    //     w_ativo   
   w_ContaTP := space(02)   //     w_bairro  
   w_DescCon := space(30)  //     w_munici  
   *
   @ 6, 17 get w_Codigo picture "99.99.9999"
   read
   if lastkey () = 27
      exit
   endif
   *
   if w_seek (w_Codigo, '1', op01)
      loop
   endif
   *
   @ 06, 17 say w_Codigo 
   @ 06, 28 say '- ' + Descri 
   @ 07, 17 get w_Descri
   @ 08, 17 get w_TipoCD picture '@!' valid w_TipoCD$"DEBITO/CREDITO"
   @ 09, 17 get w_modali picture '@!' valid w_modali$"ANALITICA/SINTETICA" 
   @ 10, 17 get w_Ativa picture '@!' valid w_ativa$"SIM/NAO" 
   @ 11, 17 get w_ContaTP picture '@!'
   @ 12, 17 get w_DescCon picture '@!'
   read
   if lastkey () = 27
      exit
   endif
   *
   resp = ' '
   @ 24, 0 clear to 24, 79
   Opcao := IIF(op01 == 1,"Inclusão",IIF(op01 == 2,"Alteração","Exclusão"))
   @ 24, 22 say 'Confirma '+Opcao+' dos Dados <S/N>?' get resp valid RESP$'SNsn' 
   read
   if resp $ 'Ss' .and. op01 # 3
      select (1)
	  if op01 == 1
         append blank 
	  endif	 
      replace Codigo with w_Codigo, Descri with w_Descri
      replace TipoCD with w_TipoCD, modali with w_modali, ativa with w_ativa
      replace ContaTP with w_ContaTP, DescCon with w_DescCon
      commit
   else
      delete   
   endif	
enddo
close all
return


***************
function w_seek
***************         
parameters ch, area, teste
Local Ok := .f.
*
select &area
find (ch)
if teste = 1
   if found ()
      w_men = 'Registro já Cadastrado. Tecle [ESC]'
      imp_mens (w_men, 1)
	  Ok := .t.
   endif
elseif teste = 2 .or. teste = 3
      if ! found ()
         w_men = 'Registro não Encontrado. Não pode ser efetuada Alteração. Tecle [ESC]'
         imp_mens (w_men, 1)
         Ok := .t.
	   else
         CampContas()
	     Ok := .f.
      endif
endif
return Ok

Procedure CampContas()
 w_Descri  := Descri  
 w_TipoCD  := TipoCD  
 w_modali  := modali  
 w_Ativa   := Ativa   
 w_ContaTP := ContaTP 
 w_DescCon := DescCon 
Return

***********************
procedure ConsultaSocio
***********************      
do while .t.
   @ 5, 1 clear to 22, 77
   set message to 22 center
   w_men = '*** Consulta Plano Contas ***'
   @ 6, centra (w_men) say w_men 
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   @ 9, 35 prompt ' Individual ' message 'Consulta por Conta'
   @ 11,35 prompt ' Geral      ' message 'Consulta Geral'
   menu to op01
   if lastkey () = 27
      exit
   endif
   do case
      case op01 = 1
         do pdsca102
      case op01 = 2
         SELECT 1
         USE CONTAS
         INDEX ON codigo TAG indice1 TO contas1
         browse(5,1,22,77)
		 //dbedit(5,1,22,77)
   endcase
enddo
return




******************
procedure pdsca102
******************   
SELECT 1
USE CONTAS
INDEX ON codigo TAG indice1 TO contas1
*
@ 3, 52 clear to 3, 77
@ 3, 62 say 'Rotina: '+PROCNAME()
do while .t.
if op01 = 2
   tela101 ()
   w_Codigo  := space(10)        //     w_empresa 
   w_Descri  := space(50)       //     w_matricul
   w_TipoCD  := space(01)      //     w_ccusto  
   w_modali  := space(01)     //     w_nome    
   w_Ativa   := space(01)    //     w_ativo   
   w_ContaTP := space(02)   //     w_bairro  
   w_DescCon := space(40)  //     w_munici  
   *
   @ 6, 17 get w_Codigo picture "99.99.9999"
   read
   if lastkey () = 27
      exit
   endif

   if w_seek (w_Codigo, '1', 2)
      loop
   endif
   @ 06, 17 say w_Codigo 
   @ 06, 28 say '- ' + Descri 
   @ 07, 17 get w_Descri
   @ 08, 17 get w_TipoCD picture '@!' valid w_TipoCD$"DC"
   @ 09, 17 get w_modali picture '@!' valid w_modali$"AS" 
   @ 10, 17 get w_Ativa picture '@!' valid w_ativa$"SN" 
   @ 11, 17 get w_ContaTP picture '@!'
   @ 12, 17 get w_DescCon picture '@!'
   read
   resp = ' '
   @ 24, 0 clear to 24, 79
   @ 24, 22 say 'Confirma Alteracao dos Dados <S/N>?' get resp valid RESP$'SNsn' 
   read
   if resp $ 'Ss'
      replace Codigo with w_Codigo, Descri with w_Descri,;
      TipoCD with w_TipoCD, modali with w_modali, ativa with w_ativa,;
      ContaTP with w_ContaTP, DescCon with w_DescCon
      commit
   endif
Elseif op01 = 3
    w_ch = cempresa + cmat
    select (4)
    find (w_ch)
    if found ()
       w_men = 'Funcionario com movimentos. Tecle [ESC]'
       imp_mens (w_men, 1)
       loop
    endif
    select (1)
    delete
else 
    @ 24, 0 clear to 24, 79
    @ 24, 22 say 'Tecle algo para continuar...' 
    do while inkey () = 0
    enddo
endif
enddo
close all
return

****************
function tela101
****************        
@ 05, 3 clear to 22, 77
@ 06, 3 say 'CONTA........:' 
@ 07, 3 say 'DESCRIÇÃO....:' 
@ 08, 3 say 'TIPO CONTA...:        C-Credito   D-Debito' 
@ 09, 3 say 'MODALIDADE...:          A-Analitico S-Sintético' 
@ 10, 3 say 'ATIVA........:    S-Sim       N-Não' 
@ 11, 3 say 'COD CLASSIF..:' 
@ 12, 3 say 'NOME CLASSIF.:' 
w_men = '[ESC] - Encerrar'
imp_mens (w_men, 2)
return .t.


function tela102        
@ 8, 3 clear to 22, 77
@ 8, 3 say 'CCUSTO..... :' 
@ 9, 3 say 'NOME....... :' 
@ 10, 3 say 'ENDEREÇO... :' 
@ 11, 3 say 'BAIRRO..... :                      CEP..... :' 
@ 12, 3 say 'MUNICIPIO.. :' 
@ 13, 3 say 'NASCIMENTO. :                      ADMISSAO :' 
@ 14, 3 say 'MENSALIDADE :                      ATIVO... :' 
w_men = '[ESC] - Encerrar'
imp_mens (w_men, 2)
return .t.

       
procedure scatel02      
do while .t.
   @ 5, 1 clear to 22, 77
   @ 3, 52 clear to 3, 77
   @ 3, 62 say 'Rotina: '+PROCNAME()
   set message to 22 center
   w_men = '*** M O V I M E N T O ***'
   @ 6, centra (w_men) say w_men 
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   @ 10, 35 prompt '1) Inclusão   ' message 'Inclui Movimento'
   @ 11, 35 prompt '2) Alteração  ' message 'Altera Movimento'
   @ 12, 35 prompt '3) Exclusão   ' message 'Exclui Movimento'
   @ 13, 35 prompt '4) Consultas  ' message 'Consultas ao Movimento'
   @ 14, 35 prompt '5) Integração ' message 'Integracao Folha/Movimento'
   @ 15, 35 prompt '6) Encerrar   ' message 'Encerramento do Mes'
   @ 16, 35 prompt '7) Reajuste   ' message 'Reajustar Mensalidades'
   @ 17, 35 prompt '8) Integracao/folha-RM' message 'Integracao Folha-RM'
   menu to op02
   if lastkey () = 27
      exit
   endif
   do case
      case op02 = 1
         do pdsca201
      case op02 = 2
         do pdsca202
      case op02 = 3
         do pdsca202
      case op02 = 4      
         do ConsultaMovimento
      case op02 = 5
         do pdsca203
      case op02 = 6
         do pdsca204
      case op02 = 7
         do pdsca205
      case op02 = 8
         do pdsca206
   endcase
enddo
@ 3, 52 say space (26) 
return

procedure ConsultaMovimento      
do while .t.
   @ 5, 1 clear to 22, 77
   set message to 22 center
   w_men = '*** Consulta Movimentação ***'
   @ 6, centra (w_men) say w_men 
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   @ 9, 35 prompt ' Individual ' message 'Consulta por pessoa'
   @ 11,35 prompt ' Geral      ' message 'Consulta Geral'
   menu to op01
   if lastkey () = 27
      exit
   endif
   do case
      case op01 = 1
         do pdsca202
      case op01 = 2
         select (1)
         use adsca002 index aisca002
         MSetCursor(.T.)
         //browse(5,1,22,77)
		   dbedit(5,1,22,77)
   endcase
enddo
return

procedure pdsca201      
select (5)
use tabsca04 index tabsca04
select (4)
use adsca001 index aisca001
select (3)
use tabsca01 index tabsca01
select (2)
use tabsca03 index tabsca03
select (1)
use adsca002 index aisca002

w_empresa = space (2)
w_matricul = space (4)
w_verba = 0
w_valor = 0
w_refer = 0
w_sub = 0
@ 3, 52 clear to 3, 77
@ 3, 62 say 'Rotina: '+PROCNAME()
do while .t.
   tela201 ()
   @ 3, 52 say '       Movimento - Incluir' 
   @ 9, 35 get w_empresa
   read
   if lastkey () = 27
      exit
   endif
   w_empresa = strzero (val (w_empresa), 2)
   if w_seek (w_empresa, '3', 2)
      loop
   endif
   @ 9, 35 say w_empresa 
   @ 9, 38 say '- ' + nome 
   @ 11, 35 get w_matricul
   read
   w_ch = w_empresa + w_matricul
   if w_seek (w_ch, '4', 2)
      loop
   endif
   @ 11, 35 say strzero (val (w_matricul), 4) + ' ' + nome 
   w_verba = 0
   @ 13, 35 get w_verba picture '999'
   read
   w_verba = strzero (w_verba, 3)
   if w_seek (w_verba, '2', 2)
      loop
   endif
   @ 13, 35 say w_verba picture '999' 
   @ 13, 39 say nome 
   volta = .f.
   do while .t.
      @ 15, 35 get w_sub picture '999'
      read
      if lastkey () = 27
         volta = .t.
         exit
      endif
      w_sub2 = strzero (w_sub, 3)
      @ 15, 35 say w_sub2 
      w_sub3 = w_verba + w_sub2
      if empty (w_sub)
         select (5)
         goto top
         sv1 = savescreen (2, 0, 23, 79)
         do co_subv
         restscreen (2, 0, 23, 79, sv1)
         release sv1
         loop
      endif
      if w_seek (w_sub3, '5', 2)
         w_sub = 0
         loop
      endif
      @ 15, 39 say nomesub 
      exit
   enddo
   if volta = .t.
      loop
   endif
   @ 17, 35 get w_valor picture '999999999.99'
   @ 19, 35 get w_refer picture '99'
   read
   if lastkey () = 27
      exit
   endif
   if ! w_conf (1)
      loop
   endif
   select (1)
   append blank 
   replace empresa with w_empresa
   replace matricula with strzero (val (w_matricul), 4)
   replace verba with w_verba
   replace valor with w_valor
   replace refer with w_refer
   replace subverba with w_sub2
   commit
   if refer != 0
      replace parcelas with refer
      replace saldo with valor
      replace valor with valor / refer
      commit
   endif
   w_verba = 0
   w_valor = 0
   w_refer = 0
   w_sub = 0
enddo
close all
return

procedure pdsca202      
select (5)
use tabsca04 index tabsca04
select (4)
use adsca001 index aisca001
select (3)
use tabsca01 index tabsca01
select (2)
use tabsca03 index tabsca03
select (1)
use adsca002 index aisca002
@ 3, 52 clear to 3, 77
@ 3, 62 say 'Rotina: '+PROCNAME()
do while .t.
   tela201 ()
   do case
      case op02 = 2
         w_cab = '       Movimento - Alterar'
      case op02 = 3
         w_cab = '       Movimento - Excluir'
      case op02 = 4
         w_cab = '     Movimento - Consultas'
   endcase
   @ 3, 52 say w_cab 
   w_empresa = space (2)
   w_matricul = space (4)
   w_ccusto = space (4)
   @ 9, 35 get w_empresa picture '99'
   read
   if lastkey () = 27 .or. empty (w_empresa)
      exit
   endif
   w_empresa = strzero (val (w_empresa), 2)
   if w_seek (w_empresa, '3', 2)
      select (1)
      loop
   endif
   @ 9, 35 say w_empresa 
   @ 9, 38 say '- ' + nome 
   @ 11, 35 get w_matricul
   read
   w_ch = w_empresa + strzero (val (w_matricul), 4)
   if w_seek (w_ch, '1', 2)
      select (1)
      loop
   endif
   if w_seek (w_ch, '4', 2)
      select (1)
      loop
   endif
   @ 11, 35 say w_matricul + ' ' + nome 
   select (1)

   do while .t.
      @ 9, 35 say empresa 
      w_empresa = empresa
      if w_seek (w_empresa, '3', 2)
         select (1)
         loop
      endif
      @ 9, 38 say '- ' + nome 
      select (1)
      w_ch = empresa + strzero (val (matricula), 4)
      select (4)
      find (w_ch)
      g_nome = nome
      select (1)
      @ 11, 35 say matricula + ' ' + g_nome 
      @ 13, 35 say verba picture '999' 
      @ 15, 35 say subverba picture '999' 
      @ 17, 35 say valor picture '999999999.99' 
      @ 19, 35 say refer picture '99' 
      imp_mens (' ', 2)
      if op02 = 2
         if w_conf (2)
            w_empresa = empresa
            read
            select (1)
            @ 13, 35 get verba picture '999'
            @ 15, 35 get subverba picture '999'
            @ 17, 35 get valor picture '999999999.99'
            @ 19, 35 get refer picture '99'
            read
         endif
      else 
         if op02 = 3
            if w_conf (3)
               w_verba = 0
               @ 19, 22 say 'Cod. Verba' 
               @ 19, 35 get w_verba picture '999'
               read
               w_verba = strzero (w_verba, 3)
               if w_verba = '000'
                  delete
               else 
                  delete all for verba = w_verba .and. empresa = w_empresa
               endif
            endif
         endif
      endif
      imp_mens (' ', 2)
      if w_conf (4)
         skip 1
         if eof ()
            w_men = 'Fim do Cadastro. Tecle [ESC]'
            imp_mens (w_men, 1)
            exit
         endif           
      else 
         exit
      endif
   enddo
enddo
close all
return

function pdsca203       
@ 5, 1 clear to 22, 78
@ 3, 52 say '      Movimento - Integrar' 
cores = setcolor ()
w_men = ' Aguarde. Captando dados da folha de Pagto. '
set color to n/w*
@ 12, centra (w_men) say w_men 
setcolor (cores)
select (1)
use adsca002 index aisca002
delete all for verba = '001'
pack
reindex
goto top
select (2)
use adsca001 index aisca001
replace all mensal with 0.00 for ! eof ()

arq = fopen ('C:\FOLHA\fpg01a.dad', 0)
if ferror () != 0
   w_men = 'Erro de Abertura. Codigo DOS ' + strzero (ferror (), 3)
   imp_mens (w_men, 1)
   return .t.
endif

buffer = space (1197)
w_ct = 0

@ 17, 1 clear to 21, 77
@ 17, 1 to 21, 77
@ 18, 10 say 'EMPRESA =====>' 
@ 18, 50 say 'MATRICULA ===>' 
@ 20, 10 say 'TOTAL PROC. =>' 

gtot = 0
ft = 1
do while .t.
   if ft = 1
      ft = 2
      loop
   endif
   fread (arq, @buffer, 1197)
   if ferror () != 0
      w_men = 'Erro de Leitura, Codigo DOS ' + strzero (ferror (), 3)
      imp_mens (w_men, 1)
      exit
   endif
   if ! substr (buffer, 2, 1) $ '0123456789'
      exit
   endif
   if val (substr (buffer, 490, 1)) = 2
      loop
   endif
   @ 18, 25 say substr (buffer, 2, 1) 
   @ 18, 65 say substr (buffer, 7, 4) 
   w_emp = substr (buffer, 1, 2)
   w_mat = substr (buffer, 7, 4)
   w_ch = w_emp + w_mat
   select (2)
   find (w_ch)
   if ! found ()
      loop
   endif
   w_sal = val (substr (buffer, 255, 12)) / 100
   w_grt = val (substr (buffer, 267, 12)) / 100
   w_calc = 0
   w_calc = (w_sal + w_grt) * 0.01   && 0.005
   select (1)
   append blank 
   replace empresa with substr (buffer, 1, 2)
   replace matricula with substr (buffer, 7, 4)
   replace verba with '001'
   replace valor with w_calc
   select (2)
   replace mensal with w_calc
   gtot = gtot + 1
   @ 20, 25 say gtot picture '99999' 
enddo
fclose ('C:\FOLHA\fpg01a.dad')
close databases
close all

function tela201        
@ 5, 1 clear to 22, 77
@ 9, 21 say 'EMPRESA ....:' 
@ 11, 21 say 'MATRICULA ..:' 
@ 13, 21 say 'VERBA ......:' 
@ 15, 21 say 'SUB-VERBA ..:' 
@ 17, 21 say 'VALOR ......:' 
@ 19, 21 say 'REFERENCIA .:' 
w_men = '[ESC] - Encerrar'
imp_mens (w_men, 2)
return .t.


function pdsca204       
@ 5, 1 clear to 22, 78
@ 3, 52 say '      Movimento - Encerrar' 
w_men = ' Aguarde. Encerrando Mes '
set color to n/w*
@ 12, centra (w_men) say w_men 
setcolor (cores)
@ 3, 52 say space (26) 
select (1)
use adsca002 index aisca002
goto top
do while ! eof ()
   if parcelas != 0
      replace valor with saldo / parcelas
      replace refer with refer - 1
   endif
   skip 1
enddo
delete all for refer = 0
pack
close all
return .t.

function pdsca206
@ 5, 1 clear to 22, 78
@ 3, 52 say '      Movimento - Integrar/folha RH' 
cores = setcolor ()
w_men = ' Aguarde. Captando dados do arquivo TEXTO da folha RM '
set color to n/w*
@ 12, centra (w_men) say w_men 
setcolor (cores)
*
select (1)
use adsca002 index aisca002
delete all for verba = '001'
pack
reindex
goto top
*
select (2)
use adsca001 index aisca102
replace all mensal with 0.00 for ! eof ()
*
select (3)
use scadbf index scadbf
zap
reindex
*
IF .NOT. FILE("ASSECE.TXT")
   w_men = 'Arquivo ASSECE.TXT nao encontrado '
   imp_mens (w_men, 1)
   return .t.
endif
append from ASSECE.TXT delimited
*append from ASSECE.TXT SDF
go top
*
@ 17, 1 clear to 21, 77
@ 17, 1 to 21, 77
@ 18, 10 say 'EMPRESA =====>' 
@ 18, 50 say 'MATRICULA ===>' 
@ 20, 10 say 'TOTAL PROC. =>' 
gtot = 0
do while .not. eof()
   w_emp = subs(empresa,5,2)
   w_mat = subs(matricula,5,4)
   w_sal = salario
   w_ch = w_emp + w_mat
   @ 18, 25 say w_emp
   @ 18, 65 say w_mat
   select (2)
   find (w_mat)
   if ! found ()
      select (3)
      skip
      loop
   endif
   w_calc = 0
   w_calc = w_sal * 0.01        && Mudou de meio para um por cento em 09/04/03  0.005
   select (1)
   append blank 
   replace empresa with w_emp
   replace matricula with w_mat
   replace verba with '001'
   replace valor with w_calc
   select (2)
   replace mensal with w_calc
   gtot = gtot + 1
   @ 20, 25 say gtot picture '99999'
   select (3)
   skip
enddo
close databases
close all

        
procedure scatel04      
do while .t.
   @ 5, 1 clear to 22, 77
   @ 3, 52 clear to 3, 77
   @ 3, 62 say 'Rotina: '+PROCNAME()
   set message to 22 center
   w_men = '*** R E L A T Ó R I O S ***'
   @ 6, centra (w_men) say w_men 

   @ 10, 25 prompt 'A)           Cadastro           '
   @ 11, 25 prompt 'B)           Controle           '
   @ 12, 25 prompt 'C)          Cod. Verba          '
   @ 13, 25 prompt 'D)          Sub-Verba           '
   @ 14, 25 prompt 'E)           Fl.Pagto           '
   @ 15, 25 prompt 'F)            Tabelas           '
   @ 16, 25 prompt 'G)    Relação de Associados     '
   @ 17, 25 prompt 'H) Relação de Associados/Adesão '
   @ 18, 25 prompt 'I) Controle Geral de Pagamentos '
   @ 19, 25 prompt 'J)           Fl.Pagto - RM      '

   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   menu to op04
   if lastkey () = 27
      exit
   endif
   do case
      case op04 = 1
         pdsca401()
      case op04 = 2
         pdsca402()
      case op04 = 3
         save screen to tg
         og = 1
         @ 10, 1 clear to 19, 77
         @ 10, 25 prompt '           Geral              '
         @ 11, 25 prompt '         Por Verba            '
         menu to og
         if og = 1
            pdsca409()
         endif
         restore screen from tg
      case op04 = 4
         do rlsubver
      case op04 = 5
        save screen to tg
         og = 1
         @ 10, 1 clear to 19, 77
         @ 10, 25 prompt '           Geral              '
         @ 11, 25 prompt '  Por Centro de Custo         '
         menu to og
         if og = 1
         pdsca4041 ()
         elseif og = 2
         pdsca404 ()
         endif
         restore screen from tg
      case op04 = 6
         pdsca405()
      case op04 = 7
         pdsca406 ()
      case op04 = 8
         pdsca407 ()
      case op04 = 9
         do sca0042
      case op04 = 10
         do sca0043
   endcase
enddo
return

function pdsca401       
save screen to telag
select (3)
use tabsca02 index tabsca02
select (2)
use tabsca01 index tabsca01
select (1)
use adsca001 index aisca001, aisca101

do while .t.
   select (1)
   goto top
   @ 5, 1 clear to 22, 77
   @ 3, 52 clear to 3, 77
   @ 3, 62 say 'Rotina: '+PROCNAME()
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   w_men = 'Relatorios - Cadastro de Associados'
   @ 8, centra (w_men) say w_men 
   w_emp1 = 0
   w_emp2 = 0
   @ 12, 20 to 18, 60
   @ 14, 22 say 'Digite Intervalo de Empresas a emitir' 
   @ 16, 35 get w_emp1 picture '99'
   @ 16, 45 get w_emp2 picture '99'
   read
   if lastkey () = 27
      exit
   endif
   @ 13, 21 clear to 17, 59
   w_ord = 'M'
   @ 14, 27 say ' [M] Matricula / [N] Nome ' 
   @ 16, 41 get w_ord picture '!' valid w_ord$"MN" 
   read
   if lastkey () = 27
      exit
   endif
   select (1)
   if w_ord = 'M'
      set order to 1
   else 
      set order to 2
   endif
   @ 13, 21 clear to 17, 59
   w_com = 'N'
   @ 14, 27 say ' [C] Comprimido / [N] Normal ' 
   @ 16, 41 get w_com picture '!' valid w_com$"CN" 
   read
   if lastkey () = 27
      exit
   endif
   *
   M->SAI_DA="S"
   M->TIPO_PRN="I"
   IF .NOT. MENU_PRN("RELAT_01")
      restore screen from telag
      RETURN
   ENDIF
   *
   if w_com = 'C'
      set device to printer
      set print on
      @ prow (), pcol () say chr (30) + '4' 
      set print off
      set device to screen
   else 
      set device to printer
      set print on
      @ prow (), pcol () say chr (30) + '0' 
      set print off
      set device to screen
   endif
   @ 13, 21 clear to 17, 59
   @ 15, 22 say 'Emissao em andamento. [I] Interrompe ' 
   imp_mens (' ', 2)
   w_emp1 = strzero (w_emp1, 2)
   if w_seek (w_emp1, '2', 2)
      loop
   endif
   w_emp2 = strzero (w_emp2, 2)
   if w_seek (w_emp2, '2', 2)
      loop
   endif
   select (1)
   find (w_emp1)
   if ! found ()
      goto top
   endif
   w_pag = 0
   t_func = 0
   g_func = 0
   w_lin1 = replicate ('-', 132)
   w_lin2 = replicate ('=', 132)
   set device to printer
   do while val (empresa) <= val (w_emp2) .and. ! eof ()
      g_emp = empresa
      w_pag = w_pag + 1
      @ 0, 0 say CHR(27)+'(s13H' + '  Associacao do Servidores do SESI/DR/CE' 
      @ 0, 114 say 'Pagina: ' + strzero (w_pag, 6) 
      @ 1, 0 say 'Relacao de Associados Ativos e Desligados' 
      @ 1, 112 say 'Emissao: ' + dtoc (date ()) 
      @ 3, 0 say w_lin1 
      select (2)
      find (g_emp)
      @ 4, 0 say 'Empresa: ' + nome 
      select (1)
      @ 5, 0 say w_lin1 
      @ 6, 1 say 'Endereco' 
      @ 6, 38 say 'Bairro' 
      @ 6, 60 say 'Cep' 
      @ 6, 72 say 'Municipio' 
      @ 6, 94 say 'Dt.Nasc.' 
      @ 6, 104 say 'Dt. Adm.' 
      @ 6, 114 say 'Mensalidade' 
      @ 6, 128 say 'Ativo' 
      @ 7, 0 say w_lin1 
      w_cl = 8
      do while ! eof () .and. empresa = g_emp .and. w_cl < 56
         if inkey () = 73 .or. inkey () = 105
            set device to screen
            w_men = 'Interrompido! Continua? (S/N) '
            imp_mens (w_men, 1)
            if lastkey () = 78 .or. lastkey () = 110
               goto bottom
               skip 1
               set device to printer
               loop
            endif
            set device to printer
         endif
         ch = empresa + ccusto
         select (3)
         find (ch)
         g_nome = nome
         select (1)
         @ w_cl, 2 say 'Matricula...... :' + matricula 
         w_cl = w_cl + 1
         @ w_cl, 2 say 'Centro de Custo :' + ccusto + ' - ' + g_nome 
         w_cl = w_cl + 1
         @ w_cl, 2 say 'Nome Associado. :' + nome 
         w_cl = w_cl + 1
         @ w_cl, 1 say ender 
         @ w_cl, 38 say bairro 
         @ w_cl, 60 say cep picture '@R 99.999-999' 
         @ w_cl, 72 say munici 
         @ w_cl, 94 say nasc 
         @ w_cl, 104 say admissao 
         @ w_cl, 114 say mensal picture '@E 9,999,999.99' 
         if ativo
            @ w_cl, 128 say 'S' 
         else 
            @ w_cl, 128 say 'N' 
         endif
         w_cl = w_cl + 1
         @ w_cl, 1 say w_lin1 
         w_cl = w_cl + 1
         t_func = t_func + 1
         select (1)
         skip 1
      enddo
      if empresa != g_emp
         w_cl = w_cl + 2
         @ w_cl, 12 say 'Total de Funcionarios na Empresa: - ' + g_emp 
         @ w_cl, pcol () say t_func picture '99,999' 
         t_func = 0
         g_func = g_func + t_func
      endif
   enddo
   w_cl = w_cl + 2
   @ w_cl, 12 say 'Total de Funcionarios Associados: - ' + g_emp 
   @ w_cl, pcol () say g_func picture '99,999' 
   @ prow (), pcol () say chr (30) + '0' 
   eject
   set device to screen
   IF M->TIPO_PRN = "A"
      SET PRINTER TO
   ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
      SET PRINTER TO
      IMP_TELA("RELAT_01", 140,  0)
   ENDIF
   *
enddo
close all
restore screen from telag
return .t.

function pdsca406       
save screen to telag
select (3)
use tabsca02 index tabsca02
select (2)
use tabsca01 index tabsca01
select (1)
use adsca001 index aisca001, aisca101
do while .t.
   select (1)
   goto top
   @ 5, 1 clear to 22, 77
   @ 3, 52 clear to 3, 77
   @ 3, 62 say 'Rotina: '+PROCNAME()
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   w_men = 'Relatorios - Relacao de Associados '
   @ 8, centra (w_men) say w_men 
   w_emp1 = 0
   w_emp2 = 0
   @ 12, 20 to 18, 60
   @ 14, 22 say 'Digite Intervalo de Empresas a emitir' 
   @ 16, 35 get w_emp1 picture '99'
   @ 16, 45 get w_emp2 picture '99'
   read
   if lastkey () = 27
      exit
   endif
   @ 13, 21 clear to 17, 59
   w_ord = 'M'
   @ 14, 27 say ' [M] Matricula / [N] Nome ' 
   @ 16, 41 get w_ord picture '!' valid w_ord$"MN" 
   read
   if lastkey () = 27
      exit
   endif
   select (1)
   if w_ord = 'M'
      set order to 1
   else 
      set order to 2
   endif
   @ 13, 21 clear to 17, 59
   w_com = 'N'
   if lastkey () = 27
      exit
   endif
   set device to printer
   set print on
   @ prow (), pcol () say chr (30) + '0' 
   set print off
   set device to screen
   @ 13, 21 clear to 17, 59
   @ 15, 22 say 'Emissao em andamento. [I] Interrompe ' 
   imp_mens (' ', 2)
   w_emp1 = strzero (w_emp1, 2)
   if w_seek (w_emp1, '2', 2)
      loop
   endif
   w_emp2 = strzero (w_emp2, 2)
   if w_seek (w_emp2, '2', 2)
      loop
   endif
   select (1)
   find (w_emp1)
   if ! found ()
      w_men = 'Nao existem Associados na empresa ' + w_emp1
      imp_mens (w_men, 1)
      loop
   endif
   w_pag = 0
   t_func = 0
   g_func = 0
   w_lin1 = replicate ('-', 80)
   w_lin2 = replicate ('=', 80)
   *
   M->SAI_DA="S"
   M->TIPO_PRN="I"
   IF .NOT. MENU_PRN("RELAT_01")
      restore screen from telag
      RETURN
   ENDIF
   *
   set device to printer
   g_emp = empresa
   do while ! eof () .and. empresa >= w_emp1 .and. empresa <= w_emp2
      w_pag = w_pag + 1
      @ 0, 0 say CHR(27)+'(s13H' + '  Associacao do Servidores do SESI/DR/CE' 
      @ 0, 60 say 'Pagina: ' + str (w_pag, 9) 
      @ 1, 0 say 'Relacao de Associados Ativos e Desligados' 
      @ 1, 60 say 'Emissao: ' + dtoc (date ()) 
      @ 3, 0 say w_lin1 
      select (2)
      find (g_emp)
      @ 4, 0 say 'Empresa: ' + nome 
      select (1)
      @ 5, 0 say w_lin1 
      @ 6, 0 say 'Matricula' 
      @ 6, 12 say 'Nome do Associado' 
      @ 7, 0 say w_lin2 
      w_cl = 8
      do while ! eof () .and. empresa = g_emp .and. empresa >= w_emp1 .and. empresa <= w_emp2 .and. w_cl < 56
         if inkey () = 73 .or. inkey () = 105
            set device to screen
            w_men = 'Interrompido! Continua? (S/N) '
            imp_mens (w_men, 1)
            if lastkey () = 78 .or. lastkey () = 110
               goto bottom
               skip 1
               set device to printer
               loop
            endif
            set device to printer
         endif
         ch = empresa + ccusto
         select (3)
         find (ch)
         g_nome = nome
         select (1)
         @ w_cl, 2 say matricula 
         @ w_cl, 12 say nome 
         w_cl = w_cl + 1
         t_func = t_func + 1
         skip 1
      enddo
      if empresa != g_emp
         w_cl = w_cl + 2
         @ w_cl, 12 say 'Total de Funcionarios na Empresa: - ' + g_emp 
         @ w_cl, pcol () say t_func picture '99,999' 
         t_func = 0
         g_func = g_func + t_func
      endif
   enddo
   w_cl = w_cl + 2
   @ w_cl, 12 say 'Total de Funcionarios Associados: - ' + g_emp 
   @ w_cl, pcol () say g_func picture '999,999' 
   @ prow (), pcol () say chr (30) + '0' 
   eject
   set device to screen
   *
   IF M->TIPO_PRN = "A"
      SET PRINTER TO
   ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
      SET PRINTER TO
      IMP_TELA("RELAT_01", 140,  0)
   ENDIF
   *
enddo
close all
restore screen from telag
return .t.

function pdsca407       
save screen to telag
select (3)
use tabsca02 index tabsca02
select (2)
use tabsca01 index tabsca01
select (1)
use adsca001 index aisca001, aisca101
do while .t.
   select (1)
   goto top
   @ 5, 1 clear to 22, 77
   @ 3, 52 clear to 3, 77
   @ 3, 62 say 'Rotina: '+PROCNAME()
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   w_men = 'Relatorios - Relacao de Associados/Adesao'
   @ 8, centra (w_men) say w_men 
   w_emp1 = 0
   w_emp2 = 0
   @ 12, 20 to 18, 60
   @ 14, 22 say 'Digite Intervalo de Empresas a emitir' 
   @ 16, 35 get w_emp1 picture '99'
   @ 16, 45 get w_emp2 picture '99'
   read
   if lastkey () = 27
      exit
   endif
   @ 13, 21 clear to 17, 59
   w_ord = 'M'
   @ 14, 27 say ' [M] Matricula / [N] Nome ' 
   @ 16, 41 get w_ord picture '!' valid w_ord$"MN" 
   read
   if lastkey () = 27
      exit
   endif
   select (1)
   if w_ord = 'M'
      set order to 1
   else 
      set order to 2
   endif
   @ 13, 21 clear to 17, 59
   w_com = 'N'
   if lastkey () = 27
      exit
   endif
   *
   M->SAI_DA="S"
   M->TIPO_PRN="I"
   IF .NOT. MENU_PRN("RELAT_01")
      restore screen from telag
      RETURN
   ENDIF
   *
   set device to printer
   set print on
   @ prow (), pcol () say chr (30) + '0' 
   set print off
   set device to screen
   @ 13, 21 clear to 17, 59
   @ 15, 22 say 'Emissao em andamento. [I] Interrompe ' 
   imp_mens (' ', 2)
   w_emp1 = strzero (w_emp1, 2)
   if w_seek (w_emp1, '2', 2)
      loop
   endif
   w_emp2 = strzero (w_emp2, 2)
   if w_seek (w_emp2, '2', 2)
      loop
   endif
   select (1)
   find (w_emp1)
   if ! found ()
      w_men = 'Nao existem Associados na empresa ' + w_emp1
      imp_mens (w_men, 1)
      loop
   endif
   w_pag = 0
   t_func = 0
   g_func = 0
   w_lin1 = replicate ('-', 80)
   w_lin2 = replicate ('=', 80)
   *
   M->SAI_DA="S"
   M->TIPO_PRN="I"
   IF .NOT. MENU_PRN("RELAT_01")
      restore screen from telag
      RETURN
   ENDIF
   *
   set device to printer
   g_emp = empresa
   do while ! eof () .and. empresa >= w_emp1 .and. empresa <= w_emp2
      w_pag = w_pag + 1
      @ 0, 0 say CHR(27)+'(s13H' + '  Associacao do Servidores do SESI/DR/CE' 
      @ 0, 60 say 'Pagina: ' + str (w_pag, 9) 
      @ 1, 0 say 'Relacao de Associados Ativos e Desligados' 
      @ 1, 60 say 'Emissao: ' + dtoc (date ()) 
      @ 3, 0 say w_lin1 
      select (2)
      find (g_emp)
      @ 4, 0 say 'Empresa: ' + nome 
      select (1)
      @ 5, 0 say w_lin1 
      @ 6, 0 say 'Matricula' 
      @ 6, 12 say 'Nome do Associado' 
      @ 7, 0 say w_lin2 
      w_cl = 9
      do while ! eof () .and. empresa = g_emp .and. empresa >= w_emp1 .and. empresa <= w_emp2 .and. w_cl < 56
         if inkey () = 73 .or. inkey () = 105
            set device to screen
            w_men = 'Interrompido! Continua? (S/N) '
            imp_mens (w_men, 1)
            if lastkey () = 78 .or. lastkey () = 110
               goto bottom
               skip 1
               set device to printer
               loop
            endif
            set device to printer
         endif
         ch = empresa + ccusto
         select (3)
         find (ch)
         g_nome = nome
         select (1)
         @ w_cl, 2 say matricula 
         @ w_cl, 12 say nome 
         @ w_cl, 50 say replicate ('_', 30) 
         w_cl = w_cl + 2
         t_func = t_func + 1
         skip 1
      enddo
      if empresa != g_emp
         w_cl = w_cl + 2
         @ w_cl, 12 say 'Total de Funcionarios na Empresa: - ' + g_emp 
         @ w_cl, pcol () say t_func picture '999,999' 
         t_func = 0
         g_func = g_func + t_func
      endif
   enddo
   w_cl = w_cl + 2
   @ w_cl, 12 say 'Total de Funcionarios Associados: - ' + g_emp 
   @ w_cl, pcol () say g_func picture '999,999' 
   @ prow (), pcol () say chr (30) + '0' 
   eject
   set device to screen
   *
   IF M->TIPO_PRN = "A"
      SET PRINTER TO
   ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
      SET PRINTER TO
      IMP_TELA("RELAT_01", 140,  0)
   ENDIF
   *
enddo
close all
restore screen from telag
return .t.

function pdsca403       
save screen to telag
set softseek on
select (5)
use tabsca04 index tabsca04
select (4)
use tabsca03 index tabsca03
select (3)
use tabsca01 index tabsca01
select (2)
use adsca001 index aisca001
set filter to ativo
select (1)
use adsca002
index on empresa+verba+subverba+matricula to aiscatmp
do while .t.
   goto top
   @ 5, 1 clear to 22, 77
   @ 3, 52 clear to 3, 77
   @ 3, 62 say 'Rotina: '+PROCNAME()
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   w_men = 'Relatorios - Codigos de Verbas'
   @ 8, centra (w_men) say w_men 
   @ 5, 1 clear to 22, 77
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   w_em1 = 0
   w_em2 = 0
   @ 12, 20 to 18, 60
   @ 14, 22 say 'Digite Intervalo de Empresas a emitir' 
   @ 16, 35 get w_em1 picture '99'
   @ 16, 45 get w_em2 picture '99'
   read
   if lastkey () = 27
      exit
   endif
   @ 5, 1 clear to 22, 77
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   w_emp1 = 0
   w_emp2 = 0
   @ 12, 20 to 18, 60
   @ 14, 22 say 'Digite Intervalo de Verbas a emitir' 
   @ 16, 35 get w_emp1 picture '999'
   @ 16, 45 get w_emp2 picture '999'
   read
   if lastkey () = 27
      exit
   endif
   inter = .f.
   if w_emp1 = w_emp2
      inter = .t.
      @ 5, 1 clear to 22, 77
      w_men = '[ESC] - Encerrar'
      imp_mens (w_men, 2)
      w_sb1 = 0
      w_sb2 = 0
      @ 12, 20 to 18, 63
      @ 14, 22 say 'Digite Intervalo de Sub-Verbas a emitir' 
      @ 16, 35 get w_sb1 picture '999'
      @ 16, 45 get w_sb2 picture '999'
      read
      if lastkey () = 27
         exit
      endif
      w_sb1 = strzero (w_sb1, 3)
      w_sb2 = strzero (w_sb2, 3)
   endif
   @ 13, 21 clear to 17, 59
   @ 15, 22 say 'Emissao em andamento. [I] Interrompe ' 
   imp_mens (' ', 2)
   w_emp1 = strzero (w_emp1, 3)
   if w_seek (w_emp1, '4', 2)
      loop
   endif
   w_emp2 = strzero (w_emp2, 3)
   if w_seek (w_emp2, '4', 2)
      loop
   endif
   w_em1 = strzero (w_em1, 2)
   if w_seek (w_em1, '3', 2)
      loop
   endif
   w_em2 = strzero (w_em2, 2)
   if w_seek (w_em2, '3', 2)
      loop
   endif
   select (1)
   set filter to verba>=w_emp1 .and.verba<=w_emp2
   find (w_em1 + w_emp1)
   w_pag = 0
   w_tot = 0
   e_tot = 0
   w_lin1 = replicate ('-', 80)
   w_lin2 = replicate ('=', 80)
   *
   M->SAI_DA="S"
   M->TIPO_PRN="I"
   IF .NOT. MENU_PRN("RELAT_01")
      restore screen from telag
      RETURN
   ENDIF
   *
   set device to printer
   w_pag = w_pag + 1
   @ prow () + 1, 0 say CHR(27)+'(s13H' + '  Associacao dos Servidores do SESI/DR/CE' 
   @ prow () + 0, 65 say 'DP: ' + dtoc (date ()) 
   @ prow () + 1, 0 say 'Relatorio Geral para descontos em Folha de Pagto' 
   @ prow () + 0, 65 say 'Pag.      ' + strzero (w_pag, 3) 
   @ prow () + 1, 0 say w_lin1 
   do while ! eof () .and. empresa >= w_em1 .and. empresa <= w_em2
      if prow () > 58
         eject
         w_pag = w_pag + 1
         @ prow () + 1, 0 say 'Associacao dos Servidores do SESI/DR/CE' 
         @ prow () + 0, 65 say 'DP: ' + dtoc (date ()) 
         @ prow () + 1, 0 say 'Relatorio Geral para descontos em Folha de Pagto' 
         @ prow () + 0, 65 say 'Pag.      ' + strzero (w_pag, 3) 
         @ prow () + 1, 0 say w_lin1 
      endif
      g_emp = empresa
      select (3)
      find (g_emp)
      @ prow () + 1, 0 say 'Empresa: ' + nome 
      select (1)
      @ prow () + 1, 0 say w_lin1 
      @ prow () + 1, 1 say 'VERBA' 
      @ prow () + 0, 8 say 'MAT' 
      @ prow () + 0, 14 say 'C.CUSTO' 
      @ prow () + 0, 23 say 'NOME DO ASSOCIADO' 
      @ prow () + 0, 65 say 'VALORES' 
      @ prow () + 0, 75 say 'PARC.' 
      @ prow () + 1, 0 say w_lin2 
      do while ! eof () .and. empresa >= w_em1 .and. empresa <= w_em2 .and. g_emp = empresa .and. prow () < 59
         if inkey () = 73 .or. inkey () = 105
            set device to screen
            w_men = 'Interrompido! Continua? (S/N) '
            imp_mens (w_men, 1)
            if lastkey () = 78 .or. lastkey () = 110
               goto bottom
               skip 1
               set device to printer
               loop
            endif
            set device to printer
         endif
         if inkey () = 105
            set device to screen
            w_men = 'Interrompido! Continua? (S/N) '
            imp_mens (w_men, 1)
            if lastkey () = 78 .or. lastkey () = 110
               goto bottom
               skip 1
               set device to printer
               loop
            endif
            set device to printer
         endif
         g_cod = verba
         v_cod = subverba
         select (5)
         goto top
         find (g_cod + v_cod)
         subnome = nomesub
         select (1)
         if inter = .f.
            @ prow () + 1, 1 say g_cod + ' - ' + subnome 
         endif
         sobe = .f.
         entra = .t.
         do while ! eof () .and. empresa >= w_em1 .and. empresa <= w_em2 .and. g_emp = empresa .and. prow () < 59 .and. g_cod = verba .and. subverba = v_cod
            if inter = .t.
               if val (subverba) >= val (w_sb1) .and. val (subverba) <= val (w_sb2)
                  sobe = .f.
                  if entra = .t.
                     @ prow () + 1, 1 say g_cod + ' - ' + subnome 
                     entra = .f.
                  endif
               else 
                  sobe = .t.
               endif
            endif
            if sobe = .t.
               skip 1
               loop
            endif
            w_ch = g_emp + matricula
            select (2)
            find (w_ch)
            if ! found ()
               select (1)
               skip 1
               loop
            endif
            @ prow () + 1, 8 say matricula 
            @ prow (), 15 say ccusto 
            @ prow (), 23 say nome 
            select (1)
            @ prow (), 60 say valor picture '9,999,999.99' 
            if refer != 0
               crefere = parcelas - refer + 1
               crefere = str (crefere, 1) + '/' + str (parcelas, 1)
            else 
               crefere = ' '
            endif
            @ prow (), 75 say crefere 
            w_tot = w_tot + valor
            skip 1
         enddo
         if inter = .f.
            @ prow () + 2, 35 say 'Total da Verba: ' 
            @ prow () + 0, 67 say w_tot picture '@E 99,999,999.99' 
            e_tot = e_tot + w_tot
            w_tot = 0
         else 
            if sobe = .f.
               @ prow () + 2, 35 say 'Total da Verba (Pagina): ' 
               @ prow () + 0, 67 say w_tot picture '@E 99,999,999.99' 
               e_tot = e_tot + w_tot
               w_tot = 0
            endif
         endif
      enddo
      if empresa != g_emp
         @ prow () + 1, 35 say 'Total da verba na empresa: ' 
         @ prow () + 0, 67 say e_tot picture '99,999,999.99' 
         e_tot = 0
      endif
   enddo
   @ 0, 0 say ' ' 
   set device to screen
   set device to printer
   set print on
   @ prow (), pcol () say chr (30) + '0' 
   set print off
   set device to screen
   *
   IF M->TIPO_PRN = "A"
      SET PRINTER TO
   ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
      SET PRINTER TO
      IMP_TELA("RELAT_01", 140,  0)
   ENDIF
   *
enddo
set softseek off
close all
erase ('AISCATMP.NTX')
restore screen from telag
return .t.

function pdsca409       
save screen to telag
select (2)
use tabsca03
index on empresa to gtx1
select (1)
use adsca002
index on verba+matricula to gtx
goto top
@ 5, 1 clear to 22, 77
@ 3, 52 clear to 3, 77
@ 3, 62 say 'Rotina: '+PROCNAME()
w_men = '[ESC] - Encerrar'
imp_mens (w_men, 2)
w_men = 'Relatorios - Codigos de Verbas'
@ 8, centra (w_men) say w_men 
@ 5, 1 clear to 22, 77
w_men = '[ESC] - Encerrar'
imp_mens (w_men, 2)
@ 12, 20 to 18, 60
if lastkey () = 27
   close databases
   set device to screen
   erase ('GTX.NTX')
   return .t.
endif
@ 13, 21 clear to 17, 59
@ 15, 22 say 'Emissao em andamento. [I] Interrompe ' 
imp_mens (' ', 2)
if eof ()
   close databases
   set device to screen
   erase ('GTX.NTX')
   return .t.
endif
w_pag = 0
w_tot = 0
w_lin1 = replicate ('-', 80)
w_lin2 = replicate ('=', 80)
*
M->SAI_DA="S"
M->TIPO_PRN="I"
IF .NOT. MENU_PRN("RELAT_01")
    restore screen from telag
    RETURN
ENDIF
*
set device to printer
vez = 1
select (2)
goto top
do while ! eof ()
   xx = empresa
   t&xx = 0
   skip 1
enddo
select (1)
ttdes = 0
ttpro = 0
tttot = 0
do while ! eof ()
   if vez = 1
      @ 0, 0 say '' 
      w_pag = w_pag + 1
      @ 0, 0 say CHR(27)+'(s13H' + '  Associacao dos Servidores do SESI/DR/CE' 
      @ 0, 65 say 'DP: ' + dtoc (date ()) 
      @ 1, 0 say 'Relatorio Geral para descontos em Folha de Pagto' 
      @ 1, 65 say 'Pag.      ' + strzero (w_pag, 3) 
      @ 2, 0 say w_lin1 
      @ 4, 0 say w_lin1 
      @ 5, 1 say 'VERBA' 
      @ 5, 8 say 'DESCRICAO' 
      @ 5, 60 say 'VALOR' 
      @ 6, 0 say w_lin2 
      w_cl = 7
      vez = 2
   endif
   xx = verba
   t&xx = t&xx + valor
   if val (xx) < 100
      ttpro = ttpro + valor
   else 
      ttdes = ttdes + valor
   endif
   tttot = tttot + valor
   skip 1
enddo
select (2)
w_cl = w_cl + 1
goto top
do while ! eof ()
   xx = empresa
   if t&xx != 0
      @ w_cl, 1 say empresa 
      @ w_cl, 8 say nome 
      @ w_cl, 60 say t&xx picture '@E 999,999,999.99' 
      w_cl = w_cl + 1
   endif
   skip 1
enddo
w_cl = w_cl + 1
@ w_cl, 0 say w_lin1 
w_cl = w_cl + 2
@ w_cl, 10 say 'VALOR TOTAL ===========>' 
@ w_cl, 60 say tttot picture '@E 999,999,999.99' 
w_cl = w_cl + 1
@ w_cl, 10 say 'TOTAL DE ACRESCIMOS ===>' 
@ w_cl, 60 say ttpro picture '@E 999,999,999.99' 
w_cl = w_cl + 1
@ w_cl, 10 say 'TOTAL DE DESCONTOS ====>' 
@ w_cl, 60 say ttdes picture '@E 999,999,999.99' 
w_cl = w_cl + 2
@ w_cl, 10 say 'S A L D O =============>' 
@ w_cl, 60 say ttpro - ttdes picture '@E 999,999,999.99' 
@ w_cl, 10 say 'S A L D O =============>' 
@ w_cl, 60 say ttpro - ttdes picture '@E 999,999,999.99' 
w_cl = w_cl + 1
@ w_cl, 0 say w_lin1 

@ 0, 0 say ' ' 
set device to screen
set device to printer
set print on
@ prow (), pcol () say chr (30) + '0' 
set print off
set device to screen
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("RELAT_01", 140,  0)
ENDIF
*
close all
erase ('GTX.NTX')
restore screen from telag
return .t.

function pdsca404       
save screen to telag
select (3)
use tabsca01 index tabsca01
select (2)
use adsca002 index aisca002
select (1)
use adsca001
index on empresa+ccusto+nome to aiscatmp
set filter to ativo
w_cl = 0
goto top
select (1)
goto top
@ 5, 1 clear to 22, 77
@ 3, 52 clear to 3, 77
@ 3, 62 say 'Rotina: '+PROCNAME()
w_men = 'Relatorios - Relacao para Folha de Pagamento'
@ 8, centra (w_men) say w_men 
w_men = '[ESC] - Encerrar'
imp_mens (w_men, 2)
w_emp1 = 0
w_emp2 = 0
wurv = 0
@ 10, 20 to 18, 60 double
@ 12, 22 say 'Digite o valor URV do dia' get wurv picture '99999.99'
@ 14, 22 say 'Digite o intervalo de empresas' 
@ 16, 30 get w_emp1 picture '99'
@ 16, 44 get w_emp2 picture '99'
read
if lastkey () = 27
   close all
   erase ('AISCATMP.NTX')
   return .t.
endif
w_emp1 = strzero (w_emp1, 2)
w_emp2 = strzero (w_emp2, 2)
w_pag = 0
select (1)
g_emp = empresa
w_lin = replicate ('-', 130)
w_lin1 = replicate ('-', 130)
g_tot = 0
tot_a = 0
w_ct = 0
*
M->SAI_DA="S"
M->TIPO_PRN="I"
IF .NOT. MENU_PRN("RELAT_01")
    restore screen from telag
    RETURN
ENDIF
*
set device to printer
lin = 61
pag = 0
totg = 0
goto top
find (w_emp1)
do while empresa >= w_emp1 .and. empresa <= w_emp2 .and. ! eof ()
   empre = empresa
   totemp = 0
   lin = 61
   do while empresa = empre .and. ! eof ()
      if lin > 55
         w_pag = w_pag + 1
         @ 0, 0 say CHR(27)+'(s13H' + '  Associacao dos Servidores do SESI/DR/CE' 
         @ 0, 115 say 'DP: ' + dtoc (date ()) 
         @ 1, 0 say 'Relatorio Geral para descontos em Folha de Pagto' 
         @ 1, 115 say 'Pag.      ' + strzero (w_pag, 3) 
         @ 2, 0 say w_lin 
         select (3)
         find (empre)
         @ 3, 0 say 'Empresa: ' + nome 
         select (1)
         @ 4, 0 say w_lin 
         @ 5, 0 say 'Matricula' 
         @ 5, 11 say 'C.Custo' 
         @ 5, 20 say 'Nome do Associado' 
         @ 5, 52 say 'Tot. Desc.(CR$)' 
         @ 5, 70 say 'Tot. Desc.(URV)' 
         @ 5, 88 say 'Tot. C.Custo.(CR$)' 
         @ 5, 110 say 'Tot. C.Custo.(URV)' 
         @ 6, 0 say w_lin1 
         lin = 7
      endif
      totc = 0
      w_ch = empresa + matricula
      g_nome = nome
      custog = ccusto
      do while empresa = empre .and. ccusto = custog .and. ! eof ()
         if inkey () = 27
            eject
            set device to screen
            return ''
         endif
         if lin > 55
            w_pag = w_pag + 1
            @ 0, 0 say CHR(27)+'(s13H' + 'Associacao dos Servidores do SESI/DR/CE' 
            @ 0, 115 say 'DP: ' + dtoc (date ()) 
            @ 1, 0 say 'Relatorio Geral para descontos em Folha de Pagto' 
            @ 1, 115 say 'Pag.      ' + strzero (w_pag, 3) 
            @ 2, 0 say w_lin 
            select (3)
            find (empre)
            @ 3, 0 say 'Empresa: ' + nome 
            select (1)
            @ 4, 0 say w_lin 
            @ 5, 0 say 'Matricula' 
            @ 5, 11 say 'C.Custo' 
            @ 5, 20 say 'Nome do Associado' 
            @ 5, 52 say 'Tot. Desc.(CR$)' 
            @ 5, 70 say 'Tot. Desc.(URV)' 
            @ 5, 88 say 'Tot. C.Custo.(CR$)' 
            @ 5, 110 say 'Tot. C.Custo.(URV)' 
            @ 6, 0 say w_lin1 
            lin = 7
         endif
         w_ch = empresa + matricula
         select (2)
         find (w_ch)
         if ! found ()
            select (1)
            @ lin, 3 say matricula 
            @ lin, 11 say ccusto 
            @ lin, 20 say nome 
            @ lin, 52 say 'SEM  MOVIMENTO' 
            skip 1
            if ccusto = custog
               lin = lin + 1
            endif
            loop
         endif
         tot_v = 0
         tot_d = 0
         s_tot = 0
         do while ! eof () .and. empresa + matricula = w_ch
            if inkey () = 27
               eject
               set device to screen
               return ''
            endif
            g_verba = val (verba)
            if g_verba < 100
               tot_v = tot_v + valor
            else 
               tot_d = tot_d + valor
            endif
            skip 1
         enddo
         s_tot = tot_v - tot_d
         select (1)
         @ lin, 3 say matricula 
         @ lin, 10 say ccusto 
         @ lin, 20 say nome 
         @ lin, 56 say s_tot picture '@E 999,999.99' 
         @ lin, 74 say s_tot / wurv picture '@E 999,999.99' 
         g_tot = g_tot + s_tot
         totc = totc + s_tot
         totemp = totemp + s_tot
         skip 1
         if ccusto = custog
            lin = lin + 1
         endif
      enddo
      @ lin,92 say totc picture '9,999,999.99' 
      @ lin, 113 say totc / wurv picture '99,999,999.99' 
      lin = lin + 2
   enddo
   @ lin, 25 say 'Total na Empresa ......' 
   @ lin, 60 say totemp picture '999,999,999.99' 
   @ lin, 80 say totemp / wurv picture '999,999,999.99' 
   totg = totg + totemp
enddo
lin = lin + 2
@ lin, 25 say 'Total na Associacao ......' 
@ lin, 58 say totg picture '9,999,999,999.99' 
@ lin, 78 say totg / wurv picture '9,999,999,999.99' 
@ lin + 1, 10 say '  ' 
set device to screen
*
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("RELAT_01", 140,  0)
ENDIF
*
close all
restore screen from telag
return .t.

*******************
function pdsca4041
save screen to telag
select (3)
use tabsca01 index tabsca01
select (2)
use adsca002 index aisca002
select (1)
use adsca001
index on empresa+ccusto+nome to aiscatmp
set filter to ativo
w_cl = 0
goto top
select (1)
goto top
@ 5, 1 clear to 22, 77
@ 3, 52 clear to 3, 77
@ 3, 62 say 'Rotina: '+PROCNAME()
w_men = 'Relatorios - Relacao para Folha de Pagamento'
@ 8, centra (w_men) say w_men 
w_men = '[ESC] - Encerrar'
imp_mens (w_men, 2)
w_emp1 = 0
w_emp2 = 0
wurv = 0
@ 10, 20 to 18, 60 double
@ 12, 22 say 'Digite o valor URV do dia' get wurv picture '99999.99'
@ 14, 22 say 'Digite o intervalo de empresas' 
@ 16, 30 get w_emp1 picture '99'
@ 16, 44 get w_emp2 picture '99'
read
if lastkey () = 27
   close all
   erase ('AISCATMP.NTX')
   return .t.
endif
w_emp1 = strzero (w_emp1, 2)
w_emp2 = strzero (w_emp2, 2)
w_pag = 0
select (1)
g_emp = empresa
w_lin = replicate ('-', 80)
w_lin1 = replicate ('-',80)
g_tot = 0
tot_a = 0
w_ct = 0
*
M->SAI_DA="S"
M->TIPO_PRN="I"
IF .NOT. MENU_PRN("RELAT_01")
    restore screen from telag
    RETURN
ENDIF
*
set device to printer
lin = 61
pag = 0
totg = 0
goto top
find (w_emp1)
do while empresa >= w_emp1 .and. empresa <= w_emp2 .and. ! eof ()
   empre = empresa
   totemp = 0
   lin = 61
   do while empresa = empre .and. ! eof ()
      if lin > 55
         w_pag = w_pag + 1
         @ 0, 0 say CHR(27)+'(s13H'+'  Associacao dos Servidores do SESI/DR/CE' 
         @ 0, 115 say 'DP: ' + dtoc (date ()) 
         @ 1, 0 say 'Relatorio Geral para descontos em Folha de Pagto' 
         @ 1, 115 say 'Pag.      ' + strzero (w_pag, 3) 
         @ 2, 0 say w_lin 
         select (3)
         find (empre)
         @ 3, 0 say 'Empresa: ' + nome 
         select (1)
         @ 4, 0 say w_lin 
         @ 5, 0 say 'Matricula' 
         @ 5, 11 say 'Nome do Associado' 
         @ 5, 52 say 'Tot. Desc.(CR$)' 
         @ 6, 0 say w_lin1 
         lin = 7
      endif
      totc = 0
      w_ch = empresa + matricula
      g_nome = nome
      do while empresa = empre .and. ! eof ()
         if inkey () = 27
            eject
            set device to screen
            return ''
         endif
         if lin > 55
            w_pag = w_pag + 1
            @ 0, 0 say CHR(27)+'(s13H'+'  Associacao dos Servidores do SESI/DR/CE' 
            @ 0, 115 say 'DP: ' + dtoc (date ()) 
            @ 1, 0 say 'Relatorio Geral para descontos em Folha de Pagto' 
            @ 1, 115 say 'Pag.      ' + strzero (w_pag, 3) 
            @ 2, 0 say w_lin 
            select (3)
            find (empre)
            @ 3, 0 say 'Empresa: ' + nome 
            select (1)
            @ 4, 0 say w_lin 
            @ 5, 0 say 'Matricula' 
            @ 5, 11 say 'Nome do Associado' 
            @ 5, 52 say 'Tot. Desc.(CR$)' 
            @ 6, 0 say w_lin1 
            lin = 7
         endif
         w_ch = empresa + matricula
         select (2)
         find (w_ch)
         if ! found ()
            select (1)
            @ lin, 3 say matricula 
            @ lin, 11 say nome 
            @ lin, 52 say 'SEM  MOVIMENTO' 
            skip 1
            loop
         endif
         tot_v = 0
         tot_d = 0
         s_tot = 0
         if inkey () = 27
            eject
            set device to screen
            return ''
         endif
         g_verba = val (verba)
         if g_verba < 100
            tot_v = tot_v + valor
         else 
            tot_d = tot_d + valor
         endif
         s_tot = tot_v - tot_d
         select (1)
         @ lin, 3 say matricula 
         @ lin, 10 say nome 
         @ lin, 56 say s_tot picture '@E 999,999.99' 
         g_tot = g_tot + s_tot
         totc = totc + s_tot
         totemp = totemp + s_tot
         skip 1
      enddo
      @ lin,92 say totc picture '9,999,999.99' 
      @ lin, 113 say totc / wurv picture '99,999,999.99' 
      lin = lin + 2
   enddo
   @ lin, 25 say 'Total na Empresa ......' 
   @ lin, 60 say totemp picture '999,999,999.99' 
   @ lin, 80 say totemp / wurv picture '999,999,999.99' 
   totg = totg + totemp
enddo
lin = lin + 2
@ lin, 25 say 'Total na Associacao ......' 
@ lin, 58 say totg picture '9,999,999,999.99' 
@ lin, 78 say totg / wurv picture '9,999,999,999.99' 
@ lin + 1, 10 say '  ' 
set device to screen
*
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("RELAT_01", 140,  0)
ENDIF
*
close all
restore screen from telag
return .t.


********************
function sca0043
save screen to telag
select (2)
use adsca002 index aisca002
goto top
@ 5, 1 clear to 22, 77
@ 3, 52 clear to 3, 77
@ 3, 62 say 'Rotina: '+PROCNAME()
w_men = 'Relatorios - Relacao para Folha de Pagamento'
@ 8, centra (w_men) say w_men 
w_men = '[ESC] - Encerrar'
imp_mens (w_men, 2)
w_emp1 = 0
w_emp2 = 0
@ 14, 22 say 'Digite o intervalo de empresas' 
@ 16, 30 get w_emp1 picture '99'
@ 16, 44 get w_emp2 picture '99'
read
if lastkey () = 27
   close all
   return .t.
endif
w_emp1 = strzero (w_emp1, 2)
w_emp2 = strzero (w_emp2, 2)
set device to printer
SET PRINTER TO DESASSEC.TXT 
seek (w_emp1)
lin=0
do while empresa >= w_emp1 .and. empresa <= w_emp2 .and. ! eof ()
   if inkey () = 27
      set device to screen
      return ''
   endif
   w_ch = empresa+matricula
   wmat = matricula
   if wmat = '4806'
      skip
   else
   tot_v=0
   do while ! eof () .and. empresa + matricula = w_ch
      tot_v = tot_v + valor
      skip 1
  enddo
  @ lin, 00 say "0000"+wmat
  @ lin, 16 say STRZERO(DAY(DATE()),2)+STRZERO(MONTH(DATE()),2)+STRZERO(YEAR(DATE()),4) 
  @ lin, 24 say "0125"
  @ lin, 28 say "000:00"            
  @ lin, 34 say 0     picture '@E 999999999999.99'
  @ lin, 49 say tot_v picture '@E 999999999999.99'
  @ lin, 64 say 0     picture '@E 999999999999.99' 
  @ lin, 79 say "N" 
  **** posicao anterior ********
  *@ lin, 00 say "0000"+wmat 
  *@ lin, 17 say "0" 
  *@ lin, 26 say "125" 
  *@ lin, 32 say tot_v picture '@E 999999999.99' 
  *@ lin, 60 say "0.00N" 
  ******************************
  lin = lin + 1
  endif
enddo
set device to screen
close all
return .t.


function w_meses        
parameters mes
do case
   case mes = 1
      g_mes = 'Janeiro'
   case mes = 2
      g_mes = 'Fevereiro'
   case mes = 3
      g_mes = 'Marco'
   case mes = 4
      g_mes = 'Abril'
   case mes = 5
      g_mes = 'Maio'
   case mes = 6
      g_mes = 'Junho'
   case mes = 7
      g_mes = 'Julho'
   case mes = 8
      g_mes = 'Agosto'
   case mes = 9
      g_mes = 'Setembro'
   case mes = 10
      g_mes = 'Outubro'
   case mes = 11
      g_mes = 'Novembro'
   case mes = 12
      g_mes = 'Dezembro'
endcase
return g_mes

procedure rlsubver      
select (5)
use tabsca04 index tabsca04
select (4)
use tabsca03 index tabsca03
select (3)
use tabsca01 index tabsca01
select (2)
use adsca001 index aisca102
select (1)
use adsca002 index aisca022
do while .t.
   goto top
   @ 5, 1 clear to 22, 77
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   @ 3, 52 clear to 3, 77
   @ 3, 62 say 'Rotina: '+PROCNAME()
   w_men = 'Relatorios - Codigos de Sub-Verbas'
   @ 8, centra (w_men) say w_men 
   @ 5, 1 clear to 22, 77
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   w_emp1 = 0
   w_emp2 = 0
   @ 12, 20 to 18, 60
   @ 14, 22 say 'Digite a Verba a emitir' 
   @ 16, 35 get w_emp1 picture '999'
   read
   w_emp1 = strzero (w_emp1, 3)
   if lastkey () = 27
      exit
   endif
   select (4)
   goto top
   find (w_emp1)
   if eof ()
      loop
   endif
   nomev = nome
   @ 5, 1 clear to 22, 77
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   w_sb1 = 0
   w_sb2 = 0
   @ 12, 20 to 18, 63
   @ 14, 22 say 'Digite Intervalo de Sub-Verbas a emitir' 
   @ 16, 35 get w_sb1 picture '999'
   @ 16, 45 get w_sb2 picture '999'
   read
   if lastkey () = 27
      exit
   endif
   w_sb1 = strzero (w_sb1, 3)
   w_sb2 = strzero (w_sb2, 3)
   @ 13, 21 clear to 17, 59
   @ 15, 22 say 'Emissao em andamento. [ESC] RETORNA ' 
   imp_mens (' ', 2)
   select (1)
   set order to 1
   goto top
   set softseek on
   find (w_emp1 + w_sb1)
   set softseek off
   subver = subverba
  
//cDevOut := GetDefaultPrinter()
//cIMPX = "C:/Curso_Harbour/Fontes/NOTA.TXT"
//SET PRINTER TO &cIMPX
//SET DEVICE TO PRINT  
   
   w_pag = 0
   w_tot = 0
   e_tot = 0
   w_lin1 = replicate ('-', 80)
   w_lin2 = replicate ('=', 80)
   set device to printer
   lin = 58
   w_pag = w_pag + 1
   do while ! eof () .and. verba = w_emp1 .and. val (subverba) >= val (w_sb1) .and. val (subverba) <= val (w_sb2)
      if inkey () = 27
         set device to screen
         return
      endif
      if lin >= 58
         lin = 0
         w_pag = w_pag + 1
         lin = lin + 1
         @ lin, 0 say CHR(27)+'(s13H'+'  Associacao dos Servidores do SESI/DR/CE' 
         @ lin, 65 say 'DP: ' + dtoc (date ()) 
         lin = lin + 1
         @ lin, 0 say 'Relatorio Geral de Sub-Verbas' 
         @ lin, 65 say 'Pag.      ' + strzero (w_pag, 3) 
         lin = lin + 1
         @ lin, 0 say w_lin1 
         lin = lin + 1
         for i = 1 to 3
            @ lin, 0 say 'VERBA : ' + w_emp1 + '-' + nomev 
         next
         lin = lin + 1
         @ lin, 0 say w_lin1 
         lin = lin + 1
         @ lin, 1 say 'VERBA' 
         @ lin, 8 say 'MAT' 
         @ lin, 14 say 'C.CUSTO' 
         @ lin, 23 say 'NOME DO ASSOCIADO' 
         @ lin, 65 say 'VALORES' 
         @ lin, 75 say 'PARC.' 
         lin = lin + 1
         @ lin, 0 say w_lin2 
         lin = lin + 1
         @ lin, 0 say w_lin1 
         lin = lin + 1
         select (5)
         set order to 1
         goto top
         find (w_emp1 + subver)
         @ lin, 0 say w_emp1 + '-' + nomesub 
         lin = lin + 1
         select (1)
      endif
      if subver != subverba
         subver = subverba
         lin = lin + 6
         if lin >= 58
            loop
         endif
         lin = lin - 4
         @ lin, 35 say 'Total da Verba: ' 
         @ lin, 67 say w_tot picture '@E 99,999,999.99' 
         lin = lin + 2
         w_tot = 0
         select (5)
         set order to 1
         goto top
         find (w_emp1 + subver)
         @ lin, 0 say w_emp1 + '-' + nomesub 
         select (1)
         lin = lin + 1
      endif
      mat = matricula
      emp = empresa
      select (2)
      goto top
      find (mat)
      if ! found ()
         select (1)
         skip 1
         loop
      endif
      @ lin, 8 say matricula 
      @ lin, 15 say ccusto 
      @ lin, 23 say nome 
      select (1)
      @ lin, 60 say valor picture '9,999,999.99' 
      w_tot = w_tot + valor
      if refer != 0
         crefere = parcelas - refer + 1
         crefere = str (crefere, 1) + '/' + str (parcelas, 1)
      else 
         crefere = ' '
      endif

      @ lin, 75 say crefere 
      lin = lin + 1
      skip 1
   enddo
   lin = lin + 1
   @ lin, 35 say 'Total da Verba: ' 
   @ lin, 67 say w_tot picture '@E 99,999,999.99' 
   @ lin, 0 say ' ' 
   @ prow (), pcol () say chr (30) + '0' 
   set device to screen
enddo

//SET DEVICE TO SCREEN
//SET PRINTER TO
//PRINTFILERAW(cDevOut,cIMPX)
close all
return

    
procedure scatel05      
do while .t.
   @ 5, 1 clear to 22, 77
   @ 3, 52 clear to 3, 77
   @ 3, 62 say 'Rotina: '+PROCNAME()
   set message to 22 center
   w_men = '*** T A B E L A S ***'
   @ 6, centra (w_men) say w_men 
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   @ 9, 33 prompt ' Empresas          '
   @ 11, 33 prompt ' Centros de Custos '
   @ 13, 33 prompt ' Verbas            '
   @ 15, 33 prompt ' Sub-Verbas        '
   menu to op05
   if lastkey () = 27
      exit
   endif
   do case
      case op05 = 1
         w_cab = 'Empresas'
         @ 7, 1 clear to 22, 77
         @ 9, 35 prompt 'InclusÆo' message 'Inclui - ' + w_cab
         @ 11, 35 prompt 'Altera‡Æo' message 'Altera - ' + w_cab
         @ 13, 35 prompt 'ExclusÆo' message 'Exclui - ' + w_cab
         @ 15, 35 prompt 'Consultas' message 'Consultas - ' + w_cab
         menu to op51
         if lastkey () = 27
            loop
         endif
         do pdsca501
      case op05 = 2
         w_cab = 'Centros de Custos'
         @ 7, 1 clear to 22, 77
         @ 9, 35 prompt 'Inclusƒo' message 'Inclui - ' + w_cab
         @ 11, 35 prompt 'Altera‡ƒo' message 'Altera - ' + w_cab
         @ 13, 35 prompt 'Exclusƒo' message 'Exclui - ' + w_cab
         @ 15, 35 prompt 'Consultas' message 'Consultas - ' + w_cab
         menu to op52
         if lastkey () = 27
            loop
         endif
         do pdsca502
      case op05 = 3
         w_cab = 'Verbas'
         @ 7, 1 clear to 22, 77
         @ 9, 35 prompt 'Inclusƒo' message 'Inclui - ' + w_cab
         @ 11, 35 prompt 'Altera‡ƒo' message 'Altera - ' + w_cab
         @ 13, 35 prompt 'Exclusƒo' message 'Exclui - ' + w_cab
         @ 15, 35 prompt 'Consultas' message 'Consultas - ' + w_cab
         menu to op53
         if lastkey () = 27
            loop
         endif
         do pdsca503
      case op05 = 4
         w_cab = 'Sub-Verbas'
         @ 7, 1 clear to 22, 77
         @ 9, 35 prompt 'Inclusƒo' message 'Inclui - ' + w_cab
         @ 11, 35 prompt 'Altera‡ƒo' message 'Altera - ' + w_cab
         @ 13, 35 prompt 'Exclusƒo' message 'Exclui - ' + w_cab
         @ 15, 35 prompt 'Consultas' message 'Consultas - ' + w_cab
         menu to op54
         if lastkey () = 27
            loop
         endif
         do pdsca504
   endcase
enddo
return

procedure pdsca501      
use tabsca01 index tabsca01
do while op51 = 1
   @ 5, 1 clear to 22, 78
   tela503 ()
   @ 3, 63 say 'TABELA - INCLUI' 
   w_empresa = 0
   w_nome = space (30)
   @ 7, 30 get w_empresa picture '99'
   read
   if lastkey () = 27 .or. empty (w_empresa)
      exit
   endif
   imp_mens (' ', 2)
   w_empresa = strzero (w_empresa, 2)
   @ 7, 30 say w_empresa 
   if w_seek (w_empresa, '1', 1)
      loop
   endif
   @ 9, 30 get w_nome picture '@!'
   read
   if ! w_conf (1)
      loop
   endif
   select (1)
   append blank 
   replace codigo with w_empresa
   replace nome with w_nome
enddo

do while op51 > 1
   @ 5, 1 clear to 22, 78
   tela503 ()
   do case
      case op51 = 2
         w_cab = '    TABELA - ALTERA'
      case op51 = 3
         w_cab = '   TABELA - EXCLUI'
      case op51 = 4
         w_cab = 'TABELA - CONSULTAS'
   endcase
   @ 3, 60 say w_cab 
   w_empresa = 0
   @ 7, 30 get w_empresa picture '99'
   read
   if lastkey () = 27 .or. empty (w_empresa)
      exit
   endif
   imp_mens (' ', 2)
   w_empresa = strzero (w_empresa, 2)
   @ 7, 30 say w_empresa 
   if w_seek (w_empresa, '1', 2)
      loop
   endif
   do while .t.
      @ 7, 30 say codigo picture '99' 
      @ 9, 30 say nome picture '@!' 
      if op51 = 2
         if w_conf (2)
            @ 9, 30 get nome picture '@!'
            read
         endif
      else 
         if op51 = 3
            if w_conf (3)
               delete
            endif
         endif
      endif
      if w_conf (4)
         skip 1
         if eof ()
            w_men = 'Final de Arquivo. Tecle [ESC]'
            imp_mens (w_men, 1)
            exit
         endif
      else 
         exit
      endif
   enddo
enddo
@ 3, 60 say space (18) 
close databases
return


procedure pdsca502      
select (2)
use tabsca01 index tabsca01
select (1)
use tabsca02 index tabsca02
do while op52 = 1
   @ 5, 1 clear to 22, 78
   tela502 ()
   @ 3, 63 say 'TABELA - INCLUI' 
   w_empresa = 0
   w_codigo = space (4)
   w_conta = space (17)
   w_nome = space (30)
   @ 7, 30 get w_empresa picture '99'
   read
   if lastkey () = 27 .or. empty (w_empresa)
      exit
   endif
   imp_mens (' ', 2)
   w_empresa = strzero (w_empresa, 2)
   @ 7, 30 say w_empresa 
   if w_seek (w_empresa, '2', 2)
      loop
   endif
   @ 9, 30 get w_codigo picture '9999'
   read
   w_ch = w_empresa + w_codigo
   if lastkey () = 27
      exit
   endif
   if w_seek (w_ch, '1', 1)
      loop
   endif
   @ 11, 30 get w_conta picture '@!'
   @ 13, 30 get w_nome picture '@!'
   read
   if ! w_conf (1)
      loop
   endif
   select (1)
   append blank 
   replace empresa with w_empresa
   replace codigo with w_codigo
   replace conta with w_conta
   replace nome with w_nome
enddo
do while op52 > 1
   @ 5, 1 clear to 22, 78
   tela502 ()
   do case
      case op52 = 2
         w_cab = '    TABELA - ALTERA'
      case op52 = 3
         w_cab = '   TABELA - EXCLUI'
      case op52 = 4
         w_cab = 'TABELA - CONSULTAS'
   endcase
   @ 3, 60 say w_cab 
   w_empresa = 0
   w_codigo = 0
   @ 7, 30 get w_empresa picture '99'
   read
   if lastkey () = 27 .or. empty (w_empresa)
      exit
   endif
   imp_mens (' ', 2)
   w_empresa = strzero (w_empresa, 2)
   @ 7, 30 say w_empresa 
   if w_seek (w_empresa, '2', 2)
      loop
   endif
   select (1)
   @ 9, 30 get w_codigo picture '9999'
   read
   if lastkey () = 27 .or. empty (w_codigo)
      exit
   endif
   w_codigo = strzero (w_codigo, 4)
   imp_mens (' ', 2)
   w_ch = w_empresa + w_codigo
   @ 7, 30 say w_empresa 
   if w_seek (w_ch, '1', 2)
      loop
   endif
   do while .t.
      @ 7, 30 say empresa picture '99' 
      @ 9, 30 say codigo picture '@!' 
      @ 11, 30 say conta picture '@!' 
      @ 13, 30 say nome picture '@!' 
      if op52 = 2
         if w_conf (2)
            @ 9, 30 get codigo picture '9999'
            @ 11, 30 get conta picture '@!'
            @ 13, 30 get nome picture '@!'
            read
         endif
      else 
         if op52 = 3
            if w_conf (3)
               delete
            endif
         endif
      endif
      if w_conf (4)
         skip 1
         if eof ()
            w_men = 'Final de Arquivo. Tecle [ESC]'
            imp_mens (w_men, 1)
            exit
         endif
      else 
         exit
      endif
   enddo
enddo
@ 3, 60 say space (18) 
close databases
return

procedure pdsca503      
use tabsca03
index on empresa to tabsca03
do while op53 = 1
   @ 5, 1 clear to 22, 78
   tela503 ()
   @ 3, 63 say 'TABELA - INCLUI' 
   w_empresa = 0
   w_nome = space (30)
   @ 7, 30 get w_empresa picture '999'
   read
   if lastkey () = 27 .or. empty (w_empresa)
      exit
   endif
   imp_mens (' ', 2)
   w_empresa = strzero (w_empresa, 3)
   @ 7, 30 say w_empresa 
   if w_seek (w_empresa, '1', 1)
      loop
   endif
   @ 9, 30 get w_nome picture '@!'
   read
   if ! w_conf (1)
      loop
   endif
   select (1)
   append blank 
   replace empresa with w_empresa
   replace nome with w_nome
enddo
do while op53 > 1
   @ 5, 1 clear to 22, 78
   tela503 ()
   do case
      case op53 = 2
         w_cab = '    TABELA - ALTERA'
      case op53 = 3
         w_cab = '   TABELA - EXCLUI'
      case op53 = 4
         w_cab = 'TABELA - CONSULTAS'
   endcase
   @ 3, 60 say w_cab 
   w_empresa = 0
   @ 7, 30 get w_empresa picture '999'
   read
   if lastkey () = 27 .or. empty (w_empresa)
      exit
   endif
   imp_mens (' ', 2)
   w_empresa = strzero (w_empresa, 3)
   @ 7, 30 say w_empresa 
   if w_seek (w_empresa, '1', 2)
      loop
   endif
   do while .t.
      @ 7, 30 say empresa picture '999' 
      @ 9, 30 say nome picture '@!' 
      if op53 = 2
         if w_conf (2)
            @ 9, 30 get nome picture '@!'
            read
         endif
      else 
         if op53 = 3
            if w_conf (3)
               delete
            endif
         endif
      endif
      if w_conf (4)
         skip 1
         if eof ()
            w_men = 'Final de Arquivo. Tecle [ESC]'
            imp_mens (w_men, 1)
            exit
         endif
      else 
         exit
      endif
   enddo
enddo
@ 3, 60 say space (18) 
close databases
return

procedure pdsca504      
use tabsca03
index on empresa to tabsca03
use tabsca04
index on empresa4+codi to tabsca04
close databases
select (20)
use tabsca03 index tabsca03
select (21)
use tabsca04 index tabsca04
w_empre = 0
do while op54 = 1
   @ 5, 1 clear to 22, 78
   tela504 ()
   @ 3, 63 say 'TABELA - INCLUI' 
   w_codi = 0
   w_nome = space (30)
   @ 7, 38 get w_empre picture '999'
   read
   if lastkey () = 27 .or. empty (w_empre)
      exit
   endif
   w_empresa = strzero (w_empre, 3)
   @ 7, 38 say w_empresa 
   select (20)
   goto top
   find (w_empresa)
   if eof ()
      sv1 = savescreen (24, 0, 24, 79)
      @ 24, 30 say 'EMPRESA NAO CADASTRADA' 
      tone (800, 15)
      inkey (0)
      restscreen (24, 0, 24, 79, sv1)
      release sv1
      loop
   endif
   @ 7, 42 say nome 
   @ 9, 38 get w_codi picture '999'
   read
   if lastkey () = 27 .or. empty (w_codi)
      exit
   endif
   w_codi2 = strzero (w_codi, 3)
   @ 9, 38 get w_codi2
   clear gets 
   select (21)
   goto top
   find (w_empresa)
   tem = .t.
   do while empresa4 = w_empresa
      if codi = w_codi2
         tem = .f.
         exit
      endif
      skip 1
   enddo
   if tem = .f.
      sv1 = savescreen (24, 0, 24, 79)
      @ 24, 30 say 'JA EXISTE SUB-VERBA COM ESTE CODIGO ' 
      @ 9, 43 say nomesub 
      tone (800, 15)
      inkey (0)
      restscreen (24, 0, 24, 79, sv1)
      release sv1
      loop
   endif
   @ 11, 38 get w_nome picture '@!'
   read
   if ! w_conf (1)
      loop
   endif
   select (21)
   append blank 
   replace empresa4 with w_empresa
   replace codi with w_codi2
   replace nomesub with w_nome
   commit
enddo
do while op54 > 1
   @ 5, 1 clear to 22, 78
   do case
      case op54 = 2
         w_cab = '    TABELA - ALTERA'
         tela504 ()
      case op54 = 3
         w_cab = '   TABELA - EXCLUI'
         tela504 ()
      case op54 = 4
         w_cab = 'TABELA - CONSULTAS'
         select (21)
         set order to 1
         goto top
         do co_subv
         @ 3, 60 say space (18) 
         close databases
         return
   endcase
   @ 3, 60 say w_cab 
   w_codi = 0
   w_nome = space (30)
   @ 7, 38 get w_empre picture '999'
   read
   if lastkey () = 27 .or. empty (w_empre)
      exit
   endif
   w_empresa = strzero (w_empre, 3)
   @ 7, 38 say w_empresa 
   select (20)
   goto top
   find (w_empresa)
   if eof ()
      sv1 = savescreen (24, 0, 24, 79)
      @ 24, 30 say 'EMPRESA NAO CADASTRADA' 
      tone (800, 15)
      inkey (0)
      restscreen (24, 0, 24, 79, sv1)
      release sv1
      loop
   endif
   @ 7, 42 say nome 
   @ 9, 38 get w_codi picture '999'
   read
   if lastkey () = 27 .or. empty (w_codi)
      exit
   endif
   w_codi2 = strzero (w_codi, 3)
   @ 9, 38 get w_codi2
   clear gets 
   select (21)
   goto top
   find (w_empresa + w_codi2)
   regis = recno ()
   if eof ()
      sv1 = savescreen (24, 0, 24, 79)
      @ 24, 30 say 'NAO EXISTE SUB-VERBA COM ESTE CODIGO ' 
      @ 10, 38 say nomesub 
      tone (800, 15)
      inkey (0)
      restscreen (24, 0, 24, 79, sv1)
      release sv1
      loop
   endif
   w_nome = nomesub
   if op54 = 2
      @ 11, 38 get w_nome picture '@!'
      read
   endif
   if op54 = 3
      @ 11, 38 get w_nome picture '@!'
      clear gets 
   endif
   if ! w_conf (1)
      loop
   endif
   select (21)
   goto regis
   if op54 = 2
      replace empresa4 with w_empresa
      replace codi with w_codi2
      replace nomesub with w_nome
      commit
   endif
   if op54 = 3
      delete
   endif
enddo
@ 3, 60 say space (18) 
close databases
return

function tela502        
@ 5, 1 clear to 22, 78
@ 7, 18 say 'Empresa' 
@ 9, 18 say 'Codigo' 
@ 11, 18 say 'Conta' 
@ 13, 18 say 'Nome' 
w_men = '[ESC] - Encerrar'
imp_mens (w_men, 2)
return .t.

function tela503        
@ 5, 1 clear to 22, 78
@ 7, 18 say 'CODIGO' 
@ 9, 18 say 'NOME' 
w_men = '[ESC] - Encerrar'
imp_mens (w_men, 2)
return .t.

function tela504        
@ 5, 1 clear to 22, 78
@ 7, 18 say 'COD.VERBA .......:' 
@ 9, 18 say 'COD.SUB-VERBA ...:' 
@ 11, 18 say 'NOME SUB-VERBA ..:' 
w_men = '[ESC] - Encerrar'
imp_mens (w_men, 2)
return .t.

procedure sca006        
procedure scatel06      
do while .t.
   @ 5, 1 clear to 22, 77
   set message to 22 center
   w_men = '*** M A N U T E N C A O ***'
   @ 6, centra (w_men) say w_men 
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   @ 9, 35 prompt 'C¢pias' message 'C¢pias de Seguran‡a'
   @ 11, 35 prompt 'Restaura' message 'Recupera C¢pias'
   @ 13, 35 prompt 'Organiza' message 'Organiza Arquivos de Indices'
   menu to op06
   if lastkey () = 27
      exit
   endif
   do case
      case op06 = 1
         do pdsca601
      case op06 = 2
         do pdsca602
      case op06 = 3
         do pdsca603
   endcase
enddo
return

function pdsca601       
tela = savescreen (0, 0, 24, 79)
clear
? 'Aguarde retorno ao sistema...'
?
?
! 'PK -U A:sca *.DBF'
clear
restscreen (0, 0, 24, 79, tela)
return .t.

function pdsca602       
tela = savescreen (0, 0, 24, 79)
clear
? 'Aguarde retorno ao sistema...'
?
?
! 'PX -R A:sca *.DBF'
clear
restscreen (0, 0, 24, 79, tela)


pdsca603 ()
return .t.

function pdsca603       
@ 5, 1 clear to 22, 78
@ 3, 52 say '         ORGANIZA - INDEXA' 
w_men = ' Aguarde. Reorganizando arquivos de indices '
set color to n/w*
@ 12, centra (w_men) say w_men 
setcolor (cores)
use adsca001
pack
index on empresa+matricula+ccusto to aisca001
index on empresa+nome to aisca101
index on matricula to aisca102

use adsca002
pack
index on empresa+matricula+verba+subverba to aisca002
index on verba+subverba+empresa+matricula to aisca022

use scadbf
pack
index on matricula+empresa to scadbf

use tabsca01
index on codigo to tabsca01

select (2)
use tabsca02
index on empresa+codigo to tabsca02

use tabsca03
index on empresa to tabsca03

use tabsca04
index on empresa4+codi to tabsca04

inkey (0.5)

close all
@ 3, 52 say space (26) 
return .t.

procedure pdsca205      
@ 5, 1 clear to 22, 78
@ 3, 52 say '      Reajuste' 
cores = setcolor ()
w_men = 'Informe Percentual de aumento. Exemplo: 50%'
@ 24, centra (w_men) say w_men 
percent = 0
@ 13, 10 say 'Informe Percentual de Aumento: 999.99  % ' 
@ 13, 41 get percent picture '999.99'
read
if lastkey () = 27
   return
endif
valor = percent / 100
tone (999, 2)
@ 20, 1 clear to 19, 77
resp = ' '
@ 19, 10 say 'Confirma Reajuste de Mensalidades <S/N>?' get resp valid RESP$'SN' 
read
if resp = 'N'
   return
endif
@ 19, 1 clear to 19, 78
@ 24, 1 clear to 24, 78
w_men = 'Aguarde Final de Processamento...'
@ 24, centra (w_men) say w_men 

select (2)
use adsca002 index aisca002
delete all for verba = '001'
reindex
goto top

select (1)
use adsca001 index aisca001
goto top

@ 17, 5 to 21, 70
@ 19, 10 say 'MATRICULA: ' 
do while ! eof ()
   emp = empresa
   mat = matricula
   @ 19, 21 say matricula + ' - ' + nome 
   valeant = mensal
   valeper = valeant * valor
   valenov = valeant + valeper
   replace mensal with valenov
   select (2)
   append blank 
   replace empresa with emp
   replace matricula with mat
   replace verba with '001'
   replace valor with valenov
   select (1)
   skip 1
enddo
close databases
return

*****************
procedure co_subv
*****************       
private campo [3]
campo [1] = 'EMPRESA4'
campo [2] = 'CODI'
campo [3] = 'NOMESUB'
private masca [3]
masca [1] = '@X'
masca [2] = '@X'
masca [3] = '@X'

private cabeca [3]
cabeca [1] = ' VERBA '
cabeca [2] = ' SUB-VERBA '
cabeca [3] = ' DESCRICAO '

@ 5, 2 to 21, 70 double
@ 19, 3 to 19, 69
@ 20, 6 say '                     <F2>=PROCURA ' 
dbedit (6, 3, 18, 69, campo, 'FUNMED', masca, cabeca)
return

function funmed         
parameters mode, counter
do case
   case mode = 0
      return 1
   case mode = 1
      tone (800, 5)
      return 1
   case mode = 2
      tone (800, 5)
      return 1
   case mode = 3
      tone (800, 5)
      return 0
   case lastkey () = 27
      set order to 1
      goto top
      saidb2 = .t.
      return 0
   case lastkey () = -1
      regis = recno ()
      tela = savescreen (21, 48, 23, 75)
      con = 0
      @ 22, 50 say ' VERBA ' get con picture '@R 999'
      read
      restscreen (21, 48, 23, 75, tela)
      if lastkey () = 27
         return 1
      endif
      find (strzero (con, 3))
      return 1
   otherwise
      return 1
endcase

procedure pdsca402      
do relcon
return


Procedure pdsca405
public w_pag, w_lin1, w_lin2, nomeemp, w_mes
select (5)
use tabsca04 index tabsca04
select (4)
use tabsca03 index tabsca03
select (3)
use tabsca01 index tabsca01
select (2)
use adsca001 index aisca001, aisca101
set filter to ativo
select (1)
use adsca002 index aisca002
do while .t.
   goto top
   @ 5, 1 clear to 22, 77
   @ 3, 52 clear to 3, 77
   @ 3, 62 say 'Rotina: '+PROCNAME()
   w_men = '[ESC] - Encerrar  relatorio'
   imp_mens (w_men, 2)
   w_mes = 0
   @ 12, 25 say 'Digite o mes para relatorio ' get w_mes picture '99' valid w_mes>0 .and.w_mes<13 
   read
   if lastkey () = 27
      exit
   endif
   goto top
   @ 5, 1 clear to 22, 77
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   w_emp1 = 0
   w_emp2 = 0
   @ 12, 20 to 18, 60
   @ 14, 22 say 'Digite Intervalo de Empresas a emitir' 
   @ 16, 35 get w_emp1 picture '99'
   @ 16, 45 get w_emp2 picture '99'
   read
   if lastkey () = 27
      exit
   endif
   @ 13, 21 clear to 17, 59
   w_ord = 'M'
   @ 14, 27 say ' [M] Matricula / [N] Nome ' 
   @ 16, 41 get w_ord picture '!' valid w_ord$"MN" 
   read
   if lastkey () = 27
      exit
   endif
   select (2)
   if w_ord = 'M'
      set order to 1
   else 
      set order to 2
   endif
   @ 13, 21 clear to 17, 59
   w_com = 'N'
   @ 14, 27 say ' [C] Comprimido / [N] Normal ' 
   @ 16, 41 get w_com picture '!' valid w_com$"CN" 
   read
   if lastkey () = 27
      exit
   endif
   if w_com = 'C'
      set device to printer
      set print on
      @ prow (), pcol () say chr (30) + '5' 
      set print off
      set device to screen
   else 
      set device to printer
      set print on
      @ prow (), pcol () say chr (30) + '0' 
      set print off
      set device to screen
   endif
   @ 13, 21 clear to 17, 59
   @ 15, 22 say 'Emissao em andamento. [I] Interrompe ' 
   imp_mens (' ', 2)
   w_emp1 = strzero (w_emp1, 2)
   if w_seek (w_emp1, '3', 2)
      loop
   endif
   w_emp2 = strzero (w_emp2, 2)
   if w_seek (w_emp2, '3', 2)
      loop
   endif
   select (2)
   find (w_emp1)
   if ! found ()
      w_men = 'Nao existem Associados na empresa ' + w_emp1
      imp_mens (w_men, 1)
      loop
   endif
   w_pag = 0
   w_tot = 0
   w_func = 0
   s_men = 0
   s_far = 0
   s_col = 0
   s_emp = 0
   s_oti = 0
   s_cre = 0
   s_bou = 0
   s_des = 0
   s_tot = 0
   w_lin1 = replicate ('-', 150)
   w_lin2 = replicate ('=', 150)
   set device to printer
   w_cl = 56
   do while ! eof () .and. empresa >= w_emp1 .and. empresa <= w_emp2
      g_emp = empresa
      select (3)
      find (g_emp)
      nomeemp = nome
      select (2)
      do while ! eof () .and. empresa >= w_emp1 .and. empresa <= w_emp2 .and. g_emp = empresa
         if w_cl > 56
            do cabeca01
            w_cl = 8
         endif
         if inkey () = 73 .or. inkey () = 105
            set device to screen
            w_men = 'Interrompido! Continua? (S/N) '
            imp_mens (w_men, 1)
            if lastkey () = 78 .or. lastkey () = 110
               goto bottom
               skip 1
               set device to printer
               loop
            endif
            set device to printer
         endif
         select (2)
         w_ch = g_emp + matricula
         select (1)
         find (w_ch)
         if ! found ()
            select (2)
            skip 1
            loop
         endif
         select (2)
         matfun = matricula
         nomfun = nome
         @ w_cl, 2 say matricula 
         @ w_cl, 12 say nome 
         select (1)
         tot_v = 0
         tot_d = 0
         do while ! eof () .and. g_emp = empresa .and. w_ch = g_emp + matricula
            impri = .f.
            if w_cl > 56
               impri = .t.
               do cabeca01
               w_cl = 8
            endif
            g_veb = verba
            select (4)
            find (g_veb)
            g_nom = nome
            select (1)
            if refer != 0
               crefere = parcelas - refer + 1
               crefere = str (crefere, 1) + '/' + str (parcelas, 1)
            else 
               crefere = ' '
            endif
            if impri
               @ w_cl, 2 say matfun 
               @ w_cl, 12 say nomfun + ' (continuacao)' 
            endif
            @ w_cl, 70 say verba 
            @ w_cl, 74 say g_nom 
            @ w_cl, 109 say valor picture '9,999,999,999.99' 
            @ w_cl, 132 say crefere 
            if verba > '099'
               tot_d = tot_d + valor
            else 
               tot_v = tot_v + valor
            endif
            skip 1
            w_cl = w_cl + 1
         enddo
         if tot_d != 0 .or. tot_v != 0
            @ w_cl, 109 say tot_v - tot_d picture '----------------' 
            w_cl = w_cl + 1
            @ w_cl, 70 say '999' 
            @ w_cl, 74 say 'Total do Desconto ---> ' 
            @ w_cl, 109 say tot_v - tot_d picture '9,999,999,999.99' 
            w_cl = w_cl + 1
         endif
         w_cl = w_cl + 1
         select (2)
         skip 1
      enddo
   enddo
   set device to screen
   set device to printer
   set print on
   @ prow (), pcol () say chr (30) + '0' 
   set print off
   set device to screen
enddo
close all
return

procedure sca0042       
save screen to telag
@ 5, 2 clear to 20, 77
select (6)
use sca10 alias vtotais
index on c10mesano+c10verba to sca10n
select (4)
use tabsca03 index tabsca03
goto top
w_emp1 = empresa
goto bottom
w_emp2 = empresa
goto top
select (3)
use tabsca01 index tabsca01
goto top
w_em1 = codigo
goto bottom
w_em2 = codigo
goto top
select (2)
use adsca001 index aisca001
set filter to ativo
select (1)
use adsca002
index on empresa+verba+matricula to aiscatmp
tone (999, 2)
resp = ' '
@ 9, 15 say 'Deseja Somente Imprimir <S/N>' get resp valid RESP$'SN' 
read
if resp = 'S'
   mesano = space (4)
   @ 12, 30 say 'Mes e Ano: ' get mesano picture '@R 99/99'
   read
   datav = mesano
   if lastkey () = 27
      return
   endif
else 
   datav = substr (dtoc (date ()), 4, 2) + substr (dtoc (date ()), 7, 2)
   mesano = datav
endif
@ 6, 3 clear to 20, 78
@ 12, 28 say 'A G U A R D E . . .' 
if resp = 'N'
   do while .t.
      goto top
      @ 5, 1 clear to 22, 77
      w_men = '[ESC] - Encerrar'
      imp_mens (w_men, 2)
      w_men = 'Relatorios - Controle Geral de Pagamentos'
      @ 8, centra (w_men) say w_men 
      @ 5, 1 clear to 22, 77
      w_men = '[ESC] - Encerrar'
      imp_mens (w_men, 2)
      @ 12, 20 to 18, 60
      if lastkey () = 27
         exit
      endif
      @ 5, 1 clear to 22, 77
      w_men = '[ESC] - Encerrar'
      imp_mens (w_men, 2)
      @ 12, 20 to 18, 60
      if lastkey () = 27
         exit
      endif
      @ 13, 21 clear to 17, 59
      @ 15, 22 say '       Aguarde Processamento... ' 
      imp_mens (' ', 2)
      if w_seek (w_emp1, '4', 2)
         loop
      endif
      if w_seek (w_emp2, '4', 2)
         loop
      endif
      if w_seek (w_em1, '3', 2)
         loop
      endif
      if w_seek (w_em2, '3', 2)
         loop
      endif
      select (1)
      find (w_em1 + w_emp1)
      if ! found ()
         w_men = 'Nao existem Verbas no movimento da empresa ' + w_em1
         imp_mens (w_men, 1)
         loop
      endif
      w_tot = 0
      e_tot = 0
      do while ! eof () .and. empresa >= w_em1 .and. empresa <= w_em2
         g_emp = empresa
         select (3)
         find (g_emp)
         select (1)
         do while ! eof () .and. empresa >= w_em1 .and. empresa <= w_em2 .and. g_emp = empresa
            g_cod = verba
            do while ! eof () .and. empresa >= w_em1 .and. empresa <= w_em2 .and. g_emp = empresa .and. g_cod = verba
               w_ch = g_emp + matricula
               select (2)
               find (w_ch)
               if ! found ()
                  select (1)
                  skip 1
                  loop
               endif
               select (1)
               w_tot = w_tot + valor
               skip 1
            enddo
            select vtotais
            goto top
            find (datav + g_cod)
            if eof ()
               append blank 
               replace c10mesano with datav, c10verba with g_cod
            endif
            if g_emp = '03'
               replace c10casa with w_tot
            elseif g_emp = '04'
               replace c10barra with w_tot
            elseif g_emp = '05'
               replace c10para with w_tot
            elseif g_emp = '06'
               replace c10cent with w_tot
            elseif g_emp = '07'
               replace c10dist with w_tot
            elseif g_emp = '08'
               replace c10coz1 with w_tot
            elseif g_emp = '15'
               replace c10coz2 with w_tot
            elseif g_emp = '16'
               replace c10sca with w_tot
            elseif g_emp = '09'
               replace c10crat with w_tot
            elseif g_emp = '10'
               replace c10juaz with w_tot
            elseif g_emp = '11'
               replace c10sobr with w_tot
            elseif g_emp = '12'
               replace c10mara with w_tot
            elseif g_emp = '13'
               replace c10arac with w_tot
            elseif g_emp = '14'
               replace c10camo with w_tot
            endif
            select (1)
            e_tot = e_tot + w_tot
            w_tot = 0
         enddo
      enddo
      exit
   enddo
endif
*
M->SAI_DA="S"
M->TIPO_PRN="I"
IF .NOT. MENU_PRN("RELAT_01")
   restore screen from telag
   RETURN
ENDIF
*
set device to printer
@ prow (), pcol () say chr (15) 
@ prow (), pcol () say ' ' 
select vtotais
goto top
find (datav)
lin = 61
pag = 0
store 0 to t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15
store 0 to d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15
do while c10mesano = datav .and. ! eof ()
   verba = c10verba
   select (4)
   goto top
   find (verba)
   descve = nome
   select vtotais
   do while c10verba = verba .and. ! eof ()
      if lin > 60
         do cabger
         lin = 6
      endif
      @ lin, 0 say substr (descve, 1, 15) 
      @ lin, 17 say c10casa picture '@E 9,999,999.99' 
      @ lin, 31 say c10barra picture '@E 9,999,999.99' 
      @ lin, 45 say c10para picture '@E 9,999,999.99' 
      @ lin, 59 say c10cent picture '@E 9,999,999.99' 
      @ lin, 73 say c10dist picture '@E 9,999,999.99' 
      @ lin, 87 say c10coz1 picture '@E 9,999,999.99' 
      @ lin, 101 say c10coz2 picture '@E 9,999,999.99' 
      @ lin, 115 say c10crat picture '@E 9,999,999.99' 
      @ lin, 129 say c10juaz picture '@E 9,999,999.99' 
      @ lin, 143 say c10sobr picture '@E 9,999,999.99' 
      @ lin, 157 say c10mara picture '@E 9,999,999.99' 
      @ lin, 171 say c10arac picture '@E 9,999,999.99' 
      @ lin, 185 say c10camo picture '@E 9,999,999.99' 
      @ lin, 199 say c10sca picture '@E 9,999,999.99' 
      vt = c10casa + c10barra + c10para + c10cent + c10dist + c10coz1 + c10coz2 + c10crat + c10juaz + c10sobr + c10mara + c10arac + c10camo + c10sca
      @ lin, 218 say vt picture '@E 9,999,999.99' 
      lin = lin + 2
      if val (verba) < 100
         t1 = t1 + c10casa
         t2 = t2 + c10barra
         t3 = t3 + c10para
         t4 = t4 + c10cent
         t5 = t5 + c10dist
         t6 = t6 + c10coz1
         t7 = t7 + c10coz2
         t8 = t8 + c10crat
         t9 = t9 + c10juaz
         t10 = t10 + c10sobr
         t11 = t11 + c10mara
         t12 = t12 + c10arac
         t13 = t13 + c10camo
         t14 = t14 + vt
         t15 = t15 + c10sca
      else 
         d1 = d1 + c10casa
         d2 = d2 + c10barra
         d3 = d3 + c10para
         d4 = d4 + c10cent
         d5 = d5 + c10dist
         d6 = d6 + c10coz1
         d7 = d7 + c10coz2
         d8 = d8 + c10crat
         d9 = d9 + c10juaz
         d10 = d10 + c10sobr
         d11 = d11 + c10mara
         d12 = d12 + c10arac
         d13 = d13 + c10camo
         d14 = d14 + vt
         d15 = d15 + c10sca
      endif
      skip 1
   enddo
enddo
@ lin, 0 say replicate ('-', 232) 
lin = lin + 1
@ lin, 0 say 'T O T A I S -->' 
@ lin, 17 say t1 - d1 picture '@E 9,999,999.99' 
@ lin, 31 say t2 - d2 picture '@E 9,999,999.99' 
@ lin, 45 say t3 - d3 picture '@E 9,999,999.99' 
@ lin, 59 say t4 - d4 picture '@E 9,999,999.99' 
@ lin, 73 say t5 - d5 picture '@E 9,999,999.99' 
@ lin, 87 say t6 - d6 picture '@E 9,999,999.99' 
@ lin, 101 say t7 - d7 picture '@E 9,999,999.99' 
@ lin, 115 say t8 - d8 picture '@E 9,999,999.99' 
@ lin, 129 say t9 - d9 picture '@E 9,999,999.99' 
@ lin, 143 say t10 - d10 picture '@E 9,999,999.99' 
@ lin, 157 say t11 - d11 picture '@E 9,999,999.99' 
@ lin, 171 say t12 - d12 picture '@E 9,999,999.99' 
@ lin, 185 say t13 - d13 picture '@E 9,999,999.99' 
@ lin, 199 say t15 - d15 picture '@E 9,999,999.99' 
@ lin, 216 say t14 - d14 picture '@E 999,999,999.99' 
lin = lin + 1
@ lin, 0 say replicate ('-', 232) 
@ 0, 0 say ' '
close databases
*
set device to screen
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("RELAT_01", 240,  0)
ENDIF
*
@ 0, 0 say chr (18)
restore screen from telag
return
*****************************

procedure cabger
mes = substr (mesano, 1, 2)
if mes = '01'
   dmes = 'JANEIRO'
elseif mes = '02'
   dmes = 'FEVEREIRO'
elseif mes = '03'
   dmes = 'MARCO'
elseif mes = '04'
   dmes = 'ABRIL'
elseif mes = '05'
   dmes = 'MAIO'
elseif mes = '06'
   dmes = 'JUNHO'
elseif mes = '07'
   dmes = 'JULHO'
elseif mes = '08'
   dmes = 'AGOSTO'
elseif mes = '09'
   dmes = 'SETEMBRO'
elseif mes = '10'
   dmes = 'OUTUBRO'
elseif mes = '11'
   dmes = 'NOVEMBRO'
elseif mes = '12'
   dmes = 'DEZEMBRO'
elseif .t.
   dmes = ' '
endif
@ 0, 0 say 'ASSOCIACAO DOS SERVIDORES DO SESI/DR/CE' 
@ 0, 218 say 'DATA:' + dtoc (date ()) 
@ 1, 0 say 'CONTROLE GERAL DE PAGAMENTOS                                                             MES: ' + dmes + ' / ' + substr (mesano, 3, 2) 
pag = pag + 1
@ 1, 218 say 'PAG.:' + transform (pag, '99999999') 
@ 2, 0 say replicate ('-', 232) 
@ 3, 0 say '     VERBA    ' 
@ 3, 17 say 'CASA DA IND.' 
@ 3, 31 say 'BARRA DO CE.' 
@ 3, 45 say 'PARANGABA  ' 
@ 3, 59 say 'CAT CENTRAL' 
@ 3, 73 say 'DIST. INDUS.' 
@ 3, 87 say 'COZ. BARRA ' 
@ 3, 101 say 'COZINHA DIS.' 
@ 3, 115 say 'CRATO ' 
@ 3, 129 say 'JUAZEIRO N.' 
@ 3, 143 say 'SOBRAL ' 
@ 3, 157 say 'MARANGUAPE' 
@ 3, 171 say 'ARACATI' 
@ 3, 185 say 'CAMOCIM' 
@ 3, 204 say 'CDA' 
@ 3, 216 say 'T O T A L' 
@ 4, 0 say replicate ('-', 232) 
return

procedure relcon        
public w_pag, w_lin1, w_lin2, nomeemp, w_mes, w_emp1, w_emp2
select (5)
use tabsca04 index tabsca04
select (4)
use tabsca03 index tabsca03
select (3)
use tabsca01 index tabsca01
select (2)
use adsca001 index aisca001, aisca101
set filter to ativo
select (1)
use adsca002 index aisca002
do while .t.
   goto top
   @ 5, 1 clear to 22, 77
   @ 3, 52 clear to 3, 77
   @ 3, 62 say 'Rotina: '+PROCNAME()
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   w_mes = 0
   @ 12, 25 say 'Digite o mes para relatorio ' get w_mes picture '99' valid w_mes>0 .and.w_mes<13 
   read
   if lastkey () = 27
      exit
   endif
   goto top
   @ 5, 1 clear to 22, 69
   w_men = '[ESC] - Encerrar'
   imp_mens (w_men, 2)
   w_emp1 = 0
   w_emp2 = 0
   @ 12, 20 to 18, 69
   @ 14, 22 say 'Digite Intervalo de Empresas a emitir' 
   @ 16, 35 get w_emp1 picture '99'
   @ 16, 45 get w_emp2 picture '99'
   read
   if lastkey () = 27
      exit
   endif
   if w_emp1 > w_emp2
      loop
   endif
   @ 13, 21 clear to 17, 59
   w_ord = 'M'
   @ 14, 27 say ' [M] Matricula / [N] Nome ' 
   @ 16, 41 get w_ord picture '!' valid w_ord$"MN" 
   read
   if lastkey () = 27
      exit
   endif
   select (2)
   if w_ord = 'M'
      set order to 1
   else 
      set order to 2
      do relcon2
      loop
   endif
   @ 13, 21 clear to 17, 59
   w_com = 'N'
   @ 14, 27 say ' [C] Comprimido / [N] Normal ' 
   @ 16, 41 get w_com picture '!' valid w_com$"CN" 
   read
   if lastkey () = 27
      exit
   endif
   if w_com = 'C'
      set device to printer
      set print on
      @ prow (), pcol () say chr (30) + '5' 
      set print off
      set device to screen
   else 
      set device to printer
      set print on
      @ prow (), pcol () say chr (30) + '0' 
      set print off
      set device to screen
   endif
   @ 13, 21 clear to 17, 60
   @ 15, 22 say 'Emissao em andamento. [ESC] Interrompe ' 
   select (1)
   goto top
   find (strzero (w_emp1, 2))
   emp = empresa
   w_lin1 = replicate ('-', 150)
   w_lin2 = replicate ('=', 150)
   w_pag = 0
   lin = 56
   set device to printer
   w_cl = 56
   do while ! eof () .and. val (empresa) >= w_emp1 .and. val (empresa) <= w_emp2
      emp = empresa
      mat = matricula
      veb = verba
      sub = subverba
      if inkey () = 27
         set device to screen
         set device to printer
         set print on
         @ prow (), pcol () say chr (30) + '0' 
         set print off
         set device to screen
         return
      endif
      if lin >= 56
         select (3)
         goto top
         find (emp)
         nomeemp = nome
         do cabeca01
         lin = 8
      endif
      @ lin, 2 say mat 
      select (2)
      set order to 1
      goto top
      find (emp + mat)
      @ lin, 12 say nome 
      select (4)
      goto top
      find (veb)
      for i = 1 to 2
         @ lin, 60 say empresa 
         @ lin, 64 say nome 
      next
      select (1)
      veb2 = veb
      sub2 = sub
      total = 0
      do while empresa = emp .and. matricula = mat
         veb = verba
         sub = subverba
         if refer != 0
            crefere = parcelas - refer + 1
            crefere = strzero(crefere, 2) + '/' + str (parcelas, 2)
         else 
            crefere = ' '
         endif
         total2 = valor
         if lin >= 56
            select (3)
            goto top
            find (emp)
            nomeemp = nome
            do cabeca01
            lin = 8
         endif
         if veb2 != veb
            veb2 = veb
            select (4)
            goto top
            find (veb)
            for i = 1 to 2
               @ lin, 60 say empresa 
               @ lin, 64 say nome 
            next
         endif
         select (5)
         find (veb + sub)
         if eof ()
            @ lin, 84 say 'DIVERSOS' 
         else 
            @ lin, 84 say nomesub 
         endif
         @ lin, 118 say total2 picture '@E 999,999.99' 
         @ lin, 132 say crefere 
         if veb = '100' .and. sub = '001'
            total = total - total2
         else 
            total = total + total2
         endif
         lin = lin + 1
         select (1)
         skip 1
      enddo
      @ lin, 100 say replicate ('-', 30) 
      lin = lin + 1
      @ lin, 73 say 'Total do Desconto -->' 
      @ lin, 118 say total picture '@E 999,999.99' 
      lin = lin + 2
      eject
   enddo
   set device to screen
   set device to printer
   set print on
   @ prow (), pcol () say chr (30) + '0' 
   set print off
   set device to screen
enddo
close all
return

procedure cabeca01      
w_pag = w_pag + 1
@ 0, 0 say 'Associacao do Servidores do SESI/DR/CE' 
@ 0, 114 say 'Pagina: ' + str (w_pag, 9) 
@ 1, 0 say 'Controle Mensal de Pagamentos - ' + w_meses (w_mes) 
@ 1, 112 say 'Emissao: ' + dtoc (date ()) 
@ 3, 0 say w_lin1 
@ 4, 0 say 'Empresa: ' + nomeemp 
@ 5, 0 say w_lin1 
@ 6, 0 say 'MATRICULA' 
@ 6, 12 say 'NOME DO ASSOCIADO' 
@ 6, 60 say 'COD VERBAS' 
@ 6, 118 say 'VALORES' 
@ 6, 132 say 'PARC.' 
@ 7, 0 say w_lin1 
return
procedure relcon2       
select (2)
goto top
set order to 2
@ 13, 21 clear to 17, 59
w_com = 'N'
@ 14, 27 say ' [C] Comprimido / [N] Normal ' 
@ 16, 41 get w_com picture '!' valid w_com$"CN" 
read
if lastkey () = 27
   return
endif
if w_com = 'C'
   impe = chr (15)
   @ 13, 21 clear to 17, 60
   @ 15, 22 say 'Emissao em andamento. [ESC] Interrompe ' 
else 
   impe = chr (18)
   @ 13, 21 clear to 17, 60
   @ 15, 22 say 'Emissao em andamento. [ESC] Interrompe ' 
endif
select (2)
goto top
find (strzero (w_emp1, 2))
emp = empresa
w_lin1 = replicate ('-', 150)
w_lin2 = replicate ('=', 150)
w_pag = 0
lin = 56
set device to printer
w_cl = 56
do while ! eof () .and. val (empresa) >= w_emp1 .and. val (empresa) <= w_emp2
   emp = empresa
   mat = matricula
   nom = nome
   if inkey () = 27
      set device to screen
      set device to printer
      set print on
      @ prow (), pcol () say chr (30) + '0' 
      set print off
      set device to screen
      return
   endif
   if lin >= 56
      select (3)
      goto top
      find (emp)
      nomeemp = nome
      do cab02
      lin = 8
   endif
   select (1)
   goto top
   find (emp + mat)
   if eof ()
      select (2)
      skip 1
      loop
   endif
   veb = verba
   sub = subverba
   @ lin, 0 say nom 
   @ lin, 43 say mat 
   select (4)
   goto top
   find (veb)
   for i = 1 to 2
      @ lin, 60 say empresa 
      @ lin, 64 say nome 
   next

   select (1)
   veb2 = veb
   sub2 = sub
   total = 0
   do while empresa = emp .and. matricula = mat
      veb = verba
      sub = subverba
      if refer != 0
         crefere = parcelas - refer + 1
         crefere = str (crefere, 1) + '/' + str (parcelas, 1)
      else 
         crefere = ' '
      endif
      total2 = valor
      if lin >= 56
         select (3)
         goto top
         find (emp)
         nomeemp = nome
         do cab02
         lin = 8
      endif
      if veb2 != veb
         veb2 = veb
         select (4)
         goto top
         find (veb)

         for i = 1 to 2
            @ lin, 60 say empresa 
            @ lin, 64 say nome 
         next
      endif
      select (5)
      find (veb + sub)
      if eof ()
         @ lin, 96 say 'DIVERSOS' 
      else 
         @ lin, 96 say nomesub 
      endif
      @ lin, 118 say total2 picture '@E 999,999.99' 
      @ lin, 132 say crefere 
      if veb = '100' .and. sub = '001'
         total = total - total2
      else 
         total = total + total2
      endif
      lin = lin + 1
      select (1)
      skip 1
   enddo
   @ lin, 104 say replicate ('-', 23) 
   lin = lin + 1
   @ lin, 73 say 'Total do Desconto -->' 
   @ lin, 118 say total picture '@E 999,999.99' 
   lin = lin + 2
   select (2)
   skip 1
enddo
set device to screen
set device to printer
set print on
@ prow (), pcol () say chr (30) + '0' 
set print off
set device to screen
return

procedure cab02         
w_pag = w_pag + 1
lin = 0
@ 0, 0 say impe 
@ 0, 0 say CHR(27)+'(s13H'+'Associacao do Servidores do SESI/DR/CE' 
@ 0, 114 say 'Pagina: ' + str (w_pag, 9) 
@ 1, 0 say 'Controle Mensal de Pagamentos - ' + w_meses (w_mes) 
@ 1, 112 say 'Emissao: ' + dtoc (date ()) 
@ 3, 0 say w_lin1 
@ 4, 0 say 'Empresa: ' + nomeemp 
@ 5, 0 say w_lin1 
@ 6, 0 say 'NOME DO ASSOCIADO' 
@ 6, 40 say 'MATRICULA' 
@ 6, 60 say 'COD VERBAS' 
@ 6, 118 say 'VALORES' 
@ 6, 132 say 'PARC.' 
@ 7, 0 say w_lin1 
return


function calcu          
c_cor = setcolor ()
ca_tela = savescreen (5, 3, 19, 29)
set cursor off
set color to /bg
@ 6, 4 clear to 18, 28
set color to w/bg
@ 7, 5 say replicate (chr (220), 23) 
@ 8, 5 say chr (219) + space (21) + chr (219) 
@ 9, 5 say replicate (chr (223), 23) 
set color to /w
@ 5, 3 to 19, 29 double
@ 11, 5 say ' 7 ' 
@ 11, 10 say ' 8 ' 
@ 11, 15 say ' 9 ' 
@ 13, 15 say ' 4 ' 
@ 13, 10 say ' 5 ' 
@ 13, 5 say ' 6 ' 
@ 15, 5 say ' 1 ' 
@ 15, 10 say ' 2 ' 
@ 15, 15 say ' 3 ' 
@ 17, 5 say '  0  ' 
@ 17, 13 say '  .  ' 
set color to w/b
@ 11, 20 say ' - ' 
@ 17, 25 say ' % ' 
@ 13, 20 say ' + ' 
@ 13, 25 say ' * ' 
@ 15, 25 say ' / ' 
set color to w/r
@ 15, 20 say chr (17) + chr (196) + chr (217) 
@ 16, 20 say '   ' 
@ 17, 20 say ' = ' 
@ 11, 25 say 'C/E' 
set color to w
c_result = 0
c_alga = space (14)
c_dec = ''
c_dig = chr (0)
c_var = 'C_ALGA'
c_verdad = .f.
set color to w
@ 8, 6 say ' ' + str (c_result, 19, 4) + ' ' 
c_uoper = ''
c_perc = ' '
do while c_dig != chr (27)
   c_dig = chr (inkey (0))
   if c_dig = chr (27)
      set cursor on
      exit
   endif
   c_var = iif (c_dig = '.', 'C_DEC', c_var)
   c_alga = iif (c_dig = '.' .and. c_alga = space (14), space (13) + '0', c_alga)
   if c_dig = '%'
      if c_verdad
         c_perc = iif (c_perc = '%', ' ', '%')
         set color to /w
         @ 7, 27 say c_perc 
         set color to w
      else 
         @ 8, 7 say space (13) + '0.0000' 
      endif
   elseif c_dig $ '0123456789' .and. len (ltrim (&c_var)) != iif (c_var = 'C_DEC', 4, 14)
      &c_var = iif (c_var = 'C_DEC', &c_var + c_dig, substr (&c_var + c_dig, 2))
      @ 8, 7 say c_alga + '.' + substr (c_dec + substr ('00000', len (c_dec) + 1), 1, 4) 
      c_verdad = iif (c_verdad .and. c_uoper $ '=' + chr (13), .f., c_verdad)
   elseif c_dig $ '+-/*=' + chr (13)
      if c_verdad
         if val (c_alga + '.' + c_dec) != 0
            if c_perc = '%'
               ope_ra = str (c_result, 19, 4) + c_uoper + '(' + str (c_result, 19, 4) + '*' + c_alga + '.' + substr (c_dec + substr ('00000', len (c_dec) + 1), 1, 4) + ')/100.000'
            else 
               ope_ra = str (c_result, 19, 4) + c_uoper + c_alga + '.' + substr (c_dec + substr ('00000', len (c_dec) + 1), 1, 4)
            endif
            c_result = &ope_ra
            if lennum (c_result) > 19
               set color to n/w
               @ 8, 5 say ' ' 
               @ 8, 27 say ' ' 
               set color to w
               tone (800, 5)
               @ 8, 47 say '   E   R   R   O   ' 
               tone (800, 5)
               set console off
               wait
               set console on
               c_var = 'C_ALGA'
               c_alga = space (14)
               c_dec = ''
               c_perc = ' '
               c_verdad = .f.
               @ 8, 7 say space (13) + '0.0000' 
               c_dig = 'E'
            else 
               @ 8, 7 say str (c_result, 19, 4) 
            endif
         endif
      elseif c_dig $ '+-/*'
         c_verdad = .t.
         c_result = val (c_alga + '.' + c_dec)
      endif
      set color to n/w
      @ 8, 5 say iif (c_dig $ '+-/*', c_dig, ' ') 
      @ 8, 27 say ' ' 
      set color to w
      c_var = 'C_ALGA'
      c_alga = space (14)
      c_dec = ''
      c_uoper = c_dig
      c_perc = ' '
   elseif c_dig $ 'EeCc'
      c_var = 'C_ALGA'
      c_alga = space (14)
      c_dec = ''
      c_perc = ' '
      if c_dig $ 'Cc'
         c_verdad = .f.
         set color to n/w
         @ 8, 5 say ' ' 
         @ 8, 27 say ' ' 
         set color to w
      endif
      @ 8, 7 say space (13) + '0.0000' 
   endif
enddo
setcolor (c_cor)
restscreen (5, 3, 19, 29, ca_tela)
set cursor on
return .t.


Function ConfTela()  // ajusta tamanho da tela
 
 Local nWidth := Hb_GtInfo(HB_GTI_DESKTOPWIDTH)
 Local nHeight := Hb_GtInfo(HB_GTI_DESKTOPHEIGHT)
  
 If nWidth = 1024 .And. nHeight = 768
  Wvt_SetFont( "Lucida Console", 28, 12, 0 )
  Wvt_SetFont( "Lucida Console", 28, 12, 0 )
  
 ElseIf nWidth = 1152 .And. nHeight = 864
  Wvt_SetFont( "Lucida Console", 31, 13, 0 )
  Wvt_SetFont( "Lucida Console", 31, 13, 0 )
 
 ElseIf nWidth = 1280 .And. nHeight = 600
  Wvt_SetFont( "Lucida Console", 21, 15, 0 )
  Wvt_SetFont( "Lucida Console", 21, 15, 0 )
 
 ElseIf nWidth = 1280 .And. nHeight = 720
  Wvt_SetFont( "Lucida Console", 26, 15, 0 )
  Wvt_SetFont( "Lucida Console", 26, 15, 0 )
 
 ElseIf nWidth = 1280 .And. nHeight = 768
  Wvt_SetFont( "Lucida Console", 28, 15, 0 )
  Wvt_SetFont( "Lucida Console", 28, 15, 0 )
 
 ElseIf nWidth = 1280 .And. nHeight = 960
  Wvt_SetFont( "Lucida Console", 35, 15, 0 )
  Wvt_SetFont( "Lucida Console", 35, 15, 0 )
 
 ElseIf nWidth = 1280 .And. nHeight = 1024
  Wvt_SetFont( "Lucida Console", 38, 15, 0 )
  Wvt_SetFont( "Lucida Console", 38, 15, 0 )
 
 ElseIf nWidth = 1400 .And. nHeight = 1050
  Wvt_SetFont( "Lucida Console", 39, 16, 0 )
  Wvt_SetFont( "Lucida Console", 39, 16, 0 )
  
 Else  // se nenhuma anterior, seta padrao
  Wvt_SetFont( "Lucida Console", 28, 12, 0 )
  Wvt_SetFont( "Lucida Console", 28, 12, 0 )
 EndIf
  
 Wvt_Maximize()
 
Return Nil

*********************************************
