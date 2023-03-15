if(!global.game_is_paused)
{
	
	if(instance_exists(target))
	{
		if(surging)
		{
			if(AnimationEnd())
			{
				surging = false;
				sprite_index = sprite_idle;
			}
		}
		else
		{
			if(--duration <= 0)
			{
				instance_destroy();
				exit;
			}	
		}
		
		x = target.x + x_offset * target.image_xscale;
		y = target.y + y_offset;
	}
	else
	{
		instance_destroy();
		exit;
	}

	//image_alpha = sinanimation_progress;
	//if (animation_progress > 1)
	//{
	//	animation_progress = 1;
	//}
	//else
	//{
	//	animation_progress+=animation_speed;	
	//}
}