///@arg inst
///@arg sprite
///@arg reversed
///@arg time
///@arg xscale
function EntityCutsceneAnimate(_inst,_sprite,_reversed = false,_time = noone,_xscale = noone){
	with(_inst)
	{
		sprite_index = _sprite;
		if(!_reversed)
		{
			image_index = 0;
			image_speed = 1;
		}
		else
		{
			image_index = image_number - 1;
			image_speed = -1;
		}
		if(_time != noone)
		{
			AnimationSetLength(_sprite,_time);	
		}
		if(_xscale != noone)
		{
			InstanceRotateCentrally(_xscale,);
		}
		state = EntityStateCutsceneAnimatedEndModeBackToIdle;
	}
}