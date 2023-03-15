function PlayerDash(){
	if(movement_direction == image_xscale)
	{
		dash_type = dash_types.forward;
	}
	else
	{
		dash_type = dash_types.backwards;
	}
	
	if(movement_direction == 0)
	{
		switch(dash_type)
		{
			case dash_types.forward:
			
			movement_direction = image_xscale;
			
			break;
			
			case dash_types.backwards:
			
			movement_direction = -image_xscale;
			
			break;
			
			default:
			
			movement_direction = image_xscale;
			
			break;
		}
	}
	
	sprite_index = sprite_dash[dash_type];
	image_index = 0;
	Vx = dash_speed[dash_type] * movement_direction;
	state = PlayerStateDash;
	
	PlayerSoundMake(dash_sounds[dash_type]);
	
	DustEffectOnFallCreate();
	
}

//function PlayerDashForward(){
	
//	state = PlayerStateDash;
//	movement_direction = 0;
//	Vx = dash_speed[0] * image_xscale;
//	sprite_index = spr_hero_dash_forward;
//	image_index = 0;
	
//	DustEffectOnFallCreate();
	
//}

//function PlayerDashBackwards(){
	
//	Vx = dash_speed * movement_direction;
//	state = PlayerStateDash;
//	movement_direction = 0;
	
//	sprite_index = spr_hero_dash;
//	image_index = 0;
	
//	DustEffectOnFallCreate();
	
//}