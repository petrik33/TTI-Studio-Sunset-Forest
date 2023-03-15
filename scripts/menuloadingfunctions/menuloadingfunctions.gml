function MenuLoadSoundSettings(){
	//var _audio_page = menu_page.audio;
	var audio_settings_map = DS_MapLoadFromJSON(global.audio_settings_file);
	//menu_pages[@ _audio_page][@ 0][@ menu_element.current_value] = audio_settings_map[? "Music"];
	//menu_pages[@ _audio_page][@ 1][@ menu_element.current_value] = audio_settings_map[? "Sounds"];
	global.music_group_gain = audio_settings_map[? "Music"];
	global.sounds_group_gain = audio_settings_map[? "Sounds"];
	ds_map_destroy(audio_settings_map);
	
	//audio_group_set_gain(music,global.music_group_gain,0);
	//audio_group_set_gain(audiogroup_default,global.sounds_group_gain,0);
}

function MenuLoadControls(){
	var controls_map = DS_MapLoadFromJSON(global.controls_file);
	
	//var alternative_controls_page = menu_pages[@ menu_page.alternative_keys];
	//var skills_controls_page = menu_pages[@ menu_page.skills_controls];
	
	//Skills Controls
	for(var i = 0;i<array_length(global.default_skill_controls);i++)
	{
		//skills_controls_page[@ i][@ menu_element.current_value] = _new_control;
		//skills_controls_page[@ i][@ menu_element.first_entry] = chr(_new_control);
		
		//Update Player
		with(global.oPlayer)
		{
			var control_name = TextTranslate(skills[i][SKILL.NAME],LANGUAGE.ENG);
			var _new_control = controls_map[? control_name];
			global.controls_used[i] = _new_control;
			skills[@ i][@ SKILL.HOTKEY] = _new_control;	
		}
	}
	
	global.alternative_controls_on = controls_map[? "Alternative Toggle"];
	
	//Alternative Controls
	if(global.alternative_controls_on)
	{
		for(var k = 0;k<array_length(global.default_alternative_controls);k++)
		{
			//alternative_controls_page[@ k][@ menu_element.current_value] = _new_control;
			//alternative_controls_page[@ k][@ menu_element.first_entry] = chr(_new_control);
			with(global.oPlayer)
			{
				var control_name = alternative_controls_names[k];
				var _new_control = controls_map[? control_name];
				global.controls_used[i + k] = _new_control;
				alternative_controls[@ k] = _new_control;
			}	
		}
		
		//menu_pages[menu_page.controls][1][menu_element.current_value] = true;
		//menu_pages[menu_page.alternative_keys][alternative_key.attack][menu_element.value_range] = true;
		//menu_pages[menu_page.alternative_keys][alternative_key.push][menu_element.value_range] = true;
	}	
}
	
function MenuLoadGameData(){
	ini_open(global.game_data);
	global.save_exists = ini_read_real(global.data_section,"Save Exists",0);
	global.start_time = ini_read_real(global.data_section,"Game Time",TIME_GAME_START);
	global.illustrations_watched = ini_read_real(global.data_section,"Illustrations Watched",false);
	global.boss_first_steal_enum = ini_read_real(global.data_section,"Boss Enum",0);
	global.photosensitive = ini_read_real(global.data_section,"Photosensitive",0);
	global.language = ini_read_real(global.data_section,"Language",LANGUAGE.ENG);
	ini_close();
}