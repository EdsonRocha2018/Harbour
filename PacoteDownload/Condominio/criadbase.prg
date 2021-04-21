//#include "jpa.ch"

function criabase()
   LOCAL arrCampos
 setcolor("w+/n")
 @ 24,00 clear to 24,80
 @ 24,01 say "Contas.dbf..."
 inkey(3)
 select 1
 if .not. file("Contas.dbf")
  arrCampos := {}
  aadd(arrCampos,{"Codigo","C",10,0})
  aadd(arrCampos,{"Descri","C",30,0})
  aadd(arrCampos,{"TipoCD","C",7,0})               // C-Credito ou D-Debito
  aadd(arrCampos,{"modali","C",9,0})              //  A-Analitica ou S-Sintetica
  aadd(arrCampos,{"Ativa","C",3,0})              //   S-Sim ou N-Nao
  aadd(arrCampos,{"ContaTP","C",2,0})           //    CC-Conta Corrente
  aadd(arrCampos,{"DescCon","C",30,0})         //     Descrição do tipo de conta. Ex: Conta corrente, conta poupança, etc...
  dbcreate("Contas.dbf",arrCampos)
  if file("Cont001.ntx")
   erase Cont001.ntx
  endif
  if file("Cont002.ntx")
   erase Cont002.ntx
  endif
  if .not. abre("Contas.dbf",5,"e")
   setcolor("w+/n")
   @ 24,00 clear to 24,80
   @ 24,01 say "Arquivo Contas.dbf indisponivel no momento!"
   inkey(3)
   set color to
   clear screen
   close data
   clear memory
   return nil
  endif
  index on field->Codigo TAG Cont001
  index on field->Codigo+field->TipoCD TAG Cont002
  dbunlock()
 else
  if .not. file("Cont001.ntx")
   if .not. abre("Contas.dbf",5,"e")
    setcolor("w+/n")
    @ 24,00 clear to 24,80
    @ 24,01 say "Arquivo Contas.dbf indisponivel no momento!"
    inkey(3)
    set color to
    clear screen
    close data
    clear memory
    return nil
   endif
   index on field->Codigo to Cont001.ntx
  endif
 if .not. file("Cont002.ntx")
   if .not. abre("Contas.dbf",5,"e")
    setcolor("w+/n")
    @ 24,00 clear to 24,80
    @ 24,01 say "Arquivo Contas.dbf indisponivel no momento!"
    inkey(3)
    set color to
    clear screen
    close data
    clear memory
    return nil
   endif
   index on field->Codigo+field->TipoCD to Cont002.ntx
  endif
 endif
 close data
 clear memory
 setcolor("w+/n")
 @ 24,00 clear to 24,80
 @ 24,01 say "Moviment.dbf..."
 inkey(3)
 select 1
 if .not. file("Moviment.dbf")
    arrCampos := {}
    aadd(arrCampos,{"DataLan","D",8,0})
    aadd(arrCampos,{"Codigo","C",10,0})
    aadd(arrCampos,{"Descri","C",40,0})
    aadd(arrCampos,{"TipoCD","C",7,0})  
    aadd(arrCampos,{"modali","C",9,0})   
    aadd(arrCampos,{"ContaTP","C",2,0})
    aadd(arrCampos,{"DescCon","C",30,0})  
    aadd(arrCampos,{"Valor","N",15,2})
    aadd(arrCampos,{"Observ","C",30,0})
    dbcreate("Moviment.dbf",arrCampos)
    if file("Mov001.ntx")
       erase Mov001.ntx
    endif
    if file("Mov002.ntx")
       erase Mov002.ntx
    endif
    if .not. abre("Moviment.dbf",5,"e")
    setcolor("w+/n")
    @ 24,00 clear to 24,80
    @ 24,01 say "Arquivo Moviment.dbf indisponivel no momento!"
    inkey(3)
    set color to
    clear screen
    close data
    clear memory
    return nil
  endif
  index on Dtoc(field->DataLan)+field->Codigo to Mov001.ntx
  index on field->Codigo+Dtoc(field->DataLan) to Mov002.ntx
  dbunlock()
 else
  if .not. file("Mov001.ntx")
   if .not. abre("Moviment.dbf",5,"e")
    setcolor("w+/n")
    @ 24,00 clear to 24,80
    @ 24,01 say "Arquivo Moviment.dbf indisponivel no momento!"
    inkey(3)
    set color to
    clear screen
    close data
    clear memory
    return nil
   endif
   index on Dtoc(field->DataLan)+field->Codigo to Mov001.ntx
  endif
  if .not. file("Mov002.ntx")
   if .not. abre("Moviment.dbf",5,"e")
    setcolor("w+/n")
    @ 24,00 clear to 24,80
    @ 24,01 say "Arquivo Moviment.dbf indisponivel no momento!"
    inkey(3)
    set color to
    clear screen
    close data
    clear memory
    return nil
   endif
   index on field->Codigo+Dtoc(field->DataLan) to Mov002.ntx
  endif
  if .not. file("Mov002.ntx")
   if .not. abre("Moviment.dbf",5,"e")
    setcolor("w+/n")
    @ 24,00 clear to 24,80
    @ 24,01 say "Arquivo Moviment.dbf indisponivel no momento!"
    inkey(3)
    set color to
    clear screen
    close data
    clear memory
    return nil
   endif
  index on field->Codigo+Dtoc(field->DataLan) to Mov002.ntx
  endif
 endif
 close data
 clear memory
return nil

function abre(carquivo, ntempo, cmodo)
do while ntempo > 0
 if cmodo = "c"
  use &carquivo shared
 else
  use &carquivo exclusive
 endif
 if neterr()
  ntempo = ntempo - 0.5
  inkey(0.5)
 else
  return(.t.)
 endif
enddo
return(.f.)

function bloqueia(ntempo)
do while ntempo > 0
 if rlock()
  return(.t.)
 endif
 ntempo = ntempo - 0.5
 inkey(0.5)
enddo
return(.f.)