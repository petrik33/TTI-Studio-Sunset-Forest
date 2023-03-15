function IndicatorStateFree(){
	if(instance_exists(global.oPlayer) && abs(global.oPlayer.x - x) > global.seed_opening_radius)
	{
		state = IndicatorDisappearing;
		sprite_index = sprite_surging;
		image_index = image_number - 1;
		image_speed = -1;
	}
}