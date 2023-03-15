///@arg height
///@arg time
function CreateBlackBars(_height,_time){
	with(instance_create_layer(0,0,"Managers",obj_black_bars))
	{
		black_bar_target_h = _height;
		come_up_spd = 1 / (_time * FRAME_RATE);
	}
}

///@arg time
function HideBlackBars(_time){
	with(obj_black_bars)
	{
		come_up_spd = 1 / (_time * FRAME_RATE);
		come_down = true;
	}
}