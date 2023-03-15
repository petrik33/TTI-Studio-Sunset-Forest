///@arg inst
///@arg side
function EntityPlaceOnEdge(_inst,_side)
{
	var _edge_x = global.rightEdge;
	if(_side == -1)
	{
		_edge_x = global.leftEdge;	
	}
	with(_inst)
	{
		var _offset = SpriteBBoxOffset(sprite_index,_side * image_xscale) * image_xscale;
		x = _edge_x - _offset - _side;
	}
}

//function EntityPlaceOnRightEdge(_inst)
//{
//	with(_inst)
//	{
//		var _offset = SpriteBBoxOffset(sprite_index,1);
//		x = global.rightEdge + _offset - 1;
//	}	
//}