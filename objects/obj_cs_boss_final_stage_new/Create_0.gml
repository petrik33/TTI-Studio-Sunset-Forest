// Inherit the parent event
event_inherited();
var blink_time = 60;
var wait_time = blink_time * 1.75;
var after_flash_time = (blink_time/2 + wait_time)/FRAME_RATE;

var diamond_color = make_color_rgb(15,239,149);

var end_flash_time = FRAME_RATE * 0.25;

scene_info =
[
	[scene_camera_clamp,false],
	[scene_change_camera_state,CameraStateFollow],
	[scene_change_camera_target,global.oPlayer],
	[scene_wait,3],
	[scene_screen_flash_to_wait,blink_time,c_black,wait_time],
	[scene_player_remove_specials],
	[scene_camera_zoom,2],
	[scene_wait_no_skip,0.25 + after_flash_time],
	[scene_player_tired,2,0.75],
	[scene_player_final_fall],
	[scene_wait,3],
	[scene_screen_flash_to_wait,blink_time,c_black,wait_time],
	[scene_camera_zoom,1],
	[scene_next_take_live_args],
	[scene_camera_move,function(){ return (global.oPlayer.x + global.GUI_W * 0.4 * sign(shrine_x - global.oPlayer.x)) },CAMERA_Y,room_width],//move immediately
	[scene_wait_no_skip,after_flash_time],
	[scene_wait,2],
	[scene_boss_revive],
	[scene_wait,2],
	[scene_boss_awaken_final_stage],
	[scene_wait,1],
	[scene_queen_monolog,1,2],
	[scene_wait,0.5],
	[scene_hero_forgive],
	[scene_wait,1],
	[scene_queen_monolog,2,9],
	[scene_wait,0.5],
	[scene_final_crystal_move_horizontally_to_boss,7],
	[scene_wait,0.5],
	[scene_final_crystal_raise,FRAME_RATE * 3],
	[scene_wait,0.5],
	[scene_queen_monolog,3,2],
	[scene_wait,0.5],
	[scene_animate_object,global.crystal,spr_crystal_final],
	[scene_screen_flash,end_flash_time,diamond_color],
	[scene_screen_flash,end_flash_time,c_white],
	[scene_camera_stop_vibration],
	[scene_camera_shake,7,120],
	[scene_play_audio,sn_earthquake_cutscene8_1,[MIN_PITCH_DEFT,MAX_PITCH_DEFT],MAX_GAIN_DEFT * 1.25],
	[scene_delete_object,global.crystal],
	[scene_wait,end_flash_time/FRAME_RATE],
	[scene_final],
	[scene_wait,0.25],
	[scene_kill_object,global.oBoss,spr_boss_final_death],
	[scene_wait,3],
	//[scene_kill_object,global.oPlayer,spr_hero_death],
	[scene_final_dawn,10],
	[scene_wait,4]
]	
