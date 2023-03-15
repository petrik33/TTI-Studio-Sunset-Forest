if(!global.game_is_paused && barrier_working)
{
	var _edge_x = x;
	var _edge_side = -image_xscale;
	var _collided = false;
	with(pobj_moving_entity)
	{
		var _offset = SpriteBBoxOffset(sprite_index,_edge_side * image_xscale) * image_xscale;
		var _vec = x + _offset - _edge_x;
		if(sign(_vec) == _edge_side)
		{
			//Behind the edge
			if(object_is_ancestor(object_index,pobj_alive_entity))
			{
				EntityPlaceOnEdge(self,_edge_side);
				if(state == PlayerStateThunderForm)
				{
					PlayerLeaveThunderForm();	
				}
				Vx = 0;
			}
			else
			{
				if(object_is_ancestor(object_index,pobj_projectile))
				{
					instance_destroy();
				}
			}
			_collided = true;
		}
	}
	if(barrier_visible && _collided)
	{
		WallBarrierFlash();
	}
}