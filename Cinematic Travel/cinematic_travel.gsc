/************************************************************************************
                              IW4 SERVER SCRIPTS                               *****
***********************************************************************************
**
** - Name        : Cinematic Travel
** - Description : scripted auto-pilot fly in world 
** - Author      : Hosseinpourziyaie
** - Note        :  --------------------------------------------
** - Started on  : 14 December 2020  | Ended on : 16 December 2020
**
** 
**                                                                  
** [NOTE] This script's camera flights linear(no rotation of angles one single travel)
**
** [NOTE] Travel scripts for mp_rust, mp_crash ,map_highrise ,mp_vacant 
**                                              were recorded by Hosseinpourziyaie
**
**
** [Copyright © Hosseinpourziyaie 2020] <hosseinpourziyaie@gmail.com>
**
************************************************************************************/
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
	thread onPlayerConnect();
	setupTravelScripts();
}

onPlayerConnect()
{
	for( ;; )
	{
		level waittill( "connected", player );
	
		player thread onSpawnPlayer();	
	}
}

onSpawnPlayer()
{
	self endon ( "disconnect" );
	self waittill( "spawned_player" );
	self Callback_Hold_Use(::init_travel);
}

Callback_Hold_Use(pointer) {
  self endon("disconnect");

  if (!isDefined(self.HoldDownHint) && !isDefined(self.HoldDownBar)) {
    self.HoldDownHint = createFontString("default", 1.3);
    self.HoldDownHint setPoint("BOTTOM", "BOTTOM", 0, -20);
    self.HoldDownHint setText("Hold [^3[{+activate}]^7] to start cinematic Travel");
    self.HoldDownHint.foreGround = true;

    self.HoldDownBar = createPrimaryProgressBar(45);
    self.HoldDownBar.bar.color = (1, 1, 1);
    self.HoldDownBar setPoint("BOTTOM", "BOTTOM", 0, -20);
    self.HoldDownBar.bar.x = -60;

    self.Progress = 0;
  }

  for (;;) {
    if (self useButtonPressed()) 
	{
      self.HoldDownHint.Alpha = 0;
      self.HoldDownBar.Alpha = 1;
      self.HoldDownBar.bar.Alpha = 1;
	  
      self.Progress += 0.05;
      self.HoldDownBar updatebar(self.Progress);
      wait .05;
      if (self.Progress == 1) {
        if (isDefined(self.HoldDownBar))
          self.HoldDownBar destroyElem();
        if (isDefined(self.HoldDownHint))
          self.HoldDownHint destroyElem();
        break;
      }
    } else {
      self.HoldDownBar.Alpha = 0;
	  self.HoldDownBar.bar.Alpha = 0;
      self.HoldDownHint.Alpha = 1;

      self.Progress = 0;
	  self.HoldDownBar updatebar( self.Progress );
    }
	
    wait .05;
  }

  self thread[[pointer]]();
}

Init_Travel()
{
	if(!isDefined(level.TravelScripts[level.script]) || level.TravelScripts[level.script].size == 0) 
	{
		self iprintln("^1[ ERROR ] ^7 No Fly script for this Map");
		return;
	}
	
	self endon("disconnect");
	level endon( "game_ended" );
	
	/*----------------------------------------------------------------------
	self thread lmsg("travel_hint", "Press ^3[USE] ^7to start cinematic Travel");
	while(!self useButtonPressed()) wait .05;	
	self thread timer(2);
	wait 2;
	-----------------------------------------------------------------------*/

    self.lastPosOrigin = self.origin;
	self.lastPosAngles = self GetPlayerAngles();
	
	//-------------------------------------------->>
	self takeallweapons();
	self setClientDvar("ui_hud_hardcore",1);

	self visionSetNaked( "mpOutro", 2.0 );
	
	self hide();
	//<<--------------------------------------------
	
	self thread Start_Travel();
		
	//Ambientstop( 1 );
	self playLocalSound( "mp_suspense_05" );
	
	//self playLocalSound( "estate_betrayal" );
	//musicPlay( "estate_betrayal" );
	//AmbientPlay( "estate_betrayal" );
	
	//-------------------------------------------->>
	self waittill ( "travel_finished" );
	
	self setOrigin(self.lastPosOrigin);
    self setPlayerAngles(self.lastPosAngles);
	
	self visionSetNaked( getDvar( "mapname" ), 3.0 );
	
	self show();
	
	self giveWeapon( "usp_tactical_mp", 0, false );
	wait 0.1;
	self switchToWeapon("usp_tactical_mp");
	//<<--------------------------------------------
}

