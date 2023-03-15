#region Affected State

///@func BossAffectedState(sprite,attack,behaviour,transition)
///@arg spr_idle
///@arg	[tp_sprites]
///@arg [crstl_sprites_and_offsets]
///@arg [attacks]
///@arg behavior
///@arg transition_in
///@arg [trans_out_sprite_and_offsets] = [sprite,xoffset,yoffset]
///@arg shield

function BossAffectedState(_sprite_idle,_teleport_sprites,_crystal_sprites,_attacks,_behavior_function,_transition_in,_trans_out_offsets,_shield_struct) constructor{
	sprite_idle = _sprite_idle;
	sprite_pushed = _sprite_idle;
	sprite_run = _sprite_idle;
	teleport_sprites = _teleport_sprites;
	crystal_sprites = [_crystal_sprites[0],_crystal_sprites[1]];
	crystal_particle_offsets = [_crystal_sprites[2],_crystal_sprites[3]];
	boss_attacks = _attacks;
	boss_shield_struct = _shield_struct;
	state_free = _behavior_function;
	sprite_transition_effect = _transition_in;
	trans_out_offsets = [_trans_out_offsets[1],_trans_out_offsets[2]];
	boss_affected_trans_out_sprite = _trans_out_offsets[0];
	//sprite_affected_fragment_death = _spr_frag_death;
}
	
#endregion

#region HP

function BossSurgeNewHP(){
	current_hp = max_hp;
	EffectCreateOnTargetOffset(spr_boss_hp_surging,image_xscale,self,boss_current_hp_xoffset,boss_current_hp_yoffset,false);
	alarm[0] = AnimationGetFrameLength(spr_boss_hp_surging);
}

///@arg time
function BossHideHP(_time = boss_hp_default_hide_time){
	if(boss_hp_alive)
	{
		var _hide_spd = boss_hp_hide_frame / _time;
		sprite_set_speed(spr_boss_hp_teleporting,_hide_spd,spritespeed_framespergameframe);
		EffectCreateOnTargetOffset(spr_boss_hp_teleporting,image_xscale,self,boss_current_hp_xoffset,boss_current_hp_yoffset,false);
		boss_hp_alive = false;
	}
}

///@arg time
function BossHPReveal(_time = boss_hp_default_reveal_time){
	if(current_hp > 0 && !boss_hp_alive && !entity_shielded)
	{
		var _reveal_spd = (sprite_get_number(spr_boss_hp_teleporting) - boss_hp_hide_frame) / _time;
		sprite_set_speed(spr_boss_hp_teleporting,_reveal_spd,spritespeed_framespergameframe);
		EffectCreateReversedTargeted(spr_boss_hp_teleporting,self,boss_current_hp_xoffset,boss_current_hp_yoffset,image_xscale);
		alarm[1] = _time;
	}
}

#endregion

#region One Time

function BossExplosionCreate(){
	with(pobj_hero)
	{
		var _dist = x - other.x;
		if(abs(_dist) <= other.boss_push_range)
		{
			EntityPush(self,other.pushing_speed,sign(_dist),other.pushing_direction);
		}
	}
	EffectCreate(x,y,spr_boss_explosion,image_xscale,false);		
}
	
function BossDisplayGUI(){
	with(global.boss_manager)
	{
		boss_gui_display = true;	
	}	
}

function BossHideGUI(){
	with(global.boss_manager)
	{
		boss_gui_display = false;	
	}	
}

#endregion

#region Debug

function BossDebugKillCurrentState(){
	with(global.boss_manager)
	{
		boss_hp_fragments_left = 1;
	}
	with(global.oBoss)
	{
		current_hp = 1;	
	}
	EntityDamage(global.oBoss,0);
}
	
function BossDebugKillTotally(){
	with(global.oBoss)
	{
		bossCurentStage = bossStageNum - 1;
		//boss_steal_count_list = array_create(SKILLS.NUMBER,true);	
		with(global.boss_manager)
		{
			for(var i = 0; i < SKILLS.NUMBER; i++)
			{
				if(boss_affecteds_available[i] == true)
				{
					BossManagerDestroyFragment(i);
				}
			}
			bossCurentStage = other.bossCurentStage;
		}
		BossDebugKillCurrentState();
	}
}

