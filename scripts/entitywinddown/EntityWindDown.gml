function EntityWindDown(){
	if(image_index < image_number - 1 && object_is_ancestor(object_index,pobj_moving_entity))
	{
		state = EntityStateWindDown;
	}
	else
	{
		EntityMakeFree();
	}
}