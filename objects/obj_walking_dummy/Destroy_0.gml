event_inherited();
if(state != DummyStateTransformBack)
{
	with(instance_create_layer(global.dummy_pole_inst.x,global.dummy_pole_inst.y,"Instances",obj_dummy_revive_alternative))
	{
		image_angle = 0;
	}
}
