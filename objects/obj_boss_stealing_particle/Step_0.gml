if(!particle_caught)
{
	#region//Motion
	waving_animation_progress += waving_animation_spd;
	if(waving_animation_progress > (double_pi) ) waving_animation_progress = waving_animation_progress mod (double_pi);

	direction = point_direction(x,y,attack_target_instance.x + target_offset_x ,attack_target_instance.y + target_offset_y);
	image_angle+=angle_rotating_speed;

	var waving_V = sin(waving_animation_progress) * waving_spd;

	if(point_distance(x,y,attack_target_instance.x + target_offset_x ,attack_target_instance.y + target_offset_y) <= directional_spd + abs(waving_V))
	{
		x = attack_target_instance.x + target_offset_x;
		y = attack_target_instance.y + target_offset_y;
		particle_caught = true;
		exit;
	}
	else
	{
		//Move
		var _Vx = lengthdir_x(directional_spd,direction) + lengthdir_x(waving_V,direction + 90);
		var _Vy = lengthdir_y(directional_spd,direction) + lengthdir_y(waving_V,direction + 90);

		x+=_Vx;
		y+=_Vy;
	}
	

	#endregion

	#region//Particles

	part_particles_create(global.particle_system,x-_Vx,y-_Vy,spark_particle,2);

	#endregion
	
}





