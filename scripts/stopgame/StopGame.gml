function StopGame(){
	with(pobj_hitable) 
	{
		if(state != state_free || sprite_idle != sprite_run)
		{
			previous_image_speed = image_speed;
			image_speed = 0;
		}
	}
	with(pobj_bullet)
	{
		previous_image_speed = image_speed;
		image_speed = 0;
	}
	with(obj_enemy_portal)
	{
		if(state!=PortalStateOpened || state!=PortalStateClosed || state!=PortalStateAboutToSpawn)
		{
			image_speed = 0;	
		}
	}
	with(pobj_effect)
	{
		if(pause_effect)
		{
			previous_image_speed = image_speed;
			image_speed = 0;	
		}
	}
	with(obj_dirt_effect)
	{
		image_speed = 0;
	}
	
	with(global.oPlayer)
	{
		PlayerStop();	
	}
	
	global.game_is_paused = true;

}

function ContinueGame(){
	with(pobj_hitable) 
	{
		image_speed = previous_image_speed;
	}
	with(obj_enemy_portal)
	{
		if(image_speed = 0)
		{
			if(state!=PortalStateOpening)
			{	
				image_speed = 1;
			}
			else image_speed = -1;
		}
	}
	with(pobj_effect)
	{
		if(pause_effect)
		{
			image_speed = previous_image_speed;;	
		}
	}
	with(pobj_bullet)
	{
		image_speed = previous_image_speed;
	}
	with(obj_dirt_effect)
	{
		image_speed = 1;
	}
	with(global.oPlayer)
	{
		PlayerUnstop();	
	}
			
	global.game_is_paused = false;	
}