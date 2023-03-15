/// @description Check Cursor For Sleep
if(!global.gui_show)
{
	return;
}
if(global.alternative_controls_on || cursor_sprite == -1 || global.game_is_paused)
{
	var new_mouse_position = [floor(device_mouse_x_to_gui(0)),floor(device_mouse_y_to_gui(0))];
	if(array_equals(mouse_position,new_mouse_position))
	{
		if(++cursor_sleeping_counter == cursor_sleep_limit)
		{
			cursor_sprite = -1;
		}
	}
	else
	{
		cursor_sleeping_counter = 0;
		if(cursor_sprite == -1) cursor_sprite = spr_game_cursor;
	}

	mouse_position = new_mouse_position;
	alarm[0] = cursor_sleep_check_frequency;
}
