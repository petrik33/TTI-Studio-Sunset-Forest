if(!global.game_is_paused)
{
	if(--life_timer <= 0)
	{
		DyingScript();
		exit;
	}

	#region Pushing enemies out

	var _collided_with = instance_place(x,y,pobj_colliding_entity);
	if(_collided_with != noone)
	{
		var _collided_object = _collided_with.object_index;
		if(!object_is_ancestor(_collided_object,pobj_hero))
		{
			var _side = -sign(_collided_with.Vx);
			if(_side == 0)
			{
				_side = -EnemyFindMovementDirection();	
			}
			if(_collided_with.push_vulnerable)
			{
				if(_collided_with.object_index != obj_dummy_alternative)
				{
					switch(_side)
					{
						case 1:

						_collided_with.x = bbox_right - SpriteBBoxOffset(_collided_with.sprite_index,-_collided_with.image_xscale) * _collided_with.image_xscale;
					
						break;
					
						case -1:
					
						_collided_with.x = bbox_left - SpriteBBoxOffset(_collided_with.sprite_index,_collided_with.image_xscale) * _collided_with.image_xscale;
					
						break;
					}
				}
				if(object_is_ancestor(_collided_object,enemy_parent))
				{
					if(_collided_object == obj_walking_dummy)
					{
						ds_list_add(global.dummy_targets_list,id);
						if(!_collided_with.transform_back)
						{
							_collided_with.transform_back = true;
						}
					}
					if(_collided_with.object_index == obj_dummy_alternative)
					{
						DummyWalkingRemoveTarget(id);	
					}
					EntityDamage(_collided_with,_side,true);
					EffectCreateOnTarget(spr_firewall_vfx,_side,_collided_with,false);
				}
			}
			EntityPush(_collided_with,pushing_speed,_side,pushing_direction);
			if(object_is_ancestor(_collided_object,pobj_boss))
			{
				DyingScript();
				audio_stop_sound(global.firewall_sound);
			}
		}
	}

	#endregion
}
