function AttackRangedShoot(){
	attack_charge_count = 0;
	attack_worry_delay = 0;
	//attack_direction = noone;
	with(attack_owner)
	{
		var _dist = other.attack_target_inst.x - x;
		if(_dist!=0)
		{
			InstanceRotateCentrally(sign(_dist),self);
		}
		
		movement_direction = 0;
		
		state = RangedAttackWindUp;
			
		if(attack_struct.attack_sprite_is_VFX)
		{
			with(other)
			{
				var _face = attack_owner.image_xscale;
				attack_vfx = EffectCreateOnTargetOffset(attack_sprite,_face,attack_owner,attack_x_offset,attack_y_offset,false);
				if(attack_vfx != noone) attack_vfx.pause_effect = true;
				if(attack_vfx_targeted)
				{
					var _target_x = attack_target_inst.x;
					var _target_y = attack_target_inst.y;
					with(attack_vfx)
					{
						var _attack_dir = point_direction(x,y,_target_x,_target_y);
						if(image_xscale == -1)
						{
							image_angle = _attack_dir - 180;
						}
						else
						{
							image_angle = _attack_dir;	
						}
					}
				}
			}
		}
		else
		{
			sprite_index = other.attack_sprite;
			image_index = 0;
		}
		
		//var _windup_sound = attack_struct.attack_windup_sound;
		//if(_windup_sound!=noone)
		//{
		//	emitter_sound(_windup_sound,false);	
		//}
		
		if(audio_is_playing(step_sound))
		{
			audio_pause_sound(step_sound);	
		}
	}
}