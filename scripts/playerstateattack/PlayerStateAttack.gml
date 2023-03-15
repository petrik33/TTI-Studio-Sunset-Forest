function PlayerStateAttack(){
	
	#region//Controls

	#region//Movement Controls
	var key_right = ( keyboard_check(vk_right) || keyboard_check(ord("D")) ); 
	var key_left = ( keyboard_check(vk_left) || keyboard_check(ord("A")) );
	#endregion

	#endregion

	#region//Movement

	movement_direction = key_right - key_left;

	spd*=hero_in_attack_spd_factor;
	EntityMovement();
	spd/=hero_in_attack_spd_factor;

	#endregion

	PlayerGatherBufferInput();

	#endregion

	PlayerAttackProceed();

	#region//End State

	if(AnimationEnd())
	{
		EntityMakeFree();
		ds_list_clear(hit_by_attack);
		hero_attack_counter++;
		current_attack_HB = noone;
	}
	#endregion

	#region//Animation
	if(Vx!=0)
	{
		if(!keyboard_check(global.backwards_control))
		{
			InstanceRotateCentrally(sign(Vx),);
		}
	}
	#endregion
}
