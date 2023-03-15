function StrikeCreate(_x,_y,_image_xscale,_object){
	with(instance_create_layer(_x,_y,"Effects",_object))
	{
		image_xscale = _image_xscale;
	}	
}

function EntityStrikingAttack(){
	with(attack_struct)
	{
		if(attack_charge_count == attack_worry_delay_target)
		{
			AttackPlayerWorry();
			if(instance_exists(attack_target))
			{
				attack_strike_x = attack_target.x;
			}
		}
		if(++attack_charge_count >= attack_charge_target)
		{
			#region//Shoot
				
			attack_cooldown = 0;
			attack_charge_count = 0;
				
			for(var i = 0;i < attack_strikes_num;i++)
			{
				if(instance_exists(attack_target))
				{
					StrikeCreate(attack_strike_x,FLOOR_Y,attack_owner.image_xscale,attack_striking_object);
				}
			}	
			#endregion
			with(attack_owner)
			{
				EntityMakeFree();
			}
		}
	}
}