///@arg sprite
///@arg xscale
///@arg target
///@arg fade_out
function EffectCreateOnTarget(_sprite,_xscale,_target,_fade_out)
{
	if(!instance_exists(_target))
	{
		return noone;	
	}
	var _target_sprite = _target.sprite_index;
	var _xoffset = SpriteBBoxOffset(_target_sprite,0);
	var _yoffset = SpriteBBoxYOffsetCenter(_target_sprite,true);
	var _effect = EffectCreateOnTargetOffset(_sprite,_xscale,_target,_xoffset,_yoffset,_fade_out);
	return _effect;
}