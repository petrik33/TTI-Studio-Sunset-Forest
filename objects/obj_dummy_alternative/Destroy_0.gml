event_inherited();
if(revive)
{
	var _reviveX = x;
	var _reviveY = y;
	var _revive_asset = obj_dummy_death_alternative;
	if(dummyWalking)
	{
		if(instance_exists(global.dummy_pole_inst))
		{
			_reviveX = global.dummy_pole_inst.x;
			_reviveY = FLOOR_Y + dummy_yoffset;
		}
		_revive_asset = obj_dummy_revive_alternative;
		if(dummy_target != noone)
		{
			//Died Before Reaching Target
			ds_queue_enqueue(global.dummy_targets_queue,dummy_target);
		}
	}
	//else
	//{
		with(instance_create_layer(_reviveX,_reviveY,"Instances",_revive_asset))
		{
			image_angle = other.image_angle;
			dying_angle_speed = other.angle_speed;
		}
	//}
	
}


