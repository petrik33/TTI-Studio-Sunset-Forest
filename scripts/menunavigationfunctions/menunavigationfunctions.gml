///@arg element
function MenuInputLeftSide(element)
{
	switch (element[menu_element.type])
	{
		
		case menu_element_type.blockable_page_transfer:
		#region
		if(element[menu_element.current_value] = false)
		{
			break;	
		}
		
		#endregion
		
		case menu_element_type.page_transfer:
		#region
		
		previous_page = current_page;
		current_page = element[menu_element.first_entry];
		//widest_entry = WidestEntryFind(current_page);
			
		break;
		#endregion
		
		case menu_element_type.script_runner:
		#region
		
		script_execute(element[menu_element.first_entry]);
		
		break;
		#endregion
		
		case menu_element_type.toggle:
		#region
		
		var _old_value = element[menu_element.current_value];
		element[@ menu_element.current_value] = !_old_value;
		var _script = element[menu_element.first_entry];
		if(_script != noone)
		{
			script_execute(_script,!_old_value);
		}
		//else
		//{
				
		//}
		
		break;
		#endregion
		
		case menu_element_type.shifter:
		#region
		
		if(inputing)
		{
			element[menu_element.value_range](element[menu_element.current_value]);
			inputing = false;
		}
		else
		{
			inputing = true;
			inputing_buffer = element[menu_element.current_value];
		}
		
		break;
		#endregion
		
		case menu_element_type.enemy_toggle:
		#region
		
		if(inputing = false)
		{
			inputing_buffer = element[menu_element.current_value];
		}
		else
		{
			cursored_portrait_anim_counter = 0;
			inputing_buffer = -1;
			control_input_alpha_shift = 0;
			input_waving_progress = arcsin(0.5);
		}
		
		inputing=!inputing;
		break;
		
		#endregion
		
		case menu_element_type.bestiary:
		#region
		
		if(inputing = false)
		{
			inputing_buffer = element[menu_element.current_value];
		}
		else
		{
			var _current_value = element[menu_element.first_entry];
			if(global.enemies[ENEMY.ACTIVE][_current_value])
			{
				BestiaryEnemyOpenFromMenu(_current_value);
			}
			else
			{
				inputing = !inputing;//To Avoid Input	
			}
		}
		
		inputing=!inputing;
		
		break;
		
		#endregion
		
		default:
		#region
		inputing=!inputing;
		if(!inputing)//Value Entered
		{
			inputing_buffer = 0;
			control_input_alpha_shift = 0;
			input_waving_progress = arcsin(0.5);
		}
		else
		{
			inputing_buffer = element[menu_element.current_value];
		}
		break;
		#endregion
	}
	
	//audio_play_sound(sn_menu_choose,1,false);
	PlayerSoundMake(sn_menu_choose,,,false);
}

function MenuKeyNavigation(){
	var _key_down = (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down));
	var _key_up = (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up));
	var _key_input = _key_down - _key_up;
	if(_key_input!=0)
	{
		page_cursors[@ current_page] += _key_input;
		
		if(page_cursors[current_page] >= array_length(menu_pages[current_page]) )  page_cursors[current_page] = 0;
		if(page_cursors[current_page] < 0) page_cursors[current_page] = array_length(menu_pages[current_page]) - 1;
		
		var element = menu_pages[current_page][page_cursors[current_page]];
		while(
			(element[menu_element.type] = menu_element_type.blockable_page_transfer
			&& element[menu_element.current_value] == false)
			|| (element[menu_element.type] = menu_element_type.mouse_alternative_input
			&& element[menu_element.value_range] == false)
		)
		{
			page_cursors[@ current_page] +=_key_input;
			element = menu_pages[current_page][page_cursors[current_page]];
		}
	
		//audio_play_sound(sn_menu_scroll,1,false);
		PlayerSoundMake(sn_menu_scroll,,,false);
	}
	
	return _key_input
}

