event_inherited();

#region//General Stuff
global.oPlayer = self;
view_y_offset = 56;
global.oCamera.follow_target = self;
player_gui_display = false;
sprite_attack = spr_hero_attack;

hero_backwards_spd_rate = 0.8;

#endregion

#region//Pause

pausing = false;
unpausing = false;
sleeping = true;//For Game Start
state_before_sleep = EntityStateStatic;

paused_y = FLOOR_Y;
paused_image_index = 0;
paused_sprite = sprite_idle;

sprite_pause = spr_hero_sleep;
sprite_index = sprite_pause;//For Menu
depth = layer_get_depth("Hero");

pause_waving_amplitude = 24;
pause_waving_progress = 0;
pause_waving_spd = (pi) / (FRAME_RATE * 4);

staff_inst = instance_create_layer(x,y,"Hero",obj_staff);

#endregion

#region//Attack

attack_speed = 1;
hit_by_attack = ds_list_create();

hero_in_attack_spd_factor = 0.5;

input_buffered = noone;

current_attack_HB = noone;

hero_attack_counter = 0;
hero_bwn_attack_timer = 0;
hero_attack_reset_time = FRAME_RATE * 0.25;

hero_attack_sprites = [spr_hero_attack,spr_hero_attack2,spr_hero_attack3];
hero_attack_HBs = [spr_hero_attackHB,spr_hero_attack2HB,spr_hero_attack3HB];

#region Attack Animations Set Speed

var _attack_time = FRAME_RATE * 0.48;
var _attack_time_added = FRAME_RATE * 0.06;//To make every attack in a row longer then previous

for(var i = 0;i<array_length(hero_attack_sprites);i++)
{
	var _attack_sprite = hero_attack_sprites[i]
	var _attack_animation_spd = sprite_get_number(_attack_sprite)/(_attack_time + _attack_time_added * i);
	sprite_set_speed(_attack_sprite,_attack_animation_spd,spritespeed_framespergameframe);
}

#endregion

#endregion

#region//Worrying

worry_sprite = spr_hero_spider_sense;
worry_light_sprite = spr_hero_sense_light;
worry_effect = noone;
worry_y_offset = 10;

#endregion

#region//Dashing

sprite_dash = [spr_hero_dash_forward,spr_hero_dash];

var _dash_distance = [200,180];
var _dash_time = [0.75,0.8];
for(var d = 0; d <= 1; d++)
{
	//var _dash_time = AnimationGetFrameLength(sprite_dash[d]);
	AnimationSetLength(sprite_dash[d],_dash_time[d]);
	var _d_time = _dash_time[d] * FRAME_RATE;
	dash_decceleration[d] = (2 * _dash_distance[d]) / (sqr(_d_time));
	dash_speed[d] = dash_decceleration[d] * _d_time;
}

dash_type = -1;

enum dash_types
{
	forward,
	backwards
}

#endregion

#region//Jumping

var _jumping_height = 69;
jump_spd = sqrt(2 * _jumping_height * _gravity);
from_floor_to_jump = 2;
jumped = false;
jumped_twice = false;
jump_attack_min_height = 33;

jump_sounds = [sn_hero_jump1,sn_hero_jump2];
second_jump_sounds = [sn_hero_mid_jump1,sn_hero_mid_jump2];

#endregion

#region Dodging

//player_dodge_CD_time = FRAME_RATE * 0.25;
//player_dodge_CD = player_dodge_CD_time;

#endregion

#region//Controls

//alternative_controls = array_create(alternative_key.push);
alternative_controls = [ord("S"),ord("J"),ord("K")];
alternative_controls_names = ["Interaction","Attack","Push"];

global.backwards_control = vk_alt;

#endregion

#region//Seeds Opening

global.seed_opening_radius = 128;
seed_opening_sprites = [spr_hero_invoking,spr_hero_open_seed];
seed_to_open = noone;

#endregion

#region//Skills

#region//Skill Enum
enum SKILL
{
	ID,
	SCRIPT,
	SPRITE,
	CAST_DURATION,
	COOLDOWN,
	HOTKEY,
	NAME,
	FULL_CAST,
	ICON,
	RANGE,
	SOUNDS,
	WALK,
	JUMP,
	AVAILABLE,
	SPECIAL_PROGRESS
}
#endregion

#region//Skill Structures Enum
	enum SKILLS
	{
		ICE_TRAP,
		FIRE_BALL,
		WIND,
		THUNDER,
		NUMBER
	}
