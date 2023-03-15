state();
skip_button = (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left));
//Full Skip
if(keyboard_check(vk_escape))
{
	full_skip_counter++
	if(full_skip_counter == full_skip_time)
	{
		state = StateTransitionIn;
		full_skip = true;
	}
}
else
{
	if(full_skip_counter>0) full_skip_counter--;	
}