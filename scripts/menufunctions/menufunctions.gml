function ChangeSoundsVolume(volume){
	//audio_group_set_gain(audiogroup_default,volume,0);
	global.sounds_group_gain = volume;
}

function ChangeMusicVolume(volume){
	//audio_group_set_gain(music,volume,0);
	global.music_group_gain = volume;
}

//function DebugDataToggle(_toggle){
//	global.live_debug_data_on = _toggle;
//}	

function AlternativeControlsToggle(_toggle){
	
	global.alternative_controls_on = _toggle;
	obj_game.alarm[0] = 1;//Cursor Wake Up Check
	for(var i = 1;i<array_length(global.default_alternative_controls);i++)
	{
		menu_pages[@ menu_page.alternative_keys][@ i][@ menu_element.value_range] =_toggle;	
	}
	
}

function PhotosensitiveToggle(_toggle){
	global.photosensitive = _toggle;
}

function WindowSetSize(window_width,window_height){
	window_set_size(window_width,window_height);	
	with(obj_game) alarm[3] = 1;//Window Center
	WindowSet(window_width,window_height);
}

function WindowedToggle(_toggle)
{
	var display_w = display_get_width();
	var display_h = display_get_height();
	
	var window_width = display_w;
	var window_height = display_h;
	
	if(_toggle)
    {
		window_width = floor(window_width / windowed_downscale);
		window_height = floor(window_height / windowed_downscale);
    }
	
	global.windowed = _toggle;
	
	
	WindowSetSize(window_width,window_height);
	window_set_fullscreen(!_toggle);
	room_goto(room0);
	//MenuLineCountHeight(false);
	//MenuLineCountPosition(menu_side_x,menu_side_y);
}

///@arg language
function MenuChangeLanguage(lang){
	global.language = lang;
	MenuSaveLanguage();
	room_goto(room0);
}

function SoundsOff(){
	menu_pages[menu_page.audio][0][menu_element.current_value] = 0;
	menu_pages[menu_page.audio][1][menu_element.current_value] = 0;
	ChangeSoundsVolume(0);
	ChangeMusicVolume(0);
}

function SoundsFull(){
	menu_pages[menu_page.audio][0][menu_element.current_value] = 1 * menu_pages[menu_page.audio][0][menu_element.value_factor];
	menu_pages[menu_page.audio][1][menu_element.current_value] = 1 * menu_pages[menu_page.audio][1][menu_element.value_factor];
	ChangeSoundsVolume(1);
	ChangeMusicVolume(1);
}
	
function MenuAllEnemiesOn(){
	
	for(var i = 0; i < ENEMIES.VOA; i++)
	{
		global.enemies[ENEMY.ACTIVE][@ i] = true;	
	}
		
}
	
function QuitToMainMenu(){
	game_restart();
}	
	
function MenuStartSavedGame(){
	LoadGame();
}
	
function MenuPhotoModeOn(){
	sleeping = true;
	menu_active = false;
	menu_in_photo_mode = true;
	image_alpha = 0;
}
	
function MenuHeadToPhotoModePage(){
	previous_page = current_page;
	current_page = menu_page.photo_mode;
	DayNightPausedModeSwitch(1,0);
}
	
function MenuRunCredits(){
	FadeInRoom(room_credits,-1);
	forest_ambient_stop(false,fade_time.fast);
	//MusicStop(fade_time.fast);
	menu_active = false;
}
	
//function MenuAddGameEnemies(){
	
//	//var _enemies_element = menu_pages[menu_page.enemies][1];
	
//	////Fullfill the List
//	//for(var i = 0;i<array_length(_enemies_element[menu_element.current_value]);i++)
//	//{
//	//	if(_enemies_element[menu_element.current_value][i] = true)
//	//	{
//	//		ds_list_add(global.enemies_list,_enemies_element[menu_element.value_range][i]);
//	//	}
//	//}
	
//	////In case all enemies are off
//	//if(ds_list_empty(global.enemies_list))
//	//{
//	//	global.enemies[| 0] = obj_enemy;
//	//}
	
//}
	
function StartGame(){
	
	time_set_transition(TIME_GAME_START,FRAME_RATE * 3);
	
	cutscene_run(obj_CS_tutorial);
	
	MenuClose();
	
	//MusicStop(fade_time.slow);
	
}
	
function StartTutorialOnly(){
	StartGame();
	global.onlyTutorial = true;
}

