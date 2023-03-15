function PlayerAccumulateAllSpecials(){
	with(pobj_player_special_stack)
	{
		instance_destroy();	
	}
	for(var i = 0; i < SKILLS.NUMBER; i++)
	{
		PlayerAccumulateSpecial(i);
	}
}


function PlayerAccumulateSpecial(_enum){
	with(global.oPlayer)
	{
		skills[_enum][SKILL.SPECIAL_PROGRESS] = spec_stacks_needed - 1;
		skills_cooldowns[_enum] = 0;
		PlayerSpecialAddProgress(_enum);
	}
}

function PlayerResetAllSpecials(){
	with(pobj_player_special_stack)
	{
		instance_destroy();	
	}
	with(global.oPlayer)
	{
		for(var i = 0; i < SKILLS.NUMBER; i++)
		{
			skills[i][SKILL.SPECIAL_PROGRESS] = 0;
		}
	}
}