///@arg element
function MenuKeyInput(element){
	switch(element[menu_element.type])
	{
		case menu_element_type.slider:
		#region
		
		if(!keyboard_check(vk_control) && !keyboard_check(vk_alt))
		{
			var _h_right = (keyboard_check(vk_right) || keyboard_check(ord("D")));
			var _h_left = (keyboard_check(vk_left) || keyboard_check(ord("A")));
		}
		else
		{
			var _h_right = (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")));
			var _h_left = (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")));	
		}
		
		var h_key_input = _h_right - _h_left;
		
		if(h_key_input!=0)
		{
			var _value_min = element[menu_element.value_range][0];
			var _value_max = element[menu_element.value_range][1];
			var _value_range = _value_max - _value_min;
			element[@ menu_element.current_value] += h_key_input * (_value_range / 100);
			element[@ menu_element.current_value] = clamp(
				element[@ menu_element.current_value],
				element[menu_element.value_range][0],
				element[menu_element.value_range][1]
			)
			script_execute(element[menu_element.first_entry],element[menu_element.current_value]);
		
			//audio_play_sound(sn_menu_adjust,1,0);
			PlayerSoundMake(sn_menu_adjust,,,false);
		}
		
		break;
		#endregion
		
		case menu_element_type.enemy_toggle:
		#region
		
		#region//Cursor Movement
		var _h_right = (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")));
		var _h_left = (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")));
		
		var h_input = _h_right - _h_left;
		if(h_input!=0)
		{
			element[@menu_element.first_entry] += h_input;
			element[@menu_element.first_entry] = clamp(element[menu_element.first_entry],0,ENEMIES.VOA-1)
			//audio_play_sound(sn_menu_choose,1,false);
			PlayerSoundMake(sn_menu_choose,,,false);
		}
		#endregion
		
		var _key_down = (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down));
		var _key_up = (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up));
		
		#region//Toggling Up
		if(_key_up)
		{
			global.enemies[ENEMY.ACTIVE][@ element[menu_element.first_entry]] = true;
			//audio_play_sound(sn_menu_adjust,1,0);
			PlayerSoundMake(sn_menu_adjust,,,false);
		}
		#endregion
		
		#region//Toggling Off
		if(_key_down)
		{
			var _active_list = ds_list_create();
		
			for(var i = 0;i < ENEMIES.VOA; i++)
			{
				if(global.enemies[ENEMY.ACTIVE][i] = true)
				{
					ds_list_add(_active_list,i);	
				}
			}
			
			if(!ds_list_empty(_active_list))
			{
				global.enemies[ENEMY.ACTIVE][@ element[menu_element.first_entry]] = false;
				//audio_play_sound(sn_menu_adjust,1,0);
				PlayerSoundMake(sn_menu_adjust,,,false);
			}
			
		}
		#endregion
		
		break;
		#endregion
		
		case menu_element_type.bestiary:
		#region
		
		#region//Cursor Movement
		var _h_right = (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")));
		var _h_left = (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")));
		
		var h_input = _h_right - _h_left;
		if(h_input!=0)
		{
			element[@menu_element.first_entry] += h_input;
			element[@menu_element.first_entry] = clamp(element[menu_element.first_entry],0,ENEMIES.NUMBER-1);
			//audio_play_sound(sn_menu_choose,1,false);
			PlayerSoundMake(sn_menu_choose,,,false);
		}
		#endregion
		
		break;
		#endregion
		
		case menu_element_type.rectangular_bar:
		#region
		
		var _h_right = (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")));
		var _h_left = (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")));
		
		var h_input = _h_right - _h_left;
		
		if(h_input!=0)
		{
			element[@ menu_element.current_value] += h_input;
			//audio_play_sound(sn_menu_adjust,1,0);
			PlayerSoundMake(sn_menu_adjust,,,false);
		}
		
		//Keep the Value between min and max
		element[@ menu_element.current_value] = clamp(
			element[@ menu_element.current_value],
			element[menu_element.value_range][0],
			element[menu_element.value_range][1]
		)
		
		script_execute(
			element[menu_element.first_entry],
			element[menu_element.current_value]/element[menu_element.value_factor]
		)
		
		break;
		
		#endregion
		
		case menu_element_type.control_input:
		case menu_element_type.mouse_alternative_input:
		#region
		
		if(keyboard_lastkey!=0 && keyboard_lastkey!=vk_enter)
		{
			var passed_check = true;
			#region//Forbidden Check
			for(var i=0;i<array_length(global.forbidden_controls);i++)
			{
				if(keyboard_lastkey	= global.forbidden_controls[i]) passed_check = false;
			}
			#endregion
			#region//Used Check
			
			var _previous_control = element[menu_element.current_value];
			var _previous_id = noone;
			
			for(var k = 0;k<array_length(global.controls_used);k++)
			{
				if(keyboard_lastkey	= global.controls_used[k]) passed_check = false;
				if(global.controls_used[k] = _previous_control) _previous_id = k;
				
			}
			#endregion
			if(passed_check)
			{
				element[@ menu_element.current_value] = keyboard_lastkey;
				element[@ menu_element.first_entry] = chr(keyboard_lastkey);
				if(_previous_id!=noone) global.controls_used[_previous_id] = keyboard_lastkey;
				
				inputing = !inputing;
				keyboard_lastkey = 0;
				//audio_play_sound(sn_menu_adjust,1,0);
				PlayerSoundMake(sn_menu_adjust,,,false);
			}
			
			else
			{
				keyboard_lastkey = 0;	
			}
			
		}
		
		break;
		#endregion
		
		case menu_element_type.shifter:
		#region
		
		var _h_right = (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")));
		var _h_left = (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")));
		
		var _h_input = _h_right - _h_left;
		if(_h_input!=0)
		{
			element[@menu_element.current_value]+=_h_input;
			var _elements_num = array_length(element[menu_element.first_entry]);
			
			#region//Safe Check
			if(element[menu_element.current_value]<0)
			{
				element[@menu_element.current_value] = _elements_num - 1;
			}
			
			if(element[menu_element.current_value] == array_length(element[menu_element.first_entry]))
			{
				element[@menu_element.current_value] = 0;
			}
			#endregion
		}
		
		break;
		#endregion
	}
}

///@arg mouse_x
///@arg mouse_y
///@arg mouse_moved
///@arg element
function MenuMouseControl(mouse_gui_x,mouse_gui_y,mouse_moved,element){
	if(mouse_gui_y>=menu_line_y && mouse_gui_y <= menu_line_y + menu_line_height)
	{
		//Mouse Is on Menu
		if(mouse_gui_x>=menu_line_x - gap_to_line - widest_entry)
		{
			//Moving The Cursor With Mouse
			if(mouse_moved)
			{
				
				var _new_element = (mouse_gui_y - menu_line_y) div (unit_height+units_gap);
				var _old_element = page_cursors[current_page];
				//Keep The Choice In Bounds
				_new_element = clamp
				(
					_new_element,
					0,
					array_length(menu_pages[current_page]) - 1
				);
						
				page_cursors[current_page] = _new_element;
					
				if(_new_element!=_old_element)
				{
					if(inputing) inputing = false;
					//audio_play_sound(sn_menu_scroll,1,false);
					PlayerSoundMake(sn_menu_scroll,,,false);
				}	
			}
		
			//Find The Side of the menu where mouse lies
			if(mouse_gui_x>menu_line_x)
			{
				//Mouse on The Right Side
				if(mouse_check_button(mb_left))
				{
					//Mouse Menu Input(Right Side)
					MenuMouseInput(mouse_gui_x,mouse_gui_y,element)	;
				}
			}
			else
			{
				//Mouse On The Left Side
				if(mouse_check_button_pressed(mb_left))
				{
					MenuInputLeftSide(menu_pages[current_page][page_cursors[current_page]]);
				}
			}
		}
	}
}

///@arg mouse_x
///@arg mouse_y
///@arg element
function MenuMouseInput(mouse_gui_x,mouse_gui_y,element){
	switch(element[menu_element.type])
	{
		
		case menu_element_type.slider:
		#region
		
		var _x1 = menu_line_x+gap_to_line;
		var _input_percent = clamp((mouse_gui_x - _x1) / slider_len,0,1);
		
		var _value_min = element[menu_element.value_range][0];
		var _value_max = element[menu_element.value_range][1];
		var _value_range = _value_max - _value_min;
		element[@ menu_element.current_value] = _value_min + _value_range * _input_percent;
		//element[@ menu_element.current_value] = clamp(
		//	element[@ menu_element.current_value],
		//	element[menu_element.value_range][0],
		//	element[menu_element.value_range][1]
		//)
		script_execute(element[menu_element.first_entry],element[menu_element.current_value]);
		
		break;
		#endregion
		
		case menu_element_type.rectangular_bar:
		#region
						
		var _entered_value = (mouse_gui_x - menu_line_x - gap_to_line) div (rect_bar_width + rect_bar_gap) + 1;
		_entered_value = clamp
		(
			_entered_value,
			element[menu_element.value_range][0],
			element[menu_element.value_range][1]
		);
						
		element[@ menu_element.current_value] = _entered_value;
		script_execute
		(
			element[menu_element.first_entry],
			element[menu_element.current_value]/element[menu_element.value_factor]
		);
					
		//audio_play_sound(sn_menu_adjust,1,0);
		if(mouse_check_button_pressed(mb_left)) PlayerSoundMake(sn_menu_adjust,,,false);
						
		break;
		#endregion
					
		case menu_element_type.toggle:
		#region
					
		draw_set_font(menu_font)
		var _on_right_border = menu_line_x + gap_to_line + string_width("On");
					
		var _entered_value = noone;
					
		if(mouse_gui_x < _on_right_border)
		{
			var _entered_value = true;	
		}
		else
		{
			var _off_right_border = _on_right_border + 8 + string_width("Off");
			if(mouse_gui_x<_off_right_border)
			{
				var _entered_value = false;
			}
		}
					
		var _old_value = element[menu_element.current_value];
					
		if(_entered_value!=noone && _entered_value!=_old_value)
		{
			element[@ menu_element.current_value] = !_old_value;
			script_execute(element[menu_element.first_entry],!_old_value)
		}
					
		break;
		#endregion
					
		case menu_element_type.shifter:
		#region
		
		if(mouse_check_button_pressed(mb_left))
		{
					
			var _center_of_side = (menu_line_x + gap_to_line + global.GUI_W - GUI_BOUND) / 2;
			var _input = sign( mouse_gui_x - _center_of_side);
			
			element[@menu_element.current_value]+=_input;
			var _elements_num = array_length(element[menu_element.first_entry]);
			
			#region//Safe Check
			if(element[menu_element.current_value]<0)
			{
				element[@menu_element.current_value] = _elements_num - 1;
			}
			
			if(element[menu_element.current_value] == array_length(element[menu_element.first_entry]))
			{
				element[@menu_element.current_value] = 0;
			}
			#endregion
					
			element[menu_element.value_range](element[menu_element.current_value]);
		}
					
		break;
		#endregion
		
		case menu_element_type.enemy_toggle:
		#region
		
		if(mouse_check_button_pressed(mb_left))
		{
					
			var _center_of_side = (menu_line_x + gap_to_line + global.GUI_W - GUI_BOUND) / 2;
			var _enemy_x1 = _center_of_side - portrait_width/2;
			var _enemy_x2 = _center_of_side + portrait_width/2;
			if(mouse_gui_x < _enemy_x1 || mouse_gui_x > _enemy_x2)
			{
				var _input = sign( mouse_gui_x - _center_of_side);
					
				element[@menu_element.first_entry]+=_input;
				var _input_successful = true;
			
				#region//Safe Check
				if(element[menu_element.first_entry]<0)
				{
					element[@menu_element.first_entry]++;
					var _input_successful = false;
				}
			
				if(element[menu_element.first_entry] == ENEMIES.VOA)
				{
					element[@menu_element.first_entry]--;
					var _input_successful = false;
				}
				#endregion
			
				if(_input_successful)
				{
					//audio_play_sound(sn_menu_choose,1,false);
					PlayerSoundMake(sn_menu_choose,,,false);
				}
				//element[menu_element.value_range](element[menu_element.current_value]);
			
			}
			else
			{
				#region//Activating or deactivating enemy
			
				var _active_list = ds_list_create();
		
				for(var i = 0;i < ENEMIES.VOA; i++)
				{
					if(global.enemies[ENEMY.ACTIVE][i] = true)
					{
						ds_list_add(_active_list,i);	
					}
				}
			
				if(!ds_list_empty(_active_list))
				{
					global.enemies[ENEMY.ACTIVE][@ element[menu_element.first_entry]] = !global.enemies[ENEMY.ACTIVE][element[menu_element.first_entry]];
					//audio_play_sound(sn_menu_adjust,1,0);
					PlayerSoundMake(sn_menu_adjust,,,false);
				}
			
				ds_list_destroy(_active_list);
			
				#endregion
			}
			
		}
					
		break;
		#endregion
		
		case menu_element_type.bestiary:
		#region
		
		if(mouse_check_button_pressed(mb_left))
		{
					
			var _center_of_side = (menu_line_x + gap_to_line + global.GUI_W - GUI_BOUND) / 2;
			var _enemy_x1 = _center_of_side - portrait_width/2;
			var _enemy_x2 = _center_of_side + portrait_width/2;
			if(mouse_gui_x < _enemy_x1 || mouse_gui_x > _enemy_x2)
			{
				//Arrow Pressed
				var _input = sign( mouse_gui_x - _center_of_side);
					
				element[menu_element.first_entry]+=_input;
				var _input_successful = true;
			
				#region//Safe Check
				element[@menu_element.first_entry] = clamp(element[menu_element.first_entry],0,ENEMIES.NUMBER-1);
				#endregion
			
				if(_input_successful)
				{
					//audio_play_sound(sn_menu_choose,1,false);
					PlayerSoundMake(sn_menu_choose,,,false);
				}
				//element[menu_element.value_range](element[menu_element.current_value]);
			
			}
			else
			{
				var _current_value = element[menu_element.first_entry];
				#region//Icon Pressed
				if(global.enemies[ENEMY.ACTIVE][_current_value])
				{
					BestiaryEnemyOpenFromMenu(_current_value);
				}
				PlayerSoundMake(sn_menu_adjust);
				#endregion
			}
					
			break;
			
		}
		#endregion
						
		default:
		#region				
		break;
		#endregion
	}
}
	
function MenuCancelInput(element){
	element[@ menu_element.current_value] = inputing_buffer;
	inputing = false;
	//audio_play_sound(sn_menu_back,1,0);
	PlayerSoundMake(sn_menu_back,,,false);
	enemy_input_cursor = -1;
	//current_page = previous_page;
}
	
function MenuReturnToPreviousPage(){
	if(object_index == obj_pause_menu && current_page == menu_page.main)
	{
		UnpauseGame();
	}
	else
	{
		current_page = previous_page;
		//audio_play_sound(sn_menu_back,1,0);
		PlayerSoundMake(sn_menu_back,,,false);
	}
}