function EntityStateJumpAttack(){
	
 	#region//Movement
	
	Vy+=_gravity;
	
	if(EntityCollision())
	{
		Vx = 0;
		Vy = 0;
		EntityMakeFree();
		exit;
	}
	
	#endregion
	
	#region//Animation
	
	if(AnimationEnd())
	{
		image_speed = 0;	
	}
	
	#endregion
	
	#region//Attacking
	
	var _inst_attacked = instance_place(x,y,attack_struct.attack_target);
	
	if(_inst_attacked!=noone)
	{
		var _hit_list = attack_struct.hit_by_attack;
		if(ds_list_find_index(_hit_list,_inst_attacked) = -1)
		{	
			ds_list_add(_hit_list,_inst_attacked);
			EntityDamage(_inst_attacked,image_xscale);
			EffectCreateOnTarget(attack_struct.attack_hit_effect,image_xscale,_inst_attacked,false);
		}
	}
	
	#endregion
	
}