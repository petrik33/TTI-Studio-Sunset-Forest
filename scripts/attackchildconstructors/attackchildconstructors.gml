#region//Dash

///@func AttackDash(Attack,sprite,time,loops,distance)
///@arg inst owner instance
///@arg sprite attack image
///@arg time* fixed attack time if necessary
///@arg cooldown attack cooldown
///@arg speed attack speed factor
///@arg target target instances' parnet
///@arg x_range range of the attack
///@arg sound (made on attack)

///@arg sprite image for dash charge
///@arg charge_time* total time of charge
///@arg loops number of charge animation loops
///@arg distance distance of the dash
///@arg [push_effect]
///@arg hit_effect
///@arg sn_charge


function AttackDash(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,
_charge_sprite,_charge_time,_charge_loops,_dash_distance,_push_effect,_hit_effect,_sn_charge) 
: Attack(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,ATTACK_TYPE.DASH) constructor 
{
	
	#region//Set Charge Sprite
	dash_charging_sprite = _charge_sprite;
	if(_charge_time!=noone && _charge_time!=-1)
	{
		AnimationSetLength(_charge_sprite,_charge_time/_charge_loops);
	}
	#endregion
	
	attack_dash_speed = _dash_distance / AnimationGetFrameLength(_sprite);
	
	attack_charge_sound = _sn_charge;
	
	attack_charge_count = 0;
	attack_charge_target = _charge_loops;
	attack_target_inst = noone;
	
	attack_hit_effect = _hit_effect;
	attack_push_effect = _push_effect;

	range_function = function(){
		var _my_x = attack_owner.x;
		var in_range = noone;
		with(attack_target)
		{
			if(abs(_my_x - x)<=other.attack_x_range)
			{
				var in_range = self;
			}
		}
		return in_range;
	}
	
	attack_function = function(){
		attack_charge_count = 0;
		with(attack_owner)
		{
			attack_worry_delay = 0;
			state = MeleeAttackCharging;
			emitter_sound(attack_struct.attack_charge_sound,false);
			sprite_index = other.dash_charging_sprite;
			image_index = 0;
			Vx = 0;
			Vy = 0;	
		}
		return true;	
	}
		
	charge_function = function(){
		attack_cooldown = 0;
		with(attack_owner)
		{
			emitter_sound(attack_struct.attack_sound,false);
			state = EntityDashAttack;
			sprite_index = other.attack_sprite;
			image_index = 0;
			Vx = other.attack_dash_speed * sign(other.attack_target_inst.x - x);
			InstanceRotateCentrally(sign(Vx));
			if(audio_is_playing(step_sound)) audio_pause_sound(step_sound);
			return true
		}
	}
}

#endregion

#region//Ranged Attack

///@func AttackRanged(Attack,shooting_frame,bullet,back_range)
///@arg inst
///@arg sprite
///@arg time*
///@arg cooldown
///@arg speed
///@arg target
///@arg x_range
///@arg sound

///@arg is_targeted
///@arg shooting_frame {int} frame of the animation when shot happens
///@arg bullet {object} object_id of the bullet to make shot with
///@arg back_x_range* {real} back range of the attack
///@arg x_offset {real} offset between bullet creation and owner x coordinates
///@arg y_offset {real} offset between bullet creation and owner y coordinates
///@arg [attack_sprite_is_VFX] [{bool},{bool}] if attack sprite is just side VFX and if it's targeted
///@arg targeting_buffer time before the shot when the target coordinates are counted

