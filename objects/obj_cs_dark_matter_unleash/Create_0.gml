event_inherited();

global.dark_matter_unleash++;

if(global.dark_matter_unleash >= 3)
{
	cutscene_ending = CS_DM_unleash_last;	
}

var _flash_color = make_color_rgb(255,0,92);

//var _scene_mod = global.dark_matter_unleash mod 2;

var _portal_side = global.oPlayer.image_xscale;

var text_portal_damaged = "dark matter unleash: portal damaged " + string(global.dark_matter_unleash);
var text_see = "dark matter unleash: see " + string(global.dark_matter_unleash)

var _scene_portal = global.rightPortal;

if(_portal_side == -1)
{
	_scene_portal = global.leftPortal;	
}

var _portal_x = _scene_portal.x;

var _scene_new_enemy = noone;
switch(global.dark_matter_unleash)
{
	case 2:
	
	var _scene_new_enemy = [scene_portal_spawn_momma,_scene_portal];
	
	break;
	
	case 1:
	
	var _scene_new_enemy = [scene_portal_surge_voa,_scene_portal];
	
	break;
	
	case 3:
	
	var _scene_new_enemy = [scene_wait,0.5];
	
	break;
}

scene_info = 
[
	[scene_dark_matter_start],
	[scene_wait,1],
	[scene_screen_flash,10,_flash_color],
	[scene_screen_flash,10,c_white],
	[scene_wait,0.25],
	[scene_player_shoot_dark_matter_projectile],
	[scene_change_camera_target,obj_dark_matter_projectile],
	[scene_wait_for_side_input],
	[scene_next_take_live_args],
	[scene_change_camera_target,function(){ return instance_find(obj_dark_matter_stream,0)}],
	[scene_wait_for_side_input],
	[scene_wait,2],
	[scene_game_continue],
	[scene_change_camera_target,global.oPlayer],
	[scene_wait,1],
	[scene_textbox,Text(text_portal_damaged)],
	[scene_camera_move,_portal_x,CAMERA_Y,CAMERA_CS_SPD],
	[scene_wait,0.25],
	_scene_new_enemy,
	[scene_wait,2.75],
	[scene_change_camera_state,CameraStateFollow],
	[scene_textbox,Text(text_see)],
	[scene_animate_object,global.oPlayer,spr_hero_DM_unleash_heal,noone],
	[scene_dark_matter_heal_player]
]
