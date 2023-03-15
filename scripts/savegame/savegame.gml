function SaveGame() {
	global.save_exists = true;
	ini_open(global.game_data);
	ini_write_real(global.data_section,"Save Exists",global.save_exists);
	ini_write_real(global.data_section,"Game Time",global.time);
	ini_write_real(global.game_section,"Dark Matter Counter",global.dark_matter_unleash);
	ini_write_real(global.game_section,"Tutorial Wave",global.tutorial_wave);
	ini_write_real(global.game_section,"Companion Alive",global.companion_alive);
	//ini_write_real(global.game_section,"Boss Cutscene Watch",global.boss_CS_to_watch);
	
	ini_write_real(global.game_section,"Boss Fight On",global.boss_fight_on);
	var _boss_states_left_str = "";
	var _boss_current_stage = 0;
	if(instance_exists(obj_boss_manager))
	{
		var _states_available = global.boss_manager.boss_affecteds_available;
		for(var i = 0; i < SKILLS.NUMBER; i++)
		{
			_boss_states_left_str += string(_states_available[i]);
		}
		
		_boss_current_stage = global.boss_manager.bossCurentStage;
	}
	
	ini_write_string(global.game_section,"Boss States Left",_boss_states_left_str);
	ini_write_real(global.game_section,"Boss Current Stage",_boss_current_stage);
	
	ini_write_real(global.game_section,"Player HP",global.oPlayer.current_hp);
	var _player_skill_special_prog_str = "";
	for(var i = 0; i < SKILLS.NUMBER; i++)
	{
		var _skill_prog = global.oPlayer.skills[i][SKILL.SPECIAL_PROGRESS];
		_player_skill_special_prog_str += string(_skill_prog);
	}
	ini_write_string(global.game_section,"Player Specials Progress",_player_skill_special_prog_str);
	//var _leaves_number = 0;
	var _hp_leaves = global.oPlayer.hp_leaves;
	var _leaves_str = "";
	for(var i = 0; i < array_length(_hp_leaves);i++)
	{
		var _leaf_number = _hp_leaves[i];
		_leaves_str += string(_leaf_number);
	}
	ini_write_string(global.game_section,"Player HP Leaves",_leaves_str);
	
	if(!instance_exists(global.leftCandle))
	{
		ini_write_real(global.game_section,"Candle Left HP",0);
	}
	else
	{
		ini_write_real(global.game_section,"Candle Left HP",global.leftCandle.current_hp);
	}
	
	if(!instance_exists(global.rightCandle))
	{
		ini_write_real(global.game_section,"Candle Right HP",0);
	}											   
	else										   
	{											   
		ini_write_real(global.game_section,"Candle Right HP",global.rightCandle.current_hp);
	}
	if(instance_exists(obj_shrine))
	{
		ini_write_real(global.game_section,"Shrine HP",obj_shrine.current_hp);
	}
	else
	{
		ini_write_real(global.game_section,"Shrine HP",0);	
	}
	ini_close();
	
	//TextNotification(global.GUI_W - text_separation,text_separation,Text("Game Saved"),,fa_right,fa_middle);
	SaveNotificationCreate();
	
}

function RemoveSave () {
	global.save_exists = false;
	ini_open(global.game_data);
	ini_write_real(global.data_section,"Save Exists",global.save_exists);	
	ini_close();
}

function SaveNotificationCreate() {
	var _x = global.GUI_W - sprite_get_width(spr_game_saved)/2 - GUI_BOUND;
	var _y = sprite_get_height(spr_game_saved)/2 + GUI_BOUND;
	var _inst = instance_create_layer(_x,_y,"GUI",obj_game_saved);
	if(!global.game_saved_bestiary_opened)
	{
		BestiaryEnqueue(BESTIARY_PAGE_TYPE.TEXT,Text("Bestiary: Game Saved"));
		global.game_saved_bestiary_opened = true;
	}
	return _inst;
}