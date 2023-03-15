///@func AnimationEndReverse()
///@arg LastFrame*
function AnimationEndReverse() {
	switch(sprite_get_speed_type(sprite_index))
	{
		case spritespeed_framespersecond:
		var sprite_speed = sprite_get_speed(sprite_index) * image_speed/FRAME_RATE;
		break;
		
		case spritespeed_framespergameframe:	
		var sprite_speed = sprite_get_speed(sprite_index) * image_speed;
		break;
	}
	
	if(argument_count = 1) var sprite_last_frame = argument[0];
	else var sprite_last_frame = 0;
	
	
	return (image_index+sprite_speed<=sprite_last_frame)
	
}
