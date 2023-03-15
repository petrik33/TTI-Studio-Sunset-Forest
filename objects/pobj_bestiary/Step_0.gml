if(lerp_progress < 1)
{
	lerp_progress += lerp_spd;	
}
else
{
	lerp_progress = 1;
	if(alpha_progress < 1)
	{
		alpha_progress += alpha_spd;
		if(alpha_progress > 1) alpha_progress = 1;
	}
}

if(keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_tab))
{
	if(instance_exists(global.oMenu))
	{
		instance_destroy();
		MenuActivate();
		return;
	}
	
	if(ds_queue_empty(global.bestiary_queue))
	{
		BestiaryClose();
		return;
	}
	
	var _queue_info = ds_queue_dequeue(global.bestiary_queue);
	BestiaryChangePage(_queue_info);	
}
