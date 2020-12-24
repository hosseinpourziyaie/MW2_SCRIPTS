/************************************************************************************
                              IW4 SERVER SCRIPTS                               *****
***********************************************************************************
**
** - Name        : Holographical Banner
** - Description : Holographic Banner drawn in world using light fx
** - Author      : N/A
** - Note        :  --------------------------------------------
** - Started on  : N/A  | N/A
**
**
**                                                                  
** [NOTE] you can use "misc/aircraft_light_wingtip_green" for fx aswell
**
** 
** [DISCLAIMER] Im not this script author. Im just sharing it 
**
************************************************************************************/

init() {
	level thread dmcSetup();
	level thread dmcLogic();
}

dmcSetup() { //TODO: Optimize this mess
	dmcLoadConfig();		// Loading config text

	level.aHoloPosition = [];
	level.aHoloText = [];
	level thread dmcInitMapPositions();		// Load the location of the text
	level thread dmcLoadFonts();			// font Load
}

dmcLogic() {
	wait 0.05;
		level thread dmcDrawHolographicText();

		level thread dmcLevelWatchGameEnded();
}


dmcLoadConfig() {

	level.stringHolo		= "HOSSEINPOURZIYAIE";
}

dmcDrawHolographicText() {
	if(level.aHoloPosition.size && level.stringHolo) {
		angles = level.aHoloPosition["angles"] + (0,180,0);
		origin = level.aHoloPosition["origin"];

		vecx = AnglesToRight(angles);
		vecy = AnglesToUp(angles);
		vecz = AnglesToForward(angles);

		str = level.stringHolo;

		len = 0;
		for(i=0;i<str.size;i++) {
			letter = GetSubStr(str,i,i+1);
			len += level.aFontSize[letter] + 0.8;
		}
		m = 4.5;
		x = (len / 2) * -1 * m;

		for(i=0;i<str.size;i++) {
			letter = GetSubStr(str,i,i+1);
			arr = level.aFont[letter];
			foreach(pos in arr) {
				ox = dmcVectorMultiply(vecx, pos[0] * m + x);
				oy = dmcVectorMultiply(vecy, (16 - pos[1]) * m);
				oz = dmcVectorMultiply(vecz, 1);
				position = origin + ox + oy + oz;
				fx = SpawnFX(loadfx("misc/aircraft_light_wingtip_red"), position);
				TriggerFX(fx, 1);
				level.aHoloText[level.aHoloText.size] = fx;
			}
			x += (level.aFontSize[letter] + 0.8) * m;
		}
	}
}

dmcVectorMultiply( vec, dif )
{
	vec = ( vec[ 0 ] * dif, vec[ 1 ] * dif, vec[ 2 ] * dif );
	return vec;
}

dmcRemoveHolographicText() {
	foreach(fx in level.aHoloText) {
		fx delete();
	}
}

dmcLevelWatchGameEnded() {
	self waittill("game_ended");
	dmcRemoveHolographicText();
}

