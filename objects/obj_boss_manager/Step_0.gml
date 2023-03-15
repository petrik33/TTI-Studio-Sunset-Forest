if(!global.game_is_paused)
{
	if(boss_teleporting)
	{
		if(--boss_teleport_time == 0)
		{
			BossManagerTeleportation();
		}
		if(--boss_teleport_worry_time == 0)
		{
			BossManagerWorry();	
		}
	}
	//?
	//if(boss_current_enum != boss_idle_form_enum)
	//{
			
	//}
	if(boss_shield_active)
	{
		if(boss_shield_invoking)
		{
			boss_shield_invoke_timer++;
			if(boss_shield_invoke_timer >= boss_shield_invoke_time)
			{
				boss_shield_invoking = false;
				boss_shield_invoke_timer = 0;
			}
			
		}
		else
		{
			if(!boss_teleporting)
			{
				boss_shield_duration_left--;
				if(boss_shield_duration_left <= 0)
				{
					boss_shield_active = false;
					boss_shield_duration_left = 0;
				}	
			}
		}
	}
}