#endregion

function BossFromTornadoTransitionUpdateSpeed(){
	spd /= boss_tornado_spd_multiplier;
	acceleration_speed = spd / boss_acceleration_time;
	decceleration_speed = spd / boss_decceleration_time;	
}

function BossStateFromTornadoTransition(){
	if(AnimationEndReverse())
	{
		BossFromTornadoTransitionUpdateSpeed();
		EntityMakeStatic();
	}
}
	
function BossDefaultMovementAI(){
	var _return = noone;
	movement_direction = FacePlayer();
	EntityMovement();
	BossWaving();
	
	if(Vx != 0)
	{
		InstanceRotateCentrally(sign(Vx));
	}
	return _return;
}
	
function BossStopWaving(){
	if(animation_progress >= pi) animation_progress -= pi;
	previous_state = state;
	state = BossWavingBeingStopped;
	vibration_x = x;
}

function BossWavingBeingStopped(){
	EntityMovement();
	animation_progress += animation_spd * sign(animation_progress - pi/2);
	var _add_y = sin(animation_progress) * boss_waving_amplitude;
	y = flying_y + _add_y;
	if(abs(_add_y) <= 0.5)
	{
		state = previous_state;
		y = flying_y;
		animation_progress = 0;
	}
}

function BossIdleFinalDeath(){
	PlayerMakeStatic();
	movement_direction = 0;
	Vx = 0;
	state = BossStateDying;
	BossStopWaving();
	if(!instance_exists(global.oPlayer)) return;
	var _x_vec = x - global.oPlayer.x;
	if(_x_vec != 0)
	{
		InstanceRotateCentrally(sign(_x_vec),global.oPlayer);	
	}
	//var _side = (global.oPlayer.x == x) ? 1 : sign(global.oPlayer.x-global.oBoss.x);
	boss_push_range *= 2;
	pushing_speed *= 1.5;
	BossExplosionCreate();
}

function BossFinalDeath(){
	sprite_index = spr_boss_death_idle_final;
	image_index = 0;
	state = BossStateFinalDeath;
	movement_direction = 0;
	push_vulnerable = false;
	damage_vulnerable = false;
	with(pobj_wall_barrier)
	{
		barrier_working = false;	
	}
	x = vibration_x;
	y = flying_y;
}

function BossStateFinalDeath(){
	if(AnimationEnd())
	{
		image_index = image_number - 1;
		image_speed = 0;
		state = BossStateDestroyed;
		cutscene_run(obj_CS_boss_final_stage_new);
	}
}

function BossStateDestroyed(){
	//	
}

function BossStateDying(){
	BossDeathVibrationMovement();
	if(--boss_death_timer <= 0)
	{
		BossFinalDeath();
	}
}
	

function BossTransitionToFinalStateFinish(){
	sprite_idle = spr_boss_final_idle;
	sprite_death = spr_boss_final_death;
	boss_final_death = true;
	EntityMakeStatic();
}

//function BossStateFinalStatic(){
//	EntityMovement();
//}	
	
function BossDeathVibrationMovement(){
	var _vibration_range = random_range(vibration_range_min,vibration_range_max);
	var _vibration_direction = irandom(359);
	x = vibration_x + lengthdir_x(_vibration_range,_vibration_direction);
	y = flying_y + lengthdir_y(_vibration_range,_vibration_direction);
}
	
