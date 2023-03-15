///@arg skill_id
///@arg range_ui
function PlayerCastSkill(_skill_id,_range_ui = true){
	if(_skill_id != ultimate_skill_id)
	{
		if(skills[_skill_id][SKILL.SPECIAL_PROGRESS] < spec_stacks_needed)
		{
			current_skill = skills[_skill_id];
		}
		else
		{
			current_skill = special_skills[_skill_id];
			with(pobj_player_special_stack)
			{
				if(skill_id == _skill_id)
				{
					instance_destroy();
				}
			}
		}
	
		#region Create Indicator of Range
		
		if(_range_ui)
		{
			var _cast_time = AnimationGetFrameLength(sprite_index,current_skill[SKILL.FULL_CAST]);
			SkillRangeIndicatorsCreate(_cast_time);
		}
	
		#endregion
	}
	else
	{
	
		var _ultimate_skill = ultimate_skills[ultimate_skill_id];
		
		current_skill = ultimate_skill_general_struct;
		current_skill[SKILL.SPRITE] = _ultimate_skill[ULT_SKILL.SPRITE];
		current_skill[SKILL.ID] = _skill_id;
		current_skill[SKILL.FULL_CAST] = _ultimate_skill[ULT_SKILL.FULL_CAST];
		current_skill[SKILL.SOUNDS] = _ultimate_skill[ULT_SKILL.SOUNDS];
		current_skill[SKILL.COOLDOWN] = 0;
		
	}
	
	previous_state = state;
	hero_bwn_attack_timer = 0;
	movement_direction = 0;
	
	sprite_index = current_skill[SKILL.SPRITE];
	image_index = 0;
	
	cast_count = 0;
	skill_casted = false;
	full_cast = false;
	state = PlayerStateCastSkill;
	
	var skill_sounds = current_skill[SKILL.SOUNDS];
	var _skill_sound = skill_sounds[SP_SOUNDS.WIND_UP];
	current_skill_sound = PlayerSoundMake(_skill_sound);
	
}