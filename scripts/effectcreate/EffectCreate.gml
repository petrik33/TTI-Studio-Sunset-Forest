///@arg x
///@arg y
///@arg sprite
///@arg xscale
///@arg fade_out
///@arg GUI
function EffectCreate(_x,_y,_sprite,_xscale,_fade_out,_gui = false)
{
	var _layer_name = "Effects";
	if(_gui) _layer_name = "GUI";
	var _created_effect = instance_create_layer(_x,_y,_layer_name,pobj_effect);
	with(_created_effect)
	{
		sprite_index = _sprite;
		image_xscale = _xscale;
		fade_out = _fade_out;
		gui_effect = _gui;
	}
	return _created_effect
}