function ControlsSetDefault(){
	var alternative_controls_page = menu_pages[@ menu_page.alternative_keys];
	var skills_controls_page = menu_pages[@ menu_page.skills_controls];
	
	//Change Skills
	for(var i=0;i<array_length(global.default_skill_controls);i++)
	{
		var _control_element = skills_controls_page[@ i];
		_control_element[@ menu_element.current_value] = global.default_skill_controls[i];
		_control_element[@ menu_element.first_entry] = chr(global.default_skill_controls[i]);
	}
	
	global.alternative_controls_on = false;
	var _controls_page = menu_pages[@ menu_page.controls];
	_controls_page[@ (alternative_keys_element - 1)][@ menu_element.current_value] = false;
	_controls_page[@ alternative_keys_element][@ menu_element.current_value] = false;
	
	for(var k=0;k<array_length(global.default_alternative_controls);k++)
	{
		var _control_element = alternative_controls_page[@ k];	
		_control_element[@ menu_element.current_value] = global.default_alternative_controls[k];
		_control_element[@ menu_element.first_entry] = chr(global.default_alternative_controls[k]);
		if(k>0) _control_element[@ menu_element.value_range] = false;
		
	}
}

function ExitGame(){
	game_end();
}

function BossCreateLoaded(){
	global.oBoss = instance_create_layer(boss_spawn_x - tile_w * 4,FLOOR_Y - boss_dist_to_floor,"Boss",obj_boss);	
}

function BossConditionsApply(){
	global.companion_alive = false;
	
	//PlayerHeal(portal_max_hp,hp_frag_DM_id);
	
	//Player Max HP Increase
	//with(global.oPlayer)
	//{
	//	for(var i = 0; i < portal_max_hp; i++)//Times you unleash dark matter
	//	{
	//		PlayerMaxHPIncrease();
	//	}
	//}
	
	with(pobj_wall_barrier)
	{
		x = shrine_x - final_fight_edges_range * image_xscale;
	}
	
	global.crystal = instance_create_layer(shrine_x,CS_boss_crystal_underground_y,"Effects",obj_crystal);
	with(global.crystal)
	{
		light_instance = obj_shrine.crystal_light;
		stopped = true;
	}
	
	global.boss_earthquake = true;
	instance_destroy(pobj_tower);
	global.boss_earthquake = false;
	
	global.leftEdge = shrine_x - final_fight_edges_range;
	global.rightEdge = shrine_x + final_fight_edges_range;
}
	
function BossFightQuickTest(){
	MenuClose();
	GameStartGeneral();
	PlayerWakeUpFree();
	TutorialShrineDestroy();
	forest_ambient_stop(false);
	BossCreateLoaded();
	BossConditionsApply();
	BossFightStart();
	BossQuickLoad();
	SaveGame();
}

function BossQuickLoad(){
	global.dark_matter_unleash = portal_max_hp;
	repeat(portal_max_hp) { PlayerMaxHPIncrease() };
	PlayerHeal(portal_max_hp,hp_frag_DM_id);
	
	with(global.oBoss)
	{
		//EntityMakeFree();
		if(global.boss_first_steal_enum != boss_idle_form_enum)
		{
			bossCurentStage = 1;
			with(global.boss_manager) bossCurentStage = 1
			BossAffectedStateChange(global.boss_first_steal_enum);
			//boss_steal_count_list[global.boss_first_steal_enum] = true;
			with(global.oPlayer)
			{
				skills[global.boss_first_steal_enum][SKILL.AVAILABLE] = false;//Block Player's Skill
			}
			//global.boss_first_steal_enum = noone;
		}
		else
		{
			BossFightStageTransition(boss_idle_form_enum);
			with(global.oBoss)
			{
				EntityMakeFree();	
			}
			//global.boss_first_steal_enum = irandom(SKILLS.NUMBER - 1);	
		}
	}	
}

function DayNightDebugModeRun(){
	instance_destroy(global.time_cycler);
	global.time_cycler = instance_create_layer(0,0,"Managers",obj_time_cycler_debug_version);
	previous_page = current_page;
	current_page = menu_page.day_night_debug;
	MenuLineCountHeight(true);
	MenuLineCountPosition(1,1);
	widest_entry = max(widest_entry,WidestEntryFind(current_page));
	//instance_destroy(self);
	//instance_create_layer(global.GUI_W - GUI_BOUND - 32,global.GUI_H - GUI_BOUND - 32,"GUI",obj_back_button);
	CameraStateChange(CameraStateControlled);
}