function AttackRanged(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,
_is_targeted,_shot_frame,_bullet_obj,_back_range,_x_offset,_y_offset,_sprite_is_VFX,_targeting_buffer)//_y_target_offset,_sprite_is_VFX)
: Attack(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,ATTACK_TYPE.RANGED)
constructor{
	
	attack_no_auto_worry = true;
	
	
	//shooting_frame = _shot_frame;
	bullet_object = _bullet_obj;
	attack_x_offset = _x_offset;
	attack_y_offset = _y_offset;
	//attack_target_y_offset = _y_target_offset;
	attack_target_inst = noone;
	if(is_array(_sprite_is_VFX))
	{
		//Is Vfx actually
		attack_sprite_is_VFX = _sprite_is_VFX[0];
		attack_vfx_targeted = _sprite_is_VFX[1];
	}
	else
	{
		//Not Vfx
		attack_sprite_is_VFX = _sprite_is_VFX;	
	}
	
	attack_ranged_targeted = _is_targeted;
	attack_vfx = noone;
	
	attack_charge_count = 0;
	if(_shot_frame != noone)
	{
		attack_charge_target = AnimationGetFrameLength(attack_sprite,_shot_frame);
	}
	else
	{
		attack_charge_target = AnimationGetFrameLength(attack_sprite);	
	}
	
	if(_targeting_buffer == noone)
	{
		attack_ranged_targeting_buffer = floor(attack_charge_target - player_worry_buffer_time);//Debug
	}
	else
	{
		attack_ranged_targeting_buffer = floor(attack_charge_target - FRAME_RATE * _targeting_buffer);	
	}
	
	attack_range_delayed = (attack_ranged_targeting_buffer < 0);
	attack_worry_delay_target = -attack_ranged_targeting_buffer;//For Delayed Attacks Only
	
	attack_direction = noone;
	
	#region//Back Range
	if(_back_range!=-1 && _back_range!=noone)
	{
		attack_back_range = _back_range;	
	}
	else
	{
		attack_back_range = _attack_x_range;	
	}
	#endregion
	
	range_function = function(){
		//Count Attack Range
		with(attack_owner)
		{
			switch(sign(image_xscale))
			{
				case 1:
				var hit_range_min = x - other.attack_back_range;
				var hit_range_max = x + other.attack_x_range;
				break;
				case -1:
				var hit_range_min = x - other.attack_x_range;
				var hit_range_max = x + other.attack_back_range; 
				break;
			}
		}
		//Find Targets In Range
		var in_range = noone;
		with(attack_target)
		{
			if(x>=hit_range_min && x<=hit_range_max)
			{
				in_range = self;
			}
		}
		return in_range;
	}
		
	attack_function = function(){
		if(attack_range_delayed)
		{
			if(attack_worry_delay == 0)
			{
				AttackPlayerWorry();
				RangedAttackTarget();
			}
			if(++attack_worry_delay == attack_worry_delay_target)
			{
				AttackRangedShoot();
				return true;
			}
			else
			{
				return false;	
			}
		}
		else
		{
			AttackRangedShoot();
			return true;
		}
	}
	
}

#endregion

#region//Melee Attack

/// @arg inst owner instance
/// @arg sprite attack image
/// @arg time* fixed attack time if necessary
/// @arg cooldown attack cooldown
/// @arg speed attack speed factor
/// @arg target target instances' parnet
/// @arg x_range range of the attack
/// @arg sound (made on attack)
   
/// @arg hit_box sprite of hit box
/// @arg hit_effect sprite of hit effect
/// @arg push_efect {array} no push effect = noone
/// @arg attack_vfx* {bool} if the attack sprite is only vfx
/// @arg delay the number of frames attack shoud be delayed after worrying player
/// @arg on_hit function called when enemy is hit (e.g. EntityDamage) 

function AttackMelee(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,
_hit_box,_hit_effect,_push_effect,_attack_vfx,_delay,_on_hit = EntityDamage)
: Attack(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,ATTACK_TYPE.MELEE)
constructor{
	
	attack_hit_box = _hit_box;
	attack_hit_list = ds_list_create();
	attack_hit_effect = _hit_effect;
	
	//attack_targeted = false;
	
	attack_sprite_is_vfx = _attack_vfx;
	attack_vfx = noone;
	
	attack_on_hit = _on_hit;
	
	attack_target_inst = noone;
	
	attack_push_effect = _push_effect;
	
	range_function = function(){
		var in_range = noone;
		var _attacker = attack_owner;
		with(attack_target)
		{
			var _side = sign(x - other.attack_owner.x);
			switch(_side)
			{
				case 1: 
				if(bbox_left - _attacker.bbox_right < other.attack_x_range) in_range = self;
				break;
					
				case -1:
				if(_attacker.bbox_left - bbox_right < other.attack_x_range) in_range = self;
				break;
			}
		}
		attack_target_inst = in_range;
		return in_range;
	}
	
	if(_delay == noone)
	{
		attack_worry_delay_target = 0;	
	}
	else
	{
		attack_worry_delay_target = _delay;	
	}
	
	attack_delayed_player_worried = false;
	
	attack_function = function(){
		if(attack_automatic)
		{
			AttackExecuteMelee();
			return true;
		}
		else
		{
			if(++attack_worry_delay >= attack_worry_delay_target)
			{
				AttackExecuteMelee();
				return true;
			}
			else
			{
				if(!attack_delayed_player_worried)
				{
					AttackPlayerWorry();
 
					attack_delayed_player_worried = true;
				}
				return false;
			}
		}
	}
	
}

