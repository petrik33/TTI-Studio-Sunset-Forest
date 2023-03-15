function AttackPlayerWorry(){
	if(instance_exists(attack_target))
	{
		if(object_is_ancestor(attack_target.object_index,pobj_hero))
		{
			PlayerWorry();
		}
	}
}