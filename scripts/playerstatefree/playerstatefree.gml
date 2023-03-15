function PlayerStateFree(){
	
var grounded = (FLOOR_Y - y <= from_floor_to_jump);
	
#region//Controls

#region//Buffered Inputs
if(input_buffered!=noone)
{
	switch(input_buffered)
	{
		case input_buffer_type.attack:
		#region
		
		PlayerAttack();
		
		break;
		#endregion
		
		//case input_buffer_type.dash:
		//#region
		
		//PlayerDash();
		
		//break;
		//#endregion
		
		case input_buffer_type.dodge:
		#region
		
		PlayerDodge();
		
		break;
		#endregion
		
		case input_buffer_type.push:
		#region
		
		PlayerPush();
		
		break;
		#endregion
	}
	input_buffered = noone;
	exit;
}
#endregion

#region//Movement Controls
var key_right = ( keyboard_check(vk_right) || keyboard_check(ord("D")) ); 
var key_left = ( keyboard_check(vk_left) || keyboard_check(ord("A")) );
//var key_dodge = ( keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) );
var key_jump = keyboard_check_pressed(vk_space);
var key_backwards = keyboard_check(global.backwards_control);
#endregion

#region//Skills Control
for(var i=0;i<SKILLS.NUMBER;i++)
{
	var skill = skills[i];
	if(keyboard_check(skill[SKILL.HOTKEY]) && PlayerSkillsRequirment(i))
	{
		var _able_to_cast = (skills_cooldowns[i]<=0) || (skill[SKILL.SPECIAL_PROGRESS] == spec_stacks_needed);
		if(_able_to_cast)
		{
			PlayerCastSkill(i);
			exit;
		}
	}
}
#endregion

#region//Attacks and Push Control

#region//Get Control Input
var _attack = mouse_check_button(mb_left) || (global.alternative_controls_on && keyboard_check(alternative_controls[alternative_key.attack]));
var _push = mouse_check_button(mb_right) || (global.alternative_controls_on && keyboard_check(alternative_controls[alternative_key.push]));
#endregion

if(++hero_bwn_attack_timer>=hero_attack_reset_time)
{
	hero_attack_counter = 0;
}	

#region//Attack Event
if(_attack)
{
	if(grounded || (FLOOR_Y - y)<jump_attack_min_height)
	{
		PlayerAttack();
	}
	else
	{
		PlayerAttackInAir();
	}
	exit;
}
#endregion

#region//Push Event
if(_push)
{
	PlayerPush();
	exit;
}
#endregion

#endregion

#endregion

#region//Movement

#region//Jump Event
if(key_jump && !jumped_twice)
{
	PlayerJump();
	grounded = false;
}
#endregion

#region Grounded Actions
if(grounded)
{
	
	#region//Opening Seeds
	seed_to_open = noone;
	with(pobj_companion_seed)
	{
		if(abs(x - other.x) < global.seed_opening_radius && state = state_free)
		{
			other.seed_to_open = self;
		}
	}
	if(seed_to_open!=noone)
	{
		if(keyboard_check(alternative_controls[alternative_key.interaction]))
		{
			state = PlayerStateOpeningSeed;
			movement_direction = 0;
			if(seed_to_open.companion_spawned = obj_companion_bird)
			{
				sprite_index = seed_opening_sprites[0];
			}
			else sprite_index = seed_opening_sprites[1];
			with(seed_to_open)
			{
				state = seed_state_being_opened;
				with(current_indicator)
				{
					instance_destroy();
					EffectCreateReversed(x,y,sprite_surging,image_xscale);
				}
			}
			image_index = 0;
			exit;
		}
	}
	#endregion
	
	#region//Dashing

	if(keyboard_check(vk_shift))
	{
		PlayerDash();
		exit;
	}

	#endregion
	
	//#region Dodging
	
	//if(key_dodge && player_dodge_CD <= 0)
	//{
	//	PlayerDodge();
	//	exit;
	//}
	
	//#endregion
	
	#region//Jump Fall Event
	if(jumped)
	{
		PlayerFallDownAfterJump();
	}
	#endregion
	
}
#endregion

#region Running / Walking

movement_direction = key_right - key_left;
if(key_backwards)
{
	spd *= hero_backwards_spd_rate;
	EntityMovement();
	spd /= hero_backwards_spd_rate;
}
else
{
	EntityMovement();
}

#endregion

#endregion

#region//Animations and Sound
if(movement_direction!=0)
{
	if(!key_backwards)
	{
		if(Vx != 0)
		{
			InstanceRotateCentrally(sign(Vx));	
		}
	}
	#region//Sound
	if(grounded)
	{
		sprite_index = sprite_run;
		if(AnimationEnd(2))
		{
			if(!audio_exists(step_sound))
			{
				step_sound = PlayerSoundMake(footstep_sounds,,[0.2,0.4]);  //AudioPlaySoundRandom(footstep_sounds,MIN_PITCH_DEFT,MAX_PITCH_DEFT,0.2,0.4,false);
			}
		}
	}
	#endregion
}
else
{
	sprite_index = sprite_idle;
}
#endregion

}

///@arg sounds*
///@arg [pitch]
///@arg [gain]
///@arg [loops]
///@arg [fade_time]
function PlayerSoundMake(_sound_source,_pitch_arr = [MIN_PITCH_DEFT,MAX_PITCH_DEFT],_gain_arr = [MIN_GAIN_DEFT,MAX_GAIN_DEFT], _loops = false,_fade_time = 0){
	if(is_array(_sound_source))
	{
		var _sound_resource = _sound_source[irandom(array_length(_sound_source)-1)];
	}
	else
	{
		var _sound_resource = _sound_source;	
	}
	
	var _pitch = 1;
	if(is_array(_pitch_arr)) _pitch = random_range(_pitch_arr[0],_pitch_arr[1]);
	
	var _gain = 1;
	if(is_array(_gain_arr)) _gain = random_range(_gain_arr[0],_gain_arr[1]);
	
	var _sound = audio_play_sound(_sound_resource,0,_loops);
	audio_sound_pitch(_sound,_pitch);
	if(_fade_time != 0)
	{
		audio_sound_gain(_sound,0,0);
	}
	audio_sound_gain(_sound,_gain * global.sounds_group_gain * sounds_hidden_gain,_fade_time);
	return _sound;
}


