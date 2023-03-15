
#region//Motion

if(--time_before_return > 0)
{

	#region Static Waving

	waving_animation_progress += waving_animation_spd;
	if(waving_animation_progress > 1 ) waving_animation_progress = waving_animation_progress mod 1;

	var waving_y = animcurve_channel_evaluate(waving_animation_curve,waving_animation_progress) * waving_amplitude;
	
	y = ystart + waving_y;

	#endregion
}
else
{
	if(instance_exists(attack_target_instance))
	{
		image_angle += angle_rotating_speed * image_xscale;
		var x_target = attack_target_instance.x + target_xoffset * attack_target_instance.image_xscale;
		var y_target = attack_target_instance.y + target_yoffset;
		
		if(point_distance(x,y,x_target,y_target) <= directional_spd)
		{
			x = x_target;
			y = y_target;
			with(attack_target_instance)
			{
				PlayerReactivateSkill(other.skill_stolen);
				PlayerHeal(1,noone);
				PlayerAccumulateSpecial(other.skill_stolen);
			}
			instance_destroy();
		}
		else
		{
		
			var _direction = point_direction(x,y,x_target,y_target);
		
			var _Vx = lengthdir_x(directional_spd,_direction);
			var _Vy = lengthdir_y(directional_spd,_direction);
			
			x += _Vx;
			y += _Vy;
			
		}
	}
	else
	{
		instance_destroy();
	}
}
	

#endregion





