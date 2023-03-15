///@arg inst
///@arg barrier
function InstanceBehindBarrier(_inst,_barrier = self){
	with(_barrier)
	{
		var _edge_x = x;
		var _edge_side = -image_xscale;
		with(_inst)
		{
			var _offset = SpriteBBoxOffset(sprite_index,_edge_side * image_xscale) * image_xscale;
			var _vec = x + _offset - _edge_x;
			return (sign(_vec) == _edge_side)
		}	
	}
}