#endregion

#region//Melee Targeted Attack

/// @arg inst owner instance
/// @arg sprite attack image
/// @arg time* fixed attack time if necessary
/// @arg cooldown attack cooldown
/// @arg speed attack speed factor
/// @arg target target instances' parnet
/// @arg x_range range of the attack
/// @arg sound (made on attack)

/// @arg hit_box sprite of hit box
/// @arg hit_effect sprite of hit effect
/// @arg push_efect {array} no push effect = noone
/// @arg attack_vfx* {bool} if the attack sprite is only vfx
/// @arg [offset_circle] [x_offset,y_offset,R] for the vfx of the attack creation
/// @arg delay the number of frames attack shoud be delayed after worrying player
/// @arg on_hit function called when enemy is hit (e.g. EntityDamage) 


function AttackMeleeTargeted(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound, _hit_box,_hit_effect,_push_effect,_attack_vfx,_offset_circle,_delay,_on_hit = EntityDamage)
: AttackMelee(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,_hit_box,_hit_effect,_push_effect,_attack_vfx,_delay,_on_hit)
constructor{
	
	attack_type = ATTACK_TYPE.MELEE_TARGETED;
	
	attack_target_inst = noone;
	
	//attack_vfx_targeted = true;
	
	targeted_melee_offset_circle = _offset_circle;
	
	if(_delay == noone)
	{
		attack_worry_delay_target = 0;	
	}
	else
	{
		attack_worry_delay_target = _delay;	
	}
	
	attack_delayed_player_worried = false;
	
	range_function = function(){
		var in_range = noone;
		var _side = attack_owner.image_xscale;
		var _attacker = attack_owner;
		with(attack_target)
		{
			if(sign(x - _attacker.x) = _side)
			{
				switch(_side)
				{
					case 1: 
					if(bbox_left - _attacker.bbox_right < other.attack_x_range) in_range = self;
					break;
					
					case -1:
					if(_attacker.bbox_left - bbox_right < other.attack_x_range) in_range = self;
					break;
				}
			}
		}
		return in_range
	}
	
	attack_function = function(){
		if(++attack_worry_delay >= attack_worry_delay_target)
		{
			AttackExecuteMeleeTargeted();
			return true;
		}
		else
		{
			if(!attack_delayed_player_worried)
			{
				AttackPlayerWorry();
				attack_delayed_player_worried = true;
			}
			return false;
		}	
	}
}

#endregion

#region Dash To Melee

///@func AttackDashToMelee()
///@arg inst owner instance
///@arg sprite attack image
///@arg time* fixed attack time if necessary
///@arg cooldown attack cooldown
///@arg speed attack speed factor
///@arg target target instances' parnet
///@arg x_range range of the attack
///@arg sound (made on attack)

///@arg sprite image for dash charge
///@arg charge_time* total time of charge
///@arg loops number of charge animation loops
///@arg distance traveled distance of the dash
///@arg MeleeAttack Melee Attack Struct that would than be used
///@arg sn_charge

function AttackDashToMelee(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,
_charge_sprite,_charge_time,_charge_loops,_dash_distance,_melee_attack_struct,_sn_charge) 
: Attack(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,ATTACK_TYPE.DASH) constructor 
{
	
	#region//Set Charge Sprite
	dash_charging_sprite = _charge_sprite;
	if(_charge_time!=noone && _charge_time!=-1)
	{
		AnimationSetLength(_charge_sprite,_charge_time/_charge_loops);
	}
	#endregion
	
	attack_dash_speed = _dash_distance / AnimationGetFrameLength(_sprite);
	attack_charge_sound = _sn_charge;
	
	attack_charge_count = 0;
	attack_charge_target = _charge_loops;
	attack_target_inst = noone;
	
	attack_following_struct = _melee_attack_struct;

	range_function = function(){
		var _my_x = attack_owner.x;
		var in_range = noone;
		with(attack_target)
		{
			if(abs(_my_x - x)<=other.attack_x_range)
			{
				var in_range = self;
			}
		}
		return in_range;
	}
	
	attack_function = function(){
		attack_charge_count = 0;
		with(attack_owner)
		{
			attack_worry_delay = 0;
			state = MeleeAttackCharging;
			emitter_sound(attack_struct.attack_charge_sound,false);
			sprite_index = other.dash_charging_sprite;
			image_index = 0;
			Vx = 0;
			Vy = 0;	
		}
		return true;	
	}
		
	charge_function = function(){
		attack_cooldown = 0;
		with(attack_owner)
		{
			emitter_sound(attack_struct.attack_sound,false);
			state = EntityDashToMeleeAttack;
			sprite_index = other.attack_sprite;
			image_index = 0;
			Vx = other.attack_dash_speed * sign(other.attack_target_inst.x - x);
			InstanceRotateCentrally(sign(Vx));
			if(audio_is_playing(step_sound)) audio_pause_sound(step_sound);
			return true;
		}
	}
}

