/// @description Transition Progress
if(transition_running)
{
	if(transition_timer != (transition_time * FRAME_RATE))
	{
		transition_timer++;
		var skip_button = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_escape);
		var _transition_progress = transition_timer / (transition_time * FRAME_RATE);
		if(skip_button)
		{
			_transition_progress = 1;
			transition_timer = (transition_time * FRAME_RATE);
		}
		if(transition_direction = 1)
		{
			transition_alpha = _transition_progress;//Fade In
		}
		else
		{
			transition_alpha = 1 - _transition_progress;//Fade Out
		}
	}
	else
	{
		transition_timer = 0;
		if(transition_direction = 1)
		{
			transition_direction = -1;
			current_logo++;
		}
		else
		{
			transition_running = false;
		}
	}
}
else
{
	logo_timer++;
	var skip_button = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_escape);
	if(skip_button)
	{
		logo_timer = (logo_time * FRAME_RATE);
	}
	if(logo_timer == (logo_time * FRAME_RATE))
	{
		if(current_logo + 1 = array_length(intro_logos))
		{
			FadeInRoomNext(transition_time)
		}
		else
		{
			transition_running = true;
			transition_direction = 1;
			logo_timer = 0;
		}
	}
}