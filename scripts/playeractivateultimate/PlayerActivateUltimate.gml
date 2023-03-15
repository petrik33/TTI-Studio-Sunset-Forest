///@arg enum
function PlayerActivateUltimate(_enum){
	skills[_enum][SKILL.AVAILABLE] = true;
	skills_cooldowns[_enum] = 0;
	ultimate_skill_id = _enum;
	ultimate_skill_icon_sprite = ultimate_skills[_enum][ULT_SKILL.ICON];
	ultimate_skill_img_index = 0;
	ultimate_skill_img_number = sprite_get_number(ultimate_skill_icon_sprite) - 1;
	ultimate_skill_img_spd = sprite_get_speed(ultimate_skill_icon_sprite) / FRAME_RATE;
	ultimate_skill_icon_wave_progress = 0;
}

function PlayerDeactivateUltimate(){
	if(ultimate_skill_id != noone)
	{
		skills_cooldowns[ultimate_skill_id] = skills[ultimate_skill_id][SKILL.COOLDOWN];
		skills[ultimate_skill_id][SKILL.AVAILABLE] = false;
		ultimate_skill_id = noone;
	}
}