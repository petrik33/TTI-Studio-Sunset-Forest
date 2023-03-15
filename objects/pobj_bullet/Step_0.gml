if(!global.game_is_paused)
{
	event_inherited();

	#region//Collisions
	var _inst_hit = BulletCollision();
	if(_inst_hit!=noone && _inst_hit != shooter_id)
	{
		var _obj_id = _inst_hit.object_index;
		if(!object_is_ancestor(_obj_id,pobj_wave))
		{
			var _target_hit = object_is_ancestor(_obj_id,enemy_parent);
			if(!non_enemy_pass || _target_hit)
			{
				var _hit_angle = image_angle;
				var hit_xscale = image_xscale;
		
				death_sound_play();
		
				if(hit_effect != noone)
				{			
					if(object_is_ancestor(_inst_hit.object_index,pobj_alive_entity))
					{
						#region//Create Hit Effect
						with(EffectCreateOnTarget(hit_effect,hit_xscale,_inst_hit,false))
						{
							image_angle = _hit_angle;	
						}
						#endregion
					}
					else
					{
						//Hitting Other Bullet
						with(EffectCreate(x,y,hit_effect,hit_xscale,false))
						{
							image_angle = _hit_angle;	
						}
						with(_inst_hit)
						{
							if(hit_effect != noone)
							{
								if(object_is_ancestor(_obj_id,pobj_bullet))
								{
									with(EffectCreate(x,y,hit_effect,image_xscale,false))
									{
										image_angle = other.image_angle;	
									}
								}
							}
							instance_destroy();
						}
					}
				}
			
				#region//Hitting the Target
				if(_target_hit)
				{
					on_hit_script(_inst_hit,sign(cos(degtorad(image_angle))),magical_damage);
					target_hit = true;
					if(push_effect != noone)
					{
						EntityPush(_inst_hit,push_effect[0],sign(Vx),push_effect[1]);
					}	
				}
				#endregion
			
				instance_destroy();
			}
		}
	}
	#endregion

	BulletAnimation();

	#region//Light
	
	BulletAttachedLightUpdate();
	#endregion
	
}