#endregion

#region Striking Attack

///@arg inst owner instance
///@arg sprite attack image
///@arg time* fixed attack time if necessary
///@arg cooldown attack cooldown
///@arg speed attack speed factor
///@arg target target instances' parnet
///@arg x_range range of the attack
///@arg sound (made on attack)

///@arg object
///@arg num
///@arg charge_target

function AttackStriking(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,
_striking_object, _objects_number,_charge_target) 
: Attack(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,ATTACK_TYPE.STRIKING)
constructor {
	
	attack_no_auto_worry = true;
	
	attack_striking_object = _striking_object;
	attack_strikes_num = _objects_number;
	attack_strike_x = noone;
	attack_charge_count = 0;
	attack_charge_target = _charge_target * AnimationGetFrameLength(attack_sprite);
	
	attack_worry_delay_target = floor(attack_charge_target - player_worry_buffer_time);
	
	attack_function = function(){
		AttackStrike();
		return true;
	}
}
#endregion

#region//Attack Voa

///@func AttackVoa()
///@arg inst
///@arg sprite
///@arg time*
///@arg cooldown
///@arg speed
///@arg target
///@arg x_range
///@arg sound

///@arg bullet {object} object_id of the bullet to make shot with
///@arg x_offset {real} offset between bullet creation and owner x coordinates
///@arg y_offset {real} offset between bullet creation and owner y coordinates

function AttackVoa(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,_bullet_obj,_x_offset,_y_offset)
: Attack(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,ATTACK_TYPE.VOA_LIKE)
constructor{
	
	attack_no_auto_worry = true;
	attack_automatic = true;
	
	bullet_object = _bullet_obj;
	attack_x_offset = _x_offset;
	attack_y_offset = _y_offset;
	attack_charge_effect_inst = noone;
	
	attack_function = function(){
		with(attack_owner)
		{
			state = VoaAttackWindUp;
		}
		attack_charge_effect_inst = EffectCreate(
			attack_owner.x+attack_x_offset,
			attack_owner.y+attack_y_offset,
			attack_sprite,
			attack_owner.image_xscale,
			false
		);
		return true;
	}
	
}

#endregion

#region//Attack Jumping

///@func AttackJumping(Attack,sprite,time,loops,distance)
///@arg inst owner instance
///@arg sprite attack image
///@arg time* fixed attack time if necessary
///@arg cooldown attack cooldown
///@arg speed attack speed factor
///@arg target target instances' parnet
///@arg x_range range of the attack
///@arg sound (made on attack)

///@arg sprite image for jump charge
///@arg charge_time* total time of charge
///@arg charge_num number of charge animation loops
///@arg distance of the jump
///@arg jump_time seconds spent in air during jump
///@arg hit_effect
///@arg sn_charge

