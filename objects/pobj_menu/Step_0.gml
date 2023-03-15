/// @description Menu Control
if(menu_active)
{
	var element = menu_pages[current_page][page_cursors[current_page]];

	#region//Mouse Data

	mouse_gui_y = device_mouse_y_to_gui(0);
	mouse_gui_x = device_mouse_x_to_gui(0);

	mouse_moved = (mouse_gui_x!=mouse_previous_x) || (mouse_gui_y!=mouse_previous_y)

	#region//Mouse Movement Update
	mouse_previous_x = mouse_gui_x;
	mouse_previous_y = mouse_gui_y;
	#endregion

	#endregion

	#region//Menu Navigation

	#region//Keyboard Control

	if(!inputing) 
	{
		MenuKeyNavigation();
	}
	else
	{
		MenuKeyInput(element);
	}

	#endregion
	
	MenuMouseControl(mouse_gui_x,mouse_gui_y,mouse_moved,element);

	#endregion

	#region//Return to the Previous Page / Cancel Input
	if(keyboard_check_pressed(vk_escape))
	{	
		if(inputing)
		{
			MenuCancelInput(element)
		}
		else
		{
			MenuReturnToPreviousPage();
		}
	}
	#endregion

	#region//Input with Enter Key

	if(keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space))
	{
		MenuInputLeftSide(element);
	}
	#endregion
}


