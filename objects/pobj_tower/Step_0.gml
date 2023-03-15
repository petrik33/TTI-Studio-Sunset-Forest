if(!global.game_is_paused)
{
	#region//Collision With Enemies
	if(!blown_off)
	{
		var enemy_collided = instance_place(x,y,pobj_enemy)
		if(enemy_collided!=noone)
		{
			with(enemy_collided)
			{
				drop_matter = false;
				DyingScript();	
			}
			EntityDamage(self,0);
			if(!ObjectIsVisible(self))
			{
				var _side = sign(x - global.oPlayer.x);
				if(_side == 0) _side = 1;
				var _sprite = spr_candle_damaged_flash_gradient;
				var _flash_part = shrine_candle_damaged_flash_part;
				var _dir = 55;
				var _time = FRAME_RATE * 1.5;
				FlashNotificationCreate(_sprite,_side,_flash_part,_dir,_time);
				if(!global.flash_bestiary_opened[FLASH_TYPE.CANDLE_DAMAGED])
				{
					BestiaryEnqueue(
						BESTIARY_PAGE_TYPE.FLASH_NOTIFICATION,
						[FLASH_TYPE.CANDLE_DAMAGED,Text("Bestiary: Candle Damaged Flash"),_sprite,_flash_part,_dir,_time]
					);
					global.flash_bestiary_opened[FLASH_TYPE.CANDLE_DAMAGED] = true;
				}
			}
			if(current_hp > 0)
			{
				damage_recieved = true;
				damaged_animation_progress = 0;
				sprite_index = sprite_damaged;
				image_index = 0;
			}
			find_hp_relatives();
		}
	}
	#endregion
	
	if(instance_exists(light_instance))
	{
		light_instance.y = y - hp_center_y_offset;
	}
}