boss_rain_emitter = part_emitter_create(global.particle_system);
boss_rain_emitter_gui = part_emitter_create(global.gui_particle_system);
boss_current_enum = boss_idle_form_enum;
bossCurentStage = 0;

#region//Init Particles Types

#region Global

#region Default

var _default_ice_particle = part_type_create();
part_type_shape(_default_ice_particle,pt_shape_snow);
part_type_life(_default_ice_particle,FRAME_RATE * 7.75, FRAME_RATE * 7.75);

part_type_scale(_default_ice_particle,0.1,0.1);
part_type_size(_default_ice_particle,0.8,1.2,0,0);
part_type_orientation(_default_ice_particle,0,360,0,0,false);

part_type_blend(_default_ice_particle,false);

part_type_alpha1(_default_ice_particle,1);

part_type_direction(_default_ice_particle,270,270,0,0);
part_type_speed(_default_ice_particle,0.3,0.3,0,0);
part_type_gravity(_default_ice_particle,0.005,285);


#endregion

#region//Ice
var _ice_p = _default_ice_particle;
#endregion

#region//Fire

var _fire_p = part_type_create();
part_type_sprite(_fire_p,spr_boss_rain_part_fire,false,false,false);
part_type_life(_fire_p,FRAME_RATE * 6, FRAME_RATE * 7);

part_type_scale(_fire_p,0.25,0.25);
part_type_size(_fire_p,0.8,1.2,0,0);
part_type_orientation(_fire_p,0,360,0,0,false);

part_type_blend(_fire_p,false);

part_type_alpha3(_fire_p,0,1,0);

part_type_direction(_fire_p,0,360,0,0);
part_type_speed(_fire_p,0.1,0.2,0,0);
part_type_gravity(_fire_p,0.0001,270);

#endregion

#region Wind
var _wind_p = part_type_create();
part_type_sprite(_wind_p,spr_boss_rain_part_wind,true,false,false);
part_type_life(_wind_p,FRAME_RATE * 7.5, FRAME_RATE * 7.5);

part_type_scale(_wind_p,1,1);
part_type_size(_wind_p,0.8,1.2,0,0);
part_type_orientation(_wind_p,0,360,2,0.1,false);

part_type_blend(_wind_p,false);

part_type_alpha3(_wind_p,1,1,0);

part_type_speed(_wind_p,5,5,0,0);
part_type_gravity(_wind_p,0.0001,270);
#endregion

#region Thunder
var _thunder_p = part_type_create();
part_type_sprite(_thunder_p,spr_boss_rain_part_thunder,false,false,false);
part_type_life(_thunder_p,FRAME_RATE * 2.5, FRAME_RATE * 2.5);

part_type_scale(_thunder_p,1,1);
part_type_size(_thunder_p,0.8,1,0,0);
part_type_orientation(_thunder_p,20,40,0,0,false);

part_type_blend(_thunder_p,false);

part_type_alpha1(_thunder_p,1);

part_type_direction(_thunder_p,285,285,0,0);
part_type_speed(_thunder_p,2,2,0,0);
part_type_gravity(_thunder_p,0.035,285);
#endregion

boss_rain_particles = [_ice_p,_fire_p,_wind_p,_thunder_p];
boss_rain_particles_number = [3,-6,-3,6];

#endregion

#region GUI

#region Default

_default_ice_particle = part_type_create();
part_type_shape(_default_ice_particle,pt_shape_snow);
part_type_life(_default_ice_particle,FRAME_RATE * 7.75, FRAME_RATE * 7.75);

part_type_scale(_default_ice_particle,0.1,0.1);
part_type_size(_default_ice_particle,0.8,1.2,0,0);
part_type_orientation(_default_ice_particle,0,360,0,0,false);

part_type_blend(_default_ice_particle,false);

part_type_alpha1(_default_ice_particle,1);

part_type_direction(_default_ice_particle,270,270,0,0);
part_type_speed(_default_ice_particle,0.3,0.3,0,0);
part_type_gravity(_default_ice_particle,0.005,285);


#endregion

#region//Ice

_ice_p = _default_ice_particle;

ice_gradient_alpha = 1;
ice_gradient_alpha_multiplier = 0;
ice_gradient_alpha_multiplier_target = 1;
ice_gradient_multiply_min_distance = 333;
ice_gradient_multiply_max_distance = global.initial_viewW * 0.9;
ice_gradient_distance_multiplier = 1;
//ice_gradient_alpha_anim_curve = animcurve_get_channel(anc_boss_ice_gradient,0);
//ice_gradient_alpha_anim_spd = 1 / (FRAME_RATE * 10);
//ice_gradient_alpha_anim_prog = 0;

#endregion

#region//Fire

_fire_p = part_type_create();
part_type_sprite(_fire_p,spr_boss_rain_part_fire,false,false,false);
part_type_life(_fire_p,FRAME_RATE * 3, FRAME_RATE * 4);

part_type_scale(_fire_p,0.25,0.25);
part_type_size(_fire_p,1.6,2,0,0);
part_type_orientation(_fire_p,0,360,0,0,false);

