function EntityDashAttack(){
	var hitted = EntityDashCollision();
	if(hitted!=noone)
	{
		EntityDamage(hitted,sign(Vx));
		EffectCreateOnTarget(attack_struct.attack_hit_effect,image_xscale,hitted,false);
		if(attack_struct.attack_push_effect!=noone)
		{
			EntityPush(
				hitted,
				attack_struct.attack_push_effect[Push_Effect_enum.speed],
				image_xscale,
				attack_struct.attack_push_effect[Push_Effect_enum.angle]
			);
		}
		EntityMakeFree();
	}
	if(AnimationEnd())
	{
		EntityMakeFree();
	}
	
	//if(Vx!=0)
	//{
	//	image_xscale = sign(Vx);
	//}
}