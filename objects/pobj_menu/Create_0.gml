menu_active = true;
menu_font = Font(fn_menu);

#region//Page Variables
current_page = starting_page;
page_cursors = array_create(menu_page.last_empty,0);
previous_page = current_page;
#endregion

#region Actions

bestiary_closed = BestiaryButtonHide();

#endregion

#region//Mouse Movement
mouse_previous_x = 0;
mouse_previous_y = 0;
mouse_gui_x = mouse_previous_x;
mouse_gui_y = mouse_previous_y;
mouse_moved = (mouse_gui_x!=mouse_previous_x) || (mouse_gui_y!=mouse_previous_y);
#endregion

#region//Drawing Variables

draw_set_font(menu_font);//For Sizes Counting

#region//General

unit_height = font_get_size(menu_font);
units_gap = floor(unit_height * 0.25);
widest_entry = 0;

#endregion

#region//Width count

for(var i=0;i<menu_page.last_empty;i++)
{
	var page = menu_pages[i];
	if(page != noone)
	{
		widest_entry = max(widest_entry,WidestEntryFind(page));
	}
}

menu_right_side_max_width = widest_entry;
//menu_right_side_width = min(menu_right_side_max_width,(global.GUI_W - GUI_BOUND) - (menu_line_x + gap_to_line));


#endregion

#region//Menu Line

gap_to_line = 6;	

MenuLineCountHeight(false);
MenuLineCountPosition(menu_side_x,menu_side_y);

#endregion

#region//Element Input Variables

input_waving_progress = arcsin(0.5);
input_waving_spd = (double_pi) / (FRAME_RATE * 3);

#endregion

#region//Sliders

draw_set_font(Font(fn_percents));
slider_len = global.GUI_W * (1 - menu_right_edge) - string_width("100%") - GUI_BOUND;

#endregion

#region//Rectangular Bar

rect_bar_gap = floor((global.GUI_W * (1 - menu_right_edge)  ) / 10 / 3)
rect_bar_height = font_get_size(menu_font)/2;
rect_bar_width = ceil((global.GUI_W * (1 - menu_right_edge)  ) / 10 / 3 * 2)
//rect_bar_width = 10

#endregion

#region//Enemy Toggle

enemy_toggle_low_alpha = 0.5;

cursored_portrait_add_y = 8;
cursored_portrait_anim_counter = 0;
cursored_portrait_anim_spd = double_pi / (FRAME_RATE * 1.5);

toggle_arrow_width = portrait_width / 2;
toggle_arrow_height = 12;
//toggle_arrow_gap = 4;


#endregion

#region//Control Input

control_input_alpha_shift = 0;
alpha_speed = (pi) / (FRAME_RATE * 3);

#endregion

#endregion

#region//Input Variables
inputing = false;
inputing_buffer = 0;
enemy_input_cursor = -1;
#endregion

//menu_music = MusicFadeIn(menu_music_res,MILI_TO_SECONDS * 3,true);

if(audio_group_is_loaded(music))
{
	MenuMusicPlay(menu_music_res);
}
else
{
	alarm[0] = 5;	
}


