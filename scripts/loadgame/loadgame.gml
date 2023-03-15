function LoadGame(){
	global.game_loaded = true;
	FadeInRoom(room0,noone);
}

function BossStartLoaded(){
	with(global.oBoss)
	{
		if(bossCurentStage == 0 || 	bossCurentStage == bossStageNum - 1)
		{
			EntityMakeFree();
			movement_direction = EnemyFindMovementDirection();
			BossSurgeNewHP();
		}
		else
		{
			BossMakeInviolable();
			alarm[2] = FRAME_RATE * 2;	
		}
	}
	BossFightStageTransition(boss_idle_form_enum);
}

function LoadedGameDataApply(){
	ini_open(global.game_data);
	
	global.companion_alive = ini_read_real(global.game_section,"Companion Alive",global.companion_alive);
	if(global.companion_alive && !global.restart_game)
	{
		CompanionSoulDrop(irandom(1),companion_soul_drop_x,companion_soul_drop_y);	
	}
	
	#region Player HP Leaves Load
	
	global.dark_matter_unleash = ini_read_real(global.game_section,"Dark Matter Counter",0);
	
	global.oPlayer.current_hp = ini_read_real(global.game_section,"Player HP",global.oPlayer.max_hp);
	var _default_leaves_str = "0000";
	repeat(global.dark_matter_unleash)
	{
		PlayerMaxHPIncrease();
		_default_leaves_str += "0";
	}
	
	var _leaves_str = ini_read_string(global.game_section,"Player HP Leaves",_default_leaves_str);
	var _hp_num = array_length(global.oPlayer.hp_leaves);
	for(var i = 0; i < _hp_num;i++)
	{
		var _hp_id = int64(string_char_at(_leaves_str,i+1));
		global.oPlayer.hp_leaves[i] = _hp_id;
	}
	#endregion
	
	#region Player Specials Progress Load
	var _player_skill_special_prog_str = ini_read_string(global.game_section,"Player Specials Progress","0000");
	for(var i = 0; i < SKILLS.NUMBER; i++)
	{
		//var _skill_prog = int64(_player_skill_special_prog_str[i])
		var _skill_prog = int64(string_char_at(_player_skill_special_prog_str,i+1));
		repeat(_skill_prog)
		{
			PlayerSpecialAddProgress(i);	
		}
	}
	#endregion
	
	#region Loading Into Boss Fight
	
	global.boss_fight_on = ini_read_real(global.game_section,"Boss Fight On",global.boss_fight_on);
	if(global.boss_fight_on)
	{
		instance_destroy(obj_enemy_portal);
		BossCreateLoaded();
		
		#region //Load Defeated States
		var _states_left_str = ini_read_string(global.game_section,"Boss States Left","1111");
		for(var i = 0; i < SKILLS.NUMBER; i++)
		{
			if(!int64(string_char_at(_states_left_str,i+1)))//If state not available
			{
				with(global.boss_manager)
				{
					BossManagerDestroyFragment(i);	
				}
			}
		}
		
		var _boss_current_stage = ini_read_real(global.game_section,"Boss Current Stage",0);
		global.oBoss.bossCurentStage = _boss_current_stage;
		global.boss_manager.bossCurentStage = _boss_current_stage;
		
		//with(global.oBoss)
		//{
		//	if(bossCurentStage != 0 || 	bossCurentStage != bossStageNum - 1)
		//	{
		//		BossMakeInviolable();
		//		alarm[2] = FRAME_RATE * 2;	
		//	}
		//}
		
		//global.boss_first_steal_enum = boss_idle_form_enum; // To Make Boss Enter Idle State On Start
		#endregion
		
		BossConditionsApply();
		
		if(!global.restart_game)
		{
			BossFightStart();
			BossStartLoaded();
		}
		
		return;
	}
	//if(ini_read_real(global.game_section,"Boss Cutscene Watch",false))
	//{
	//	instance_destroy(obj_enemy_portal);
	//	cutscene_run(obj_CS_boss_fight);
	//}
	
	#endregion
	
	var _tutorial_wave_default = true;
	if(global.quick_started) _tutorial_wave_default = false;
	with(obj_enemy_portal)
	{
		portal_hp -= global.dark_matter_unleash;
		if(portal_hp <= 0)
		{
			instance_destroy();
			with(obj_game) alarm[2] = FRAME_RATE * 4;//Run Boss Cutscene
		}
		else
		{
			PortalUpdateBalance();
			PortalResumeSpawn();
		}
	}
	global.tutorial_wave = ini_read_real(global.game_section,"Tutorial Wave",_tutorial_wave_default);
	if(global.tutorial_wave)
	{
		PortalsTutorialModeActivate();
		instance_destroy(obj_companion_soul);
	}
	
	global.leftCandle.current_hp = ini_read_real(global.game_section,"Candle Left HP",global.leftCandle.current_hp);
	global.rightCandle.current_hp = ini_read_real(global.game_section,"Candle Right HP",global.rightCandle.current_hp);
	obj_shrine.current_hp = ini_read_real(global.game_section,"Shrine HP",obj_shrine.max_hp);
	with(pobj_tower)
	{
		if(current_hp <= 0)
		{
			DyingScript();
		}
		else
		{
			find_hp_relatives();	
		}
	}
	
	ini_close();	
}