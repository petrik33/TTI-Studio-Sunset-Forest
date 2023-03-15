function HP_pick_up(picking_instance){
	if(picking_instance.current_hp<picking_instance.max_hp)
	{
		with(picking_instance)
		{
			for(var i = current_hp;i>0;i--)
			{
				hp_leaves[@ i]	= hp_leaves[i-1];
			}
			hp_leaves[@ 0] = other.image_index;
			current_hp++;
		}
		return true
	}
	else return false;
}

function attack_spd_pick_up(picking_instance){
	if(picking_instance.attack_speed = 1)
	{
		EntityBuff(
		picking_instance,
		"attack_speed",
		EFFECT_ACTION.MULTIPLY,
		1.25,
		12,
		spr_attack_speed_buff,
		0,
		0,
		sn_attack_speed_buff_step,
		spr_drop_attack_speed
		)
	}
	return true
}

function Special_pickUp_script(picking_instance) {
	var _skill_id = image_index;
	var _special_ready = false;
	with(picking_instance)
	{
		_special_ready = (skills[_skill_id][SKILL.SPECIAL_PROGRESS] == spec_stacks_needed);	
	}
	if(!_special_ready)
	{
		PlayerAccumulateSpecial(_skill_id);
		return true;
	}
	return false;
}

function movement_spd_pick_up(picking_instance){
	EntityBuff(
	picking_instance,
	"spd",
	EFFECT_ACTION.MULTIPLY,
	1.25,
	12,
	spr_speed_buff,
	-12,
	0,
	sn_default_step,
	spr_drop_movement_spd
	)
	
	return true
}

function defense_pick_up(picking_instance)
{
	with(picking_instance)
	{
		if(damage_vulnerable)
		{
			EntityGiveShield(picking_instance,18);
			return true;
		}
		else
		{
			return false;	
		}
	}
}