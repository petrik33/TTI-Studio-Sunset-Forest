if(appearing)
{
	image_alpha += alpha_appear_spd;
	if(image_alpha >= 1)
	{
		image_alpha = 1;
		appearing = false;
	}
}
else
{
	alpha_anim_progress += alpha_anim_spd;
	if(alpha_anim_progress > 1)
	{
		alpha_anim_progress = 0;	
	}
	image_alpha = alpha_min + alpha_anim_range * animcurve_channel_evaluate(alpha_animcurve,alpha_anim_progress);
}
//image_index = (image_number - 1) * image_alpha;

if(mouse_check_button_pressed(mb_left))
{
	var mouse_gui_x = device_mouse_x_to_gui(0);
	var mouse_gui_y = device_mouse_y_to_gui(0);
	if(mouse_gui_x <= bbox_right && mouse_gui_x >= bbox_left)
	{
		if(mouse_gui_y <= bbox_bottom && mouse_gui_y >= bbox_top)
		{
			BestiaryOpen();
		}
	}
}
		
	
if(keyboard_check_pressed(vk_tab))
{
	BestiaryOpen();
}