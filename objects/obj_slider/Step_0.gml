if(mouse_check_button(mb_left))
{
	var mouse_gui_x = device_mouse_x_to_gui(0);
	var mouse_gui_y = device_mouse_y_to_gui(0);
	var on_slider = mouse_gui_x >= x && mouse_gui_x <= x + width && mouse_gui_y >= y - 3 && mouse_gui_y <= y + height + 3;
	if(on_slider)
	{
		var progress = (mouse_gui_x - x) / width;
		current_value = snap_number(lerp(value_min,value_max,progress),decimals_count);
	}
}
