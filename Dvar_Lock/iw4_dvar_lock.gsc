/************************************************************************************
**
** - Name        : Lock Prohbited Dvars for Player 
** - Description : --------------------------------------------
** - Author      : N/A
** - Note        :  --------------------------------------------
** - Started on  : N/A  | Ended on : N/A

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