function DayNightDebugSaveValues(){
	var save_string = "";
	var _shader_values = global.time_cycler.shader_values[global.day_night_debug_current_point];
	for(var i = 0; i < COLOR_MIX.last;i++)
	{
		var _current_value = _shader_values[DAY_NIGHT_SHADER.COLORS_ID][i] * 255;
		save_string += (string(int64(_current_value)) + ",");	
	}
	for(var i = 0; i < CON_SAT_BRT.last; i++)
	{
		var _current_value = _shader_values[DAY_NIGHT_SHADER.CON_SAT_BRT_ID][i];
		save_string += string(_current_value);
		if( i != CON_SAT_BRT.last - 1)
		{
			save_string +=	",";
		}
	}
	var _file_name = "Sunset Forest Debug Data " + string(global.day_night_debug_current_point + 1) + ".txt";
	StringSaveInFile(save_string,_file_name);
}
	
function DayNightDebugReset(){
	with(global.time_cycler)
	{
		shader_values[global.day_night_debug_current_point] = [default_colors,default_con_sat_brt];
	}
	for(var i = 0; i < COLOR_MIX.last;i++)
	{
		menu_pages[menu_page.day_night_debug][i+CON_SAT_BRT.last][menu_element.current_value] = global.time_cycler.default_colors[i];	
	}
	for(var i = 0; i < CON_SAT_BRT.last; i++)
	{
		menu_pages[menu_page.day_night_debug][i][menu_element.current_value] = global.time_cycler.default_con_sat_brt[i];	
	}
}

function DayNightDebugModeExit(){
	instance_destroy(global.time_cycler);
	global.time_cycler = instance_create_layer(0,0,"Managers",obj_time_cycler);
	current_page = previous_page
	previous_page = menu_page.day_night_debug;
	MenuLineCountHeight(false);
	MenuLineCountPosition(1,1);
	widest_entry = max(widest_entry,WidestEntryFind(current_page));
	//instance_destroy(self);
	//instance_create_layer(global.GUI_W - GUI_BOUND - 32,global.GUI_H - GUI_BOUND - 32,"GUI",obj_back_button);
	CameraStateChange(CameraStateStatic);
	global.oCamera.x = camera_start_x;
}

///@arg enum
function BossSetFirstSteal(_skill_id){
	global.boss_first_steal_enum = _skill_id;
}

function MenuClose(){
	instance_destroy(self);//Delete Menu
	MenuSaveSettings();
	//MenuAddGameEnemies();
}

function MenuQuickStart(){
	CompanionSoulDrop(irandom(1),companion_soul_drop_x,companion_soul_drop_y);
	global.companion_alive = true;
	QuickStart();
	SaveGame();
}

///@arg
function PortalCreate(_side){
	var _spawn_point = spawn_point_right_x;
	if(_side == -1)
	{
		_spawn_point = spawn_point_left_x;	
	}
	var _inst = instance_create_layer(_spawn_point,FLOOR_Y - spawn_point_y,"Shrines",obj_enemy_portal);
	with(_inst)
	{
		side = _side;
		image_xscale = -_side;
		spawn_cooldown = irandom_range(about_to_spawn_offset + 10,spawn_time);
		state = PortalStateOpened;
	}
	return _inst;
}

function ConnectPortals(){
	with(global.rightPortal) another_portal = global.leftPortal;
	with(global.leftPortal) another_portal = global.rightPortal;
}
	
function QuickStart()
{
	forest_ambient_stop(false);
	
	TutorialShrineDestroy();
	
	#region//Create Portals
	
	global.rightPortal = PortalCreate(1);
	global.leftPortal = PortalCreate(-1);
	
	ConnectPortals();
	
	#endregion
	
	global.start_time = TIME_GAME_START;
	
	if(!global.restart_game)
	{
		global.time_cycler.time_state = time_state_free;
		PlayerWakeUpFree();
		GameStartGeneral();
		PortalsResumeSpawning();
	}
	else
	{
		time_state = time_state_stop;
	}
	
	with(global.time_cycler)
	{
		time_set_transition(global.start_time,FRAME_RATE * 3);
	}
	
	if(!global.game_loaded)
	{
		MenuClose();
		global.quick_started = true;
	}
	
}



