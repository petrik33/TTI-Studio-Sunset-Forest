event_inherited();

global.boss_manager = instance_create_layer(0,0,"Managers",obj_boss_manager);

#region//Basics

movement_direction = -1;
InstanceRotateCentrally(movement_direction);
sprite_index = spr_boss_appearance;
state = BossStateAppearance;
state_free = BossStateFree;

#endregion

#region Drops

drop_chance = 1;
drops_list = [
	obj_drop_defense,
	obj_drop_movement_spd,
	obj_drop_special_fragment,obj_drop_special_fragment,obj_drop_special_fragment,obj_drop_special_fragment
]

#endregion

#region//Boss Affected States

#region//State Structs

	#region//Ice

	#region//Attacks
	
	var _ice_invoke_struct = new AttackInvoke(
		self,
		spr_boss_invoking_ice,
		noone,
		boss_invoke_time,
		1,
		noone,
		noone,
		noone,
		obj_boss_minion_ice,
		63,
		-112,
		noone,
		false,
		5
	)
	
	var _ice_melee_struct = new AttackMeleeTargeted(
		self,
		spr_boss_melee_ice,
		noone,
		boss_melee_time,
		1,
		pobj_hero,
		boss_def_melee_range,
		noone,
		spr_boss_melee_ice,
		spr_boss_melee_ice_hit,
		[pushing_speed,25],
		true,
		[64,-109,50],
		player_worry_buffer_time/4,
		EntityFreeze
	)
	
	var _ice_attack_ice_struct = new AttackRanged(
		self,
		spr_boss_ice_projectile_VFX,
		noone,
		3,
		1,
		pobj_hero,
		boss_ranged_attacks_range,
		noone,
		true,
		4,
		obj_boss_ice_projectile,
		noone,
		105,
		-115,
		[true,false],
		0
	)
	
	var _ice_attack_water_struct = new AttackRanged(
		self,
		spr_boss_water_projectile_VFX,
		noone,
		boss_ranged_time,
		1,
		pobj_hero,
		boss_ranged_attacks_range,
		noone,
		true,
		8,
		obj_boss_water_projectile,
		noone,
		105,
		-193,
		[true,false],
		noone
	)
	
	var ice_shielding = new EntityAttackShielding(
	self,
	spr_boss_forming_shield_ice,
	noone,
	0,
	1,
	noone,
	noone,
	noone,
	[spr_boss_shield_ice,spr_boss_shield_surging_ice,spr_boss_shield_damaged_ice],
	noone,
	noone,
	6,
	boss_shielding_time
)
	
	//Debug
	//boss_current_ice_attack = 0;
	//boss_ice_attack_structs = [_ice_attack_water_struct,_ice_attack_ice_struct];
	//boss_switch_attack_struct = false;
	
	#endregion
	
	#region//Behaviour
	
	boss_ice_range_attacks = [_ice_attack_water_struct,_ice_attack_ice_struct];
	boss_ice_current_range_id = 0;
	
	var _ice_state_free = function(){
		if(BossDefaultBehaviour() == BOSS_EVENT.ATTACK)
		{
			if(attack_struct.attack_type == ATTACK_TYPE.RANGED)
			{
				//Change The Attack For the next time
				boss_ice_current_range_id++;
				if(boss_ice_current_range_id >= 2) boss_ice_current_range_id = 0;
				boss_attacks[1] = boss_ice_range_attacks[boss_ice_current_range_id];
			}
			boss_between_attacks_timer = boss_between_attacks_time;
		}
	}
	
	#endregion
	
	var _boss_ice_state = new BossAffectedState(
		spr_boss_idle_ice,
		[spr_boss_teleport_ice,noone,spr_boss_tp_vfx_ice],
		[spr_boss_crystal_idle_ice,spr_boss_crystal_destr_ice,-1,3],
		[_ice_melee_struct,boss_ice_range_attacks[boss_ice_current_range_id],_ice_invoke_struct],
		_ice_state_free,
		spr_boss_transition_ice,
		[spr_boss_ice_trans_out,5,0],
		ice_shielding
	)
	
	#endregion

	#region//Fire

		#region//Attacks
		
		var _fire_attack_struct = new AttackMelee(
			self,
			spr_boss_melee_fire,
			noone,
			boss_melee_time,
			1,
			pobj_hero,
			boss_def_melee_range * 0.8,
			noone,
			spr_boss_melee_fireHB,
			spr_boss_melee_fire_hit,
			[pushing_speed,pushing_direction],
			false,
			player_worry_buffer_time
		)
		
		var _fire_range_struct = new AttackRanged(
			self,
			spr_boss_range_surge_fire,
			1,
			boss_ranged_time,
			1,
			pobj_hero,
			boss_ranged_attacks_range,
			noone,
			true,
			6,
			obj_boss_fire_bullet,
			noone,
			192,
			-103,
			[true,true],
			noone
		)
		
		var _fire_invoke_struct = new AttackInvoke(
			self,
			spr_boss_invoke_fire,
			noone,
			boss_invoke_time,
			1,
			noone,
			noone,
			noone,
			obj_boss_minion_fire,
			86,
			noone,
			noone,
			true,
			7
		);
		
		var fire_shielding = new EntityAttackShielding(
			self,
			spr_boss_forming_shield_fire,
			noone,
			0,
			1,
			noone,
			noone,
			noone,
			[spr_boss_shield_fire,spr_boss_shield_surging_fire,spr_boss_shield_damaged_fire],
			noone,
			noone,
			4,
			boss_shielding_time
		)
		
		//var _fire_attack_struct = new AttackMelee(
		//self,
		//spr_boss_attack_fire,
		//noone,
		//3,
		//1,
		//pobj_hero,
		//noone,
		//sn_default_attack,
		//spr_boss_attack_HB_fire,
		//spr_boss_explosion,
		//noone,
		//false
		//)
		
		#endregion
		
		#region//Behavior
		
		var _fire_state_behavior = BossStateFree;
		
		#endregion

		var _boss_fire_state = new BossAffectedState(
			spr_boss_idle_fire,
			[spr_boss_teleport_fire,spr_boss_teleport_back_fire,spr_boss_tp_vfx_fire],
			[spr_boss_crystal_idle_fire,spr_boss_crystal_destr_fire,1,5],
			[_fire_attack_struct,_fire_range_struct,_fire_invoke_struct],
			_fire_state_behavior,
			spr_boss_transition_fire,
			[spr_boss_fire_trans_out,2,17],
			fire_shielding
		)

		#endregion
	
	#region//Wind
	
	#region//Attack Debug!
	
	//var _wind_invoke_struct = new AttackInvoke(
	//		self,
	//		spr_boss_invoking_wind,
	//		noone,
	//		boss_invoke_time,
	//		1,
	//		noone,
	//		noone,
	//		noone,
	//		obj_boss_minion_wind,
	//		48,
	//		-92,
	//		noone,
	//		false,
	//		3
	//	);
		
	var _wind_invoke_struct = new AttackRanged(
			self,
			spr_boss_invoking_wind,
			noone,
			boss_invoke_time,
			1,
			pobj_hero,
			boss_ranged_attacks_range,
			noone,
			true,
			3,
			obj_boss_minion_wind,
			noone,
			48,
			-92,
			false,
			noone
			//false,
			//3
		);
	
	var _wind_melee_struct = new AttackMeleeTargeted(
		self,
		spr_boss_melee_wind,
		noone,
		boss_melee_time,
		1,
		pobj_hero,
		boss_def_melee_range,
		noone,
		spr_boss_melee_wind,
		spr_boss_melee_wind_hit,
		[pushing_speed,60],
		true,
		[43,-99,0],
		noone
	)
	
	var _wind_attack_struct = new AttackRanged(
		self,
		spr_boss_attack_wind,
		noone,
		boss_ranged_time,
		1,
		pobj_hero,
		boss_ranged_attacks_range,
		noone,
		false,
		2,
		obj_boss_wind_special_bullet,
		noone,
		100,
		-96,
		false,
		noone
	);
	
	var wind_shielding = new EntityAttackShielding(
			self,
			spr_boss_forming_shield_wind,
			noone,
			0,
			1,
			noone,
			noone,
			noone,
			[spr_boss_shield_wind,spr_boss_shield_surging_wind,spr_boss_shield_damaged_wind],
			noone,
			noone,
			6,
			boss_shielding_time
		)
	
	#endregion
	
	#region//Behaviour
	
	var _wind_state_free = BossStateFree;
	
	#endregion
	
	var _boss_wind_state = new BossAffectedState(
		spr_boss_idle_wind,
		[spr_boss_teleport_wind,noone,spr_boss_tp_vfx_wind],
		[spr_boss_crystal_idle_wind,spr_boss_crystal_destr_wind,0,0],
		[_wind_melee_struct,_wind_attack_struct,_wind_invoke_struct],
		_wind_state_free,
		spr_boss_transition_wind,
		[spr_boss_wind_trans_out,-17,-4],
		wind_shielding
	)
	
	#endregion
	
	#region//Thunder
	
	#region//Attack Debug!
	
	var _thunder_invoke_struct = new AttackInvoke(
			self,
			spr_boss_invoking_thunder,
			noone,
			boss_invoke_time,
			1,
			noone,
			noone,
			sn_minion_surge_thunder8_1,
			obj_boss_minion_thunder,
			178,
			-118,
			noone,
			true,
			5
		)
	
	var _thunder_melee_struct = new AttackMeleeTargeted(
		self,
		spr_boss_melee_thunder_new,
		noone,
		boss_melee_time,
		1,
		pobj_hero,
		boss_def_melee_range + 50,
		sn_thunder2,
		spr_boss_melee_thunder_newHB,
		spr_boss_melee_thunder_hit,
		[pushing_speed,pushing_direction],
		true,
		[-60,-52,0],
		player_worry_buffer_time/3
	)
	
	var _thunder_attack_struct = new AttackStriking(
		self,
		spr_boss_attack_charge_thunder,
		noone,
		boss_ranged_time,//Debug
		1,
		pobj_hero,
		700,
		noone,
		obj_boss_thunder,
		1,
		3
	)
	
	var thunder_shielding = new EntityAttackShielding(
			self,
			spr_boss_forming_shield_thunder,
			noone,
			0,
			1,
			noone,
			noone,
			noone,
			[spr_boss_shield_thunder,spr_boss_shield_surging_thunder,spr_boss_shield_damaged_thunder],
			noone,
			noone,
			7,
			boss_shielding_time
		)
	
	#endregion
	
	#region//Behaviour
	
	var _thunder_state_free = BossStateFree;
	
	#endregion
	
	var _boss_thunder_state = new BossAffectedState(
		spr_boss_idle_thunder,
		[spr_boss_teleport_thunder,spr_boss_teleport_back_thunder,noone],
		[spr_boss_crystal_idle_thunder,spr_boss_crystal_destr_thunder,1,1],
		[_thunder_melee_struct,_thunder_attack_struct,_thunder_invoke_struct],
		_thunder_state_free,
		spr_boss_transition_thunder,
		[spr_boss_thunder_trans_out,4,-14],
		thunder_shielding
	)
	
	#endregion
	
	boss_states = [_boss_ice_state,_boss_fire_state,_boss_wind_state,_boss_thunder_state];

