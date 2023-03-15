///@arg sprite
///@arg left_right
function SpriteBBoxOffset(_sprite,_side){
	var _origin_x = sprite_get_xoffset(_sprite);
	if(_side == 1)
	{
		var _bbox_x = sprite_get_bbox_right(_sprite);
	}
	else
	{
		if(_side == -1)
		{
			var _bbox_x = sprite_get_bbox_left(_sprite);
		}
		else
		{
			var _bbox_x = (sprite_get_bbox_right(_sprite) + sprite_get_bbox_left(_sprite))/2;
		}
	}
	return _bbox_x - _origin_x;
}

//function SpriteBBoxLeftOffset(_sprite){
//	var _bbox_x = sprite_get_bbox_left(_sprite);
//	var _origin_x = sprite_get_xoffset(_sprite);
//	return _origin_x - _bbox_left_x;
//}

///@arg sprite
///@arg bbox
function SpriteBBoxYOffsetCenter(_sprite,_bbox = true){

	if(_bbox)
	{
		var _height = sprite_get_bbox_bottom(_sprite) - sprite_get_bbox_top(_sprite);
	}
	else
	{
		var _height = sprite_get_height(_sprite);	
	}
	var _dif = _height - sprite_get_yoffset(_sprite);
	var _y_offset = - (_height / 2 - _dif);
	
	return _y_offset;

}