function BossDefaultAttackAI(){
	var _attacks_number = array_length(boss_attacks);
	
	var _can_attack = (--boss_between_attacks_timer <= 0);
	
	for(var i = 0; i < _attacks_number; i++)
	{
		attack_struct = boss_attacks[i];
		//var _attack_AI = attack_struct.attack_default_AI;
		//if(_attack_AI(attack_struct))
		//{
		//	return BOSS_EVENT.ATTACK;
		//}
		with(attack_struct)
		{
			if(attack_cooldown_function())
			{
				if(_can_attack)
				{
					if(range_function != noone)
					{
						attack_target_inst = range_function();
						if(attack_target_inst == noone)
						{
							with(other)
							{
								if(teleport_CD_timers[BOSS_TP_AIM.TO_ATTACK] <= 0)
								{
									if(BossTeleport(BOSS_TP_AIM.TO_ATTACK))
									{
										attack_struct.attack_worry_delay = attack_struct.attack_worry_delay_target;
										attack_struct.attack_delayed_player_worried = true;
										return BOSS_EVENT.TELEPORT;
									}
								}
							}
						}
						else
						{
							if(attack_function())
							{
								//with(other)
								//{
								//	boss_between_attacks_timer = boss_between_attacks_time;
								//}
								return BOSS_EVENT.ATTACK;
							}
						}
					}
					else
					{
						if(attack_function())
						{
							//boss_between_attacks_timer = boss_between_attacks_time;
							return BOSS_EVENT.ATTACK;
						}
					}
				}
			}
		}
	}
	
	return noone;
}

//Default Behaviour
function BossDefaultBehaviour(){
	var _return = noone;
	
	_return = BossDefaultMovementAI();
	
	if(_return == noone)
	{
		_return = BossDefaultAttackAI();
	}
	
	
	if(_return == noone)
	{
		_return = BossTeleportControl();
	}
	
	return _return;
}
	
function BossShield(){
	attack_struct = boss_shield_struct;
	with(attack_struct)
	{
		attack_function();	
	}
}

function BossTransitionToFinalTornado(){
	sprite_index = spr_boss_tornado_transition;
	image_index = 0;
	state = BossStateTransitionToFinalTornado;
}
	
function BossTornadoCountSlowingDistance(){
	var t = abs(Vx) / decceleration_speed;//Time For Slowing Down
	var slowing_distance = t * (abs(Vx) - decceleration_speed/2 * t);	
	return slowing_distance;
}

///@arg distance
function BossTornadoCountMovementTime(_S){
	var rootArg = sqr(acceleration_speed)/4 + 4 * Vx * _S;
	if(rootArg < 0) return 0;
	var t = (-Vx + sqrt(rootArg))/(2 * acceleration_speed);
	return t;
}

function BossStateTransitionToFinalTornado(){
	if(AnimationEnd())
	{
		BossTransitionToTornadoUpdateSpeed(25);
		state = BossStateFinalTornadoCatchPlayer;
		boss_tornado_target_x = global.oPlayer.x;
		movement_direction = sign(global.oPlayer.x - x);
		sprite_index = spr_boss_tornado;
		image_index = 0;
	}
}
	
function BossStateFinalTornadoCatchPlayer(){
	var dist = abs(boss_tornado_target_x - x);
	if(movement_direction = 0 && abs(Vx) == 0)
	{
		x = boss_tornado_target_x;
		state = BossStateFinalTornadoDeliverPlayer;
		boss_tornado_target_x = shrine_x + (ff_player_x_to_center * sign(x - shrine_x));
		movement_direction = sign(boss_tornado_target_x - x);
		if(movement_direction == 0) movement_direction = 1;
		
		exit;
	}
	else
	{
		if(dist <= BossTornadoCountSlowingDistance())
		{
			movement_direction = 0;
		}		
	}
	EntityMovement();
	if(Vx != 0)
	{
		InstanceRotateCentrally(sign(Vx));
	}
}

function BossStateFinalTornadoDeliverPlayer(){
	var dist = abs(boss_tornado_target_x - x);
	if(movement_direction = 0 && abs(Vx) == 0)
	{
		var _player_side = sign(global.oPlayer.x - shrine_x);
		x = boss_tornado_target_x;
		
		global.oPlayer.x = boss_tornado_target_x;
		global.oPlayer.image_xscale = sign(cos(boss_tornado_player_rotation_progress));
		InstanceRotateCentrally(-_player_side,global.oPlayer);
		//EntityPush(global.oPlayer,9,1,90);//Throw Player Up
		
		state = BossStateFinalTornadoMoveToFinal;
		boss_tornado_target_x = shrine_x + ff_boss_x_target * -_player_side;
		movement_direction  = sign(boss_tornado_target_x - x);
		boss_tornado_player_rotation_progress = 0;
		
		var camDist = abs(shrine_x - x);
		var bossDist = abs(boss_tornado_target_x - x);
		var t = BossTornadoCountMovementTime(bossDist);
		
		CameraStateChange(CameraStateStatic);
		CameraMoveTo(shrine_x,CAMERA_Y,camDist/t,false);
		
		exit;
	}
	else
	{
		if(dist <= BossTornadoCountSlowingDistance())
		{
			movement_direction = 0;
		}	
	}
	
	EntityMovement();
	if(Vx != 0)
	{
		InstanceRotateCentrally(sign(Vx));
	}
	
	#region Player Inside Tornado
	
	boss_tornado_player_rotation_progress += boss_tornado_player_rotation_spd;
	boss_tornado_player_rotation_progress %= double_pi;
	
	with(global.oPlayer)
	{
		x = other.x;
		y -= other.boss_tornado_player_raise_spd;
		//Debug:add proper rotation
		image_xscale = cos(other.boss_tornado_player_rotation_progress) * other.image_xscale;
	}
	
	#endregion
}

