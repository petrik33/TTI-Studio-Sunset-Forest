if(fading_out)
{
	image_alpha-=fade_away_spd;
	if(image_alpha<=0) instance_destroy();
}
else
{
	if(AnimationEnd())
	{
		if(!fade_out) instance_destroy();
		else
		{
			image_speed = 0;
			fading_out = true;
		}
	}
}

