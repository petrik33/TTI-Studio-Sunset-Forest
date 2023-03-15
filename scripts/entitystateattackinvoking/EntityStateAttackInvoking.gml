function EntityStateAttackInvoking(){
	EntityMovement();
	var _invk_index = image_index;
	var _x = x;
	var _y = y;
	var _face = image_xscale;
	with(attack_struct)
	{
		if(attack_sprite_is_vfx)
		{
			_invk_index = attack_vfx.image_index;
		}	
		if(_invk_index >= attack_invoke_frame)
		{
			attack_cooldown = 0;
			//EntitySurge(attack_invoke_sprite,attack_invoke_object,_x + attack_x_offset * _face,_y + attack_y_offset,"Instances",_face,attack_sound);
			var _invoked = instance_create_layer(_x + attack_x_offset * _face,_y + attack_y_offset,"Instances",attack_invoke_object);
			InstanceRotateCentrally(_face,_invoked);
			if(invoke_push_effect != noone)
			{
				EntityPush(_invoked,invoke_push_effect[0],_face,invoke_push_effect[1]);
			}
			with(attack_owner)
			{
				if(!attack_struct.attack_sprite_is_vfx && floor(image_index) < image_number - 1)
				{
					state = EntityStateWindDown;
				}
				else
				{
					EntityMakeFree();	
				}
			}
		}
	}
}