///@arg spd_multiplier
function BossTransitionToTornadoUpdateSpeed(_spd_multiplier){
	boss_tornado_spd_multiplier = _spd_multiplier;
	spd *= boss_tornado_spd_multiplier;
	acceleration_speed = spd / boss_acceleration_time;
	decceleration_speed = spd / boss_decceleration_time;
	var t = spd / decceleration_speed;//Time For Slowing Down
	boss_tornado_slowing_distance = t * (spd - decceleration_speed/2 * t);
}

function BossTransitionToTornado(){
	state = BossStateTornado;
	BossTransitionToTornadoUpdateSpeed(50);
	sprite_index = spr_boss_tornado;
	image_index = 0;	
}

function BossStateFinalTornadoMoveToFinal(){
	var dist = abs(boss_tornado_target_x - x);
	if(movement_direction = 0 && abs(Vx) == 0)
	{
		x = boss_tornado_target_x;
		sprite_index = spr_boss_tornado_transition;
		image_speed = -1;
		image_index = image_number - 1;
		state = BossStateFromTornadoTransition;
		exit;
	}
	else
	{
		if(dist <= BossTornadoCountSlowingDistance())
		{
			movement_direction = 0;
		}	
	}
	EntityMovement();
	if(Vx != 0)
	{
		InstanceRotateCentrally(sign(Vx));
	}
}

function BossStateTornado(){
	var dist = abs(x - boss_tornado_x_target)
	if(dist <= spd)
	{
		x = boss_tornado_x_target;
		sprite_index = spr_boss_tornado_transition;
		image_index = image_number - 1;
		image_speed = -1;
		state = BossStateFromTornadoTransition;
		InstanceRotateCentrally(1);	
		Vx = 0;
		exit;
	}
	else
	{
		if(dist <= BossTornadoCountSlowingDistance())
		{
			movement_direction = 0;
		}
	}
	EntityMovement();
	with(instance_place(x,y,obj_candle_tower))
	{
		instance_destroy();	
	}
	//with(instance_place(x,y,obj_candle_tower_blown_off))
	//{
	//	instance_destroy();	
	//}
	with(instance_place(x,y,obj_shrine))
	{
		if(!collapsing) collapsing = true;
		current_hp = 0;
		//instance_destroy(light_instance);
	}
	with(instance_place(x,y,pobj_hero))
	{
		if(state != EntityStatePushed)
		{
			EntityPush(self,9,-other.image_xscale,45);	
		}
	}
}

function BossStateAppearance(){
	if(AnimationEnd())
	{
		BossMakeStatic();
	}
}

function BossCreateParticle(){
	particle_stolen = false;
	//steal_CD_time = RangeArrayGetNumber(steal_CD_time_range,true);
	state = BossStateWaitingForPlayerAnimation;
	damage_vulnerable = false;
	push_vulnerable = false;
	stun_vulnerable = false;
	with(global.oPlayer)
	{
		image_index = 0;
		sprite_index = spr_hero_losing_particle;
		state = PlayerStateLosingParticle;
		Vx = 0;
		Vy = 0;
	}
}