part_type_blend(_fire_p,false);

part_type_alpha3(_fire_p,0,1,0);

part_type_direction(_fire_p,0,360,0,0);
part_type_speed(_fire_p,0.2,0.4,0,0);
part_type_gravity(_fire_p,0.0002,270);

#endregion

#region Wind

_wind_p = part_type_create();
part_type_sprite(_wind_p,spr_boss_rain_part_wind,true,false,false);
part_type_life(_wind_p,FRAME_RATE * 3, FRAME_RATE * 3);

part_type_scale(_wind_p,2,2);
part_type_size(_wind_p,0.8,1.2,0,0);
part_type_orientation(_wind_p,0,360,2,0.1,false);

part_type_blend(_wind_p,false);

part_type_alpha3(_wind_p,1,1,0);

part_type_speed(_wind_p,7,7,0,0);
part_type_gravity(_wind_p,0.0002,270);

boss_wind_particles_gui_direction = 0;

#endregion

#region Thunder

var _thunder_p1 = part_type_create();

var _part_life_min = FRAME_RATE * 0.75;
var _part_life_max = FRAME_RATE * 1.25;

part_type_sprite(_thunder_p1,spr_boss_rain_gui1,true,true,false);
part_type_life(_thunder_p1,_part_life_min,_part_life_max);

part_type_scale(_thunder_p1,1.5,1.5);
part_type_size(_thunder_p1,0.8,1.6,0,0);
part_type_orientation(_thunder_p1,0,0,0,0,false);

part_type_blend(_thunder_p1,false);
part_type_alpha3(_thunder_p1,1,1,0);

part_type_gravity(_thunder_p1,0.01,270);

var _thunder_p2 = part_type_create();

part_type_sprite(_thunder_p2,spr_boss_rain_gui2,true,true,false);
part_type_life(_thunder_p2,_part_life_min,_part_life_max);

part_type_scale(_thunder_p2,0.75,0.75);
part_type_size(_thunder_p2,1,1.5,0,0);
part_type_orientation(_thunder_p2,0,0,0,0,false);

part_type_blend(_thunder_p2,false);
part_type_alpha1(_thunder_p2,1);

part_type_gravity(_thunder_p2,0,270);

var _thunder_p3 = part_type_create();

part_type_sprite(_thunder_p3,spr_boss_rain_gui3,true,true,false);
part_type_life(_thunder_p3,_part_life_min,_part_life_max);

part_type_scale(_thunder_p3,0.75,0.75);
part_type_size(_thunder_p3,1,1.5,0,0);
part_type_orientation(_thunder_p3,0,0,0,0,false);

part_type_blend(_thunder_p3,false);
part_type_alpha1(_thunder_p3,1);

part_type_gravity(_thunder_p3,0,270);

var _thunder_p4 = part_type_create();

part_type_sprite(_thunder_p4,spr_boss_rain_gui4,true,true,false);
part_type_life(_thunder_p4,_part_life_min,_part_life_max);

part_type_scale(_thunder_p4,1,1);
part_type_size(_thunder_p4,0.8,1.2,0,0);
part_type_orientation(_thunder_p4,0,0,0,0,false);

part_type_blend(_thunder_p4,false);
part_type_alpha1(_thunder_p4,1);

part_type_gravity(_thunder_p4,0,270);

var _thunder_particles = [_thunder_p1,_thunder_p2,_thunder_p3,_thunder_p4];

var _particles_type_num = 4;
var _thunder_particles_general_num = -4;
var _thunder_particles_parts = [0.5,1,1,6.5];
var _thunder_particles_gui_num = array_create(_particles_type_num);

var _thunder_particles_total_part = 0;

for(var i = 0; i < _particles_type_num; i++)
{
	_thunder_particles_total_part += _thunder_particles_parts[i];	
}

for(var i = 0; i < _particles_type_num; i++)
{
	_thunder_particles_gui_num[i] = _thunder_particles_general_num * _thunder_particles_parts[i] * _thunder_particles_total_part; // e.g -4 * 0.5 * 9
}

boss_thunder_gui_emitters = array_create(_particles_type_num);
for(var i = 0; i < _particles_type_num; i++)
{
	boss_thunder_gui_emitters[i] = part_emitter_create(global.gui_particle_system);	
}

#endregion

boss_rain_particles_gui = [_ice_p,_fire_p,_wind_p,_thunder_particles];
boss_rain_particles_number_gui = [-4,-36,-36,_thunder_particles_gui_num];

#endregion

#endregion

var _fire_color = make_color_rgb(255,142,169);
var _ice_color = make_color_rgb(0,190,246);
var _wind_color = make_color_rgb(0,246,56);
var _thunder_color = make_color_rgb(255,241,237);
var _idle_color = make_color_rgb(246,0,71);
boss_state_colors = [_ice_color,_fire_color,_wind_color,_thunder_color,_idle_color];

#region Ambient Sounds

