//function CompanionStateFree() {
//	var movement_x_target = x;

//	if(instance_exists(master)) movement_x_target = master.x + distance_to_master;

//	var difference = movement_x_target - x;
//	movement_direction = sign (difference);
//	if(abs(difference) < (Vx*Vx/decceleration_speed*1.5) || abs(difference) < spd ) movement_direction = 0;

//	if(movement_direction!=0) image_xscale = movement_direction;

//	var collided_with = EntityMovement();
	
//	#region//Animations
//	if(Vx!=0)
//	{
//		sprite_index = sprite_run;
//	}
//	else
//	{
//		sprite_index = sprite_idle;
//	}
//	#endregion
	
//	#region//Push Enemies
//	if(collided_with!=noone)
//	{
		
//		if(object_get_parent(collided_with.object_index)=pobj_enemy)
//		{
//			with(collided_with)
//			{
//				EntityPush(other.pushing_speed,other.movement_direction,other.pushing_direction)
//				var _hit_effect = other.hit_effect
//				var _hit_xscale = other.movement_direction
//				with(instance_create_layer(x,(bbox_bottom+bbox_top)/2,"Effects",pobj_effect))
//				{
//					sprite_index = _hit_effect
//					image_xscale = _hit_xscale
//					attack_target_instance = other;
//				}
//				if(object_get_parent(object_index)=pobj_enemy)
//				{
//					EntityDamage(self);
//				}
//			}
//			Vx = 0;
//		}
//	}
//	#endregion

//}
