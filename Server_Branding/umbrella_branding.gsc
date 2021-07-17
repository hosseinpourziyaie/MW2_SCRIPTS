/************************************************************************************
                              IW4 SERVER SCRIPTS                               *****
***********************************************************************************
**
** - Name        : Server Banner
** - Description : draw image alongside some info in end corner of screen
** - Author      : Hosseinpourziyaie
** 
**
**  [Copyright © Hosseinpourziyaie 2017] <hosseinpourziyaie@gmail.com>
**
************************************************************************************/

init()
{
    precacheShader( "cardtitle_flag_turkey" );
    thread drawlogo();
} 
drawlogo()
{
	level.info_img = NewHudElem();
	level.info_img.alignX = "right";
	level.info_img.alignY = "bottom";
	level.info_img.x = 720;
	level.info_img.y = 485;
	level.info_img.alpha = 1;
	level.info_img SetShader("cardtitle_flag_turkey",200,40);
	
	/////////////////////////////////////////////////////////////
	level.info_txt = NewHudElem();
	level.info_txt.alignX = "right";
	level.info_txt.alignY = "bottom";
	level.info_txt.x = 712;
	level.info_txt.y = 450;
	level.info_txt.archived = true;
	level.info_txt.alpha = 1;
	level.info_txt.color = ( 1, 1, 1 );
	//level.info_txt.glowColor = (0.2, 0.3, 0.7);
    //level.info_txt.glowAlpha = 1;
	level.info_txt.fontScale = 0.8;
	level.info_txt.font = "hudbig";
	level.info_txt.hidewheninmenu = false;	
	//level.info_txt setPulseFx(50,int(((10*.85)*1000)),500);
	for(;;)
	{
		level.info_txt setText("^1UMBRELLA CORPORATION");
		wait 8;
		level.info_txt setText("^3by hosseinpourziyaie");
		wait 8;
		level.info_txt setText("^0order your own server now");
		wait 8;
		level.info_txt setText("^4ready to lead the charge!");
		wait 8;
	}
}