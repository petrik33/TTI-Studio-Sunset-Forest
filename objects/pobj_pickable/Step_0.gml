if(!global.game_is_paused)
{
	if(fallen)
	{
		animation_progress+=animation_speed;
		y = FLOOR_Y + 1 + animcurve_channel_evaluate(anim_channel,animation_progress mod 1);
	}
	else
	{
		Vy += _gravity;
		if(FLOOR_Y - bbox_bottom > Vy)
		{
			y += Vy;
		}
		else
		{
			y = (y - bbox_bottom) + FLOOR_Y;
			Vy = 0;
			fallen = true;
		}
	}
	
	#region//Light Control
	light_instance.y = (bbox_bottom + bbox_top)/2
	#endregion
	
	var picking = instance_place(x,y,pickup_parent);
	if(picking!=noone)
	{
		if(pickup_script(picking))
		{
			instance_destroy();
			exit;
		}
	}
	
	if(++time_passed>=life_time)
	{
		image_alpha-=1/fade_out_time;
		if(image_alpha<=0)
		{
			instance_destroy();
		}
	}
}
