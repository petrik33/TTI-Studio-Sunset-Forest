function PlayerResetCooldowns(){
	with(global.oPlayer)
	{
		for(var i=0;i<SKILLS.NUMBER;i++)
		{
			skills_cooldowns[@ i] = 0;
		}
	}
}