#endregion

#endregion

#region//Attacks

#region Idle Attacks Structs

#region Invoking

boss_invoking_attack = new AttackInvoke(
	self,
	spr_boss_invoking,
	noone,
	boss_invoke_time,
	1,
	noone,
	noone,
	noone,
	obj_boss_minion,
	86,
	-31,
	[2,-30],
	false,
	boss_invoke_frame
)

#endregion

#region Melee

boss_idle_melee_attack = new AttackMelee(
self,
spr_boss_melee,
noone,
boss_melee_time,
1,
pobj_hero,
boss_def_melee_range,
noone,
spr_boss_meleeHB,
spr_boss_melee_hit,
[pushing_speed,35],
false,
player_worry_buffer_time
)

#endregion

#region Ranged

boss_idle_range_attack = new AttackRanged(
	self,
	spr_boss_ranged_attack,
	noone,
	boss_ranged_time,
	1,
	pobj_hero,
	boss_ranged_attacks_range - 100,
	noone,
	true,
	10,
	obj_boss_bullet,
	noone,
	150,
	-100,
	false,
	noone
)

#endregion

#region Shielding

boss_idle_shielding = new EntityAttackShielding(
	self,
	spr_boss_forming_shield_idle,
	noone,
	0,
	1,
	noone,
	noone,
	noone,
	[spr_boss_shield_idle,spr_boss_shield_surging_idle,spr_boss_shield_damaged_idle],
	noone,
	noone,
	2,
	boss_shielding_time
)

