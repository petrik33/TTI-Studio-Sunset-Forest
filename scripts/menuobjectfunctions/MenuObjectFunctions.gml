///@arg day_night_include
function MenuFindLongestEntry(_day_night_debug_include)
{
	var max_entries = 1;
	for(var i=0;i<array_length(menu_pages);i++)
	{
		var _page = menu_pages[i];
		if(_page != noone)
		{
			if(!_day_night_debug_include && i == menu_page.day_night_debug)
			{
				continue;	
			}
			max_entries = max(array_length(menu_pages[i]),max_entries);
		}
	}
	return max_entries;
}

function PauseMenuAwake(){
	sleeping = false;
	image_alpha = 1;
	sleep_timer = 0;	
}

///@arg page_array
function WidestEntryFind(page){

	var _widest_entry = 0;
	var entries = array_length(page);
	draw_set_font(menu_font)
	for(var i = 0;i<entries;i++)
	{
		_widest_entry = max(_widest_entry,string_width(page[i][menu_element.name]));
	}
	return _widest_entry;
}

///@arg debugDayNight?
function MenuLineCountHeight(_day_night_debug_mode){
	
	var max_entries = MenuFindLongestEntry(_day_night_debug_mode);
	//height
	menu_line_height = unit_height * (max_entries)  + units_gap * (max_entries - 1)
	//Make It odd 3
	menu_line_height += menu_line_height mod 3;
	
}

///@arg side_x
///@arg side_y
function MenuLineCountPosition(_menu_side_x,_menu_side_y)
{
	switch(_menu_side_x)
	{
		case -1:
		
		menu_line_x = GUI_BOUND + gap_to_line + widest_entry;
		
		
		break;
		case 1:
		
		menu_line_x = (global.GUI_W - GUI_BOUND) * menu_right_edge - gap_to_line;
		
		break;
		
		case 0:
		default:
	
		menu_line_x = (global.GUI_W / 2);

		break;
	}
	menu_right_side_width = min(menu_right_side_max_width,(global.GUI_W - GUI_BOUND) - (menu_line_x + gap_to_line));
	
	switch(_menu_side_y)
	{
		case 1:
		
		menu_line_y = global.GUI_H - GUI_BOUND - menu_line_height - sprite_get_height(spr_menu_line_bot);
		
		break;
		case -1:
		
		menu_line_y = GUI_BOUND + sprite_get_height(spr_menu_line_top);
		
		break;
		case 0:
		
		menu_line_y = (global.GUI_H  - menu_line_height) / 2;
		
		default:
		break;
	}
}
	