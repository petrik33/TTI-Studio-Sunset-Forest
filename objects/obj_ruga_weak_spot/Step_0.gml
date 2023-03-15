event_inherited();
if(!global.game_is_paused)
{
	if(--living_timer>0)
	{
		if(fly_up_timer < fly_up_time)
		{
			fly_up_timer++;
			y = lerp(ystart, y_target,fly_up_timer / fly_up_time);
		}
		if(instance_exists(owner))
		{
			if(owner.state != RugaStateWeakTransition)
			{
				x = owner.x + x_offset * owner.image_xscale;
			}
			else
			{
				x = owner.x;
			}	
		}
		else
		{
			DyingScript();	
		}
	}
	else
	{
		expired = true;
		DyingScript();
	}
}
