if(show_image)
{
	draw_self();	
}

#region Text

if(current_text != -1)
{
	DrawSetText(c_white,fa_left,fa_center,text_font);
	var _print = string_copy(current_text,0,text_progress)
	draw_text_ext(gui_right/2,text_y,_print,text_separation,text_width);
}

#endregion

#region Transition

if(transition_progress > 0)
{
	draw_set_color(c_black);
	
	//Upside
	draw_rectangle(gui_left,gui_top,gui_right,screen_centre * transition_progress,false);
	//Downside
	draw_rectangle(gui_left,gui_bot - screen_centre * transition_progress,gui_right,gui_bot,false);
	
	draw_set_color(c_white);
}

#endregion

//#region//Full Skip

//if(full_skip_show)
//{
//	full_skip_alpha = abs(sin(full_skip_sin_progress) * full_skip_max_alpha);
//	full_skip_sin_progress+=full_skip_sin_spd;
//	draw_set_alpha(full_skip_alpha)

//	DrawSetText(c_gray,fa_top,fa_left,fn_secondary_illustrations);

//	draw_text(full_skip_x_offset,full_skip_y_offset,full_skip_text)

//	draw_set_alpha(1);
//	draw_set_color(c_white);
//}

//#endregion