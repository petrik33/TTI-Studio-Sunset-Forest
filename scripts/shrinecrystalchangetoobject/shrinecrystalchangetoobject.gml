function ShrineCrystalDetach(){
	if(instance_exists(obj_shrine))
	{
		with(obj_shrine)
		{
			crystal_on_shrine = false;
			instance_destroy(light_instance);
			global.crystal = instance_create_layer(crystal_x,crystal_y,"Effects",obj_crystal);
			with(global.crystal)
			{
				light_instance = other.crystal_light;
			}
			//crystal_light = noone;
		}
	}
}

function CrystalReturnToShrine(){
	with(obj_shrine)
	{
		crystal_on_shrine = true;
		crystal_light = global.crystal.light_instance;
	}	
	instance_destroy(global.crystal);
}

function CrystalDropPortalsLifestream(){
	with(global.crystal)
	{
		var _y0 = y - crystal_h/2;
		var _H = FLOOR_Y - _y0;
		var _g = crystal_lifestream_gravity;
		
		var _time = CountObjectFallTime(_H,_g);
		
		var _dist = crystal_lifestreams_fall_range;
		var _stream_spd = _dist / _time;
		
		var _left_stream = instance_create_layer(x,_y0,"Effects",obj_crystal_lifestream);
		with(_left_stream)
		{
			Vx	= -_stream_spd;
			side = -1;
			image_angle = 180;
		}
		var _right_stream = instance_create_layer(x,_y0,"Effects",obj_crystal_lifestream);
		with(_right_stream)
		{
			Vx	= _stream_spd;
			side = 1;
		}
		
		CameraChangeTarget(_left_stream);
	}
}