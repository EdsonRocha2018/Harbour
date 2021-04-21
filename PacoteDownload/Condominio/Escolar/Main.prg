************************************
#include "SET.CH"
#include "CLUBE.CH"
#include "DIRECTRY.CH"
#include "INKEY.CH"  
#include "hbgtinfo.ch"

#DEFINE CRLF CHR(13)+CHR(10)

REQUEST HB_LANG_PT
REQUEST HB_CODEPAGE_PT850
REQUEST HB_GT_WIN_DEFAULT

FUNCTION MAIN( cINSTAL )

HB_GtInfo( HB_GTI_FONTNAME, "Lucida Console" )  // fonte
hb_gtInfo( HB_GTI_FONTWIDTH, 10 )
hb_gtInfo( HB_GTI_FONTSIZE , 20 )
hb_gtInfo( HB_GTI_FONTQUALITY , .T. )
HB_GtInfo( HB_GTI_WINTITLE, "DATASAC" ) // titulo da tela
HB_GtInfo( HB_GTI_MAXIMIZED, .F. )
HB_GtInfo( HB_GTI_ISFULLSCREEN, .T. )
hb_gtInfo( HB_GTI_ALTENTER, .T. )
HB_GtInfo( HB_GTI_ISFULLSCREEN, .T. )

