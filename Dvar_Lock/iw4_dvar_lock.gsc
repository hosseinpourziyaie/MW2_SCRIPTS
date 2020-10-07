/************************************************************************************
                       ULTRAMOD MODERN WARFARE 2 Project                       *****
***********************************************************************************
**
** - Name        : Player Prohbited DvarLock for MW2
** - Description : 
** - Author      : Hosseinpourziyaie
** - Note        :  --------------------------------------------
** - Started on  : 8 October 2020  | Ended on : 8 October 2020
**
** [WARNING] consider giving credits to author if you planning to use this script
**                                                                               
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
		player thread playerDvarsLock();
	}
}


playerDvarsLock()
{
	self endon( "disconnect" );
	
	while(1)
	{		
		self setClientDvar( "r_fullbright", 0);

		self setClientDvar( "r_detail", 1);

		self setClientDvar( "r_fog", 1);
		
		wait .1;
	}
}