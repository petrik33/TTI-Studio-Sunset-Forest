function PlayerStateCastSkill()
{
	if(current_skill[SKILL.WALK])
	{
		var grounded = (FLOOR_Y - y <= from_floor_to_jump);
	
		var key_right = ( keyboard_check(vk_right) || keyboard_check(ord("D")) ); 
		var key_left = ( keyboard_check(vk_left) || keyboard_check(ord("A")) );
	
		var key_backwards = keyboard_check(global.backwards_control);
	
		movement_direction = key_right - key_left;
	
		if(current_skill[SKILL.JUMP])
		{
			var key_jump = keyboard_check_pressed(vk_space);
	
			if(key_jump && !jumped_twice)
			{
				PlayerJump();
				grounded = false;
			}
	
			if(grounded && jumped)
			{
				PlayerFallDownAfterJump();	
			}
		}
	
		spd *= hero_skill_spd_rate;
		EntityMovement();
		spd /= hero_skill_spd_rate;
		
		#region//Changing Side
		if(Vx!=0)
		{
			if(!key_backwards)
			{
				InstanceRotateCentrally(sign(Vx),);
			}
		}
		#endregion
	}
	else
	{
		EntityMovement();	
	}
	
	//Skill Cast
	if(!skill_casted && AnimationEnd(current_skill[SKILL.FULL_CAST]))
	{
		//Stop & Play Sounds
		audio_stop_sound(current_skill_sound);
		var skill_sounds = current_skill[SKILL.SOUNDS];
		PlayerSoundMake(skill_sounds[SP_SOUNDS.RELEASE]);
		
		//Cast Skill
		script_execute(current_skill[SKILL.SCRIPT]);
		
		//Refresh Cooldown
		var skill_id = current_skill[SKILL.ID];
		skills_cooldowns[@ skill_id ] = current_skill[SKILL.COOLDOWN];
		
		//If Special
		if(skills[skill_id][SKILL.SPECIAL_PROGRESS] >= spec_stacks_needed)
		{
			skills[@ skill_id][@ SKILL.SPECIAL_PROGRESS] = 0;	
		}
		
		//Update Variables
		skill_casted = true;
		full_cast = true;
		cast_sign = 0;
		
	}

	//Cancel Cast
	if(keyboard_check_released(current_skill[SKILL.HOTKEY]) && !full_cast)
	{
		audio_stop_sound(current_skill_sound);
		image_speed = -1;
		//cast_sign = -1;
		skill_casted = true;
		SkillRangeIndicatorsDestroy();
	}

	//Leave The Cast State
	if(AnimationEnd() || (skill_casted && AnimationEndReverse() ))
	{
		cast_count = 0;
		
		EntityEndState();
		skill_casted = false;
		current_skill = -1;
		current_skill_sound = -1;
		full_cast = false;
		cast_sign = 1;
		SkillRangeIndicatorsDestroy();
	}
	
}

function SkillRangeIndicatorsDestroy(){
	with(obj_skill_range_indicator)
	{
		instance_destroy();	
	}
}
