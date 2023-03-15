event_inherited();

#region//Tutorial Vars

tutorial_tip_timer = FRAME_RATE * 0.25;
tutorial_step = -1;

var _lmb_button_text = Text("(use LMB)");
var _rmb_button_text = Text("(use RMB)");
if(global.alternative_controls_on)
{
	_lmb_button_text += (" " + Text("or") + " (" + chr(global.oPlayer.alternative_controls[alternative_key.attack]) + ")" );
	_rmb_button_text += (" " + Text("or") + " (" + chr(global.oPlayer.alternative_controls[alternative_key.push]) + ")" );
}

var _skills_hotkeys = "";
for(var i = 0; i < SKILLS.NUMBER; i++)
{
	_skills_hotkeys += chr(global.oPlayer.skills[i][SKILL.HOTKEY]);	
}

var _skills_keys_text = Text("use skill keys") + " (" + _skills_hotkeys + ")";

tutorial_tips = 
[
	_lmb_button_text,
	_rmb_button_text,
	Text("use Shift + Attack"),
	Text("use Shift backwards"),
	Text("use Alt"),
	_skills_keys_text,
	_skills_keys_text,
	Text("tutorial: stone")
]

tip_x = global.GUI_W / 2;
tip_y = global.oPlayer.skill_bar_y + GUI_BOUND * 2;

tutorial_show_tip = false;
tutorial_tip_font = Font(fn_buttons);

tutorial_tip_alpha = 0;
tutorial_tip_alpha_animspd = (pi) / (FRAME_RATE * 3);
tutorial_tip_alpha_animprogress = 0;

global.dummy_pole_inst = noone;

#region//tutorial conditions

var _tutorial_dummy_destroy = function(){return instance_exists(obj_dummy_death_alternative)};

var _tutorial_alt = function(){
	
	return (global.oPlayer.movement_direction!=global.oPlayer.image_xscale && keyboard_check(global.backwards_control))
}

var _tutorial_push_dummy = function(){
	var _condition = false;
	if(instance_exists(obj_dummy_alternative))
	{
		_condition = abs(sin(degtorad(obj_dummy_alternative.image_angle))) >= 0.4;
	}
	return _condition
}

var _tutorial_dash = function(){
	return (global.oPlayer.state == PlayerStateDashAttack)
}

var _tutorial_dash_backwards = function(){
	return (global.oPlayer.state == PlayerStateDash && global.oPlayer.dash_type == dash_types.backwards)
}

#endregion

#endregion

#region//Scene Info
scene_info =
[
	[scene_wait,2],
	[scene_player_wake_up],
	[scene_textbox,Text("tutorial: good morning")],
	[scene_textbox,Text("tutorial: less words")],
	[scene_textbox,Text("tutorial: explain later")],
	[scene_wait,0.1],
	[scene_change_camera_state,CameraStateFollow],
	[scene_move_object,global.oPlayer,tutorial_dummy_spawn_point,global.oPlayer.spd],
	[scene_wait,0.2],
	[scene_animate_object,global.oPlayer,spr_hero_invoking,noone],
	[scene_create_object,tutorial_dummy_x,FLOOR_Y,"Instances",obj_dummy_spawn],
	[scene_wait,0.5],
	
	[scene_textbox,Text("tutorial: dummy")],
	[scene_animation_sequence,global.oPlayer,[spr_hero_attack,spr_hero_attack2,spr_hero_attack3]],
	[scene_textbox,Text("tutorial: repeat")],
	[scene_make_player_free],
	[scene_tutorial,_tutorial_dummy_destroy,1],
	[scene_wait,0.75],
	[scene_make_player_static],
	
	[scene_textbox,Text("tutorial: good job")],
	[scene_make_player_free],
	[scene_tutorial,_tutorial_push_dummy,1],
	[scene_wait,0.5],
	[scene_make_player_static],
	
	[scene_textbox,Text("tutorial: dash")],
	[scene_make_player_free],
	[scene_tutorial,_tutorial_dash,1],
	[scene_wait,0.5],
	[scene_make_player_static],
	
	[scene_textbox,Text("tutorial: dash backwards")],
	[scene_make_player_free],
	[scene_tutorial,_tutorial_dash_backwards,1],
	[scene_wait,0.5],
	[scene_make_player_static],
	
	[scene_textbox,Text("tutorial: alt")],
	[scene_make_player_free],
	[scene_tutorial,_tutorial_alt,30],
	[scene_wait,0.5],
	[scene_make_player_static],
	
	[scene_textbox,Text("tutorial: skills")],
	[scene_make_player_free],
	[scene_tutorial_skills,1],
	[scene_wait,0.75],
	[scene_make_player_static],
	
	[scene_textbox,Text("tutorial: after skills")],
	[scene_player_accumulate_specials],
	[scene_textbox,Text("tutorial: special skills")],
	[scene_make_player_free],
	[scene_tutorial_skills,1],
	[scene_wait,0.75],
	[scene_make_player_static],
	
	[scene_textbox,Text("tutorial: end")],
	[scene_textbox,Text("tutorial: stone")],
	[scene_textbox,Text("tutorial: end tip")],
	[scene_make_player_free],
	[scene_tutorial_stone]
]
#endregion