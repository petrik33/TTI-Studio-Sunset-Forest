#region Author Animations

if(sprite_index != -1 && image_alpha > 0)
{
	draw_self();
}

#endregion

#region Author Name/Role

if(name_role_alpha > 0)
{
	var _name = credits[CREDITS_ARRAY.names][current_id];
	var _role = credits[CREDITS_ARRAY.roles][current_id];
	DrawSetText(c_white,fa_middle,fa_left,authors_font);
	draw_set_alpha(name_role_alpha);
	draw_text(name_x,name_role_y,_name);
	draw_set_halign(fa_right);
	draw_text(role_x,name_role_y,_role);
	draw_set_alpha(1);
}

#endregion

#region Message

if(message_alpha > 0)
{
	DrawSetText(c_white,fa_middle,fa_center,page_font);
	draw_set_alpha(message_alpha);
	draw_text_ext(global.GUI_W/2,global.GUI_H/2,message_text,-1,page_width);
	draw_set_alpha(1);
}

#endregion

#region With Love

if(with_love_alpha > 0)
{
	DrawSetText(c_white,fa_middle,fa_right,page_font);
	draw_set_alpha(with_love_alpha);
	draw_text(with_love_x,with_love_y,with_love_text);
	draw_set_alpha(1);
}	

#endregion

#region People

if(people_role_alpha > 0)
{
	
	DrawSetText(c_white,fa_top,fa_center,authors_font);	
	draw_set_alpha(people_role_alpha);
	
	var _role_string = credits_page_names[current_people_role];
	
	draw_text(people_role_x,people_role_y,_role_string);
	
	var _role_y_space = string_height(_role_string) + section_gap;
	
	#region Drawing People' Names
	
	var _people_start_y = people_role_y + _role_y_space;
	var _total_height = 0;
	var _people_height = page_height - _role_y_space;
	
	draw_set_alpha(image_alpha);
	
	DrawSetText(c_white,fa_top,fa_left,page_font);
	
	var _people_draw_x = people_leftX;
	
	for(var i = 0; i <= current_person_id; i++)
	{
		var _people_array = credits_page[current_people_role];
		if(i == current_person_id)
		{
			if(current_person_id == array_length(_people_array))
			{
				break;	
			}
			draw_set_alpha(person_alpha);	
		}
		
		var _name = _people_array[i];
		var _name_height = string_height(_name);
		
		if(_total_height + _name_height >= _people_height)
		{
			_people_draw_x = people_rightX;
			_total_height = 0;
			draw_set_halign(fa_right);
		}
		
		var _draw_y = _people_start_y + _total_height;
		
		draw_text(_people_draw_x,_draw_y,_name);
		_total_height += _name_height;
		
		if(current_people_role == CREDITS_PAGE_SECTION.SPECIAL)
		{
			var _message = thank_you_for_list[i];
			if(i == current_person_id)
			{
				draw_set_alpha(thank_you_for_alpha);
			}
			
			var _name_width = string_width(_name);
			var _draw_x = _people_draw_x + _name_width + thank_you_gap;
			draw_set_font(thank_you_font);
			draw_text(_draw_x,_draw_y,_message);
		}
	}
	
	draw_set_alpha(1);
	
	#endregion
	
}

#endregion