///@func AnimationGetFrameLength
///@arg sprite
///@arg frames_number*
function AnimationGetFrameLength(_sprite){
	
	var frames_number = sprite_get_number(_sprite);
	if(argument_count>1) frames_number = argument[1];
	
	var spr_spd = sprite_get_speed(_sprite);
	
	var spr_spd_type = sprite_get_speed_type(_sprite);
	if(spr_spd_type = spritespeed_framespersecond)
	{
		spr_spd /= FRAME_RATE;
	}
	
	return ceil(frames_number/spr_spd);
}