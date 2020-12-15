/************************************************************************************
                              IW4 SERVER SCRIPTS                               *****
***********************************************************************************
**
** - Name        : Callout HUD Script for MW2
** - Description : Text HUD Displays players current location callout
** - Author      : Hosseinpourziyaie
** - Note        :  --------------------------------------------
** - Started on  : 25 September 2020  | Ended on : 25 September 2020
**
** [WARNING] consider giving credits to author if you planning to use this script
**                                                                  
**                                                  
**
** [NOTE] MapEdits for mp_rust , mp_crash were recorded by Hosseinpourziyaie
**
**
** [Copyright © ULTRAMOD/Hosseinpourziyaie 2019] <hosseinpourziyaie@gmail.com>
**
************************************************************************************/

init()
{
	setupCalloutPoints();
	thread onPlayerConnect();
}


onPlayerConnect()
{
	while(1)
	{
		level waittill( "connected", player );
		//player.lastArea = "";
		player thread calloutDisplayHUD();
	}
}


calloutDisplayHUD()
{
	//self iPrintLn( "[DEBUG]::calloutDisplayHUD called");
	self endon( "disconnect" );
	self.callouthud = newClientHudElem(self);
	self.callouthud.x = 0;
	self.callouthud.y = 0;
	self.callouthud.alignX = "left";
	self.callouthud.alignY = "top";
	self.callouthud.horzAlign = "left";
	self.callouthud.vertAlign = "top";
	self.callouthud.fontscale = 1.2;
	self.callouthud setText("");
	self.callouthud.hidewheninmenu = true;
	self.callouthud.alpha = 0;
	self.callouthud fadeOverTime(0.5);
	self.callouthud.alpha = 1;
	self.callouthud.glowAlpha = 0.6;
	self.callouthud.glowColor = (0.3, 0.3, 0.3);
	
	self.lastArea = "";
	
	while(1)
	{		
		if( level.activeUAVs[self.team] || !getDvarInt( "g_hardcore" )){
			self.callouthud.x = 107;
			self.callouthud.y = 3; 
		}
		else{
			self.callouthud.x = 3;
			self.callouthud.y = 2; 
		}

		if ( !isAlive( self ))
		{
			self.callouthud fadeOverTime(.5);
			self.callouthud.alpha = 0;
			//>----------------------------------
			self waittill( "spawned_player" );
			//---------------------------------->
			self.callouthud fadeOverTime(.5);
			self.callouthud.alpha = 1;
		}
		
		playerArea = getPlayerLocationCallout(self);
		if (self.lastArea != playerArea)
		{
			self.callouthud fadeOverTime(.2);
			self.callouthud.alpha = 0;
			wait .2;
			self.callouthud setText(playerArea);
			self.callouthud fadeOverTime(.2);
			self.callouthud.alpha = 1; 
	
			self.lastArea = playerArea;
		}
				
		wait .2;
	}
}

getPlayerLocationCallout(player)
{
	for(i=0;i<level.CalloutPoints[level.script].size;i++)
	{
		if(distance(level.CalloutPoints[level.script][i]["origin"],player.origin) < level.CalloutPoints[level.script][i]["radius"])
		{
			//self iPrintLn( "[DEBUG]::getPlayerLocationCallout -> " + level.CalloutPoints[level.script][i]["callout"] + " , distance = " + distance(level.CalloutPoints[level.script][i]["origin"],player.origin));
			return level.CalloutPoints[level.script][i]["callout"];
		}
	}
	
	return "";
}