#endregion

#region//Sound Enum
enum SP_SOUNDS
{
	WIND_UP,
	RELEASE
}
#endregion

#region Ultimate Skill Enum

enum ULT_SKILL
{
	SPRITE,
	ICON,
	FULL_CAST,
	OFFSET,
	SOUNDS
}

#endregion

#region//Variables and GUI

current_skill = -1;//Indicates skill being casted
cast_count = 0;//Indicates how long is the skill being casted

skills = array_create(SKILLS.NUMBER);
special_skills = array_create(SKILLS.NUMBER);
ultimate_skills = array_create(SKILLS.NUMBER,0);
skills_cooldowns = array_create(SKILLS.NUMBER,0);
skill_casted = false;//indicates that the skill has been casted recently
full_cast = false;

hero_skill_spd_rate = 0.5;

skill_bar_height = sprite_get_height(spr_skill_cast_bar);
skill_bar_width = 192;

//skill_bar_x = global.GUI_W/2 - 116;
//skill_bar_y = global.GUI_H - GUI_BOUND;

skill_icons_gap = (skill_bar_width - frame_width) / (SKILLS.NUMBER - 1);

//var _skills_on_side = SKILLS.NUMBER / 2 - 1;

//skill_icons_x = hp_show_x - sprite_get_xoffset(hp_sprite);
//skill_icons_y = hp_show_y - sprite_get_height(hp_sprite) -sprite_get_yoffset(hp_sprite) - 4;
//skill_icons_gap = sprite_get_width(spr_skill_frame) - 1;

//skill_icons_x = global.GUI_W / 2 - (_skills_on_side * skill_icons_gap) - (skill_icons_gap + frame_width)/2;
skill_icons_x = global.GUI_W / 2 - skill_icons_gap * (SKILLS.NUMBER - 1) / 2;
skill_icons_y = GUI_BOUND + frame_height/2;

skill_bar_x = (global.GUI_W - skill_bar_width) / 2;
skill_bar_y = skill_icons_y + frame_height/2 + skill_bar_height + GUI_BOUND;

//ultimate_skill_sprites = [spr_ultimate_icon_ice,spr_ultimate_icon_fire,spr_ultimate_icon_wind,spr_ultimate_icon_thunder];

#endregion

#region//Ice Trap

PlayerAddSkill(
	0,
	SkillIceTrap,
	spr_hero_ice_skill,
	0.6,
	14,
	ord("Q"),
	"Ice Trap",
	11,
	spr_icon_ice,
	noone,
	[sn_spell_invoke_windup,sn_spell_ice_trap_release],
	false,
	false
)

PlayerAddSkillSpecial(
	0,
	PlayerSpecialIce,
	spr_hero_special_ice,
	0.3,
	6,
	5,
	spr_icon_ice_special,
	[0,hero_ice_special_range],
	[sn_hero_jump1,sn_ice_special],
	true,
	false
)

#endregion

#region//Fire Ball

PlayerAddSkill(
	1,
	SkillFireBall,
	spr_hero_fireball,
	0.3,
	10,
	ord("W"),
	"Fire Ball",
	7,
	spr_icon_fireball,
	noone,
	[sn_spell_fireball_windup,sn_spell_fireball_release],
	true,
	true
)

var _firew_w = 59;

PlayerAddSkillSpecial(
	1,
	PlayerSpecialFire,
	spr_hero_special_fire,
	0.6,
	6,
	6,
	spr_icon_fire_special,
	[hero_special_fire_x_offset,_firew_w],
	[noone,sn_swing3],
	true,
	false
)



#endregion

#region//Wind

PlayerAddSkill(
	2,
	SkillWind,
	spr_hero_wind,
	0.2,
	8,
	ord("E"),
	"Wind Wave",
	4,
	spr_icon_wind,
	noone,
	[sn_spell_wind_windup,sn_spell_wind_release],
	true,
	true
)

PlayerAddSkillSpecial(
	2,
	PlayerSpecialWind,
	spr_hero_special_wind,
	0.2,
	4,
	6,
	spr_icon_wind_special,
	[wind_orb_x_offset + wind_orb_throw_distance,wind_orb_explosion_range],
	[noone, sn_swing2],
	true,
	true
)

#endregion

#region//Thunder

