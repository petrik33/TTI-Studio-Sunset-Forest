if(!surged)
{
	if(AnimationEnd())
	{
		sprite_index = sprite_idle;
		image_index = 0;
		surged = true;
	}
}

if(instance_exists(global.oPlayer))
{
	x = global.oPlayer.x + x_offset * global.oPlayer.image_xscale;	
}
else
{
	instance_destroy();	
}
