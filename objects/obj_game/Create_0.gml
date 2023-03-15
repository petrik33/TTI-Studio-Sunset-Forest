randomize();

audio_falloff_set_model(audio_falloff_exponent_distance_clamped);

#region//Globals

global.boss_first_steal_enum = irandom(SKILLS.THUNDER);

global.game_is_paused = false;
global.pause_available = true;

global.sounds_group_gain = 1;
global.music_group_gain = 1;

global.quick_started = false;

global.last_tutorial_enemy = false;
//global.tutorial_wave_current_portal = 1;
//global.game_final = false;

global.dummy_targets_queue = ds_queue_create();
global.dummy_exists = false;

global.boss_earthquake = false;
global.boss_fight_on = false;
global.oBoss = noone;

global.alternative_controls_on = false;

global.crystal = noone;

global.gui_show = true;

global.restart_counter = 1;
global.restart_game = false;
global.game_loaded = false;

global.companion_alive = false;

global.onlyTutorial = false;

global.photosensitive = false;

global.dark_matter_unleash = 0;

global.windowed = debug_windowed;

//Audio
forest_ambient = noone;
forest_ambient_asset = sn_forest_ambient;

global.bestiary = noone;
global.bestiary_queue = ds_queue_create();

global.save_exists = false;

//Particle Systems
global.particle_system = noone;
//global.particle_system_front = noone;
global.gui_particle_system = noone;

global.leftPortal = noone;
global.rightPortal = noone;

global.illustrations_watched = false;
global.illustrations_watched_this_time = true;

global.boss_manager = noone;
global.boss = noone;

global.tutorial_wave = false;
//global.boss_CS_to_watch = false;

//Map Edges
//global.leftEdge = spawn_point_left_x;
//global.rightEdge = spawn_point_right_x;

global.day_night_debug_current_point = 0;

global.start_time = TIME_GAME_START;

#region Controls

global.controls_file_reset = false;

global.forbidden_controls = [vk_left,vk_right,vk_space,vk_escape,vk_shift,ord("A"),ord("D")];

global.default_skill_controls = [ord("Q"),ord("W"),ord("E"),ord("R")];

global.alternative_controls_on = false;

global.default_alternative_controls = [ord("S"),ord("J"), ord("K")];

var _controls_number = array_length(global.default_skill_controls) + array_length(global.default_alternative_controls);
global.controls_used = array_create(_controls_number,noone);

for(var i = 0; i < array_length(global.default_skill_controls); i++)
{
	global.controls_used[i] = global.default_skill_controls[i];	
}

for(var k = 0; k < array_length(global.default_alternative_controls); k++)
{
	global.controls_used[i + k] = global.default_alternative_controls[k];	
}

#endregion

#region//Text
global.game_on = false; 
global.text_speed = .62;
global.current_text_box = -1;
global.current_cutscene = noone;
global.language = LANGUAGE.ENG;
global.text_sound = noone;
#endregion

#region//Enemies

global.enemies = array_create(ENEMY.ARRAY_SIZE);
//Debug
global.enemies[ENEMY.OBJECT] = [obj_enemy,obj_flying_enemy,obj_cool_enemy,obj_ruga,obj_coluna,obj_voa,obj_momma,obj_douhta];
global.enemies[ENEMY.NAME] = ["Shooka", "Komar", "Bohra", "Ruga", "Coluna","Voa","Momma","Douhta"];
global.enemies[ENEMY.ACTIVE] = [1,1,1,1,1,0,0,0];
global.enemies[ENEMY.IDLE] =
[
	spr_enemy_idle,
	spr_enemy_flying_idle,
	spr_enemy_cool_idle,
	spr_ruga_walking,
	spr_coluna_activated_idle,
	spr_voa_idle,
	spr_momma_idle,
	spr_douhta_idle
];
global.enemies[ENEMY.PORTRAIT] = 
[
	spr_enemy_portrait,
	spr_komar_portrait,
	spr_cool_enemy_portrait,
	spr_ruga_portrait,
	spr_coluna_portrait,
	spr_voa_portrait,
	spr_momma_portrait,
	spr_douhta_portrait
];
global.enemies[ENEMY.MAX_HP] = [3,3,4,4,3,2,1,4];
global.enemies[ENEMY.BESTIARY_OPENED] = array_create(ENEMIES.NUMBER,false);

#region//Loading Enemies Active Data

global.enemies_datafile = "EnemiesData.json";
if(file_exists(global.enemies_datafile))
{
	LoadEnemiesData(global.enemies_datafile);
}
else
{
	SaveEnemiesData(global.enemies_datafile);
}

#endregion

#endregion

#endregion

#region Font Alternatives

global.font_alternatives_ru = ds_map_create();
global.font_alternatives_ru[? fn_buttons] = fn_buttons_crlc;
global.font_alternatives_ru[? fn_bestiary] = fn_bestiary_crlc;
global.font_alternatives_ru[? fn_bestiary_title] = fn_bestiary_title_crlc;
global.font_alternatives_ru[? fn_cutscenes] = fn_cutscenes_crlc;
global.font_alternatives_ru[? fn_illustrations] = fn_illustrations_crlc;
global.font_alternatives_ru[? fn_menu] = fn_menu_crlc;
global.font_alternatives_ru[? fn_percents] = fn_percents_crlc;
global.font_alternatives_ru[? fn_queen] = fn_queen_crlc;
global.font_alternatives_ru[? fn_secondary_cutscenes] = fn_secondary_cutscenes_crlc;
global.font_alternatives_ru[? fn_secondary_illustrations] = fn_secondary_illustrations_crlc;

#endregion

#region Bestiary

enum FLASH_TYPE {
	ENEMY_SPAWN,
	CANDLE_DAMAGED,
	MOMMA_VOA_SPAWN,
	ENUM_SIZE
}

global.flash_bestiary_opened = array_create(FLASH_TYPE.ENUM_SIZE,false);
global.game_saved_bestiary_opened = false;

#endregion

#region Managers Creation

global.music_manager = instance_create_layer(0,0,"Managers",pobj_music_manager);
global.oCamera = instance_create_layer(0,0,"Managers",obj_camera);
global.time_cycler = noone;
if(debug_manager_enabled)
{
	global.debug_manager = instance_create_layer(0,0,"Managers",obj_debug_manager);
}

#endregion

#region Save Files

global.game_data = "Game Data.ini";
global.data_section = "Data";
global.game_section = "Game";

global.controls_file = "Controls Settings.json";
global.audio_settings_file = "Audio Settings.json";

#endregion

#region//Cursor

cursor_sprite = spr_game_cursor;
window_set_cursor(cr_none)

cursor_sleep_check_frequency = 3;
cursor_sleeping_counter = 0;
cursor_sleep_limit = FRAME_RATE * 5 / cursor_sleep_check_frequency;

alarm[0] = cursor_sleep_check_frequency;

mouse_position = [floor(device_mouse_x_to_gui(0)),floor(device_mouse_y_to_gui(0))];

#endregion

#region//Audio Group Load
if(!audio_group_is_loaded(music))
{
	audio_group_load(music);
}
#endregion





