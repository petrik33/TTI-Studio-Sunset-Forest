///@arg enum
function PlayerSpecialAttack(_skill_id){
	hero_special_attack_scripts[_skill_id]();
	skills_cooldowns[_skill_id] = skills[_skill_id][SKILL.COOLDOWN];

	hero_bwn_attack_timer = 0;
	hero_attack_counter = 0;
}