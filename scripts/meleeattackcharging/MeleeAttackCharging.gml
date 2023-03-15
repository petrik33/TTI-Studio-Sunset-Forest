function MeleeAttackCharging(){
	var x_difference = 0;
	with(attack_struct)
	{
		if(!attack_automatic && ++attack_worry_delay == attack_worry_delay_target)
		{
			AttackPlayerWorry();	
		}
		if(instance_exists(attack_target_inst))
		{
			x_difference = attack_target_inst.x - other.x
		}
		else
		{
			with(attack_owner) EntityMakeFree();
			exit;
		}
	}
	if(x_difference!=0)
	{
		InstanceRotateCentrally(sign(x_difference));
	}
	if(AnimationEnd())
	{
		with(attack_struct)
		{
			attack_charge_count++;
			if(attack_charge_count>=attack_charge_target)
			{
				charge_function();
			}
		}
	}
}