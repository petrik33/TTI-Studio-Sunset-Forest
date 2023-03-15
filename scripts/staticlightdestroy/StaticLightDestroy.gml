///@arg time
function StaticLightDestroy(_time = noone){
	if(instance_exists(light_instance))
	{
		with(light_instance)
		{
			if(_time != noone)
			{
				dying_alpha_spd = 1 / _time;
			}
			alarm[0] = 1;
			if(object_index == pobj_blinking_light)
			{
				dying = true;	
			}
		}
	}
}

///@arg time
function StaticLightUp(_time = noone){
	if(instance_exists(light_instance))
	{
		with(light_instance)
		{
			if(_time != noone)
			{
				light_up_alpha_spd = 1 / _time;
			}
			alarm[1] = 1;
			if(object_index == pobj_blinking_light)
			{
				dying = true;	
			}
		}
	}
}
