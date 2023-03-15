function PlayerGatherBufferInput(){
	if(input_buffered == noone)
	{
		var _attack = mouse_check_button_pressed(mb_left) || (global.alternative_controls_on && keyboard_check_pressed(alternative_controls[alternative_key.attack]));
		var _push = mouse_check_button_pressed(mb_right) || (global.alternative_controls_on && keyboard_check_pressed(alternative_controls[alternative_key.push]));
		
		var _dash = keyboard_check_pressed(vk_shift);
		//var _dodge = (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down));
		
		if(_dash)
		{
			input_buffered = input_buffer_type.dash;
		}
		
		//if(_dodge)
		//{
		//	input_buffered = input_buffer_type.dodge;	
		//}
	
		if(_attack)
		{
			input_buffered = input_buffer_type.attack;
		}
		if(_push)
		{
			input_buffered = input_buffer_type.push;
		}
	} 
}