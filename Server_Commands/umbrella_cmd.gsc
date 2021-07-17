/************************************************************************************
                              IW4 SERVER SCRIPTS                               *****
***********************************************************************************
**
** - Name        : Server Commands
** - Description : extra added custom server commands
** - Author      : Hosseinpourziyaie
** 
**
**  [Copyright © Hosseinpourziyaie 2017] <hosseinpourziyaie@gmail.com>
**
************************************************************************************/
init()
{
	cmd_register();
	thread cmd_thread();
}

/***************************Initialize Command Parse System******************************************************************/
cmd_register()
{
	initializeDvars();
	addCommand( "playsound",   ::playsound_f );
	addCommand( "notifymsg",   ::notifymsg_f );
	addCommand( "g_balance",   ::balance_f );
	addCommand( "finishmatch", ::endmatch_f );
	addCommand( "freespec",    ::freespec_f );
}

cmd_thread()
{
	//no, while yes
	for (;;) {	
		// Check if any of the variables we support has been set
		for ( index = 0; index < level.gscCommands.size; index++ )
		{
			dVarName = level.gscCommands[index]["dvar"];
			dVarValue = getDvar( dVarName );
			// If the variable was set we'll just clean it and call the respective function
			if ( dVarValue != "" ) {
				setDvar( dVarName, "" );
				self thread [[level.gscCommands[index]["function"]]]( dVarValue );
			}
		}

		wait (0.5);	
	}
}

addCommand( dVarName, functionCall ) {
	// Check if the array for commands is already defined
	if ( !isDefined( level.gscCommands ) )
		level.gscCommands = [];
	
	// Add new element
	newElement = level.gscCommands.size;
	level.gscCommands[ newElement ] = [];
	level.gscCommands[ newElement ]["dvar"] = dVarName;
	level.gscCommands[ newElement ]["function"] = functionCall;
}

initializeDvars()
{
	setDvar( "playsound",  "" );
	setDvar( "notifymsg",  "" );
	setDvar( "g_balance",  "" );
	setDvar( "finishgame", "" );
	setDvar( "freespec", "" );
}

/***********************************Functions**********************************************************************/
playsound_f( dVarValue )
{
	// Play a sound on all the players
	level thread playSoundOnEveryone( dVarValue );
}

playSoundOnEveryone( soundName ) {
	//level endon( "game_ended" );
	
	for ( index = 0; index < level.players.size; index++ )
	{
		player = level.players[index];
		player playLocalSound( soundName );
	}
}

notifymsg_f( dVarValue )
{
	drawNotifyMessageforEveryone( dVarValue );
}

drawNotifyMessageforEveryone( msg )
{
	level.notifymsg_txt = NewHudElem();
	level.notifymsg_txt.horzAlign = "center";
	level.notifymsg_txt.vertAlign = "middle";
	level.notifymsg_txt.alignX = "center";
	level.notifymsg_txt.alignY = "middle";
	level.notifymsg_txt.x = 0;
	level.notifymsg_txt.y = -150;
	level.notifymsg_txt.archived = true;
	level.notifymsg_txt.alpha = 1;
	level.notifymsg_txt.color = ( 1, 1, 1 );
	level.notifymsg_txt.glowColor = (0.2, 0.3, 0.7);
	level.notifymsg_txt.glowAlpha = 1;
	level.notifymsg_txt.fontScale = 1.1;
	level.notifymsg_txt.font = "hudbig";
	level.notifymsg_txt.hidewheninmenu = false;
	level.notifymsg_txt setText( msg );
	level.notifymsg_txt setPulseFx(50,int(((10*.85)*1000)),500);
}

balance_f()
{
	//if(maps\mp\gametypes\_teams::getTeamBalance())
	//	iPrintLn("Theres no need to balance the teams");
	//else if(isDefined(self.pers["called_balance"]))
	//    iPrintLn("You can only call teambalance once a map");
	//else {
	//	self.pers["called_balance"] = 1;
	//	level maps\mp\gametypes\_teams::balanceTeams();
	//}
	
	iPrintLnBold( "Teams are being balanced" );
	maps\mp\gametypes\_teams::balanceTeams();
}

endmatch_f()
{
	//level thread maps\mp\gametypes\_gamelogic::forceEnd();
	
	// End the current map
	level.forcedEnd = true;
	thread maps\mp\gametypes\_gamelogic::endGame( "tie", game["strings"]["round_draw"] );
}

freespec_f()
{
	// dVarValue contains the player's number
	dVarValue = int( dVarValue );
	
	// Search for the player
	player = findPlayerByNumber( dVarValue );
	if ( !isDefined( player ) || isAlive( player ) )
		return;
	
	player iprintlnbold( "^0[ ^3ADMIN ^0] ^7Free Spectator mode permission granted!" );

	player allowSpectateTeam( "allies", true );
	player allowSpectateTeam( "axis", true );
	player allowSpectateTeam( "freelook", true );
	player allowSpectateTeam( "none", true );
}
