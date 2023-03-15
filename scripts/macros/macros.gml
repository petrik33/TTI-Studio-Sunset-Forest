#region//Basic
#macro GUI_BOUND 16

#macro ORIGINAL_VIEW_W 960
#macro ORIGINAL_VIEW_H 540

#macro MAX_VIEW_W 1280
#macro MAX_VIEW_H 800

#macro FLOOR_Y 641
#macro CAMERA_Y 519
#macro FRAME_RATE 60
#macro BUFF 0

#macro text_separation (GUI_BOUND * 2)

#region Debug Features And Configs

#macro debug_version false
#macro debug_manager_enabled false
#macro debug_windowed false

#macro DebugWindowed:debug_windowed true
#macro DebugWindowed:debug_manager_enabled true
#macro DebugWindowed:debug_version true

#macro Debug:debug_manager_enabled true
#macro Debug:debug_version true

#macro ReleaseReward:debug_version true

#endregion

#macro windowed_downscale 1.5

#endregion

#region//Menu

#macro  alternative_keys_element 2

#endregion

#region//Audio

#macro falloff_ref_dist 480
#macro falloff_max_dist ORIGINAL_VIEW_W
#macro falloff_factor 1

#macro sounds_hidden_gain 1.5

//audio_falloff_set_model(audio_falloff_exponent_distance);

#endregion

#region//Design

#macro tile_w 64

#macro outline_scale 1

#region//Player

#macro DM_send_xoffset 20
#macro DM_send_yoffset -76

#macro player_x_start (shrine_x + 64) 

#macro player_worry_buffer_time 28

#macro player_max_buffs 10

#macro player_dodge_frame 4
#macro player_undodge_frame 11

#macro wind_orb_explosion_range 167
#macro wind_orb_throw_distance 210

#macro player_loosing_particle_frame 5
#macro hero_special_fire_x_offset 122
#macro hero_special_fire_push_range 80

#macro icicle_x_offset 88
#macro icicle_y_offset -37

#macro hero_ice_special_range 333

#macro hero_ice_special_up_frame 8
#macro hero_ice_special_down_frame 10

#macro dash_attack_max_frame 3

#macro wind_skill_x_offset 21
#macro wind_skill_y_offset -43

#macro wind_orb_x_offset 52
#macro wind_orb_y_offset -24
#macro wind_orb_explosion_frame 11
//#macro wind_special_frame 6

#macro ice_trap_skill_x_offset 17
#macro skill_4_range 400
#macro skill_wind_range 333//Not Used Anymore

#macro hero_special_stacks_y_offset -30
#macro special_stack_angle_speed (360 / (FRAME_RATE * 1))

#macro hero_dark_matter_unleash_frame 12
#macro dark_matter_unleash_x_offset 104
#macro dark_matter_unleash_y_offset -47

#macro hp_frag_DM_id 4

#endregion

#region Boss

#macro boss_ranged_attacks_range (ORIGINAL_VIEW_W * 0.75)

#macro boss_melee_time 2
#macro boss_invoke_time 8
#macro boss_ranged_time 6
#macro boss_shielding_cooldown_time 45
#macro boss_shielding_time 15

#macro boss_acceleration_time (FRAME_RATE * 1)
#macro boss_decceleration_time (FRAME_RATE * 0.1)

#macro boss_invoke_frame 3

#macro boss_def_melee_range 133

#macro boss_idle_form_enum 4

#macro boss_hp_hide_frame 6
#macro boss_hp_default_hide_time (boss_hp_hide_frame / 14)
#macro boss_hp_default_reveal_time ((sprite_get_number(spr_boss_hp_teleporting) - boss_hp_hide_frame) / 14)

#endregion

#macro camera_start_x (room_width / 2 + 30)
#macro camera_pause_y_target (FLOOR_Y + 24) - (ORIGINAL_VIEW_H / 2)

#macro map_width 2560
#macro spawn_point_left_x 64
#macro spawn_point_right_x (map_width - 64)
#macro shrine_x (map_width/2)

