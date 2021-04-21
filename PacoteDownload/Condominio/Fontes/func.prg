function centra         
parameters tam
w_tam = int ((80 - len (tam)) / 2)
return w_tam

function centra_imp     
parameters tam
w_tam = int ((132 - len (tam)) / 2)
@ 24, 0
return w_tam

function imp_mens       
parameters mens, beep
set color to w/g+
@ 24, centra (mens) say mens 
if beep = 1
   ?? chr (7)
   inkey (0)
   @ 24, 0 
endif
setcolor (cores)
return .t.

function dia            
parameters data
do case
   case dow (data) = 1
      dia = 'Domingo'
   case dow (data) = 2
      dia = 'Segunda'
   case dow (data) = 3
      dia = '  Ter‡a'
   case dow (data) = 4
      dia = ' Quarta'
   case dow (data) = 5
      dia = ' Quinta'
   case dow (data) = 6
      dia = '  Sexta'
   case dow (data) = 7
      dia = ' S bado'
endcase
return dia

function w_inter        
parameters w_int
set cursor on
if w_int = 73 .or. w_int = 105
   set device to screen
   sim = 'S'
   ?? chr (7)
   @ 12, 18 say 'Processamento Interrompido. Continua? (S/N)' get sim picture '!' valid (sim$"SN") 
   read
   if sim = 'N'
      set console on
      return .t.
   else 
      w_men = '[I] Interrompe Emissao'
      imp_mens (w_men, 2)
      @ 12, 22 say 'Emissao em andamento...' 
      set cursor off
      set device to printer
      return .f.
   endif
endif

function pri_lin        
parameters item
private item
@ 7, 1 clear to 22, 78
@ li [item], ci [item] to lf [item], cf [item] double
op_sec = achoice (li [item] + 1, ci [item] + 1, lf [item] - 1, cf [item] - 1, &vetor, .t., 'FUNC_AC', elemento, posicao)
if op_sec != 0
   set color to n/w+
   @ row (), col () say &vetor [op_sec] 
   setcolor (cores)
endif
return lastkey ()

function func_ac        
parameters modo, elem, posi
private modo, elem, posi
if lastkey () = 27
   return 0
elseif lastkey () = 13
   op_sec = elem
   return 1
elseif lastkey () = 4 .or. lastkey () = 54
   op_pri = op_pri + 1
   op_pri = iif (op_pri = 5, 1, op_pri)
   op = str (op_pri, 1, 0)
   vetor = 'TELA' + op
   return 1
elseif lastkey () = 19 .or. lastkey () = 52
   op_pri = op_pri - 1
   op_pri = iif (op_pri = 0, 4, op_pri)
   op = str (op_pri, 1, 0)
   vetor = 'TELA' + op
   return 1
elseif lastkey () = 24 .or. lastkey () = 50
   if modo = 2
      elemento = 1
      posicao = 0
      return 1
   else 
      return 2
   endif
elseif lastkey () = 5 .or. lastkey () = 56
   if modo = 1
      elemento = len (&vetor)
      posicao = len (&vetor) - 1
      return 1
   else 
      return 2
   endif
else 
   return 2
endif

function w_conf         
parameters opt
set color to w/g+
w_s = 'S'
if opt = 1
   w_men = 'Confirma? (S/N) '
   @ 24, centra (w_men) say w_men get w_s picture '!' valid (w_s$"SN") 
   read
elseif opt = 2
   w_men = 'Altera? (S/N) '
   @ 24, centra (w_men) say w_men get w_s picture '!' valid (w_s$"SN") 
   read
elseif opt = 3
   w_men = 'Exclui? (S/N) '
   @ 24, centra (w_men) say w_men get w_s picture '!' valid (w_s$"SN") 
   read
elseif opt = 4
   w_men = 'Pr¢ximo? (S/N) '
   @ 24, centra (w_men) say w_men get w_s picture '!' valid (w_s$"SN") 
   read
