draw_self();

#region Shield

if(entity_shielded)
{
	if(!entity_shield_flash)
	{
		draw_sprite_ext(
			entity_shield_sprite,
			0,
			x + entity_shield_xoffset * image_xscale,
			y + entity_shield_yoffset,
			image_xscale,image_yscale,
			0,
			c_white,
			entity_shield_alpha
		);
	}
	else
	{
		var _flash_progress = ++entity_shield_flash_time_progress / entity_shield_flash_time;
		var _img_idx = _flash_progress * (sprite_get_number(entity_shield_flash_sprite) - 1);
		draw_sprite_ext(
			entity_shield_flash_sprite,
			_img_idx,
			x + entity_shield_xoffset * image_xscale,
			y + entity_shield_yoffset,
			image_xscale,image_yscale,
			0,
			c_white,
			entity_shield_alpha
		);
		if(_flash_progress == 1)
		{
			entity_shield_flash = false;	
		}
	}
	if(entity_shield_anim_channel != noone)
	{
		entity_shield_alpha = animcurve_channel_evaluate(entity_shield_anim_channel,entity_shield_alpha_anim_progress) * entity_shield_max_alpha;
		entity_shield_alpha_anim_progress += entity_shield_alpha_anim_spd;
		if(entity_shield_alpha_anim_progress >= 1)
		{
			entity_shield_alpha_anim_progress = 1;
			entity_shield_alpha = animcurve_channel_evaluate(entity_shield_anim_channel,1) * entity_shield_max_alpha;
			entity_shield_alpha_anim_progress = 0;
			if(!entity_shield_anim_cycling)
			{
				entity_shield_anim_channel = noone;
			}			
		}	
	}
}

#endregion

if(!global.game_is_paused)
{
	
	if(entity_shielded)
	{
		if(--entity_shield_duration_left <= 0 && state == state_free)
		{
			EntityShieldDisappear(entity_shield_death_time);
			BossMakeInviolable();
			entity_shielded = false;
			alarm[4] = entity_shield_death_time; // Surge New HP
		}
	}
	else
	{
		if(boss_hp_alive)
		{
			if(boss_damaged)
			{
				var _damage = boss_current_state_max_hp - current_hp;
				var _target_index = _damage / boss_current_state_max_hp * boss_current_hp_img_num;
				boss_hp_img_index += boss_current_hp_img_spd;
				if(boss_hp_img_index >= _target_index)
				{
					boss_hp_img_index = _target_index;
					boss_damaged = false;
					if(current_hp == 0)
					{
						EffectCreateOnTargetOffset(boss_current_hp_death_sprite,image_xscale,self,boss_current_hp_xoffset,boss_current_hp_yoffset,false);
						boss_hp_alive = false;
					}
				}
			}
			if(global.boss_manager.boss_gui_display)
			{
				draw_sprite(boss_current_hp_sprite,boss_hp_img_index,x+boss_current_hp_xoffset*image_xscale,y+boss_current_hp_yoffset);
			}
		}	
	}
}