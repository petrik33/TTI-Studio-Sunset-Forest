function PlayerSendDMToCandle(){
	var _needed_candle = noone;
	var _part_x = x + DM_send_xoffset * image_xscale;
	var _part_y = y + DM_send_yoffset;
	if(image_xscale == 1)
	{
		_needed_candle = global.rightCandle;	
	}
	else
	{
		_needed_candle = global.leftCandle;	
	}
	with(instance_create_layer(_part_x,_part_y,"Effects",obj_dark_matter_particle))
	{
		target = _needed_candle;
		target_y_offset = (target.bbox_top - target.bbox_bottom)/2;
	}
	dark_matter_target = max(dark_matter_target - 2,0);
}