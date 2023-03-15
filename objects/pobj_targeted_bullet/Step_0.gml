if(!global.game_is_paused)
{
	if(instance_exists(target))
	{
		var _target_direction = point_direction(x,y,target.x,target.bbox_top+target_y_offset);
		var _angle_dif = angle_difference(direction,_target_direction);
		direction -= _angle_dif * targeting_rate;
		acceleration_progress = min(acceleration_progress + acceleration_speed,1);

		Vx = lengthdir_x(spd*acceleration_progress,direction);
		Vy = lengthdir_y(spd*acceleration_progress,direction);
			
	}
	else
	{
		Vy += _gravity;
		direction = point_direction(0,0,Vx,Vy);
	}
	image_angle = direction;
	
	event_inherited();
}

