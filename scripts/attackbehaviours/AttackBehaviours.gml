///@arg attack_struct
function AttackJumpingDefaultBehaviour(_attack){
	var _return = false;
	with(_attack)
	{
		if(attack_cooldown_function())
		{
			attack_target_inst = range_function();
			if(attack_target_inst!=noone)
			{
				if(FLOOR_Y - attack_owner.y <= 1)//Check Grounded
				{
					attack_function();
					AttackPlayerWorry();
					_return = true;
				}
			}
		}
	}
	return _return;
}

///@arg attack_struct
function AttackDefaultBehaviour(_attack){
	var _return = false;
	with(_attack)
	{
		if(attack_cooldown_function())
		{
			attack_target_inst = range_function();
			if(attack_target_inst!=noone)
			{
				if(attack_function())
				{
					_return = true;	
				}
				//if(!attack_no_auto_worry)
				//{
				//	AttackPlayerWorry();	
				//}
			}		
		}
	}
	return _return;
}

///@arg attack_struct
function AttackRangelessDefaultBehaviour(_attack){
	var _return = false;
	with(_attack)
	{
		if(attack_cooldown_function())
		{
			attack_function();
			_return = true;		
		}
	}
	return _return;	
}

///@arg attack_struct
function AttackGetDefaultBehaviour(_attack){
	switch(_attack.attack_type)
	{
		case ATTACK_TYPE.STRIKING:
		case ATTACK_TYPE.INVOKING:
		case ATTACK_TYPE.SHIELDING:
		case ATTACK_TYPE.VOA_LIKE:
		return AttackRangelessDefaultBehaviour;
		break;
			
		case ATTACK_TYPE.RANGED:
		case ATTACK_TYPE.DASH:
		case ATTACK_TYPE.MELEE:
		case ATTACK_TYPE.MELEE_TARGETED:
		return AttackDefaultBehaviour;
		break;
			
		case ATTACK_TYPE.JUMPING:
		return AttackJumpingDefaultBehaviour;	
		break;
			
		default:
		
		return noone;
		
		break;
	}
}