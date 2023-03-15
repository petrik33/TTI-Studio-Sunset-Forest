function DouhtaStateFree(){
	EntityMovement();
	if(Vx!=0)
	{
		InstanceRotateCentrally(sign(Vx));
		sprite_index = sprite_run;
	}
	if(attack_struct.attack_default_AI(attack_struct))
	{
		x += image_xscale * douhta_attack_xoffset;
	}
}
