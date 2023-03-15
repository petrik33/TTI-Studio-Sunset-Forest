#region//Draw Menu Page

#region//Variables

var page = menu_pages[current_page];
var cursor = page_cursors[current_page]
var unit_count = array_length(page);

#endregion

#region//Left Side

DrawSetText(c_white,fa_middle,fa_right,menu_font);

for(var i = 0; i < unit_count;i++)
{
	var _element = page[i];
	
	var _text_x = menu_line_x - gap_to_line;
	var _text_y = menu_line_y + unit_height * 0.5 + (unit_height+units_gap)*i;
	var _element_left_text = _element[menu_element.name];
	
	if(
		(_element[menu_element.type] != menu_element_type.blockable_page_transfer
		|| _element[menu_element.current_value] = true)
		&& (_element[menu_element.type] != menu_element_type.mouse_alternative_input
		|| _element[menu_element.value_range] = true)
	)
	{
		if(cursor = i)
		{
			draw_set_color(menu_color_light);
			if(inputing)
			{
				input_waving_progress+=input_waving_spd;
				var _element_left_scale = 0.95 + sin(input_waving_progress) * 0.1;	
				draw_text_transformed(_text_x,_text_y,_element_left_text,_element_left_scale,_element_left_scale,0);
			}
			else
			{
				draw_text(_text_x,_text_y,_element_left_text);
			}
		}
		else
		{
			draw_set_color(menu_color_dark);
			draw_text(_text_x,_text_y,_element_left_text);	
		}
	}
	else
	{
		draw_set_color(c_gray);
		draw_text(_text_x,_text_y,_element_left_text);
	}
	
}

draw_set_color(c_white);

#endregion

#region//Menu Line
draw_sprite(spr_menu_line_top,0,menu_line_x,menu_line_y);
draw_sprite_ext(spr_menu_line_mid,0,menu_line_x,menu_line_y,1,menu_line_height,0,c_white,image_alpha);
draw_sprite(spr_menu_line_bot,0,menu_line_x,menu_line_y + menu_line_height);
#endregion

#region//Right Side

draw_set_halign(fa_left);