#macro min_entity_y 380

#macro shrine_zone_left_x (shrine_x - 256)
#macro shrine_zone_right_x (shrine_x + 256)

#macro spawn_point_y 5
#macro portal_push_speed 9
#macro portal_push_direction 45
//#macro enemies_per_portal 12

#macro boss_fight_right_edge (shrine_x + tile_w * 10.5)
#macro boss_fight_left_edge (shrine_x - tile_w * 10.5)
#macro crystal_portal_w 80
#macro crystal_h (sprite_get_height(spr_diamond))
#macro crystal_lifestream_gravity 0.1

#macro fireflies_min_y 416
#macro fireflies_max_y (FLOOR_Y - 64)

#macro douhta_attack_xoffset 49

#macro voa_flying_y_min (FLOOR_Y - 210)
#macro voa_flying_y_max (FLOOR_Y - 180)

#macro momma_invoke_x_offset 8
#macro momma_invoke_y_offset -23

#macro ruga_weak_trans_x_shift 47

#macro icon_height 29
#macro icon_width 29
#macro frame_width 33
#macro frame_height 33

#macro portrait_width sprite_get_width(spr_enemy_portrait)
#macro portrait_height sprite_get_height(spr_enemy_portrait)

#macro portal_max_hp 3

#macro ILLU_WIDTH 640
#macro ILLU_HEIGHT 360
#macro ILLU_TEXT_Y 108
#macro ILLU_BARS_WIDTH 23

#region Dark Matter UI

#macro dark_matter_filling_h 9
#macro dark_matter_filling_offset 9

#endregion

#macro bird_companion_flying_y 433
#macro coluna_flying_y (FLOOR_Y - 54)

#macro tutorial_wave_total_DM 34

#endregion

#region//Cutscenes

#macro CAMERA_CS_SPD 11

#region//Start
#macro companion_soul_drop_y (FLOOR_Y - 700)
#macro companion_soul_drop_x (1130)
#endregion

#region Tutorial

#macro tutorial_dummy_spawn_point (shrine_x - tile_w * 6)
#macro tutorial_dummy_x (shrine_x - tile_w * 8)

#macro hero_heal_props_frame 10

#endregion

#region Boss Fight

#macro CS_boss_crystal_up_time (FRAME_RATE * 0.5)
#macro CS_boss_crystal_down_time (FRAME_RATE * 0.75)

#macro CS_boss_crystal_up_y 400
#macro CS_boss_crystal_underground_y 767

#macro crystal_lifestreams_fall_range (tile_w * 6)
#macro final_fight_edges_range (tile_w * 10)

#macro boss_spawn_x (shrine_x + tile_w * 8)
#macro boss_dist_to_floor 20
#macro boss_stealing_particle_frame 1

#macro boss_tornado_x_target (shrine_x - crystal_lifestreams_fall_range)
#macro hero_crystal_hide_x 1470

#macro boss_final_transition_xoffset 353
#macro boss_final_transition_yoffset 41

#macro boss_comp_kill_xoffset 130
#macro boss_comp_kill_yoffset -103

#macro companion_soul_death_x (boss_tornado_x_target + 128)
#macro companion_soul_death_y (FLOOR_Y - boss_dist_to_floor - 48)

#endregion

#region Loading / Restart

#macro restart_base_texts_num 3

#endregion

#region Final Boss Fight

#macro ff_player_x_to_center (global.GUI_W * 0.4)
#macro ff_boss_x_target (global.GUI_W / 2 - boss_final_transition_xoffset)

#macro ff_boss_catch_worb_frame 3
#macro ff_boss_catch_worb_distance (480)
#macro ff_boss_catch_worb_height 220

#macro ff_crystal_to_player_yoffset (-42+29)
#macro ff_crystal_to_player_xoffset 425
#macro ff_crystal_to_boss_xoffset 533
#macro ff_crystal_ytarget (640 - 133)

#endregion

#endregion

#region//Value Conversion

#macro MILI_TO_SECONDS 1000
#macro MICRO_TO_SECONDS 1000000

