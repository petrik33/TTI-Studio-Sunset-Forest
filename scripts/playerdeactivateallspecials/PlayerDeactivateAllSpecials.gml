function PlayerDeactivateAllSpecials(){
	with(global.oPlayer)
	{
		for(var i = 0; i < SKILLS.NUMBER; i++)
		{
			skills[i][SKILL.SPECIAL_PROGRESS] = 0;
		}
	}
	with(pobj_player_special_stack)
	{
		instance_destroy();	
	}
}