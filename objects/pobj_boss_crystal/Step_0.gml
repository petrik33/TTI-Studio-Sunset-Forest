event_inherited();
if(!global.game_is_paused)
{
	if(!crystal_waving)
	{
		image_angle += rotation_spd;
		if(flying_y - y > Vy)
		{
			Vy += _gravity;
			x += Vx;
			y += Vy;
		}
		else
		{
			y = flying_y;
			crystal_waving = true;
			//damage_vulnerable = true;
			rotation_spd /= 4;
			Vy = 0;
			Vx = 0;
		}
	}
	else
	{
		waving_animation_progress += waving_animation_spd;
		if(waving_animation_progress >= pi)
		{
			waving_animation_progress -= pi;	
		}
		var _sub_y = -abs(sin(waving_animation_progress)) * waving_amplitude;
		y = flying_y + _sub_y;
		
		#region Rotation
		
		var _rotate_left = angle_difference(image_angle,0);
		if(_rotate_left > rotation_spd)
		{
			image_angle += rotation_spd;	
		}
		else
		{
			image_angle = 0;	
		}
		
		
		#endregion
	}
	
}