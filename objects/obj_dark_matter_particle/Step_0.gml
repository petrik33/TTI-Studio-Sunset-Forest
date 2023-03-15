if(instance_exists(target))
{
	var _direction = point_direction(x,y,target.x,target.y + target_y_offset);
	image_angle = _direction;

	var _Vx = lengthdir_x(spd,_direction);
	var _Vy = lengthdir_y(spd,_direction);

	x+=_Vx;
	y+=_Vy;

	if(place_meeting(x,y,target))
	{
		with(target)
		{
			if(object_is_ancestor(object_index,pobj_hero))
			{
				PlayerReceiveDarkMatter();
			}
			else
			{
				CandleReceiveDarkMatter();	
			}
		}
		instance_destroy();	
	}
}
else
{
	instance_destroy();	
}