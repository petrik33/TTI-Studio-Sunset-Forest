var cancel_button_pressed = keyboard_check_pressed(vk_escape);
if(cancel_button_pressed)
{
	CreditsEnd(0.1);
}

skip_button = (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter));

state();