for(var i = 0; i < unit_count;i++)
{
	var element = page[i];
	var element_y = menu_line_y + unit_height * 0.5 + (unit_height+units_gap)*i;
	switch(element[menu_element.type])
	{
		case menu_element_type.slider:
		#region
		
		draw_set_font(Font(fn_percents));
		
		var _value_min = element[menu_element.value_range][0];
		var _value_range = element[menu_element.value_range][1] - _value_min;
		var _current_value = element[menu_element.current_value];
		var progress = ((_current_value - _value_min)/_value_range);
		var percent_str = string(int64(progress*100)) + "%"
		
		var x1 = menu_line_x+gap_to_line;
		var y1 = element_y;
		
		draw_set_color(menu_color_dark);
		
		draw_line_width(x1,y1,x1+slider_len,y1,6);
		
		if(inputing && page_cursors[current_page] = i) draw_set_color(menu_color_light);
		
		draw_text(x1+slider_len+16,y1,percent_str);
		
		draw_set_color(menu_color_light);
		
		draw_circle(x1+progress*slider_len,y1,8,false);
		
		
		break;
		#endregion
		
		case menu_element_type.rectangular_bar:
		#region
		
		var x1 = menu_line_x+gap_to_line;
		var y1 = element_y - rect_bar_height/2;
		
		draw_set_color(menu_color_light);
		
		for(var t = 0; t < element[menu_element.current_value];t++)
		{
			draw_rectangle(
			x1+rect_bar_gap*t+rect_bar_width*t,
			y1,
			x1+rect_bar_gap*t + rect_bar_width*(t+1),
			y1+rect_bar_height,
			false
			);
		}
		
		draw_set_color(menu_color_dark);
		
		for(var h = element[menu_element.current_value]; h < 10;h++)
		{
			draw_rectangle(
			x1+rect_bar_gap*h+rect_bar_width*h,
			y1,
			x1+rect_bar_gap*h + rect_bar_width*(h+1),
			y1+rect_bar_height,
			false
			);
		}
		
		
		break;
		#endregion
		
		case menu_element_type.control_input:
		#region
		
		draw_set_font(menu_font)
		
		draw_set_alpha(image_alpha);
		
		if(inputing && page_cursors[current_page] = i)
		{
			draw_set_color(menu_color_light);
			control_input_alpha_shift+=alpha_speed;
			draw_set_alpha(abs(cos(control_input_alpha_shift)));
		}
		else draw_set_color(menu_color_dark);
		
		draw_text(menu_line_x + gap_to_line,element_y,element[menu_element.first_entry]);
		
		draw_set_alpha(1);
		
		break;
		#endregion
		
		case menu_element_type.mouse_alternative_input:
		#region
		
		if(element[menu_element.value_range] = true)
		{
			draw_set_font(menu_font)
		
			if(inputing && page_cursors[current_page] = i)
			{
				draw_set_color(menu_color_light);
				control_input_alpha_shift+=alpha_speed;
				draw_set_alpha(abs(cos(control_input_alpha_shift)));
			}
			else
			{
				draw_set_color(menu_color_dark);
			}
		
			draw_text(menu_line_x + gap_to_line,element_y,element[menu_element.first_entry]);
		
			draw_set_alpha(1);
		}
		
		break;
		#endregion
		
		case menu_element_type.enemy_toggle:
		#region
		
		var _current_value = element[menu_element.first_entry];
		
		var _draw_x = (menu_line_x + gap_to_line + global.GUI_W - GUI_BOUND - portrait_width) / 2;
		var _draw_y = element_y - portrait_height / 2;
		
		var _text_color = menu_color_light;
		var _arrows_color = menu_color_dark;
			
		if(inputing)
		{
			cursored_portrait_anim_counter+=cursored_portrait_anim_spd;
			_draw_y += sin(cursored_portrait_anim_counter) * cursored_portrait_add_y;
			_arrows_color = menu_color_light;
		}
		
		#region//Draw Arrows
			
		draw_set_color(_arrows_color)
		
		#region//Left Arrow
		if(_current_value!=0)
		{
			draw_triangle(
				menu_line_x+gap_to_line*2,
				element_y,
				menu_line_x+ gap_to_line*2 + toggle_arrow_height,
				element_y - toggle_arrow_width/2,
				menu_line_x+ gap_to_line*2 + toggle_arrow_height,
				element_y + toggle_arrow_width/2,
				0
			)
		}
		#endregion
		
		#region//Right Arrow
		if(_current_value!=ENEMIES.VOA-1)
		{
			draw_triangle(
				global.GUI_W-GUI_BOUND*2,
				element_y,
				global.GUI_W-GUI_BOUND*2-toggle_arrow_height,
				element_y - toggle_arrow_width/2,
				global.GUI_W-GUI_BOUND*2-toggle_arrow_height,
				element_y + toggle_arrow_width/2,
				0
			)
		}
		#endregion
			
		#endregion
		
		if(global.enemies[ENEMY.ACTIVE][_current_value] = false)
		{
			draw_set_alpha(enemy_toggle_low_alpha);
			_text_color = menu_color_dark;
		}
		
		#region//Drawing Names
		
		var _text_x = _draw_x + portrait_width/2;
		var _text_y = _draw_y + portrait_height/2 + font_get_size(menu_font) + GUI_BOUND;
		DrawSetText(_text_color,fa_middle,fa_center,menu_font);
		draw_text(_text_x,_text_y,Text(global.enemies[ENEMY.NAME][_current_value]));
		draw_set_color(c_white);
		
		#endregion
			
		//Draw Portraits
		draw_sprite(global.enemies[ENEMY.PORTRAIT][_current_value],0,_draw_x,_draw_y);
		
		draw_set_alpha(1);
				
		break;
		#endregion
		
		case menu_element_type.shifter:
		#region
		
		var _text_color = menu_color_dark;
		if(inputing && page_cursors[current_page] = i)
		{
			_text_color = menu_color_light;
		}
		DrawSetText(_text_color,fa_middle,fa_center,menu_font);
		var _current_value = element[menu_element.current_value];
		var _entry_text = element[menu_element.first_entry][_current_value];
		var _text_x = (menu_line_x + gap_to_line + global.GUI_W - GUI_BOUND) / 2;
		
		#region//Draw Arrows
		
		#region//Left Arrow
		//if(_current_value!=0)
		//{
			draw_triangle(
				menu_line_x+gap_to_line,
				element_y,
				menu_line_x+gap_to_line + toggle_arrow_height,
				element_y - toggle_arrow_width/2,
				menu_line_x+gap_to_line + toggle_arrow_height,
				element_y + toggle_arrow_width/2,
				0
			)
		//}
		#endregion
		
		#region//Right Arrow
		//if(_current_value!=array_length(element[menu_element.first_entry])-1)
		//{
			draw_triangle(
				global.GUI_W-GUI_BOUND,
				element_y,
				global.GUI_W-GUI_BOUND-toggle_arrow_height,
				element_y - toggle_arrow_width/2,
				global.GUI_W-GUI_BOUND-toggle_arrow_height,
				element_y + toggle_arrow_width/2,
				0
			)
		//}
		#endregion
		
		#endregion
		
		draw_text(_text_x,element_y,_entry_text);//Entry Name
		
		draw_set_color(c_white);
		
		break;
		#endregion
		
		case menu_element_type.bestiary:
		#region
		
		var _current_value = element[menu_element.first_entry];
		
		var _draw_x = menu_line_x + gap_to_line + menu_right_side_width / 2 - portrait_width / 2;//Gap To Line is counted in side_width
		var _draw_y = element_y - portrait_height / 2;
		
		var _text_color = menu_color_light;
		var _arrows_color = menu_color_dark;
			
		if(inputing)
		{
			cursored_portrait_anim_counter+=cursored_portrait_anim_spd;
			_draw_y += sin(cursored_portrait_anim_counter) * cursored_portrait_add_y;
			_arrows_color = menu_color_light;
		}
		
		#region//Draw Arrows
			
		draw_set_color(_arrows_color)
		
		#region//Left Arrow
		if(_current_value!=0)
		{
			draw_triangle(
				menu_line_x+gap_to_line*2,
				element_y,
				menu_line_x+ gap_to_line*2 + toggle_arrow_height,
				element_y - toggle_arrow_width/2,
				menu_line_x+ gap_to_line*2 + toggle_arrow_height,
				element_y + toggle_arrow_width/2,
				0
			)
		}
		#endregion
		
		#region//Right Arrow
		if(_current_value!=ENEMIES.NUMBER-1)
		{
			var _right_edge = menu_line_x + menu_right_side_width - gap_to_line;
			draw_triangle(
				_right_edge,
				element_y,
				_right_edge - toggle_arrow_height,//Arrow Is Rotated 90 deg so it's right to subtract height not width
				element_y - toggle_arrow_width/2,
				_right_edge - toggle_arrow_height,
				element_y + toggle_arrow_width/2,
				0
			)
		}
		#endregion
			
		#endregion
		
		if(global.enemies[ENEMY.ACTIVE][_current_value] = false)
		{
			draw_set_alpha(enemy_toggle_low_alpha);
			_text_color = menu_color_dark;
		}
		
		#region//Drawing Names
		
		var _text_x = _draw_x + portrait_width/2;
		var _text_y = _draw_y + portrait_height/2 + font_get_size(menu_font) + GUI_BOUND;
		DrawSetText(_text_color,fa_middle,fa_center,menu_font);
		draw_text(_text_x,_text_y,Text(global.enemies[ENEMY.NAME][_current_value]));
		draw_set_color(c_white);
		
		#endregion
			
		//Draw Portraits
		draw_sprite(global.enemies[ENEMY.PORTRAIT][_current_value],0,_draw_x,_draw_y);
		
		draw_set_alpha(1);
		
		break;
		#endregion
		
		case menu_element_type.toggle:
		#region
		
		var _on_color = menu_color_dark;
		var _off_color = menu_color_light;
		
		if(element[menu_element.current_value] = true)
		{
			_on_color = menu_color_light;
			_off_color = menu_color_dark;
		}
		
		DrawSetText(_on_color,fa_middle,fa_left,menu_font);
		
		var x1 = menu_line_x + gap_to_line;
		
		draw_text(x1,element_y,"On");
		
		var x2 = x1 + string_width("On") + 8;
		draw_set_color(_off_color);
		
		draw_text(x2,element_y,"Off");
		
		draw_set_color(c_white);
		
		break;
		#endregion
		
		default:
		break;
		
	}
}

draw_set_color(c_white)

#endregion

#endregion