init()
{
	/***************************RUN Record Script******************************************************************/
	thread Record();
	/***************************************************************************************************************/
}
Record() {
	for(;;) {
		level waittill("connected",player);
		player thread Recorder();
	}
}

Recorder() {
	self endon("disconnect");
	self.hinthud = newClientHudElem(self);
	self.hinthud.x = -64;
	self.hinthud.y = -44;
	self.hinthud.alignX = "right";
	self.hinthud.alignY = "bottom";
	self.hinthud.horzAlign = "right";
	self.hinthud.vertAlign = "bottom";
	self.hinthud.fontscale = 1.2;
	self.hinthud setText("start pos -> [^3[{+activate}]^7]\nfinish pos -> [^3[{+melee}]^7]");
	self.hinthud.hidewheninmenu = false;
	self.hinthud.alpha = 1;
	self.hinthud.glowAlpha = 0.6;
	self.hinthud.glowColor = (0.3, 0.3, 0.3);
	
	wtf = "!";
	
	for(;;) {
		while(!self UseButtonPressed() && !self MeleeButtonPressed() && !self SecondaryOffhandButtonPressed() && !self FragButtonPressed()) wait .05;
		if(self UseButtonPressed()) {
			fs_log("locations_"+level.script+".log","	level.TravelScripts["+wtf+ level.script +wtf+"][level.TravelScripts.size]["+wtf+"start_pos"+wtf+"] = "+self.origin+";\n	level.TravelScripts["+wtf+ level.script +wtf+"][level.TravelScripts.size]["+wtf+"cam_angles"+wtf+"] = "+self GetPlayerAngles()+";","append");
			iPrintLnBold("start point saved");
		}
		else if(self MeleeButtonPressed()) {
			fs_log("locations_"+level.script+".log","	level.TravelScripts["+wtf+ level.script +wtf+"][level.TravelScripts.size]["+wtf+"finish_pos"+wtf+"] = "+self.origin+";","append");	
			iPrintLnBold("finish point saved");
		}

		while(self UseButtonPressed() || self MeleeButtonPressed() || self SecondaryOffhandButtonPressed() || self FragButtonPressed()) wait .05;
	}
}