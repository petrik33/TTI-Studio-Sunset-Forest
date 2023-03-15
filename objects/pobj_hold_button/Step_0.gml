event_inherited();

if(key_control!=noone)
{
	var _control_held = keyboard_check(key_control);
}
else
{
	var _control_held = false;
}


if(mouse_on_button || _control_held)
{
	if(mouse_check_button(mb_left) || _control_held)
	{
		if(filling_steps<filling_time) filling_steps++;
		else
		{
			instance_destroy(self);
			action();
		}
	}
	else
	{
		if(filling_steps>0) filling_steps--;	
	}
}
else
{
	if(filling_steps>0) filling_steps--;	
}
