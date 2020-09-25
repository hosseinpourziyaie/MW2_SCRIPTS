/*»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»
»»»»»»»»»»»»»»»   ULTRAMOD MW2 : IW4 as its best!                               »»»»»»»»»»»»»»»
»»»»»»»»»»»»»»»   Custom Raw Script : recorder_callout.gsc                      »»»»»»»»»»»»»»»
»»»»»»»»»»»»»»»   Author: Hosseinpourziyaie                                     »»»»»»»»»»»»»»»
»»»»»»»»»»»»»»»   Extra Info: this scripts for developer makes map marking      »»»»»»»»»»»»»»»
»»»»»»»»»»»»»»»     and saving it way easier. however trimming exported records »»»»»»»»»»»»»»»
»»»»»»»»»»»»»»»     because of gamelog system restrictions are still a pain!    »»»»»»»»»»»»»»»
»»»»»»»»»»»»»»»   For More Information Visit www.ultramod.eu                    »»»»»»»»»»»»»»»
»»»»»»»»»»»»»»»   Copyright 2020 ULTRAMODIFICATION. All rights reserved.        »»»»»»»»»»»»»»»
»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»*/

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