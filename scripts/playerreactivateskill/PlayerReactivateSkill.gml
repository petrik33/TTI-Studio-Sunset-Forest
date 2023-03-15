///@arg enum
function PlayerReactivateSkill(_enum){
	skills[_enum][SKILL.AVAILABLE] = true;
	skills_cooldowns[_enum] = 0;
}