image_angle += rotation_spd;
if(image_angle >= 360)
{
	image_angle -= 360;
	rotations_num--;
	if(rotations_num == 0)
	{
		image_angle = 0;
		rotation_spd = 0;
		ease_out = true;
	}
}

if(ease_in)
{
	image_alpha = animcurve_channel_evaluate(anim_channel_in,anim_progress);
	anim_progress += anim_spd_in;
	if(anim_progress >= 1)
	{
		image_alpha = 1;
		ease_in = false;
		anim_progress = 0;
	}
}

if(ease_out)
{
	image_alpha = animcurve_channel_evaluate(anim_channel_out,anim_progress);
	anim_progress += anim_spd_out;
	if(anim_progress >= 1)
	{
		image_alpha = 0;
		instance_destroy();
	}	
}