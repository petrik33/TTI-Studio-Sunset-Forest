event_inherited();

if(mouse_on_button)
{
	if(mouse_check_button_pressed(mb_left))
	{
		action();
	}
	
	if(mouse_check_button(mb_left))
	{
		image_index = 1;	
	}
	else
	{
		image_index = 0;	
	}
}

if(button_key != noone)
{
	if(keyboard_check_pressed(button_key))
	{
		action();
	}
}

