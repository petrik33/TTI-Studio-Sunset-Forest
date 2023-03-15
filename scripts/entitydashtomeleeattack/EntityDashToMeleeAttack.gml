function EntityDashToMeleeAttack(){
	x += Vx;
	if(AnimationEnd() || abs(x - attack_struct.attack_target_inst.x) <= attack_struct.attack_following_struct.attack_x_range)
	{
		entity_double_attack_executed = true;
		attack_struct = attack_struct.attack_following_struct;
		with(attack_struct)
		{
			AttackExecuteMelee();
		}
	}
	
	//if(Vx!=0)
	//{
	//	image_xscale = sign(Vx);
	//}
}