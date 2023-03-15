function IndicatorDisappearing(){
	if(AnimationEndReverse())
	{
		instance_destroy();
	}
	if(instance_exists(global.oPlayer) && abs(global.oPlayer.x - x) < global.seed_opening_radius)
	{
		state = IndicatorSurging;
		image_speed = 1;
	}
}