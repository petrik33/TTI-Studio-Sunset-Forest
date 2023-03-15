function EntityStateShieldForming(){
	EntityMovement();
	var _shielding_frame = attack_struct.attack_shielding_frame;
	if(AnimationEnd())
	{
		var _shield_invoke_time = AnimationGetFrameLength(sprite_index,image_number - 1 - _shielding_frame);
		with(attack_struct)
		{
			attack_cooldown = 0;
			
			AnimationSetLength(attack_shield_invk_sprite,_shield_invoke_time/FRAME_RATE);
			EffectCreateOnTarget(attack_shield_invk_sprite,other.image_xscale,other,false);
		}
		entity_shield_flash_sprite = attack_struct.attack_shield_flash_sprite;
		entity_shield_duration_left = attack_struct.attack_shield_duration;
		entity_shield_alpha = 1;
		entity_shield_alpha_anim_progress = 0;
		entity_shield_sprite = attack_struct.attack_shield_sprite;
		entity_shield_xoffset = attack_struct.attack_x_offset;
		entity_shield_yoffset = attack_struct.attack_y_offset;
		with(obj_boss_manager)
		{
			BossManagerInitializeShield(_shield_invoke_time,other.entity_shield_duration_left);
		}
		alarm[7] = _shield_invoke_time; // "entity_shielded = true" set
		EntityWindDown();
	}
}