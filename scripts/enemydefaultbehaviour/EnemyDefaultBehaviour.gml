function EnemyDefaultBehaviour(){
	EntityMovement();
	if(Vx!=0)
	{
		InstanceRotateCentrally(sign(Vx));
		sprite_index = sprite_run;
	}
	attack_struct.attack_default_AI(attack_struct);
}