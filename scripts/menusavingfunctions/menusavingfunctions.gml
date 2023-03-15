function MenuSaveSettings(){
	
	MenuSaveAndUpdateControls();
	
	MenuSaveSoundSettings();
	
	MenuSaveLanguage();
	
	MenuSaveGameData();
	
	SaveEnemiesData(global.enemies_datafile)
}

function MenuSaveAndUpdateControls(){
	
	#region//Create DS_MAP and Update Player
	var new_controls_map = ds_map_create();
	var controls_page = menu_pages[menu_page.skills_controls];
	
	for(var i=0;i<=SKILLS.THUNDER;i++)
	{
		var _control_element = controls_page[i];
		var _control_code = _control_element[menu_element.current_value];
		var _control_name = TextTranslate(_control_element[menu_element.name],LANGUAGE.ENG);
		ds_map_add(new_controls_map, _control_name  , _control_code);
		
		//Update Player
		with(global.oPlayer)
		{
			skills[@ i][@ SKILL.HOTKEY] = _control_code;	
		}
	}
	
	ds_map_add(new_controls_map, "Alternative Toggle", global.alternative_controls_on);
	var alternative_controls_page = menu_pages[menu_page.alternative_keys];
	
	for(var k=0;k<=alternative_key.push;k++)
	{
		var _control_element = alternative_controls_page[k];
		var _control_code = _control_element[menu_element.current_value];
		var _control_name =	TextTranslate(_control_element[menu_element.name],LANGUAGE.ENG);
		ds_map_add(new_controls_map, _control_name  , _control_code);
		with(global.oPlayer)
		{
			alternative_controls[@ k] = _control_code;
		}
	}
	
	#endregion
	
	DS_MapSaveToJSON(new_controls_map,global.controls_file)
	
	ds_map_destroy(new_controls_map);
}

function MenuSaveSoundSettings(){
	var audio_page_num = menu_page.audio;
	var audio_settings_map = ds_map_create();
	audio_settings_map[? "Music"] = menu_pages[audio_page_num][0][menu_element.current_value] / 10;
	audio_settings_map[? "Sounds"] = menu_pages[audio_page_num][1][menu_element.current_value] / 10;
	DS_MapSaveToJSON(audio_settings_map,global.audio_settings_file);
	ds_map_destroy(audio_settings_map);
}

function MenuSaveLanguage(){
	ini_open(global.game_data);
	ini_write_real(global.data_section,"Language",global.language);
	ini_close();
}
	
function MenuSaveGameData(){
	ini_open(global.game_data);
	ini_write_real(global.data_section,"Illustrations Watched", global.illustrations_watched)
	ini_write_real(global.data_section,"Boss Enum",global.boss_first_steal_enum);
	ini_write_real(global.data_section,"Photosensitive",global.photosensitive);
	ini_close();
}