setupCalloutPoints() {
	level.CalloutPoints["mp_rust"][0]["callout"] = "OIL TRUCK"; 
	level.CalloutPoints["mp_rust"][0]["origin"]  = (-194.034, -7.87457, -137.532);
    level.CalloutPoints["mp_rust"][0]["radius"]  = 210;
	
  	level.CalloutPoints["mp_rust"][1]["callout"] = "SHACK"; 
	level.CalloutPoints["mp_rust"][1]["origin"]  = (1283.9, 1336.12, -105.875);
    level.CalloutPoints["mp_rust"][1]["radius"]  = 260;
	
	level.CalloutPoints["mp_rust"][2]["callout"] = "PROPANE TANK"; 
	level.CalloutPoints["mp_rust"][2]["origin"]  = (1531.31, 489.3, -142.875);
    level.CalloutPoints["mp_rust"][2]["radius"]  = 180;
	
	level.CalloutPoints["mp_rust"][3]["callout"] = "OIL TANKS"; 
	level.CalloutPoints["mp_rust"][3]["origin"]  = (1322.72, 50.8137, -202.826);
    level.CalloutPoints["mp_rust"][3]["radius"]  = 320;
	
	level.CalloutPoints["mp_rust"][4]["callout"] = "PICKUP"; 
	level.CalloutPoints["mp_rust"][4]["origin"]  = (-283.699, 506.75, -155.109);
    level.CalloutPoints["mp_rust"][4]["radius"]  = 140;
	
	level.CalloutPoints["mp_rust"][5]["callout"] = "REFINERY"; 
	level.CalloutPoints["mp_rust"][5]["origin"]  = (735.612, 947.429, 41.5611);
    level.CalloutPoints["mp_rust"][5]["radius"]  = 613;
  
	level.CalloutPoints["mp_rust"][6]["callout"] = "OIL RIG"; 
	level.CalloutPoints["mp_rust"][6]["origin"]  = (-38.1688, 1557.31, -124.053);
    level.CalloutPoints["mp_rust"][6]["radius"]  = 310;

	level.CalloutPoints["mp_rust"][7]["callout"] = "TRAILER"; 
	level.CalloutPoints["mp_rust"][7]["origin"]  = (612.023, -16.8755, -183.544);
    level.CalloutPoints["mp_rust"][7]["radius"]  = 160;

  
  
  	level.CalloutPoints["mp_crash"][0]["callout"] = "CRASH SITE"; 
	level.CalloutPoints["mp_crash"][0]["origin"]  = (608.078, 506.884, 179.603);
    level.CalloutPoints["mp_crash"][0]["radius"]  = 470;
	
	level.CalloutPoints["mp_crash"][1]["callout"] = "BLUE BUILDING"; 
	level.CalloutPoints["mp_crash"][1]["origin"]  = (541.723, 1315.87, 236.967);
    level.CalloutPoints["mp_crash"][1]["radius"]  = 350;
	
	level.CalloutPoints["mp_crash"][2]["callout"] = "GARAGE"; 
	level.CalloutPoints["mp_crash"][2]["origin"]  = (79.9676, 2133.09, 338.335);
    level.CalloutPoints["mp_crash"][2]["radius"]  = 245;
	
	level.CalloutPoints["mp_crash"][3]["callout"] = "TV SHOP"; 
	level.CalloutPoints["mp_crash"][3]["origin"]  = (-767.875, 1991.37, 349.125);
    level.CalloutPoints["mp_crash"][3]["radius"]  = 340;
	
	level.CalloutPoints["mp_crash"][4]["callout"] = "TV SHOP SECOND FLOOR"; 
	level.CalloutPoints["mp_crash"][4]["origin"]  = (-767.875, 1851.88, 519.875);
    level.CalloutPoints["mp_crash"][4]["radius"]  = 467;
	
	level.CalloutPoints["mp_crash"][5]["callout"] = "BACK ALLEY"; 
	level.CalloutPoints["mp_crash"][5]["origin"]  = (-626.214, -865.768, 328.164);
    level.CalloutPoints["mp_crash"][5]["radius"]  = 586;
	
	level.CalloutPoints["mp_crash"][6]["callout"] = "APARTMENT"; 
	level.CalloutPoints["mp_crash"][6]["origin"]  = (1565.99, -1693.74, 271.925);
    level.CalloutPoints["mp_crash"][6]["radius"]  = 388;
	
	level.CalloutPoints["mp_crash"][7]["callout"] = "LIGHT SHOP"; 
	level.CalloutPoints["mp_crash"][7]["origin"]  = (198.299, -704.136, 198.508);
    level.CalloutPoints["mp_crash"][7]["radius"]  = 296;
	
	level.CalloutPoints["mp_crash"][8]["callout"] = "RESTAURANT"; 
	level.CalloutPoints["mp_crash"][8]["origin"]  = (1600.01, 610.078, 348.312);
    level.CalloutPoints["mp_crash"][8]["radius"]  = 296;
	
	level.CalloutPoints["mp_crash"][9]["callout"] = "PLAIN"; 
	level.CalloutPoints["mp_crash"][9]["origin"]  = (274.145, -2135.88, 198.878);
    level.CalloutPoints["mp_crash"][9]["radius"]  = 680;	
}