PlayerAddSkill(
	3,
	Skill4,
	spr_hero_lightning,
	0.7,
	16,
	ord("R"),
	"Thunder Strike",
	7,
	spr_icon_4,
	[0,skill_4_range],
	[sn_spell_thunder_windup,sn_spell_thunder_release],
	false,
	false
)

PlayerAddSkillSpecial(
	3,
	PlayerSpecialThunder,
	spr_hero_special_thunder_transition,
	0.2,
	4,
	5,
	spr_icon_thunder_special,
	noone,
	[noone,sn_thunder_special],
	true,
	true
)

#endregion

#region//Special Skills Variables

spec_frame_sprite = spr_special_skill_frame;
spec_frame_img_prog = array_create(SKILLS.NUMBER,0);
spec_frame_img_spd = sprite_get_speed(spec_frame_sprite) / FRAME_RATE;
spec_frame_img_num = sprite_get_number(spec_frame_sprite)-1;
//spec_frame_color = make_color_rgb(207,176,82);

spec_activation_sounds = [noone,sn_fire_special_activation,sn_wind_special_activation,sn_thunder_special_activation];

#region//Stacks

spec_stacks_sprites = [spr_special_stack_ice,spr_special_stack_fire,spr_special_stack_wind,spr_special_stack_thunder];

spec_stacks_rot_prog = 0;
#macro spec_stacks_rot_spd (2 * pi) / (FRAME_RATE * 3)
#macro spec_stacks_needed 4

//spec_stacks_y_offset = -40;

//spec_particle_sprite = spr_boss_stealing_particles;

#endregion

#region Ice

ice_special_caught_list = ds_list_create();

var _raise_height = 80;
var _raise_time = AnimationGetFrameLength(spr_hero_special_ice_state,hero_ice_special_up_frame);

//ice_special_raise_spd = _raise_height / _raise_time;

ice_special_raise_acceleration = (_raise_height * 2) / sqr(_raise_time);

#endregion

#region//Wind

function WindOrbCountSpdDirection(_direction,_distance){
	var _orb_gravity = 0.08;
	orb_throw_direction = _direction;	
	var _double_rad_angle = degtorad(2 * orb_throw_direction);	
	//After Solving Mathmatical Equation
	orb_throw_spd = sqrt(( 2 * _distance * _orb_gravity) / sin(_double_rad_angle));
}

function WindOrbCountSpdHeight(_height,_distance){
	var _angle = arctan(2 * _height / _distance);
	WindOrbCountSpdDirection(radtodeg(_angle),_distance);
}

WindOrbCountSpdDirection(20,wind_orb_throw_distance);

#endregion

#region//Thunder

player_thunderform_timer = 0
player_thunderform_time = FRAME_RATE * 2;
player_thunderform_spd_increase = 8;

#endregion

spec_icons_img_prog = array_create(SKILLS.NUMBER,0);
spec_icons_img_spd = array_create(SKILLS.NUMBER,0);
spec_icons_img_num = array_create(SKILLS.NUMBER,0);

for(var j = 0; j < SKILLS.NUMBER; j++)
{ 
	var _icon = special_skills[j][SKILL.ICON];
	spec_icons_img_spd[j] = sprite_get_speed(_icon) / FRAME_RATE;
	spec_icons_img_num[j] = sprite_get_number(_icon) - 1;
}

#endregion

#region Ultimate Skills

ultimate_skill_icon_sprite = noone;
ultimate_skill_img_index = 0;
ultimate_skill_img_spd = 0;
ultimate_skill_img_number = 0;
ultimate_skill_id = noone;

ultimate_skill_icon_wave_amp = 7;
ultimate_skill_icon_wave_progress = 0;
ultimate_skill_icon_wave_spd = pi / (FRAME_RATE * 1.5);

ultimate_skills[SKILLS.ICE_TRAP] = [spr_hero_ult_ice,spr_ultimate_icon_ice,9,8,[noone,noone]];
ultimate_skills[SKILLS.FIRE_BALL] = [spr_hero_ult_fire,spr_ultimate_icon_fire,7,18,[noone,noone]];
ultimate_skills[SKILLS.WIND] = [spr_hero_ult_wind,spr_ultimate_icon_wind,8,13,[noone,noone]];
ultimate_skills[SKILLS.THUNDER] = [spr_hero_ult_thunder,spr_ultimate_icon_thunder,16,0,[noone,noone]];

ultimate_skill_general_struct = array_create(array_length(skills[0]),-1);
ultimate_skill_general_struct[SKILL.SCRIPT] = PlayerUltimateSkillScript;
ultimate_skill_general_struct[SKILL.WALK] = false;
ultimate_skill_general_struct[SKILL.JUMP] = false;


