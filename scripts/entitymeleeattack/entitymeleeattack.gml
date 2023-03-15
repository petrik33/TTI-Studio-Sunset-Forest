function EntityMeleeAttack(){
	
	EntityMovement();
	
	#region//Proceed Attack
	var _previous_mask = mask_index;
	mask_index = attack_struct.attack_hit_box;
	var _hit_list = ds_list_create();
	var _entities_hit = instance_place_list(x,y,attack_struct.attack_target,_hit_list,false);
	for(var i = 0;i<_entities_hit;i++)
	{
		var _entity_hit = _hit_list[| i];
		if(ds_list_find_index(attack_struct.attack_hit_list,_entity_hit)=-1)
		{
			ds_list_add(attack_struct.attack_hit_list,_entity_hit);
			attack_struct.attack_on_hit(_entity_hit,image_xscale);
			if(attack_struct.attack_push_effect != noone)
			{
				EntityPush(
					_entity_hit,
					attack_struct.attack_push_effect[Push_Effect_enum.speed],
					image_xscale,
					attack_struct.attack_push_effect[Push_Effect_enum.angle]
				);
			}	
			EffectCreateOnTarget(attack_struct.attack_hit_effect,image_xscale,_entity_hit,false);
		}
	}
	
	ds_list_destroy(_hit_list);
	mask_index = _previous_mask;
	#endregion
	
	#region//End Attack
	var _end_attack = false;
	if(!attack_struct.attack_sprite_is_vfx)
	{
		if(AnimationEnd())
		{
			_end_attack = true;
		}
	}
	else
	{
		if(!instance_exists(attack_struct.attack_vfx))
		{
			_end_attack = true;	
		}
	}
	if(_end_attack)
	{
		ds_list_clear(attack_struct.attack_hit_list);
		EntityMakeFree();
		attack_struct.attack_cooldown = 0;	
	}
	#endregion
	
}