function AttackStrike(){
	with(attack_owner)
	{
		sprite_index = other.attack_sprite;
		image_index = 0;
		state = EntityStrikingAttack;
		emitter_sound(attack_struct.attack_sound,false);
	}
}

function AttackInvokeExecute(){
	if(!attack_sprite_is_vfx)
	{
		with(attack_owner)
		{
			movement_direction = 0;
			sprite_index = other.attack_sprite;
			image_index = 0;
		}
	}
	else
	{
		attack_vfx = EffectCreateOnTargetOffset(attack_sprite,attack_owner.image_xscale,attack_owner,attack_x_offset,attack_y_offset,false);
		attack_vfx.pause_effect = true;
	}
	with(attack_owner)
	{
		state = EntityStateAttackInvoking;
		emitter_sound(attack_struct.attack_sound);
	}
}