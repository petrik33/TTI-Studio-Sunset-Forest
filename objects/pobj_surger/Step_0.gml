if(AnimationEnd())
{
	var _inst = instance_create_layer(x,y,layer,object_to_surge);
	with(_inst)
	{
		image_xscale = other.image_xscale;	
	}
	instance_destroy();
}
