///@arg LastFrame
function AnimationEnd(sprite_last_frame = image_number) {
	switch(sprite_get_speed_type(sprite_index))
	{
		case spritespeed_framespersecond:
		var sprite_speed = sprite_get_speed(sprite_index) * image_speed/FRAME_RATE;
		break;
		
		case spritespeed_framespergameframe:	
		var sprite_speed = sprite_get_speed(sprite_index) * image_speed;
		break;
	}
	
	
	return (image_index+sprite_speed>=sprite_last_frame)
}