#endregion

#endregion

#region//Dark Matter

//dark_matter_max = 4;
dark_matter_max = 40;
dark_matter_current = 0;
dark_matter_target = 0;

//dark_matter_shot = false;

dark_matter_bar_h = 27;

dark_matter_bar_gui_y = (GUI_BOUND + dark_matter_bar_h);
dark_matter_bar_gui_x = GUI_BOUND;

dark_matter_bar_w = 0;
dark_matter_bar_target_w = 0;

dark_matter_and_hp_tutorial_revealed = false;

#endregion

#region//HP

current_hp=max_hp;
hp_sprite = spr_hp_fragment_alternative;
var hp_width = sprite_get_width(hp_sprite);
//hp_show_x = GUI_BOUND + sprite_get_xoffset(hp_sprite);
hp_show_x = GUI_BOUND + sprite_get_xoffset(hp_sprite);

hp_top_y = dark_matter_bar_gui_y + GUI_BOUND;
hp_bot_y = GUI_BOUND + sprite_get_height(hp_sprite) - sprite_get_yoffset(hp_sprite);
hp_show_y = hp_bot_y;

hp_in_transition = false;
hp_transition_progress = 0;
var hp_transition_time = FRAME_RATE * 0.5;
hp_transition_spd = 1 / hp_transition_time;
hp_transition_down = true;

hp_gap = (dark_matter_max * 4 - hp_width) / (max_hp - 1);

hp_leaves = array_create(max_hp);

hp_jitterings = array_create(max_hp);

hp_animation_progress = 0;
var hp_anim_curve = animcurve_get(anc_hp_waving)
hp_anim_channel = hp_anim_curve.channels[0];

for(var i=0;i<max_hp;i++)
{
	hp_leaves[i] = 0;
	hp_jitterings[i]= random(1);
}

#endregion

#region Buffs

frost_ui_id = -1;
frost_ui_time_source = -1;

buffs_list = array_create(player_max_buffs,-1);
buffs_anim_list = array_create(player_max_buffs,0);
buffs_show_x = GUI_BOUND;
buffs_show_y = GUI_BOUND + sprite_get_height(hp_sprite); //From HP_Show_y

#endregion

#region Shielding

player_shielded = false;

#endregion

#region//Enemy Info
last_hitted = noone;
var _enemy_hp_width = sprite_get_width(spr_enemy_hp_frag);
var _enemy_hp_height = sprite_get_height(spr_enemy_hp_frag);
var _enemy_hp_gap = 6;
var _max_possible_hp = 4;

enemy_hp_gap = _enemy_hp_width + _enemy_hp_gap;

enemy_info_x = global.GUI_W - GUI_BOUND - portrait_width - _enemy_hp_width * _max_possible_hp - _enemy_hp_gap * (_max_possible_hp - 1);
enemy_info_y = GUI_BOUND + portrait_height;

enemy_hp_x = enemy_info_x + portrait_width + 4;
enemy_hp_y = GUI_BOUND + _enemy_hp_height;

#endregion

#region//FSM

state = PlayerStateSleeping;

#endregion

#region Shader

//u_pixelWidth = shader_get_uniform(sh_outline,"pixelWidth");
//u_pixelHeight = shader_get_uniform(sh_outline,"pixelHeight");
////u_outline_colour = shader_get_uniform(sh_outline,"outline_colour");

//texelH = outline_scale * texture_get_texel_height(sprite_get_texture(sprite_index,0));
//texelW = outline_scale * texture_get_texel_width(sprite_get_texture(sprite_index,0));

//outline_color = make_color_rgb(60,184,120);

#endregion

#region Light

//light_instance = DynamicLightOnTarget(spr_player_light,self);

#endregion

#region//Audio

#region//Sounds

current_skill_sound = -1;

//footstep_sounds = [sn_footstep1,sn_footstep2,sn_footstep3];
footstep_sounds = [sn_Daryl_fs_1,sn_Daryl_fs_2,sn_Daryl_fs_3,sn_Daryl_fs_4,sn_Daryl_fs_5,sn_Daryl_fs_6];

swing_sounds = [sn_swing1,sn_swing2,sn_swing3,sn_swing4];

dash_sounds = [sn_player_dash8_1,sn_player_dash8_1];

#endregion

#endregion