Start_Travel()
{
	if(!isDefined(level.TravelScripts[level.script]) || level.TravelScripts[level.script].size == 0) return;
	
	camera = spawn( "script_model", self.origin );
	self thread LockPlayerAnglesToCamera(camera);
   	camera setmodel( "tag_origin" );
	
	camera EnableLinkTo();
   	//self linkto( camera );
	self PlayerLinkToDelta( camera, "tag_origin");

	self freezeControls( true );

	for(i=0;i<level.TravelScripts[level.script].size;i++)
	{
		if( !isDefined(level.TravelScripts[level.script][i]) ) continue;
			
		camera.origin = level.TravelScripts[level.script][i]["start_pos"];
		camera.angles = level.TravelScripts[level.script][i]["cam_angles"];
		
		camera MoveTo( level.TravelScripts[level.script][i]["finish_pos"], level.TravelScripts[level.script][i]["fly_length"]);
		
		wait level.TravelScripts[level.script][i]["fly_length"];
	}
	
	self Unlink();
	camera delete();
	
	self notify( "travel_finished" );
}
  
  
setupTravelScripts() {

//-------------------------------         Rust         -------------------------------//
	level.TravelScripts["mp_rust"][0]["start_pos"]   = (-261.20, 273.90, -94.90); 
	level.TravelScripts["mp_rust"][0]["finish_pos"]  = (692.60 , 238.50, -97.60);
    level.TravelScripts["mp_rust"][0]["cam_angles"]  = (0.20   , -2.10 , 0.00  );
	level.TravelScripts["mp_rust"][0]["fly_length"]  = 20;
	
	level.TravelScripts["mp_rust"][1]["start_pos"]   = (1212.30, 1424.00, 357.80); 
	level.TravelScripts["mp_rust"][1]["finish_pos"]  = (1780.60, 2001.70, 726.60);
    level.TravelScripts["mp_rust"][1]["cam_angles"]  = (23.80  , -139.40, 0.00  );
	level.TravelScripts["mp_rust"][1]["fly_length"]  = 20;
	
	level.TravelScripts["mp_rust"][2]["start_pos"]   = (-1522.50, -1429.40, -160.30); 
	level.TravelScripts["mp_rust"][2]["finish_pos"]  = (-1013.60, -1772.10, -160.30);
    level.TravelScripts["mp_rust"][2]["cam_angles"]  = (-0.30   , 55.70   , 0.00   );
	level.TravelScripts["mp_rust"][2]["fly_length"]  = 20;
	
	//level.TravelScripts["mp_rust"][3]["start_pos"]   = (-362.80, 1151.00, -140.00); 
	//level.TravelScripts["mp_rust"][3]["finish_pos"]  = (332.20 , 1112.48, -94.84 );
    //level.TravelScripts["mp_rust"][3]["cam_angles"]  = (-4.00  , -3.00  , 0.00   );
	//level.TravelScripts["mp_rust"][3]["fly_length"]  = 16;
	
//-------------------------------         Crash         -------------------------------//

	level.TravelScripts["mp_crash"][0]["start_pos"]   = (-383.45, 2374.00, 445.00); 
	level.TravelScripts["mp_crash"][0]["finish_pos"]  = (-367.75, 1399.00, 443.10);
    level.TravelScripts["mp_crash"][0]["cam_angles"]  = (0.10   , -89.00 , 0.00  );
	level.TravelScripts["mp_crash"][0]["fly_length"]  = 14;
	
	level.TravelScripts["mp_crash"][1]["start_pos"]   = (88.34 , 178.90, 186.94); 
	level.TravelScripts["mp_crash"][1]["finish_pos"]  = (783.88, 440.16, 241.24);
    level.TravelScripts["mp_crash"][1]["cam_angles"]  = (-4.18 , 20.58 , 0.00  );
	level.TravelScripts["mp_crash"][1]["fly_length"]  = 14;
	
	level.TravelScripts["mp_crash"][2]["start_pos"]   = (1104.60, 1268.40, 559.40); 
	level.TravelScripts["mp_crash"][2]["finish_pos"]  = (1099.00, 1226.70, 180.75);
    level.TravelScripts["mp_crash"][2]["cam_angles"]  = (-3.40  , -119.20, 0.00  );
	level.TravelScripts["mp_crash"][2]["fly_length"]  = 10;
	
	level.TravelScripts["mp_crash"][3]["start_pos"]   = (368.00, -1837.00, 435.00); 
	level.TravelScripts["mp_crash"][3]["finish_pos"]  = (368.00, -1837.00, 152.00);
    level.TravelScripts["mp_crash"][3]["cam_angles"]  = (11.00 , 62.00   , 0.00  );
	level.TravelScripts["mp_crash"][3]["fly_length"]  = 10;
	
	
	//level.TravelScripts["mp_crash"][0]["start_pos"]   = (-317.00,2091.00,847.00); 
	//level.TravelScripts["mp_crash"][0]["finish_pos"]  = (-188.00,-1362.00,847.00);
    //level.TravelScripts["mp_crash"][0]["cam_angles"]  = (90.00,90.00,0.00);
	//level.TravelScripts["mp_crash"][0]["fly_length"]  = 24;
	
	//level.TravelScripts["mp_crash"][1]["start_pos"]   = (299.00,348.00,175.00); 
	//level.TravelScripts["mp_crash"][1]["finish_pos"]  = (989.00,505.00,195.00);
    //level.TravelScripts["mp_crash"][1]["cam_angles"]  = (0.00,0.00,0.00);
	//level.TravelScripts["mp_crash"][1]["fly_length"]  = 20;
	
	//level.TravelScripts["mp_crash"][2]["start_pos"]   = (368.00,-1837.00,435.00); 
	//level.TravelScripts["mp_crash"][2]["finish_pos"]  = (368.00,-1837.00,152.00);
    //level.TravelScripts["mp_crash"][2]["cam_angles"]  = (11.00,62.00,0.00);
	//level.TravelScripts["mp_crash"][2]["fly_length"]  = 20;
	
	//-----------------------------        Vacant         -----------------------------//

	level.TravelScripts["mp_vacant"][0]["start_pos"]   = (-354.30, 889.20, -14.00); 
	level.TravelScripts["mp_vacant"][0]["finish_pos"]  = (615.60 , 923.60, -14.00);
    level.TravelScripts["mp_vacant"][0]["cam_angles"]  = (-0.70  , 2.10  , 0.00  );
	level.TravelScripts["mp_vacant"][0]["fly_length"]  = 12;
	
	level.TravelScripts["mp_vacant"][1]["start_pos"]   = (-1712.40, 290.40 , 154.60); 
	level.TravelScripts["mp_vacant"][1]["finish_pos"]  = (-2228.30, -220.40, 350.00);
    level.TravelScripts["mp_vacant"][1]["cam_angles"]  = (15.00   , 44.70  , 0.00  );
	level.TravelScripts["mp_vacant"][1]["fly_length"]  = 12;
	
	//level.TravelScripts["mp_vacant"][2]["start_pos"]   = (1956.00, 423.38 , 64.50); 
	//level.TravelScripts["mp_vacant"][2]["finish_pos"]  = (1956.00, -794.00, 64.20);
    //level.TravelScripts["mp_vacant"][2]["cam_angles"]  = (-0.02  , 176.90 , 0.00 );
	//level.TravelScripts["mp_vacant"][2]["fly_length"]  = 8;
	
	level.TravelScripts["mp_vacant"][2]["start_pos"]   = (2051.30, 509.30 , 54.00); 
	level.TravelScripts["mp_vacant"][2]["finish_pos"]  = (1417.20, -77.90 , 40.00);
    level.TravelScripts["mp_vacant"][2]["cam_angles"]  = (-0.24  , -136.80, 0.00 );
	level.TravelScripts["mp_vacant"][2]["fly_length"]  = 14;
	
	level.TravelScripts["mp_vacant"][3]["start_pos"]   = (-1119.60, -1129.90, 49.20); 
	level.TravelScripts["mp_vacant"][3]["finish_pos"]  = (-257.90 , -950.90 , 42.50);
    level.TravelScripts["mp_vacant"][3]["cam_angles"]  = (-1.40   , 11.80   , 0.00 );
	level.TravelScripts["mp_vacant"][3]["fly_length"]  = 10;
	
	//-----------------------------        Highrise         -----------------------------//

	level.TravelScripts["mp_highrise"][0]["start_pos"]   = (-1882.50, 5835.20, 3152.00); 
	level.TravelScripts["mp_highrise"][0]["finish_pos"]  = (-2476.10, 5434.60, 3152.60);
    level.TravelScripts["mp_highrise"][0]["cam_angles"]  = (0.00    , 34.00  , 0.00   );
	level.TravelScripts["mp_highrise"][0]["fly_length"]  = 14;
	
	level.TravelScripts["mp_highrise"][1]["start_pos"]   = (-1376.89, 6199.70, 3817.70); 
	level.TravelScripts["mp_highrise"][1]["finish_pos"]  = (-1376.40, 6071.30, 5285.60);
    level.TravelScripts["mp_highrise"][1]["cam_angles"]  = (85.00   , 90.20  , 0.00   );
	level.TravelScripts["mp_highrise"][1]["fly_length"]  = 14;
	
	level.TravelScripts["mp_highrise"][2]["start_pos"]   = (1628.70, 7883.25, 2901.70); 
	level.TravelScripts["mp_highrise"][2]["finish_pos"]  = (-18.00 , 7880.70, 2873.30);
    level.TravelScripts["mp_highrise"][2]["cam_angles"]  = (1.30   , -131.40, 0.00   );
	level.TravelScripts["mp_highrise"][2]["fly_length"]  = 14;

//-------------------------------         Template         -------------------------------//	
	/*level.TravelScripts["mp_"][level.TravelScripts.size]["start_pos"]   = (0,0,0); 
	level.TravelScripts["mp_"][level.TravelScripts.size]["finish_pos"]  = (0,0,0);
    level.TravelScripts["mp_"][level.TravelScripts.size]["cam_angles"]  = (0,0,0);
	level.TravelScripts["mp_"][level.TravelScripts.size]["fly_length"]  = 000;
	
	level.TravelScripts["mp_"][level.TravelScripts.size]["start_pos"]   = (0,0,0); 
	level.TravelScripts["mp_"][level.TravelScripts.size]["finish_pos"]  = (0,0,0);
    level.TravelScripts["mp_"][level.TravelScripts.size]["cam_angles"]  = (0,0,0);
	level.TravelScripts["mp_"][level.TravelScripts.size]["fly_length"]  = 000;
	
	level.TravelScripts["mp_"][level.TravelScripts.size]["start_pos"]   = (0,0,0); 
	level.TravelScripts["mp_"][level.TravelScripts.size]["finish_pos"]  = (0,0,0);
    level.TravelScripts["mp_"][level.TravelScripts.size]["cam_angles"]  = (0,0,0);
	level.TravelScripts["mp_"][level.TravelScripts.size]["fly_length"]  = 000;*/
}

LockPlayerAnglesToCamera(ent){
   while(isDefined(ent)){
      self SetPlayerAngles( ent.angles );
      wait 0.05;
   }
}

lmsg(id,msg) {
	self endon("disconnect");
	self setLowerMessage(id, msg);
	wait 2;
	self clearLowerMessage(id, 2);	
}

timer(time) {
	/*self endon("disconnect");	
	text SetTenthsTimer(time);*/
}