function BossStateWaitingForPlayerAnimation(){
	BossWaving();
	if(++boss_waiting_for_player_timer >= boss_waiting_for_player_time)
	{
		boss_waiting_for_player_timer = 0;
		sprite_index = spr_boss_create_particle;
		image_index = 0;
		state = BossStateCreatingParticle;
	}
	
}
	
function BossReceiveDamage(){
	if(entity_shielded)
	{
		current_hp++;
		EntityShieldFlash();
	}
	else
	{
		if(teleport_CD_timers[BOSS_TP_AIM.TO_ESCAPE] <= 0 && current_hp > 0)
		{
			BossTeleport(BOSS_TP_AIM.TO_ESCAPE);
		}
		boss_damaged = true;
	}
}

///@arg skill_enum_id
function BossAffectedStateChange(_skill_enum_id){
	
	current_skill_stolen = _skill_enum_id;
	var _new_state = boss_states[_skill_enum_id];
	
	boss_attacks = _new_state.boss_attacks;
	boss_shield_struct = _new_state.boss_shield_struct;
	teleport_sprites = _new_state.teleport_sprites;
	
	BossFightStageTransition(_skill_enum_id);
	BossManagerUpdate(_skill_enum_id);
	
	transition_effect = EffectCreate(x,y,_new_state.sprite_transition_effect,image_xscale,false);
	
	state = BossStateAffectedTransition;
	sprite_index = sprite_idle;
	image_index = 0;
	
	global.pause_available = false;
}

function BossReturnToIdle(){
	var _old_state = boss_states[current_skill_stolen];
	
	boss_attacks = boss_idle_attacks;
	boss_shield_struct = boss_idle_shielding;
	teleport_sprites = boss_idle_teleport_sprites;
	
	BossFightStageTransition(boss_idle_form_enum);
	BossManagerUpdate(boss_idle_form_enum);
	
	//transition_effect = EffectCreateReversed(x,y,_old_state.sprite_transition_effect,image_xscale,false);
	
	global.pause_available = false;
	
	state = BossStateIdleTransition;
	sprite_index = _old_state.boss_affected_trans_out_sprite;
	image_index = 0;
}

function BossAttacksCooldownReset(){
	for(var i = 0; i < array_length(boss_attacks); i++)
	{
		var _attack_struct = boss_attacks[i];
		_attack_struct.attack_cooldown = 0;
	}
	return true;
}

function BossFinishTransition(){
	global.pause_available = true;
	BossAttacksCooldownReset();
	BossInviolableMakeFree();
}

function BossStateIdleTransition(){
	if(AnimationEnd())
	{
		var _old_state = boss_states[current_skill_stolen];
		x += _old_state.trans_out_offsets[0] * image_xscale;
		var _new_y = y + _old_state.trans_out_offsets[1];
		var _new_additional_y = _new_y - flying_y;
		animation_progress = clamp(_new_additional_y/boss_waving_amplitude*pi/2,-pi/2,pi/2);
		current_skill_stolen = noone;
					
		sprite_index = boss_idle_sprite_idle;
		image_index = 0;
		
		boss_current_hp_xoffset = SpriteBBoxOffset(sprite_index,0);
		boss_current_hp_yoffset = -(sprite_get_height(sprite_index) + boss_hp_general_yoffset);
					
		EntityUpdateSprites();
					
		state_free = BossStateFree;
		BossMakeInviolable();
		
		if(bossCurentStage > 0 && bossCurentStage < bossStageNum - 1)
		{
			//Steal New Skill
			alarm[2] = FRAME_RATE * 2;
		}
		else
		{
			BossSurgeNewHP();
			current_hp = max_hp;
			BossFinishTransition();
		}
	}
	//with(transition_effect)
	//{
	//	if(!other.transition_done)
	//	{
	//		if(AnimationEndReverse(other.transition_frames[other.current_skill_stolen]))
	//		{
	//			with(other)
	//			{
	//				current_skill_stolen = noone;
					
	//				sprite_index = boss_idle_sprite_idle;
	//				image_index = 0;
					
	//				sprite_idle = sprite_index;
	//				sprite_pushed = sprite_index;
	//				sprite_run = sprite_index;
					
	//				state_free = BossStateFree;
					
	//				BossSurgeNewHP();
	//				current_hp = max_hp;
					
	//				transition_done = true;
	//			}
	//		}
	//	}
	//	else
	//	{
	//		if(AnimationEndReverse(0.5))//For Safe Checking
	//		{
	//			global.pause_available = true;
	//			with(other)
	//			{
	//				BossInviolableMakeFree();
	//				transition_done = false;
	//			}
	//		}
	//	}
	//}
}

