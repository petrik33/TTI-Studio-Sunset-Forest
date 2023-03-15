///@arg instance
///@arg side
///@arg magical
function EntityDamage(_target,_side,_magical = false)
{
	with(_target)
	{
		if(damage_vulnerable)
		{
			current_hp--;
			if(object_index == obj_player)
			{
				if(player_shielded || state == PlayerStateThunderForm)
				{
					current_hp++;
					with(obj_defense_barrier)
					{
						ShieldRemove();	
					}
					return false;
				}
			}
			if(object_is_ancestor(object_index,pobj_boss))
			{
				BossReceiveDamage();
			}
			else
			{
				if(object_is_ancestor(object_index,pobj_hitable))
				{
					with(global.oPlayer)
					{
						last_hitted = other;
					}
					EnemySpillBloodParticles(_side);
					enemy_flash_time_left = enemy_flash_time_length;
					enemy_flashing = true;
					//attacked_timer += FRAME_RATE * 4;
					//flash = 1;
				}
			}
			
			if(current_hp<=0)
			{
				DyingScript();
			}
			else
			{
				emitter_sound(hit_sound,false);
				if(object_index == obj_player)
				{
					CameraShake(random_range(12,20),random_range(FRAME_RATE * 0.4,FRAME_RATE * 0.6));	
				}
				if(state = EntityStateFrozen)
				{
					EntityMakeFree();	
				}
			}
		}
		else
		{
			if(object_index == obj_ruga)
			{
				
				if(state != RugaStateWeakFree && state != RugaStateWeakTransition)
				{
					if(_magical)
					{
						current_hp--;
						with(global.oPlayer) last_hitted = other;
						EnemySpillBloodParticles(_side);
						if(current_hp<=0)
						{
							DyingScript();
						}
						else
						{
							emitter_sound(hit_sound,false);
						}
						RugaGetDamage(false);
					}
					else
					{
						ruga_avoided_damage = true;
					}
				}
			}
		}
	}
	if(_magical)
	{
		return true;	
	}
}
