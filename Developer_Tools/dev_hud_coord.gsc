/************************************************************************************
                       ULTRAMOD MODERN WARFARE 2 Project                       *****
***********************************************************************************
**
** - Name        : Developer Tools for MW2
** - Description : Debug HUD Displays player location coordinate in world
** - Author      : Hosseinpourziyaie
** - Note        : HUD works in spectator and noclip mode aswell
** - Started on  : 14 December 2020  | Ended on : 14 December 2020
**
** [WARNING] consider giving credits to author if you planning to use this script
**                                                                  
**                                                  
** [NOTE] for more contents visit our website: http://ultramod.eu/
**
** [Copyright © ULTRAMOD/Hosseinpourziyaie 2019] <hosseinpourziyaie@gmail.com>
**
************************************************************************************/

init()
{
	thread onPlayerConnect();
}


onPlayerConnect()
{
	while(1)
	{
		level waittill( "connected", player );
		player thread playerCoordHUD();
	}
}


playerCoordHUD()
{
	self endon( "disconnect" );
	self.debughud = newClientHudElem(self);
	self.debughud.x = 064;
	self.debughud.y = -44;
	self.debughud.alignX = "left";
	self.debughud.alignY = "bottom";
	self.debughud.horzAlign = "left";
	self.debughud.vertAlign = "bottom";
	self.debughud.fontscale = 1.2;
	self.debughud setText("");
	self.debughud.hidewheninmenu = false;
	self.debughud.alpha = 1;
	self.debughud.glowAlpha = 0.6;
	self.debughud.glowColor = (0.3, 0.3, 0.3);
	
	while(1)
	{
		/*if ( !isAlive( self ))
		{
			self.debughud fadeOverTime(.5);
			self.debughud.alpha = 0;
			
			self waittill( "spawned_player" );
			
			self.debughud fadeOverTime(.5);
			self.debughud.alpha = 1;
		}*/
		
		originStr = self.origin[0] + ", " + self.origin[1] + ", " + self.origin[2];
		//AnlgesStr = self.anlges[0] + ", " + self.anlges[1] + ", " + self.anlges[2];
	
		self.debughud setText("[" + originStr + "] " + self GetPlayerAngles());

		wait .2;
	}	
}
