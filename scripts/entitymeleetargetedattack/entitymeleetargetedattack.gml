function EntityMeleeTargetedAttack(){
	
	EntityMovement();
	
	with(attack_struct)
	{
		#region//Proceed Attack
		
		with(attack_vfx)
		{
			var _hit_list = ds_list_create();
			var _entities_hit = instance_place_list(x,y,other.attack_target,_hit_list,false);
			for(var i = 0;i<_entities_hit;i++)
			{
				var _entity_hit = _hit_list[| i];
				if(ds_list_find_index(other.attack_hit_list,_entity_hit)=-1)
				{
					ds_list_add(other.attack_hit_list,_entity_hit);
					other.attack_on_hit(_entity_hit,image_xscale);
					if(other.attack_push_effect != noone)
					{
						EntityPush(
							_entity_hit,
							other.attack_push_effect[Push_Effect_enum.speed],
							//sign(cos(degtorad(image_angle))),
							image_xscale,
							other.attack_push_effect[Push_Effect_enum.angle]
						);
					}	
					with(EffectCreateOnTarget(other.attack_hit_effect,image_xscale,_entity_hit,false))
					{
						image_angle = other.image_angle;	
					}
				}
			}
			ds_list_destroy(_hit_list);
		}
		
		#endregion
		
		#region//End Attack
		
		if(!instance_exists(attack_vfx))
		{
			ds_list_clear(attack_hit_list);
			with(attack_owner) EntityMakeFree();
			attack_cooldown = 0;	
		}
		
		#endregion
		
	}
}