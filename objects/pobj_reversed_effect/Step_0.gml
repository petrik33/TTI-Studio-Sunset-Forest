if(instance_exists(attack_target_instance))
{
	if(with_offset)
	{
		x = attack_target_instance.x + x_offset * attack_target_instance.image_xscale;
		y = attack_target_instance.y + y_offset;
	}
	else
	{
		x = attack_target_instance.x;
		y = (attack_target_instance.bbox_bottom + attack_target_instance.bbox_top)/2;
	}
}

if(fading_out)
{
	image_alpha-=0.02;
	if(image_alpha<=0) instance_destroy();
}
else
{
	if(AnimationEndReverse())
	{
		if(!fade_out) instance_destroy();
		else
		{
			image_speed = 0;
			fading_out = true;
		}
	}
}

