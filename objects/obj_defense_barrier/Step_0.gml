if(instance_exists(target))
{
	x = target.x;
	y = (target.bbox_bottom + target.bbox_top) / 2;
}
else
{
	instance_destroy();
	exit;
}
//Animation
//image_alpha = abs(cos(animation_progress));
//if (animation_progress > pi) animation_progress %= (pi);

image_alpha = animation_progress;
if (animation_progress > 1)
{
	animation_progress = 1;
}
else
{
	animation_progress+=animation_speed;	
}


if(!global.game_is_paused)
{
	if(--duration <=0 )
	{
		ShieldRemove();
	}
}