function BossStateAffectedTransition(){
	with(transition_effect)
	{
		if(!other.transition_done)
		{
			if(AnimationEnd(other.transition_frames[other.current_skill_stolen]))
			{
				with(other)
				{
					var _new_state = boss_states[current_skill_stolen];
					
					sprite_index = _new_state.sprite_idle;
					image_index = 0;
					
					EntityUpdateSprites();
					
					boss_current_hp_xoffset = SpriteBBoxOffset(sprite_index,0);
					boss_current_hp_yoffset = -(sprite_get_height(sprite_index) + 15);
					
					boss_crystal_particle_xoffset = _new_state.crystal_particle_offsets[0];
					boss_crystal_particle_yoffset = _new_state.crystal_particle_offsets[1];
					
					state_free = _new_state.state_free;
					
					BossSurgeNewHP();
					current_hp = max_hp;
					
					if(first_steal)
					{
						BestiaryEnqueue(BESTIARY_PAGE_TYPE.TEXT,Text("tutorial bestiary: skill steal"));
						first_steal = false;
					}
					
					transition_done = true;
				}
			}
		}
		else
		{
			if(AnimationEnd())
			{
				with(other)
				{
					BossFinishTransition();
					transition_done = false;
				}
			}
		}
	}
}	
	
function BossDropCystal(){
	var _side = EnemyFindMovementDirection();
	var _x = x + boss_crystal_drop_xoffset * _side;
	var _y = y + boss_crystal_drop_yoffset;
	var _crystal = instance_create_layer(_x,_y,"Instances",pobj_boss_crystal);
	var _element = current_skill_stolen;
	var _sprites = boss_states[_element].crystal_sprites;
	with(_crystal)
	{
		sprite_index = 	_sprites[0];
		sprite_death = _sprites[0];
		element = _element;
		rotation_spd *= _side;
		particle_xoffset = other.boss_crystal_particle_xoffset;
		particle_yoffset = other.boss_crystal_particle_yoffset;
	}
	ObjectPush(_crystal,5.5,_side,50);
	return _crystal;
}

function BossStateSuckingParticle(){
	BossWaving();
	if(AnimationEnd(boss_suck_frame))
	{
		var _particle_x = x + boss_sucking_offsets_x[ceil(image_index)-boss_suck_frame]*image_xscale;
		var _particle_y = y + boss_sucking_offsets_y[ceil(image_index)-boss_suck_frame];
		with(stealing_particle)
		{
			x = _particle_x;
			y = _particle_y;
		}
	}
	if(AnimationEnd())
	{
		BossAffectedStateChange(stealing_particle.skill_stolen);
		instance_destroy(stealing_particle);
	}
}	

function BossSuckParticle(){
	sprite_index = spr_boss_suck_particle;
	image_index = 0;
	state = BossStateSuckingParticle;
	movement_direction = 0;
}

function BossStateWaitForParticle(){
	BossWaving();
	if(
		point_distance(
			stealing_particle.x,stealing_particle.y,
			x+boss_sucking_offsets_x[0]*image_xscale,y+boss_sucking_offsets_y[0])
			<=boss_suck_distance)
			{
				BossSuckParticle();
				with(stealing_particle) waving_spd/=2;
			}
}

function BossWaitForParticle(){
	sprite_index = sprite_idle;
	image_index = 0;
	state = BossStateWaitForParticle;
}