endif
setcolor (cores)
if w_s = 'S'
   return .t.
else 
   return .f.
endif
function w_mes          
parameters mes
do case
   case mes = '01'
      return 'Janeiro'
   case mes = '02'
      return 'Fevereiro'
   case mes = '03'
      return 'Marco'
   case mes = '04'
      return 'Abril'
   case mes = '05'
      return 'Maio'
   case mes = '06'
      return 'Junho'
   case mes = '07'
      return 'Julho'
   case mes = '08'
      return 'Agosto'
   case mes = '09'
      return 'Setembro'
   case mes = '10'
      return 'Outubro'
   case mes = '11'
      return 'Novembro'
   case mes = '12'
      return 'Dezembro'
endcase

function extenso        
parameters valor
tam = lennum (valor)
n_val = str (valor, tam, 2)

do while len (n_val) / 3 != int (len (n_val) / 3)
   n_val = '0' + n_val
enddo

tam = len (n_val)
pos = at ('.', n_val)
w_cem = substr (n_val, pos + 1, 2)
w_num = substr (n_val, 1, pos - 1)
centavos = ''
w_cruz = ''
w_mil = ''
w_milhao = ''

do while len (w_num) / 3 != int (len (w_num) / 3)
   w_num = '0' + w_num
enddo
w_ct = 1
for i = 1 to len (w_num) step 3
   var = 'val' + strzero (w_ct, 2)
   &var = substr (w_num, i, 3)
   w_ct = w_ct + 1