#endregion	

#endregion

boss_idle_attacks = [boss_idle_melee_attack,boss_idle_range_attack,boss_invoking_attack];

boss_attacks = boss_idle_attacks;

attack_struct = boss_attacks[0];

#endregion

#region//Behaviour variables

#region Stages

bossCurentStage = 0;
bossStageNum = SKILLS.NUMBER + 2; // So the Idle State is met 2 times

#endregion

#region Attacking

boss_between_attacks_time = FRAME_RATE * 1;
boss_between_attacks_timer = 0;

#endregion

#region//Waving

animation_progress = 0;
animation_spd = (double_pi) / ( FRAME_RATE * 2);

boss_waving_amplitude = 10;
//boss_waving_Vy_amplitude = boss_waving_amplitude * animation_spd;

#endregion

#region Idle Sprites

boss_idle_sprite_idle = spr_boss_idle;

#endregion

#region Final Death 

boss_final_death = false;
boss_death_timer = FRAME_RATE * 4;

vibration_x = -1;
vibration_range_min = 1.5;
vibration_range_max = 3;

#endregion

#region HP

boss_current_state_max_hp = max_hp;

boss_idle_hp_sprite = spr_boss_hp_idle;
boss_idle_hp_death_sprite = spr_boss_hp_death_idle;

