if(come_up)
{
	black_bar_h = lerp(0,black_bar_target_h,come_up_progress);
	come_up_progress = min(1,come_up_progress + come_up_spd);
	if(come_up_progress == 1) come_up = false;
}

if(come_down)
{
	black_bar_h = lerp(0,black_bar_target_h,come_up_progress);
	come_up_progress = max(0,come_up_progress - come_up_spd);
	if(come_up_progress == 0)
	{
		black_bar_h = 0;
		instance_destroy();
	}
}

#region GUI Resize

global.GUI_H = initial_gui_h - black_bar_h * 2;
display_set_gui_size(global.GUI_W,global.GUI_H);
display_set_gui_maximize(global.GUI_SCALE,global.GUI_SCALE,gui_x_offset,gui_y_offset + black_bar_h);

#endregion

draw_set_color(c_black);

draw_rectangle(0,-black_bar_h,global.GUI_W,0,false);
draw_rectangle(0,global.GUI_H,global.GUI_W,global.GUI_H + black_bar_h,false);

draw_set_color(c_white);