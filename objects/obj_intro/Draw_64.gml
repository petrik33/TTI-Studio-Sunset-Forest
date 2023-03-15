draw_sprite(intro_logos[current_logo],0,intro_gui_w/2,intro_gui_h/2);

if(transition_running)
{
	draw_set_alpha(transition_alpha);
	draw_set_color(c_black);

	draw_rectangle(0,0,intro_gui_w,intro_gui_h,false);

	draw_set_alpha(1);
	draw_set_color(c_white);
}
