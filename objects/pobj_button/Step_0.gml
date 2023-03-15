var mouse_gui_x = device_mouse_x_to_gui(0);
var mouse_gui_y = device_mouse_y_to_gui(0);

mouse_on_button = mouse_gui_x >= bbox_left && mouse_gui_x <= bbox_right
&& mouse_gui_y >= bbox_top && mouse_gui_y <= bbox_bottom;

if(shade_button_mode && mouse_on_button)
{
	image_alpha = 1;
}
else
{
	image_alpha = low_alpha;	
}
