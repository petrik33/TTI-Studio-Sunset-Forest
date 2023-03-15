///@arg sprite
///@arg xscale
///@arg target
///@arg xoffset
///@arg yoffset
///@arg fade_out
function EffectCreateOnTargetOffset(_sprite,_xscale,_target,_x_offset,_y_offset,_fade_out)
{
	var _x = _target.x + _x_offset * _xscale;
	var _y = _target.y + _y_offset;
	var _created_effect = instance_create_layer(_x,_y,"Effects",pobj_targeted_effect_offset)
	with(_created_effect)
	{
		sprite_index = _sprite;
		image_xscale = _xscale;
		attack_target_instance = _target;
		x_offset = _x_offset;
		y_offset = _y_offset;
		fade_out = _fade_out;
	}
	return _created_effect
}