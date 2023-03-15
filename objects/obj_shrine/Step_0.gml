event_inherited();
if(crystal_on_shrine)
{
	//Crystal Waving
	animation_progress+=animation_speed;
	crystal_y = crystal_y_start - animcurve_channel_evaluate(waving_channel,animation_progress mod 1);

	//Crystal Light

	with(crystal_light) y = other.crystal_y;

	//Crystal Animation
	if(damage_recieved)
	{
		damaged_animation_progress+=damaged_animation_speed;
		crystal_x = x + animcurve_channel_evaluate(damaged_channel,damaged_animation_progress);
		crystal_image_index+=crystal_damaged_image_speed;
		if(damaged_animation_progress >= 1)
		{
			crystal_sprite = crystal_sprite_idle;
			crystal_x = x;
			damage_recieved = false;
			damaged_animation_progress = 0;
			sprite_index = sprite_idle;
			image_index = 0;
		} 
	}
}

if(collapsing)
{
	y += collapse_spd;
	if(bbox_top >= FLOOR_Y)
	{
		instance_destroy(light_instance);
		instance_destroy();	
	}
}	