next
j = i - 1
w_ct = 1
for i = 1 to len (w_num) step 3
   var = 'val' + strzero (w_ct, 2)
   if j < 4
      if substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) = '0'
         w_cruz = ''
      elseif substr (&var, 1, 1) = '1' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) = '0'
         w_cruz = 'cem'
      elseif substr (&var, 1, 1) != '0' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) = '0'
         w_cruz = cem [val (substr (&var, 1, 1))]
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) = '1'
         w_cruz = 'Hum'
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) != '0'
         w_cruz = uni [val (substr (&var, 3, 1))]
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) != '0' .and. substr (&var, 3, 1) = '0'
         w_cruz = dez [val (substr (&var, 2, 1))]
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) != '0' .and. substr (&var, 3, 1) != '0'
         w_cruz = iif (substr (&var, 2, 1) = '1', out [val (substr (&var, 2, 2)) - 10], dez [val (substr (&var, 2, 1))] + ' e ' + uni [val (substr (&var, 3, 1))])
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) != '1' .and. substr (&var, 3, 1) != '0'
         w_cruz = w_cruz + dez [val (substr (&var, 2, 1))]
         w_cruz = w_cruz + uni [val (substr (&var, 3, 1))]
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) != '1' .and. substr (&var, 3, 1) = '0'
         w_cruz = w_cruz + dez [val (substr (&var, 2, 1))]
      elseif substr (&var, 1, 1) != '0' .and. substr (&var, 2, 1) = '1' .and. substr (&var, 3, 1) != '0'
         w_cruz = cem [val (substr (&var, 1, 1))]
         w_cruz = w_cruz + out [val (substr (&var, 2, 2)) - 10]
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '1' .and. substr (&var, 3, 1) != '0'
         w_cruz = cem [val (substr (&var, 1, 1))]
         w_cruz = w_mil + out [val (substr (&var, 2, 2)) - 10]
      elseif substr (&var, 2, 1) != '0' .and. substr (&var, 3, 1) = '0'
         w_cruz = cem [val (substr (&var, 1, 1))] + ' e '
         w_cruz = w_cruz + dez [val (substr (&var, 2, 1))]
      elseif substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) != '0'
         w_cruz = cem [val (substr (&var, 1, 1))] + ' e '
         w_cruz = w_cruz + uni [val (substr (&var, 3, 1))]
      else 
         w_cruz = cem [val (substr (&var, 1, 1))] + ' e '
         w_cruz = w_cruz + dez [val (substr (&var, 2, 1))] + ' e '
         w_cruz = w_cruz + uni [val (substr (&var, 3, 1))]
      endif
   endif
   if j > 3 .and. j < 7
      if substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) = '0'
         w_mil = ''
      elseif substr (&var, 1, 1) = '1' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) = '0'
         w_mil = 'cem mil '
      elseif substr (&var, 1, 1) != '0' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) = '0'
         w_mil = cem [val (substr (&var, 1, 1))] + ' mil '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) = '1'
         w_mil = 'Hum mil '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) != '0'
         w_mil = uni [val (substr (&var, 3, 1))] + ' mil '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) != '0' .and. substr (&var, 3, 1) = '0'
         w_mil = dez [val (substr (&var, 2, 1))] + ' mil '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '1' .and. substr (&var, 3, 1) != '0'
         w_mil = out [val (substr (&var, 2, 2)) - 10] + ' mil '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) != '1' .and. substr (&var, 3, 1) != '0'
         w_mil = w_mil + dez [val (substr (&var, 2, 1))] + ' e '
         w_mil = w_mil + uni [val (substr (&var, 3, 1))] + ' mil '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) != '1' .and. substr (&var, 3, 1) = '0'
         w_mil = w_mil + dez [val (substr (&var, 2, 1))] + ' mil '
      elseif substr (&var, 1, 1) != '0' .and. substr (&var, 2, 1) = '1' .and. substr (&var, 3, 1) != '0'
         w_mil = cem [val (substr (&var, 1, 1))] + ' e '
         w_mil = w_mil + out [val (substr (&var, 2, 2)) - 10] + ' mil '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '1' .and. substr (&var, 3, 1) != '0'
         w_mil = cem [val (substr (&var, 1, 1))] + ' e '
         w_mil = w_mil + out [val (substr (&var, 2, 2)) - 10] + ' mil '
      elseif substr (&var, 2, 1) != '0' .and. substr (&var, 3, 1) = '0'
         w_mil = cem [val (substr (&var, 1, 1))] + ' e '
         w_mil = w_mil + dez [val (substr (&var, 2, 1))] + ' mil '
      elseif substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) != '0'
         w_mil = cem [val (substr (&var, 1, 1))] + ' e '
         w_mil = w_mil + uni [val (substr (&var, 3, 1))] + ' mil '
      else 
         w_mil = cem [val (substr (&var, 1, 1))] + ' e '
         w_mil = w_mil + dez [val (substr (&var, 2, 1))] + ' e '
         w_mil = w_mil + uni [val (substr (&var, 3, 1))] + ' mil '
      endif
   endif
   if j > 6 .and. j < 10
      if substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) = '0'
         w_milhao = ''
      elseif substr (&var, 1, 1) = '1' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) = '0'
         w_milhao = 'cem milhoes '
      elseif substr (&var, 1, 1) != '0' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) = '0'
         w_milhao = cem [val (substr (&var, 1, 1))] + ' millhoes '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) = '1'
         w_milhao = 'Hum millhao '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) != '0'
         w_milhao = uni [val (substr (&var, 3, 1))] + ' milhoes '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) != '0' .and. substr (&var, 3, 1) = '0'
         w_milhao = dez [val (substr (&var, 2, 1))] + ' milhoes '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '1' .and. substr (&var, 3, 1) != '0'
         w_milhao = out [val (substr (&var, 2, 2)) - 10] + ' millhoes '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) != '1' .and. substr (&var, 3, 1) != '0'
         w_milhao = w_milhao + dez [val (substr (&var, 2, 1))] + ' e '
         w_milhao = w_milhao + uni [val (substr (&var, 3, 1))] + ' millhoes '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) != '1' .and. substr (&var, 3, 1) = '0'
         w_milhao = w_milhao + dez [val (substr (&var, 2, 1))] + ' millhoes '
      elseif substr (&var, 1, 1) != '0' .and. substr (&var, 2, 1) = '1' .and. substr (&var, 3, 1) != '0'
         w_milhao = cem [val (substr (&var, 1, 1))] + ' e '
         w_milhao = w_milhao + out [val (substr (&var, 2, 2)) - 10] + ' millhoes '
      elseif substr (&var, 1, 1) = '0' .and. substr (&var, 2, 1) = '1' .and. substr (&var, 3, 1) != '0'
         w_milhao = cem [val (substr (&var, 1, 1))] + ' e '
         w_milhao = w_milhao + out [val (substr (&var, 2, 2)) - 10] + ' millhoes '
      elseif substr (&var, 2, 1) != '0' .and. substr (&var, 3, 1) = '0'
         w_milhao = cem [val (substr (&var, 1, 1))] + ' e '
         w_milhao = w_milhao + dez [val (substr (&var, 2, 1))] + ' millhoes '
      elseif substr (&var, 2, 1) = '0' .and. substr (&var, 3, 1) != '0'
         w_milhao = cem [val (substr (&var, 1, 1))] + ' e '
         w_milhao = w_milhao + uni [val (substr (&var, 3, 1))] + ' millhoes '
      else 
         w_milhao = cem [val (substr (&var, 1, 1))] + ' e '
         w_milhao = w_milhao + dez [val (substr (&var, 2, 1))] + ' e '
         w_milhao = w_milhao + uni [val (substr (&var, 3, 1))] + ' millhoes '
      endif
   endif
   j = j - 3
   w_ct = w_ct + 1
