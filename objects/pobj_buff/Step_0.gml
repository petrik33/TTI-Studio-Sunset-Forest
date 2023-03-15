if(instance_exists(target))
{
	image_xscale = target.image_xscale;
	x = target.x + x_offset * image_xscale;
	y = target.y + y_offset;
	emitter_position();
}
else
{
	BuffDestroy();
	exit;
}

if(!global.game_is_paused)
{
	if(++active_time >= total_duration)
	{
		BuffRemove();
	}
}
