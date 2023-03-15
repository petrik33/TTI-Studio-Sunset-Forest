///@arg x
///@arg y
///@arg halign
///@arg valign
///@arg sprite
///@arg shade_alpha
///@arg	action
function TapButtonCreate(_x,_y,_halign = HALIGN.LEFT,_valign = VALIGN.TOP,_sprite,_shade_alpha = 0,_action,_button_key = noone){
	var _button_width = sprite_get_bbox_right(_sprite) - sprite_get_xoffset(_sprite);
	var _button_height = sprite_get_bbox_bottom(_sprite) - sprite_get_yoffset(_sprite);
	switch(_halign)
	{
		case HALIGN.CENTER:
		
		_x -= _button_width / 2;
		
		break;
		
		case HALIGN.RIGHT:
		
		_x -= _button_width;
		
		break;
		
		default:
		
		break;
	}
	
	switch(_valign)
	{
		case VALIGN.CENTER:
		
		_y -= _button_height / 2;
		
		break;
		
		case VALIGN.BOTTOM:
		
		_y -= _button_height;
		
		break;
		
		default:
		
		break;
	}
	
	var _inst = instance_create_layer(_x,_y,"GUI",pobj_tap_button);
	with(_inst)
	{
		sprite_index = _sprite;
		action = _action;
		if(_shade_alpha != 0)
		{
			low_alpha = 1 - _shade_alpha;
			image_alpha = low_alpha;
			shade_button_mode = true;
		}
		button_key = _button_key;
	}
	return _inst;
}