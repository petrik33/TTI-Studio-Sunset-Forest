///@arg side
///@arg inst
function InstanceRotateCentrally(_side,_inst = self){
	with(_inst)
	{
		if(_side != image_xscale)
		{
			var _offset = SpriteBBoxOffset(sprite_index,0);
			x += _offset * 2 * image_xscale;
			image_xscale = -image_xscale;
		}
		//else
		//{
		//	image_xscale = argument[1];//Side	
		//}
	}
}