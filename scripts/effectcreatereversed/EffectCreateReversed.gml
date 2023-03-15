///@arg x
///@arg y
///@arg sprite
///@arg xscale
///@arg GUI
function EffectCreateReversed(_x,_y,_sprite,_xscale,_gui = false)
{
	var _layer_name = "Effects";
	if(_gui) _layer_name = "GUI";
	var _created_effect = instance_create_layer(_x,_y,_layer_name,pobj_reversed_effect);
	with(_created_effect)
	{
		sprite_index = _sprite;
		image_index = image_number - 1;
		image_speed = -1;
		image_xscale = _xscale;
		gui_effect = _gui;
	}
	return _created_effect
}

///@arg sprite
///@arg target
///@arg xoffset
///@arg yoffset
///@arg xscale
function EffectCreateReversedTargeted(_sprite,_target,_xoffset,_yoffset,_xscale)
{
	var _created_effect = instance_create_layer(_target.x + _xoffset * _target.image_xscale,_target.y+_yoffset,"Effects",pobj_reversed_effect);
	with(_created_effect)
	{
		sprite_index = _sprite;
		image_index = image_number - 1;
		image_speed = -1;
		image_xscale = _xscale;
		attack_target_instance = _target;
		with_offset = true;
		x_offset = _xoffset;
		y_offset = _yoffset;
	}
	return _created_effect;
}