dmcLoadFonts() {
	level.aFont = [];
	level.aFontSize = [];

	font_letters = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!#^&*()-=+[]{}\\\/,.'\"?$:;_";
	font = [];
	font[font.size] = "....x....x....x....x...x...x....x....x...x...x....x...x.....x....x.....x....x.....x....x...x...x....x...x.....x...x...x...x...x....x....x....x....x...x...x....x....x...x...x....x...x.....x....x.....x....x.....x....x...x...x....x...x.....x...x...x...x..x...x...x....x...x...x...x...x...x...x.x.....x...x.....x...x..x..x...x...x...x..x..x...x...x...x...x..x.x#x#.#x...x...x.x..x...x";
	font[font.size] = ".... .... .... .... ... ... .... .... ... ... .... ... ..... .... ..... .... ..... .... ... ... .... ... ..... ... ... ... ... .... .... .... .... ... ... .... .... ... ... .... ... ..... .... ..... .... ..... .... ... ... .... ... ..... ... ... ... .. ... ... .... ... ... ... ... ... ... . ..... ... ..... ... .# #. ... ... ... ## ## ..# #.. #.. ..# .. . # #.# ... .#. . .. ... ";
	font[font.size] = ".##. ###. .##. ###. ### ### .##. #..# ### ### #..# #.. .#.#. #..# .###. ###. .###. ###. ### ### #..# #.# #.#.# #.# #.# ### ... .##. ###. .##. ###. ### ### .##. #..# ### ### #..# #.. .#.#. #..# .###. ###. .###. ###. ### ### #..# #.# #.#.# #.# #.# ### .# ##. ### ..#. ### ### ### ### ### ### # .#.#. .#. .##.. .#. #. .# ... ... ... #. .# .#. .#. #.. ..# .. . . ... ### ### . .. ... ";
	font[font.size] = "#..# #..# #..# #..# #.. #.. #... #..# .#. .#. #.#. #.. #.#.# ##.# #...# #..# #...# #..# #.. .#. #..# #.# #.#.# #.# #.# ..# ... #..# #..# #..# #..# #.. #.. #... #..# .#. .#. #.#. #.. #.#.# ##.# #...# #..# #...# #..# #.. .#. #..# #.# #.#.# #.# #.# ..# ## ..# ..# .##. #.. #.. ..# #.# #.# #.# # ##### #.# #..#. ### #. .# ... ### .#. #. .# .#. .#. .#. .#. .. . . ... ..# #.. # .# ... ";
	font[font.size] = "#### ###. #... #..# ##. ##. #.## #### .#. .#. ###. #.. #.#.# #.## #...# #..# #.#.# #..# ### .#. #..# #.# #.#.# .#. .#. .#. ... #### ###. #... #..# ##. ##. #.## #### .#. .#. ###. #.. #.#.# #.## #...# #..# #.#.# #..# ### .#. #..# #.# #.#.# .#. .#. .#. .# .#. ### #.#. ##. ### ..# ### ### #.# # .#.#. ... .##.. .#. #. .# ### ... ### #. .# #.. ..# .#. .#. .. . . ... .## ### . .. ... ";
	font[font.size] = "#..# #..# #..# #..# #.. #.. #..# #..# .#. .#. #.#. #.. #.#.# #..# #...# ###. #..#. ###. ..# .#. #..# #.# #.#.# #.# .#. #.. ... #..# #..# #..# #..# #.. #.. #..# #..# .#. .#. #.#. #.. #.#.# #..# #...# ###. #..#. ###. ..# .#. #..# #.# #.#.# #.# .#. #.. .# #.. ..# #### ..# #.# .#. #.# ..# #.# . ##### ... #..#. #.# #. .# ... ### .#. #. .# .#. .#. .#. .#. .. . . ... ... ..# # .# ... ";
	font[font.size] = "#..# ###. .##. ###. ### #.. .##. #..# ### #.. #..# ### #.#.# #..# .###. #... .##.# #..# ### .#. .### .#. .#.#. #.# #.. ### ... #..# ###. .##. ###. ### #.. .##. #..# ### #.. #..# ### #.#.# #..# .###. #... .##.# #..# ### .#. .### .#. .#.#. #.# #.. ### .# ### ### ..#. ##. ### .#. ### ### ### # .#.#. ... .##.# ... #. .# ... ... ... #. .# .#. .#. ..# #.. .# # . ... .#. ### . #. ### ";
	font[font.size] = ".... .... .... .... ... ... .... .... ... ... .... ... ..... .... ..... .... ..... .... ... ... .... ... ..... ... ... ... ... .... .... .... .... ... ... .... .... ... ... .... ... ..... .... ..... .... ..... .... ... ... .... ... ..... ... ... ... .. ... ... .... ... ... ... ... ... ... . ..... ... ..... ... .# #. ... ... ... ## ## ..# #.. ..# #.. #. . . ... ... .#. . .. ... ";

	pos1 = 0;
	index = 0;
	for(i=0;i<font[0].size;i++) {
		if(GetSubStr(font[0], i, i+1) == "x") {
			pos2 = i;
			letter = GetSubStr(font_letters, index, index+1);
			level.aFont[letter] = [];
			level.aFontSize[letter] = pos2 - pos1;
			for(x=pos1;x<pos2;x++) {
				for(y=0;y<font.size;y++) {
					if(GetSubStr(font[y], x, x+1) == "#") level.aFont[letter][level.aFont[letter].size] = (x - pos1, y, 0);
				}
			}
			index++;
			pos1 = pos2+1;
		}
	}
}

