/// @description

intro_logos = [spr_company_logo,spr_game_logo];
current_logo = 0;
logo_timer = 0;
if(!variable_global_exists("game_final"))
{
	global.game_final = false;	
}
if(!global.game_final)
{
	window_set_fullscreen(!debug_windowed);
}
else
{
	global.game_final = false;	
}

//Debug Value!!!
logo_time = 2;
transition_time = 2;
//logo_time = 1/FRAME_RATE;
//transition_time = 1/FRAME_RATE;
//if(debug_version)
//{
//	logo_time = 0.1;
//	transition_time = 0;
//}

transition_timer = 0;

intro_gui_w = display_get_gui_width();
intro_gui_h = display_get_gui_height();

transition_alpha = 1;

transition_running = true;
transition_direction = -1;//Fade Out
