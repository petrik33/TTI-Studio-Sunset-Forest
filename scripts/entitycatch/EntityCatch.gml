///@arg instance
function EntityCatch(_inst){
	with(_inst)
	{
		state = EntityStateTrapped;
		Vx = 0;
		Vy = 0;
		sprite_index = sprite_pushed;
		image_index = 0;
	}
}