if(!global.game_is_paused)
{
	if(!activated)
	{
		if(++life_timer <= life_time)
		{
			if(activation_gap_timer>=activation_gap)
			{
				//var _inst_on_trap = instance_place(x,y,pobj_hitable);
				var _inst_on_trap = collision_rectangle(x-4,y-51,x+4,y,pobj_hitable,false,false);
				if(_inst_on_trap!=noone)
				{
					IceTrapActivate(_inst_on_trap);
					IceTrapTargetSlowDown(_inst_on_trap);
				}
			}
			else
			{
				activation_gap_timer++;	
			}
		}
		else
		{
			IceTrapMelt();	
		}
	}
	else
	{
		if(--activation_timer == 0)
		{
			with(spike_effect)
			{
				var _inst_hit_list = ds_list_create();
				var _inst_hit_num = instance_place_list(x,y,pobj_hitable,_inst_hit_list,false);
				for(var i = 0; i < _inst_hit_num; i++)
				{
					var _inst_hit = _inst_hit_list[| i];
					if( other.hit_effect != noone)
					{
						EffectCreateOnTarget(other.hit_effect,_inst_hit.image_xscale,_inst_hit,false);
					}
					if(_inst_hit.object_index == obj_dummy_alternative)
					{
						DummyWalkingRemoveTarget(other.id);
					}
					EntityDamage(_inst_hit,0,true);
					PlayerSpecialAddProgress(SKILLS.ICE_TRAP);
				}
				ds_list_destroy(_inst_hit_list);
			}
			activated = false;
			//if(AnimationEnd())
			//{
			//	sprite_index = sprite_idle;
			//	image_index = 0;
			//	activated = false;
			//	activated_and_hit = false;
			//	activation_gap_timer = 0;
			//}
		}
	}
}

if(surging && AnimationEnd())
{
	image_index = 0;
	sprite_index = sprite_idle;
	surging = false;
}