dmcInitMapPositions() {
	//Supported: mp_afghan mp_rust mp_terminal mp_favela mp_subbase mp_boneyard mp_highrise mp_nightshift mp_underpass mp_quarry mp_complex mp_estate mp_trailerpark mp_vacant mp_invasion mp_brecourt mp_compact mp_checkpoint mp_storm mp_derail mp_rundown mp_fuel2 mp_crash mp_strike mp_abandon mp_overgrown
	//Unsupported: -
	//Drops: mp_afghan mp_rust mp_terminal mp_favela mp_subbase mp_boneyard mp_highrise mp_nightshift mp_underpass mp_quarry mp_complex mp_estate mp_trailerpark mp_vacant mp_invasion mp_brecourt mp_compact mp_checkpoint mp_storm mp_derail mp_rundown mp_fuel2 mp_crash mp_strike mp_abandon mp_overgrown
	//No drops: -
	//Holo: mp_afghan mp_rust mp_terminal mp_favela mp_subbase mp_boneyard mp_highrise^ mp_nightshift mp_underpass
	//No holo: mp_quarry mp_complex mp_estate mp_trailerpark mp_vacant mp_invasion mp_brecourt mp_compact mp_checkpoint mp_storm mp_derail mp_rundown mp_fuel2 mp_crash mp_strike mp_abandon mp_overgrown

	switch(getDvar("mapname")) {
		case "mp_afghan":
			level.aHoloPosition["origin"] = (-219.201, 1557.74, 438.21);
			level.aHoloPosition["angles"] = (0, 180, 0);
		break;
		case "mp_rust":
			level.aHoloPosition["origin"] = (-559.68, 915.441, -25.6089);
			level.aHoloPosition["angles"] = (0, 0, 0);
		break;
		case "mp_terminal":
			level.aHoloPosition["origin"] = (1075.32, 4759.88, 284.291);
			level.aHoloPosition["angles"] = (0, -90, 0);
		break;
		case "mp_favela":
			level.aHoloPosition["origin"] = (-1852.2, -415.991, 583.378);
			level.aHoloPosition["angles"] = (0, 30.5098, 0);
		break;
		case "mp_subbase":
			level.aHoloPosition["origin"] = (263.047, -2168.13, 139.118);
			level.aHoloPosition["angles"] = (0, -90, 0);
		break;
		case "mp_boneyard":
			level.aHoloPosition["origin"] = (459.3, -239.868, 28.2875);
			level.aHoloPosition["angles"] = (0, 90, 0);
		break;
		case "mp_highrise":
			level.aHoloPosition["origin"] = (-69.0602, 6371.8, 3187.87);
			level.aHoloPosition["angles"] = (0, -180, 0);
		break;
		case "mp_nightshift":
			level.aHoloPosition["origin"] = (87, -2526, 720);
			level.aHoloPosition["angles"] = (0, 67, 0);
		break;
		case "mp_underpass":
			level.aHoloPosition["origin"] = (1705.06, 377.937, 837.003);
			level.aHoloPosition["angles"] = (0, 117.966, 0);
		break;
		//////////////////////////////////////////////////////////////
		case "mp_quarry":
			level.aHoloPosition["origin"] = (-3264.6, 1447.4, 190);
			level.aHoloPosition["angles"] = (0, 270, 0);
		break;
		case "mp_complex":
			level.aHoloPosition["origin"] = (68.8, -2467.5, 775);
			level.aHoloPosition["angles"] = (0, 270, 0);
		break;
		case "mp_estate":
			level.aHoloPosition["origin"] = (572.8, 1108.9, 410);
			level.aHoloPosition["angles"] = (0, 73.5, 0);
		break;
		case "mp_trailerpark":
			level.aHoloPosition["origin"] = (-1645.5, -82.0, 120);
			level.aHoloPosition["angles"] = (0, 0, 0);
		break;
		case "mp_vacant":
			level.aHoloPosition["origin"] = (-867.1, 417.3, 120);
			level.aHoloPosition["angles"] = (0, 180, 0);
		break;
		case "mp_brecourt":
			level.aHoloPosition["origin"] = (1562.4, -35.9, 120);
			level.aHoloPosition["angles"] = (0, 90, 0);
		break;
		case "mp_invasion":
			level.aHoloPosition["origin"] = (-2066.7, -2418.2, 470);
			level.aHoloPosition["angles"] = (0, 280, 0);
		break;
		case "mp_compact":
		break;
		case "mp_checkpoint":
			level.aHoloPosition["origin"] = (-1273.5, 432.9, 320);
			level.aHoloPosition["angles"] = (0, 270, 0);
		break;
		case "mp_storm":
			level.aHoloPosition["origin"] = (275.9, -2221.9, 300);
			level.aHoloPosition["angles"] = (0, 90, 0);
		break;
		case "mp_rundown":
			level.aHoloPosition["origin"] = (965, -270.8, 20);
			level.aHoloPosition["angles"] = (0, 85, 0);
		break;
		case "mp_derail":
			level.aHoloPosition["origin"] = (-249.1, 982.3, 330);
			level.aHoloPosition["angles"] = (0, 180, 0);
		break;
		case "mp_fuel2":
			level.aHoloPosition["origin"] = (-395.7, -158.9, 205);
			level.aHoloPosition["angles"] = (0, 0, 0);
		break;
		case "mp_crash":
			level.aHoloPosition["origin"] = (160.6, 332.4, 400);			
			level.aHoloPosition["angles"] = (0, 345, 0);
		break;
		case "mp_crash_trop":
			level.aHoloPosition["origin"] = (550, 1087, 385);			
			level.aHoloPosition["angles"] = (0, -90, 0);
		break;
		/*case "mp_crash_trop":
			level.aHoloPosition["origin"] = (160.6, 332.4, 400);			
			level.aHoloPosition["angles"] = (0, 345, 0);
		break;*/
		case "mp_strike":
			level.aHoloPosition["origin"] = (-1638.2, -1995.8, 550);
			level.aHoloPosition["angles"] = (0, 270, 0);
		break;
		case "mp_overgrown":
			level.aHoloPosition["origin"] = (-698.3, -1890.1, 100);
			level.aHoloPosition["angles"] = (0, 142, 0);
		break;
		case "mp_abandon":
			level.aHoloPosition["origin"] = (773.4, -1331.1, 120);
			level.aHoloPosition["angles"] = (0, 232.5, 0);
		break;
		case "iw4_credits":
			level.aHoloPosition["origin"] = (-753, -56, 290);
			level.aHoloPosition["angles"] = (0, 360, 0);
		break;
		case "mp_nuked":
			//level.aHoloPosition["origin"] = (-469.1, 387.5, 245);
			level.aHoloPosition["origin"] = (-28.4, -25.2, -110);
			level.aHoloPosition["angles"] = (0, 15, 0);
		break;
		case "oilrig":
			level.aHoloPosition["origin"] = (501.8, 941.2, 50);
			level.aHoloPosition["angles"] = (0, 270, 0);
		break;
		case "gulag":
			level.aHoloPosition["origin"] = (-3435, 27, 2235);
			level.aHoloPosition["angles"] = (0, 325, 0);
		break;
		case "invasion":
			level.aHoloPosition["origin"] = (598.0, -4403.9, 2538);
			level.aHoloPosition["angles"] = (0, 90, 0);
		break;
		case "so_ghillies":
			level.aHoloPosition["origin"] = (-15934.4, 6144.4, 655);
			level.aHoloPosition["angles"] = (0, 235, 0);
		break;
		case "contingency":
			//level.aHoloPosition["origin"] = (-12960.8, 206.5, 850);
			level.aHoloPosition["origin"] = (-13847.8, 2007.2, 1000);
			level.aHoloPosition["angles"] = (0, 0, 0);
		break;
	}
}