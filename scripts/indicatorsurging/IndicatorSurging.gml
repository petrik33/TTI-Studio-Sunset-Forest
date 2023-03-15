function IndicatorSurging(){
	if(AnimationEnd())
	{
		image_index = 0;
		sprite_index = sprite_idle;
		state = state_free;
	}
	if(!instance_exists(global.oPlayer) || abs(global.oPlayer.x - x) > global.seed_opening_radius)
	{
		state = IndicatorDisappearing;
		sprite_index = sprite_surging;
		image_speed = -1;
	}
}