function BossStateCreatingParticle(){
	BossWaving();
	if(!particle_stolen && AnimationEnd(boss_stealing_particle_frame))
	{
		particle_stolen = true;
		var _skills_not_stolen = ds_list_create();
			
		for(var i = 0; i < SKILLS.NUMBER; i++)
		{
			//if(boss_steal_count_list[i] == false)
			if(global.boss_manager.boss_affecteds_available[i])
			{
				ds_list_add(_skills_not_stolen,i);
			}
		}
		var _stolen_id = irandom(ds_list_size(_skills_not_stolen)-1);
		var _stolen_skill = _skills_not_stolen[| _stolen_id];
			
		ds_list_destroy(_skills_not_stolen);
		
		//boss_steal_count_list[_stolen_skill] = true;
		
		#region//Creating Particle Itself
		stealing_particle = instance_create_layer(global.oPlayer.x,global.oPlayer.y - global.oPlayer.view_y_offset,"Effects",obj_boss_stealing_particle)
		with(stealing_particle)
		{
			part_type_color1(spark_particle,particles_colors[_stolen_skill]);
			part_type_sprite(small_particle,particles_sprites[_stolen_skill],false,false,false);
			skill_stolen = _stolen_skill;
			image_index = skill_stolen;
		}
		#endregion
		
		CameraShake(20,FRAME_RATE * 1);
		
		//EntityStun(global.oPlayer,1.5,0);//Stun Player
		
		with(global.oPlayer)
		{
			skills[_stolen_skill][SKILL.AVAILABLE] = false;//Block Player's Skill
			skills[_stolen_skill][SKILL.SPECIAL_PROGRESS] = 0;
			with(pobj_player_special_stack)
			{
				if(skill_id == _stolen_skill)
				{
					instance_destroy();	
				}
			}
		}
	}
	
	if(AnimationEnd())
	{
		#region//Change State
		BossWaitForParticle();
		#endregion
	}																											
}

function BossWaving(){
	y = flying_y - sin(animation_progress) * boss_waving_amplitude;
	animation_progress+=animation_spd;
	if(animation_progress >= (double_pi)) animation_progress %= (double_pi);
	
}

//State Free !
function BossStateFree(){
	
	switch(BossDefaultBehaviour())
	{
		case BOSS_EVENT.ATTACK:
		
		boss_between_attacks_timer = boss_between_attacks_time;
		
		break;
		
		default: 
		
		break;
	}
}
	
#region Teleport Related

///@arg aim
function BossRefreshTPCooldowns(_aim = -1){
	if(_aim != -1)
	{
		teleport_CD_timers[_aim] = teleport_CD_times[_aim] * FRAME_RATE;	
	}
	else
	{
		for(var i = 0; i < BOSS_TP_AIM.NUMBER; i++)
		{
			teleport_CD_timers[i] = teleport_CD_times[i] * FRAME_RATE;	
		}
	}
}
	
function BossTeleportControl(){
	//Debug
	for(var i = 0; i < BOSS_TP_AIM.NUMBER; i++)
	{
		teleport_CD_timers[i] = max(0,--teleport_CD_timers[i]);	
	}
	//teleport_CD_time = max(0,--teleport_CD_time);
	if(teleport_CD_timers[BOSS_TP_AIM.TO_DEFEND] <= 0)
	{
		with(pobj_projectile)
		{
			if(enemy_parent == pobj_hitable || object_is_ancestor(enemy_parent,pobj_hitable))
			{
				//var _dist = other.x - x;
				var _travel = Vx * other.teleport_steps_before;
				var _hits = collision_line(x,y,x+_travel,y,other,false,false);
				if(_hits != noone)
				{
					with(other)
					{
						if(BossTeleport(BOSS_TP_AIM.TO_DEFEND))
						{
							return true;
						}
					}
				}
			}
		}
	}
	return false;
}

///@arg aim[enum]
function BossTeleport(_aim){
	if(state == state_free)
	{
		Vx = 0;
		
		var _tp_in_sprite = teleport_sprites[boss_tp.in];
		var _tp_in_time = AnimationGetFrameLength(_tp_in_sprite);
	
		EffectCreate(x,y,_tp_in_sprite,image_xscale,false);
		EntityShieldDisappear(_tp_in_time);
	
		BossHideHP(_tp_in_time);
		BossRefreshTPCooldowns(_aim)
	
		with(global.boss_manager)
		{	
			teleport_aim = _aim;
		
			teleport_point = other.x;
		
			var teleport_time = RangeArrayGetNumber(other.teleport_delay_range,true) + _tp_in_time;
			boss_teleport_time = teleport_time;
			boss_teleport_worry_time = (teleport_time - teleport_worry_time);
		
			boss_teleporting = true;
		}
	
		instance_deactivate_object(global.oBoss);
		return true;
	}
	else
	{
		return false;	
	}
}

