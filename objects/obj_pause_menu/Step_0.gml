event_inherited();

#region//Sleeping

var _player_active = mouse_moved || (keyboard_check(vk_anykey));
if(!_player_active)
{
	if(sleep_timer != no_input_sleep_time)
	{
		if(!inputing) sleep_timer++;
	}
	else
	{
		if(!sleeping)
		{
			#region//Fade Away
	
			image_alpha-=fade_away_spd;
			if(image_alpha <= 0)
			{
				sleeping = true;
				image_alpha = 0;
			}
	
			#endregion
		}
	}
}
else
{
	if(!menu_in_photo_mode)
	{
		sleeping = false;
		image_alpha = 1;
		sleep_timer = 0;
	}
	else
	{
		if(keyboard_lastkey == vk_escape)
		{
			sleeping = false;
			menu_active = true;
			menu_in_photo_mode = false;
			image_alpha = 1;
		}
	}
}
#endregion
	