boss_current_hp_sprite = boss_idle_hp_sprite;
boss_current_hp_death_sprite = boss_idle_hp_death_sprite;
boss_current_hp_img_num = sprite_get_number(boss_current_hp_sprite) - 1;
boss_current_hp_img_spd = sprite_get_speed(boss_current_hp_sprite) / FRAME_RATE;

boss_hp_img_index = 0;

boss_damaged = false;
boss_hp_alive = false;

#macro boss_hp_general_yoffset 10

boss_current_hp_xoffset = SpriteBBoxOffset(spr_boss_idle,0);
boss_current_hp_yoffset = -(sprite_get_height(spr_boss_idle) + boss_hp_general_yoffset);

#endregion

#region//Teleport

//teleport_point_x = nowhere;

teleport_CD_timers = array_create(BOSS_TP_AIM.NUMBER,0);
teleport_CD_times = array_create(BOSS_TP_AIM.NUMBER);
teleport_CD_times[BOSS_TP_AIM.TO_ESCAPE] = 0.5;
teleport_CD_times[BOSS_TP_AIM.TO_DEFEND] = 16;
teleport_CD_times[BOSS_TP_AIM.TO_ATTACK] = 8;

BossRefreshTPCooldowns();

teleport_delay_range = [FRAME_RATE * 0.8,FRAME_RATE * 1.25];
//Thunder Teleport Vfx

//teleport_away_max_dist = 333;

//teleport_away_range = 333;
//teleport_out_dist = 700;
//teleport_to_range = [100,150];

boss_push_range = 180;

boss_queued_teleport_aim = noone;


//teleport_aim = -1;

//teleport_to_escape_distance = 250;

teleport_steps_before = 20;//Number Of Steps that it takes the projectile to reach the boss before it teleports

boss_idle_teleport_sprites = [spr_boss_teleport,noone,spr_boss_explosion];
teleport_sprites = boss_idle_teleport_sprites;

enum boss_tp{
	in,
	out,
	vfx
}
	
BossManagerUpdate(boss_idle_form_enum);

#endregion

#region Crystal Drop

boss_crystal_drop_xoffset = 0;
boss_crystal_drop_yoffset = -100;

boss_crystal_particle_xoffset = 0;
boss_crystal_particle_yoffset = 0;

#endregion

#region//Affected Steals

#region//Steals

//boss_steal_range = 700;

#region//Count List

//boss_steal_count_list = array_create(4,false);

#endregion

first_steal = true;

#region Waiting For Player

boss_waiting_for_player_time = AnimationGetFrameLength(spr_hero_losing_particle,player_loosing_particle_frame-1);
boss_waiting_for_player_timer = 0;
particle_stolen = false;

#endregion

stealing_particle = noone;
#macro boss_suck_frame 4
boss_suck_distance = 14;
boss_sucking_offsets_x = [134,106,70];
boss_sucking_offsets_y = [-107,-107,-100];

#endregion

current_skill_stolen = noone;

transition_effect = noone;
transition_frames = [7,9,4,7];
transition_done = false;

#endregion

#region Tornado

boss_tornado_spd_multiplier = 50;
var t = spd / decceleration_speed;//Time For Slowing Down
boss_tornado_slowing_distance = boss_tornado_spd_multiplier * t * (spd - decceleration_speed/2 * t);

boss_tornado_player_rotation_spd = (double_pi) / (FRAME_RATE * 0.33);
boss_tornado_player_rotation_progress = 0;
boss_tornado_player_raise_spd = 0.2;

boss_tornado_target_x = x;

#endregion

#region Shielding

entity_shielded = false;
entity_shield_duration_left = 0;

//entity_shield_flash_anim_time = FRAME_RATE * 1.25;
entity_shield_reveal_anim_time = FRAME_RATE * 2;
entity_shield_death_time = FRAME_RATE * 1;
entity_shield_flash_time = floor(FRAME_RATE * 0.4);

entity_shield_sprite = noone;

entity_shield_alpha_anim_progress = 0;
entity_shield_alpha_anim_spd = 0;
entity_shield_alpha = 0;
entity_shield_alpha_anc = anc_boss_shield_alpha;
entity_shield_anim_channel = noone;
entity_shield_anim_cycling = false;

entity_shield_xoffset = 0;
entity_shield_yoffset = 0;

entity_shield_flash_sprite = noone;
entity_shield_flash = false;
entity_shield_flash_time_progress = 0;

entity_shield_max_alpha = 0.75;

boss_shield_struct = boss_idle_shielding;

#endregion

#endregion

#region Appearance in Cutscene

//Create Explosion Effect

var _cutscene_push_out_range = 150;

BossExplosionCreate();
//Push Entities Out
with(pobj_hero)
{
	var _dist = x - other.x;
	if(abs(_dist)<=_cutscene_push_out_range)
	{
		EntityPush(self,9,sign(_dist),45)
	}
}
CameraShake(12,FRAME_RATE * 1.25);

#endregion