next
if substr (w_cem, 1, 1) = '0' .and. substr (w_cem, 2, 1) = '0'
   centavos = ''
elseif substr (w_cem, 1, 1) = '1' .and. substr (w_cem, 2, 1) != '0'
   centavos = out [val (substr (w_cem, 2, 1))]
elseif substr (w_cem, 2, 1) = '0'
   centavos = dez [val (substr (w_cem, 1, 1))]
elseif substr (w_cem, 1, 1) = '0' .and. substr (w_cem, 2, 1) != '1'
   centavos = uni [val (substr (w_cem, 2, 1))]
elseif substr (w_cem, 1, 1) = '0' .and. substr (w_cem, 2, 1) = '1'
   centavos = uni [val (substr (w_cem, 2, 1))]
else 
   centavos = dez [val (substr (w_cem, 1, 1))] + ' e ' + uni [val (substr (w_cem, 2, 1))]
endif
if len (trim (w_cruz)) != 0
   if len (trim (w_mil)) != 0
      w_mil = w_mil + 'e '
   endif
endif
if w_cruz = 'Hum'
   w_cruz = w_cruz + ' Real '
else 
   w_cruz = w_cruz + ' Reais '
endif
if w_cem = '01'
   centavos = 'e ' + centavos + ' centavo'
else 
   if w_cem != '00'
      centavos = 'e ' + centavos + ' centavos'
   endif
endif
retorna = w_milhao + w_mil + w_cruz + centavos
return retorna

function w_trans        
parameters valor
if valor = 0
   return 0.00
endif
valor = str (valor, 18, 2)
valor = stuff (valor, 4, 0, '.')
valor = stuff (valor, 8, 0, '.')
valor = stuff (valor, 12, 0, '.')
valor = stuff (valor, 16, 0, '.')
valor = stuff (valor, 20, 1, ',')
valor = substr (valor, rat (' ', valor) + 1, len (trim (valor)) - rat (' ', valor))
valor = iif (substr (valor, 1, 1) = '.', substr (valor, 2, len (valor) - 1), valor)
return valor

function espaco         
parameters var
pos = at (var, '_')
return substr (var, 1, pos - 1)


FUNCTION NtxProgress
LOCAL cComplete := LTRIM(STR((RECNO()/LASTREC()) * 100))
@ 23, 00 SAY "Indexing..." + cComplete + "%"
RETURN .T.
