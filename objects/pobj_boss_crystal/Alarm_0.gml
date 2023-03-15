if(instance_exists(global.oPlayer))
{
	var _dist = abs(global.oPlayer.x - x);
	if(_dist <= player_ultimate_activation_range)
	{
		if(global.oPlayer.ultimate_skill_id == noone)
		{
			with(global.oPlayer)
			{
				PlayerActivateUltimate(other.element);
			}
		}
	}
	else
	{
		with(global.oPlayer)
		{
			PlayerDeactivateUltimate();	
		}
	}
}

alarm[0] = player_ultimate_activation_check_frequency;