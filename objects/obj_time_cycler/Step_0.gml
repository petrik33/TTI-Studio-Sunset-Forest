if(!day_night_paused_mode)
{
	script_execute(time_state);
	
	key_previous = min(floor(global.time * number_of_key_times),number_of_key_times - 1);
	key_next = (key_previous + 1) mod number_of_key_times;

	var lerp_amount = (global.time - key_previous/number_of_key_times) * number_of_key_times;
	
	color_mix = mix_key_colors(key_previous,key_next,lerp_amount,colors);
	con_sat_brt_mix = mix_key_con_sat_brt(key_previous,key_next,lerp_amount,con_sat_brt);
}
else
{
	DayNightPauseValuesMix();
}
			 

script_execute(clock_state);

if(clock_enabled)
{
	clock_time = global.time + time_offset;

	clock_sun_x = ceil(cos(clock_time*2*pi) * clock_x_radius);
	clock_sun_y = ceil(sin(clock_time*2*pi) * clock_y_radius);
}

#region//Spawning Fireflies
if(fireflies_on)
{
	//var _current_chance = (animcurve_channel_evaluate(fireflies_appear_chance_curve,global.time));
	////var _odd_chance = -100 / _current_chance;
	////part_emitter_stream(global.particle_system,fireflies_emitter,part_firefly,_odd_chance);
	
	//if(random(100) < _current_chance)
	//{
	//	do
	//	{
	//		var _x = random_range(spawn_point_left_x,spawn_point_right_x);
	//		var _y = random_range(fireflies_min_y,fireflies_max_y);
	//		var _nearest_inst = instance_nearest(_x,_y,obj_firefly);
	//	}
	//	until (_nearest_inst = noone || point_distance(_x,_y,_nearest_inst.x,_nearest_inst.y) >= fireflies_min_distance)
	//	part_particles_create(global.lights_part_system,_x,_y,part_firefly,1);
	//}
	var _current_chance = (animcurve_channel_evaluate(fireflies_appear_chance_curve,global.time));
	if(random(100) < _current_chance)
	{
		part_emitter_burst(global.lights_part_system,fireflies_emitter,part_firefly,1);
	}
	
}
#endregion


