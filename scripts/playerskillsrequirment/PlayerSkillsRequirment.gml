///@arg Skill
function PlayerSkillsRequirment(argument0) {
	switch (argument0)
	{
		case SKILLS.ICE_TRAP:
			return (FLOOR_Y - y) <= from_floor_to_jump
		break;
	
		case SKILLS.FIRE_BALL:
			return true;
		break;
	
		case SKILLS.WIND: 
			return true
		break;
	
		case SKILLS.THUNDER:
			return true
		break;
	}


}