boss_ambient = noone;
boss_ambient_assets = [sn_boss_ambient_ice,sn_boss_ambient_fire,sn_boss_ambient_wind,sn_boss_ambient_rain];

#endregion 

#region Boss Teleportation

teleport_aim = -1;
teleport_out_sprite = spr_boss_teleport;
teleport_out_sprite_reversed = true;

teleport_point = nowhere;
teleport_x = nowhere;
teleport_xscale = 1;
teleport_worry_time = player_worry_buffer_time;
//teleport_away_range = 333;

//boss_tp_to_attack_range = 150;
boss_tp_to_escape_range = [300,400];

boss_teleport_time = -1;
boss_teleport_worry_time = -1;

boss_teleporting = false;

#endregion

#region Boss GUI

boss_gui_display = false;

#region Affected Fragments

boss_fragments_sprites = [spr_boss_hp_death_ice,spr_boss_hp_death_fire,spr_boss_hp_death_wind,spr_boss_hp_death_thunder];
boss_affecteds_available = array_create(SKILLS.NUMBER,true);

//fragments_gap = global.oPlayer.skill_icons_gap;
//fragments_x = global.GUI_W/2 - fragments_gap * (SKILLS.NUMBER-1)/2;
//fragments_y = GUI_BOUND + sprite_get_height(spr_boss_hp_death_ice) / 2;

fragments_ellipse_x = global.GUI_W / 2;
fragments_ellipse_y = GUI_BOUND + sprite_get_height(spr_boss_hp_death_ice)/2;
fragments_ellipse_width = global.oPlayer.skill_icons_gap * (SKILLS.NUMBER - 1)/2;
fragments_ellipse_height = GUI_BOUND * 3;

#endregion

#region HP Parts

#macro boss_idle_hp_fragments 2
#macro boss_affected_hp_fragments 4

sprite_hp_fragments_idle = spr_boss_hp_fragments_idle;
sprite_hp_fragments_affected = spr_boss_hp_fragments_affected;

sprites_hp_frags_death_idle = [spr_boss_hp_fragment4_death];
sprites_hp_frags_death_affected = [spr_boss_hp_fragment1_death,spr_boss_hp_fragment2_death,spr_boss_hp_fragment3_death];

boss_manager_current_fragments_sprites = [sprite_hp_fragments_idle,sprites_hp_frags_death_idle];

boss_hp_fragments_left = 2;

#endregion

#region Shield

//Debug!
boss_shield_duration_left = 0;
boss_shield_duration_time = 0;
boss_shield_active = false;
boss_shield_invoking = false;
boss_shield_invoke_timer = 0;
boss_shield_invoke_time = 0;
//boss_shield_duration_left = FRAME_RATE*15;
//boss_shield_duration_time = FRAME_RATE*15;
//boss_shield_active = true;
boss_shield_surface = -1;
var boss_shield_width = fragments_ellipse_width * 2 * 1.25;
var boss_shield_height = fragments_ellipse_height * 2 * 1.25;
boss_shield_radius = max(boss_shield_width,boss_shield_height) / 2;

#endregion

///@arg skill_enum
function BossManagerGetFragmentXY(_enum){
	var _part = _enum / (SKILLS.NUMBER - 1);
	var _angle = pi * _part;
	var _draw_x = fragments_ellipse_x - cos(_angle) * fragments_ellipse_width;
	var _draw_y = fragments_ellipse_y + sin(_angle) * fragments_ellipse_height;
	return [_draw_x,_draw_y];
}
	
function BossManagerDestroyFragment(_skill_stolen){
	fragment_defeated = _skill_stolen;
	var _sprite = boss_fragments_sprites[_skill_stolen];
	var _XY = BossManagerGetFragmentXY(_skill_stolen);
	EffectCreate(_XY[0],_XY[1],_sprite,image_xscale,false,true);
	boss_affecteds_available[_skill_stolen] = false;
	alarm[0] = AnimationGetFrameLength(_sprite);	
}

///@arg invoke_time
///@arg duration time
function BossManagerInitializeShield(_time_invoke,_time_duration){
	boss_shield_invoke_timer = 1;
	boss_shield_invoke_time = _time_invoke;
	boss_shield_active = true;
	boss_shield_invoking = true;
	boss_shield_duration_time = _time_duration;
	boss_shield_duration_left = _time_duration;
}

function BossManagerActivateShield(){
	boss_shield_invoking = false;
}

fragment_defeated = noone;

#endregion

//#region Boss State Effects

//boss_state_effects = array_create(SKILLS.NUMBER);

//enum BOSS_STATE_EFFECTS{
//	VALUE,
//	OPERATION,
//	DELTA
//}

//boss_state_effects[SKILLS.ICE_TRAP] = ["jump_spd",EFFECT_ACTION.MULTIPLY,0.75];

//var boss_state_effects_values = array_create(SKILLS.NUMBER,"");
//var boss_state_effects_operations = array_create(SKILLS.NUMBER,0);
//var boss_state_effects_deltas = array_create(SKILLS.NUMBER,1);

//boss_current_state_effect_value_changed = 0;

//#endregion
