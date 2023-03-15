function VoaStateFree(){
	if(attack_struct.attack_default_AI(attack_struct))
	{
		if(instance_exists(global.oPlayer))
		{
			var _dist = abs(global.oPlayer.x - x);
			if(_dist <= 40)
			{
				with(attack_struct) AttackPlayerWorry();	
			}
		}
	}
}