function AttackJumping(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,
_charge_sprite,_charge_time,_charge_num_target,_jump_distance,_jump_time,_hit_effect,_sn_charge) 
: Attack(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,ATTACK_TYPE.JUMPING)
constructor {
	
	#region//Set Charge Sprite
	attack_charging_sprite = _charge_sprite;
	if(_charge_time!=noone && _charge_time!=-1)
	{
		AnimationSetLength(_charge_sprite,_charge_time/_charge_num_target);
	}
	#endregion
	
	attack_charge_sound = _sn_charge;
	
	attack_charge_count = 0;
	attack_charge_target = _charge_num_target;
	
	hit_by_attack = ds_list_create();
	
	attack_jump_Vx = _jump_distance / (_jump_time*FRAME_RATE);
	attack_jump_Vy = _inst._gravity * (_jump_time*FRAME_RATE) / 2;
	
	attack_target_inst = noone;
	
	attack_hit_effect = _hit_effect;
	
	attack_worry_delay = attack_charge_target * AnimationGetFrameLength(attack_charging_sprite) - player_worry_buffer_time;

	range_function = function(){
		var _my_x = attack_owner.x;
		var in_range = noone;
		with(attack_target)
		{
			if(abs(_my_x - x)<=other.attack_x_range)
			{
				var in_range = self;
			}
		}
		return in_range;
	}
	
	attack_function = function(){
		attack_worry_delay = 0;
		attack_charge_count = 0;
		with(attack_owner)
		{
			state = MeleeAttackCharging;
			emitter_sound(attack_struct.attack_charge_sound,false);
			sprite_index = other.attack_charging_sprite;
			image_index = 0;
			Vx = 0;
			Vy = 0;	
		}
		return true;
	}
		
	charge_function = function(){
		attack_cooldown = 0;
		ds_list_clear(hit_by_attack);
		with(attack_owner)
		{
			state = EntityStateJumpAttack;
			
			sprite_index = other.attack_sprite;
			image_index = 0;
			Vx = other.attack_jump_Vx * image_xscale;
			Vy = -other.attack_jump_Vy;
			
			if(audio_is_playing(step_sound)) audio_pause_sound(step_sound);
			emitter_sound(attack_struct.attack_sound,false);
		}
		return true;
	}	
}

#endregion

#region Invoking

///@func AttackInvoke(Attack,sprite,time,loops,distance)
///@arg inst owner instance
///@arg sprite attack image
///@arg time* fixed attack time if necessary
///@arg cooldown attack cooldown
///@arg speed attack speed factor
///@arg target target instances' parnet
///@arg x_range range of the attack
///@arg sound (made on attack)

///@arg object
///@arg xoffset
///@arg yoffset
///@arg [push_effect]
///@arg sprite_is_vfx
///@arg invk_frame the frame you invoke the instance at

function AttackInvoke(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,
_object,_xoffset,_yoffset,_push_effect,_sprite_is_vfx,_frame) 
: Attack(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,ATTACK_TYPE.INVOKING)
constructor {
	
	attack_no_auto_worry = true; 
	
	attack_invoke_object = _object;
	
	attack_sprite_is_vfx = _sprite_is_vfx;
	attack_vfx = noone;
	
	attack_x_offset = _xoffset;
	attack_y_offset = _yoffset;
	
	invoke_push_effect = _push_effect;
	
	attack_invoke_frame = _frame;

	attack_function = function(){
		AttackInvokeExecute();
		return true;
	}
}

#endregion

#region Shielding

///@func EntityAttackShielding()
///@arg inst owner instance
///@arg sprite attack image
///@arg time* fixed attack time if necessary
///@arg cooldown attack cooldown
///@arg speed attack speed factor
///@arg target target instances' parnet
///@arg x_range range of the attack
///@arg sound (made on attack)

///@arg [shield,invk,flash]
///@arg xoffset
///@arg yoffset
///@arg shield_frame the frame you create the shield at
///@arg duration

enum SHIELD_SPRITES{
	SHIELD,
	INVOKE_ANIMATION,
	FLASH
}

function EntityAttackShielding(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,
_shield_sprites,_xoffset = noone,_yoffset = noone,_frame,_duration = 3) 
: Attack(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,ATTACK_TYPE.SHIELDING)
constructor {
	
	attack_no_auto_worry = true; 
	
	#region Attack Offsets
	if(_xoffset == noone)
	{
		attack_x_offset = SpriteBBoxOffset(attack_sprite,0);//Debug
	}
	else
	{
		attack_x_offset = _xoffset;
	}
	
	if(_yoffset == noone)
	{
		attack_y_offset = SpriteBBoxYOffsetCenter(attack_sprite,true);
	}
	else
	{
		attack_y_offset = _yoffset;
	}
	#endregion
	
	attack_shield_sprite = _shield_sprites[SHIELD_SPRITES.SHIELD];
	attack_shield_invk_sprite = _shield_sprites[SHIELD_SPRITES.INVOKE_ANIMATION];
	attack_shield_flash_sprite = _shield_sprites[SHIELD_SPRITES.FLASH];
	attack_shielding_frame = _frame;
	
	//attack_shield_object = noone;
	attack_shield_duration = FRAME_RATE * _duration;

	attack_function = function(){
		with(attack_owner)
		{
			movement_direction = 0;
			sprite_index = other.attack_sprite;
			image_index = 0;
			state = EntityStateShieldForming;
		}
		
		//attack_shield_object = noone;
		
		return true;
	}
}

#endregion


