///@arg aim
function BossPickTeleportX(_aim){
	var _target_x = shrine_x;
	
	switch(_aim)
	{
		
		case BOSS_TP_AIM.TO_ATTACK:
		
		if(instance_exists(global.oPlayer))
		{
			var _player_x = global.oPlayer.x;
			var _player_dislocation = _player_x - shrine_x;
			if(_player_dislocation > room_width / 3)
			{
				var _player_map_side = -sign(_player_dislocation);		
				_target_x = _player_x + boss_def_melee_range * 0.75  * _player_map_side;
			}
			else
			{
				var _player_face = sign(global.oPlayer.image_xscale);		
				_target_x = _player_x + boss_def_melee_range * 0.75  * _player_face;	
			}
		}
		
		break;
		
		case BOSS_TP_AIM.TO_DEFEND:
		
		//_target_x = x;
		_target_x = teleport_point;
		
		break;
		
		case BOSS_TP_AIM.TO_ESCAPE:
		
		if(instance_exists(global.oPlayer))
		{
			var _player_x = global.oPlayer.x;
			var _player_map_side = -sign(_player_x / shrine_x);		
			_target_x = _player_x + RangeArrayGetNumber(boss_tp_to_escape_range,true)  * _player_map_side; 
		}
		
		break;
	
		
	}
	
	var _x_min = 0 + (x - bbox_left);
	var _x_max = room_width - (bbox_right - x);
	_target_x = clamp(_target_x,_x_min,_x_max);
	
	return _target_x;
}

function BossStateTeleported(){
	var _anim_finished = false;
	if(image_speed == 1)
	{
		_anim_finished = AnimationEnd();
	}
	else
	{
		_anim_finished = AnimationEndReverse();	
	}
	if(_anim_finished)
	{
		EntityMakeFree();
		EntityShieldReveal();
		movement_direction = 0;
		//teleport_CD_time = RangeArrayGetNumber(teleport_CD_time_range,true);
		if(global.boss_manager.teleport_aim == BOSS_TP_AIM.TO_ATTACK)
		{
			with(attack_struct)
			{
				attack_target_inst = range_function();
				if(attack_target_inst != noone)
				{
					attack_function();
				}
			}
		}
	}
}
	
function BossManagerTeleportation(){
	instance_activate_object(global.oBoss);
	boss_teleporting = false;

	with(global.oBoss)
	{
		InstanceRotateCentrally(other.teleport_xscale);
		sprite_index = other.teleport_out_sprite;
	
		if(other.teleport_out_sprite_reversed)
		{
			image_speed = -1;
			image_index = image_number - 1;
		}
		else
		{
			image_speed = 1;
			image_index = 0;
		}
	
		x = other.teleport_x;
		state = BossStateTeleported;
		
		var _tp_vfx = teleport_sprites[boss_tp.vfx];
		if(_tp_vfx!=noone)
		{
			if(current_skill_stolen != SKILLS.FIRE_BALL)
			{
				EffectCreateOnTargetOffset(_tp_vfx,image_xscale,self,0,0,false);
			}
			else
			{
				EffectCreate(x,FLOOR_Y,_tp_vfx,image_xscale,false);	
			}
		}
		
		BossHPReveal(AnimationGetFrameLength(sprite_index));
	
	}
}

function BossManagerWorry(){
	teleport_x = BossPickTeleportX(teleport_aim);
	PlayerWorry();
	if(instance_exists(global.oPlayer))
	{
		teleport_xscale = sign(global.oPlayer.x - teleport_x);	
	}
	//Thunder State TP VFX
	if(boss_current_enum == SKILLS.THUNDER)
	{
		AnimationSetLength(spr_boss_tp_vfx_thunder,teleport_worry_time/FRAME_RATE);
		EffectCreate(teleport_x,FLOOR_Y,spr_boss_tp_vfx_thunder,teleport_xscale,false);
	}	
}
	
#endregion










