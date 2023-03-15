if(!instance_exists(global.oPlayer))
{
	instance_destroy();
}
else
{
	if(global.oPlayer.state == PlayerStateCastSkill)
	{
		alarm[0] = 3;
	}
	else
	{
		instance_destroy();	
	}
}