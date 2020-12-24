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
	self.hinthud setText("save center -> [^3[{+activate}]^7]\nsave radius -> [^3[{+melee}]^7]");
	self.hinthud.hidewheninmenu = false;
	self.hinthud.alpha = 1;
	self.hinthud.glowAlpha = 0.6;
	self.hinthud.glowColor = (0.3, 0.3, 0.3);
	
	wtf = "!";

	last_origin = self.origin;
	
	for(;;) {
		while(!self UseButtonPressed() && !self MeleeButtonPressed() && !self SecondaryOffhandButtonPressed() && !self FragButtonPressed()) wait .05;
		if(self UseButtonPressed()) {
			last_origin = self.origin;
			fs_log("locations_"+level.script+".log","	level.CalloutPoints["+wtf+ level.script +wtf+"][i]["+wtf+"origin"+wtf+"] = "+self.origin+";","append");
			iPrintLnBold("center saved");
			
 			//while(!self UseButtonPressed()) wait .05;

			//fs_log("locations_"+level.script+".log","	level.CalloutPoints["+wtf+ level.script +wtf+"][i]["+wtf+"origin"+wtf+"] = "+self.origin+";\n	level.CalloutPoints["+wtf+ level.script +wtf+"][i]["+wtf+"radius"+wtf+"] = "+self GetPlayerAngles()+";","append");
		}
		else if(self MeleeButtonPressed()) {
			/*iPrintLnBold("New sector");
			fs_log("locations_"+level.script+".log","	//--------------------------------","append");*/
			
			radius = distance(last_origin,self.origin);				
	 		fs_log("locations_"+level.script+".log","	level.CalloutPoints["+wtf+ level.script +wtf+"][i]["+wtf+"radius"+wtf+"] = "+radius+";","append");			
			iPrintLnBold("radius saved -> " + radius);
		}

		while(self UseButtonPressed() || self MeleeButtonPressed() || self SecondaryOffhandButtonPressed() || self FragButtonPressed()) wait .05;
	}
}
