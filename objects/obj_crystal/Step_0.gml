if(!global.game_is_paused)
{
	if(instance_exists(light_instance))
	{
		light_instance.x = x;
		light_instance.y = y;
		light_instance.image_angle = image_angle;
	}
	if(submerging)
	{
		if(!stopped)
		{
			dirt_img_id += dirt_img_spd;
			if(dirt_img_id >= dirt_img_num)
			{
				dirt_img_id = 0;	
			}
		}
	}
	else
	{
		if(!stopped)
		{
			if(bbox_bottom > FLOOR_Y)
			{
				submerging = true;
				SubmergeDirtThrow(x);
			}
		}
	}
}

//var key_right = ( keyboard_check(vk_right) || keyboard_check(ord("D")) ); 
//var key_left = ( keyboard_check(vk_left) || keyboard_check(ord("A")) );
//var _key_top = keyboard_check(ord("O"));
//var _key_bot = keyboard_check(ord("L"));
//var _key_submerge = keyboard_check_pressed(vk_control);
//var _key_stop = keyboard_check_pressed(vk_alt);

//var _horizontal = key_right - key_left;
//var _vertical = _key_bot - _key_top;
//x += _horizontal;
//y += _vertical;
//if(_key_submerge) submerging = !submerging;
//if(_key_stop) stopped = !stopped;