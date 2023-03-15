var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

mouse_on_button = mouse_gui_x >= left_x && mouse_gui_x <= right_x
&& mouse_gui_y >= top_y && mouse_gui_y <= bot_y;

if(mouse_on_button)
{
	if(mouse_check_button_pressed(mb_left))
	{
		script_to_run();	
	}
}
