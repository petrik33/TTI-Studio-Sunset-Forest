image_angle+=4;
if(!instance_exists(target) || ++timer>=duration)
{
	instance_destroy();
	if(instance_exists(target)) 
	{
		with(target)
		{
			EntityMakeFree();
			//movement_direction = other.movement_dir_buffer;
		}
	}
}
else
{
	x = target.x + target.image_xscale * 10;
	y = target.bbox_top
}
