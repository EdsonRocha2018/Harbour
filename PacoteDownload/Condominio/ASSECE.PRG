#include "hbgtinfo.ch"
#include "windows.ch"
#include "guilib.ch"

REQUEST	HB_LANG_PT

PROCEDURE MAIN()

	ConfigurarAmbiente()
	
    sca()
	
RETURN


*/
PROCEDURE ConfigurarAmbiente()

	Hb_LangSelect( 'PT' )
	
	wvw_SetCodePage( 0, 255 )
	wvw_SetTitle( 0, "Harbour - Consulta de CEP via webservice" )
	wvw_Size_Ready( .t. )
	wvw_EnableMaximize( 0, .t. )
	wvw_SetFont( 0 , "Consolas", 24, 11, 100, 4 )
		
	SetMode( 20, 70 )

RETURN