#macro MIN_PITCH_DEFT 0.8
#macro MAX_PITCH_DEFT 1
#macro MIN_GAIN_DEFT 0.75
#macro MAX_GAIN_DEFT 1.2

#macro nowhere -444
#macro double_pi (2 * pi)

#endregion

#region Text

#macro text_sound_fadein_time (MILI_TO_SECONDS * 0.5)

#endregion

#region//Time

#macro TIME_MENU 0.85
#macro TIME_GAME_START 0.4
//#macro TIME_BOSS_START 0.1
//#macro DAY_NIGHT_BORDER 0.5

#endregion

#region//Enums

#region//Menu Enums

enum menu_page
{
	main,
	start_game,
	settings,
	audio,
	debugging,
	enemies,
	boss,
	graphics,
	controls,
	skills_controls,
	alternative_keys,
	day_night_debug,
	photo_mode,
	last_empty
}

enum menu_element
{
	name,
	type,
	first_entry,
	current_value,
	value_range,
	value_factor
}

enum menu_element_type
{
	script_runner,
	page_transfer,
	slider,
	shifter,
	toggle,
	control_input,
	rectangular_bar,
	enemy_toggle,
	bestiary,
	blockable_page_transfer,
	mouse_alternative_input
}

//enum menu_side
//{
//	left_top,
//	right_top,
//	right_bot,
//	left_bot,
//	center
//}

#endregion

#region Day Night Shader Debug

enum DAY_NIGHT_SHADER{
	COLORS_ID,
	CON_SAT_BRT_ID
}

enum CON_SAT_BRT{
	contrast,
	saturation,
	brightness,
	popStrength,
	popThreshold,
	last
}

enum COLOR_MIX{
	colorR,
	colorG,
	colorB,
	last
}

#endregion

//enum RESOLUTION,
//{
		
//}

//enum GLOBAL_PARTS{
//	DUST,
//	DIRT,
//	PORTAL_FLASH,
//	BLOOD,
//	NUMBER
//}

enum HALIGN{
	LEFT,
	CENTER,
	RIGHT
}

enum VALIGN{
	TOP,
	CENTER,
	BOTTOM
}

enum BOSS_EVENT{
	TELEPORT,
	ATTACK
}
	
enum BOSS_TP_AIM{
	TO_ATTACK,
	TO_DEFEND,
	TO_ESCAPE,
	NUMBER
}

enum ILLUSTRATION
{
	picture,
	text
}

enum DEFEAT
{
	player_died,
	shrine_broken
}

enum COMPANION{
	plant,
	bird
}

enum CONTROL_TYPE
{
	vk_key,
	mb_button
}

enum Push_Effect_enum
{
	speed,
	angle
}

enum input_buffer_type
{
	special,
	attack,
	push,
	dash,
	dodge
}

enum alternative_key{
	interaction,
	attack,
	push
}

enum EFFECT_ACTION{
	PLUS,
	MINUS,
	DIVIDE,
	MULTIPLY,
	SET_FALSE,
	SET_TRUE,
	SPECIAL
}
	
enum ENEMIES
{
	SLIME = 0,
	KOMAR,
	BOHRA,
	RUGA,
	COLUNA,
	VOA,
	MOMMA,
	DOUHTA,
	NUMBER
}

enum ENEMY
{
	OBJECT,
	NAME,
	PORTRAIT,
	MAX_HP,
	IDLE,
	ACTIVE,
	BESTIARY_OPENED,
	ARRAY_SIZE
}

enum BESTIARY_PAGE_TYPE
{
	ENEMY,
	HP_DM_TUTORIAL,
	TEXT,
	FLASH_NOTIFICATION
}

//enum BOSS_ATTACK{
//	MELEE,
//	RANGE,
//	INVOKING
//}
	
enum ATTACK_TYPE{
	DASH,
	MELEE,
	MELEE_TARGETED,
	RANGED,
	STRIKING,
	INVOKING,
	SHIELDING,
	JUMPING,
	VOA_LIKE
}

#endregion

