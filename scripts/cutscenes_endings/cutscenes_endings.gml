//function GameOver() {
//	game_restart();
//}

function GameEnding(){
	var _callback = function () {
			IllustrationSequenceCreate(
			spr_illustrations_end,
			[
				Text("Illustrations end: Loss"),
				Text("Illustrations end: Libra"),
				Text("Illustrations end: New Night")
			],
			function () {
				RemoveSave();
				with(global.music_manager) loop_delay = [5,7];
				forest_ambient_stop(false,fade_time.fast);
				instance_destroy(obj_game);
				LayersSetVisible(false);
				instance_deactivate_all(true);
				instance_activate_object(obj_illustration_sequence);
				instance_activate_object(global.music_manager);
			},
			function () {
				//var _tsrc = time_source_create(time_source_global,1,time_source_units_seconds,global.RunCredits);
				//time_source_start(_tsrc);	
				//RunCredits();
				room_goto(room_credits);
			}
		);
	}
	var _timeSource = time_source_create(time_source_global,8,time_source_units_seconds,_callback);
	time_source_start(_timeSource);
}

function RestartNewGame(){
	if(!global.boss_fight_on)
	{
		GameStartGeneral();
		PortalsUnblock();
		if(!global.tutorial_wave)
		{
			global.companion_alive = true;
			CompanionSoulDrop(irandom(1),companion_soul_drop_x,companion_soul_drop_y);
		}
		else
		{
			PortalsTutorialModeActivate();
		}
	}
	else
	{
		BossFightStart();
		BossStartLoaded();
	}
	
	global.restart_game = false;
	
	PlayerMakeFree();
	PlayerHeal(1,irandom(hp_frag_DM_id-1));
}

function PortalsTutorialModeActivate(){
	global.tutorial_wave = true;
	PortalsAddTutorialQueue();
	with(global.rightPortal)
	{
		PortalResumeSpawn();
	}
	with(global.leftPortal)
	{
		PortalStopSpawn();
	}
}

function GameStart()
{
	PlayerMakeFree();
	GameStartGeneral();
	PortalsTutorialModeActivate();
	SaveGame();
}

function DefeatRestart(){
	global.start_time = TIME_GAME_START;
	global.restart_game = true;
	global.restart_counter++;
	LoadGame();
	MusicStop(fade_time.fast);
}

function tutorial_end(){
		
	instance_destroy(global.current_text_box);
	global.current_text_box = noone;
		
	cutscene_tutorial_end();
	
	instance_destroy(global.current_cutscene);
	global.current_cutscene = noone;
}

function AfterTutorialWaveEnd(){
	global.tutorial_wave = false;
	with(global.oPlayer)
	{
		dark_matter_target = floor(dark_matter_target * 0.75);
	}
	PlayerMakeFree();
	PortalsUnblock();
	clock_unhide();
	SaveGame();
}

function GameVictory() {
	game_restart();
}

function cutscene_tutorial_end()
{
	
	//Make Sure About Player UI
	PlayerMakeStatic();
	
	////Ensure No SKill Consequences left
	//with(pobj_companion)
	//{
	//	DyingScript();	
	//}
	//with(obj_plant_companion)
	//{
	//	DyingScript();	
	//}
	
	//Make Sure About Staff
	with(obj_staff) instance_destroy();
	
	clock_hide();
	
	if(!global.onlyTutorial)
	{	
		//Start Music
		MusicStart(ms_illustration_music,fade_time.slow);
		IllustrationSequenceCreate(
			spr_illustrations_after_tutorial,
			[
				Text("Illustrations: tribes"),
				Text("Illustrations: enemies"),
				Text("Illustrations: shrine"),
				Text("Illustrations: druid"),
				Text("Illustrations: staff")
			],
			function() {
				forest_ambient_stop(false);
				LayersSetVisible(false);
				with(pobj_tower)
				{
					audio_pause_sound(step_sound);
				}
				DummyDestroy();
				instance_deactivate_all(true);
				instance_activate_object(global.music_manager);
				instance_activate_object(obj_illustration_sequence);
			},
			function() {
				global.oPlayer.x = player_x_start;
				global.oCamera.x = global.oPlayer.x;
				InstanceRotateCentrally(1,global.oPlayer);
				
				instance_activate_all();
				LayersSetVisible(true);
				
				global.time = TIME_GAME_START;
				
				PlayerDeactivateAllSpecials();
				PlayerResetCooldowns();
				
				var _tsrc = time_source_create(time_source_global,2,time_source_units_seconds,global.cutscene_run,[obj_CS_start]);
				time_source_start(_tsrc);
				//cutscene_run(obj_CS_start);
				
				MusicStop();
				forest_ambient_start();
				with(pobj_tower)
				{
					audio_resume_sound(step_sound);
				}
		
				TutorialShrineDestroy();
		
				//Save The Info About Watched Illustration
				if(global.illustrations_watched = false && global.illustrations_watched_this_time = true)
				{
					global.illustrations_watched = global.illustrations_watched_this_time;
					ini_open(global.game_data);
					ini_write_real(global.data_section,"Illustrations Watched",global.illustrations_watched_this_time);
					ini_close();
				}	
			}
		);
	}
	else
	{
		global.onlyTutorial = false;
		FadeInRoom(room0,noone);	
	}
	
}

function CS_dark_matter_unleash_end(){
	clock_unhide();
	PlayerMakeFree();
	with(obj_momma)
	{
		invoking = true;	
	}
	with(global.oPlayer)
	{
		dark_matter_current = 0;
		dark_matter_target = 0;
	}
	PortalsUnblock();
	obj_game.alarm[1] = floor(FRAME_RATE * 1);//Save Game
}

function CS_DM_unleash_last(){
	
	CS_dark_matter_unleash_end();
	
	ContinueGame();
	
	with(pobj_enemy)
	{
		drop_matter = false;
		DyingScript();
	}
	
	PlayerHideDarkMatterBar();
	
	with(obj_game) alarm[2] = FRAME_RATE * 5;//Run Boss Cutscene
	
	//global.boss_CS_to_watch = true;
	
	SaveGame();
	
}

function BossFightStart(){
	global.boss_fight_on = true;
	
	BossDisplayGUI();
	CameraStateChange(CameraStateFollowDouble);
	CameraChangeSecondaryTarget(global.oBoss);
	CameraChangeTarget(global.oPlayer);
	
	with(global.music_manager)
	{
		loop_delay = [5,10];
		MusicStart(ms_boss_second_stage,fade_time.slow,global.MusicCallbackLoopDelayed);
	}

	BestiaryEnqueue(BESTIARY_PAGE_TYPE.TEXT,Text("tutorial bestiary: boss"));
	
	with(pobj_wall_barrier)
	{
		sprite_index = spr_wall_barrier_crystal;
		barrier_working = true;
	}
	
	//instance_destroy(global.music_manager);
	//global.music_manager = instance_create_layer(0,0,"Managers",obj_boss_music_manager);
	//with(pobj_music_manager)
	//{
	//	MusicStart(ms_boss_second_stage,MILI_TO_SECONDS*3);
	//}
}

function preboss_CS_end()
{
	PlayerMakeFree();
	with(global.oPlayer)
	{
		PlayerHeal(max_hp-current_hp,hp_frag_DM_id);	
	}
	global.oPlayer.dark_matter_current = 0;
	global.oPlayer.dark_matter_target = 0;
	PlayerHideDarkMatterBar();
	BossFightStart();
	with(global.oBoss)
	{
		EntityMakeFree();
		movement_direction = EnemyFindMovementDirection();
		BossSurgeNewHP();	
	}
	SaveGame();
}








