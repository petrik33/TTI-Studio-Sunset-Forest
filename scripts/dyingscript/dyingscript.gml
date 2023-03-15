function DyingScript() {
	if(!object_is_ancestor(object_index,pobj_boss) || boss_final_death)
	{
		death_sound_play();
		if(object_index != obj_candle_tower)
		{
			if(sprite_death!=noone)
			{
				with(instance_create_layer(x,y,layer,pobj_effect))
				{
					sprite_index = other.sprite_death;
					image_xscale = other.image_xscale;
					fade_out = other.faded_death;
				}
			}
			instance_destroy();
		}
		else
		{
			#region Candle Dying Script
			
			CandleWavingBlowDown();
			
			blown_off = true;
			
			sprite_index = spr_tower_destroy;
			image_index = 0;
			
			//Make Candle Fire Light Down Synched
			var anim_time = AnimationGetFrameLength(sprite_index) + 3; // 3 is just buffer time
			var fire_sprite = spr_candle_fire_lightdown;
			var img_num = sprite_get_number(fire_sprite);
			sprite_set_speed(fire_sprite,img_num/anim_time,spritespeed_framespergameframe);
			CandleFireUpdateSprite(fire_sprite);
			
			StaticLightDestroy(anim_time);
			
			state = CandleStateBlowingDown;
			
			#endregion
		}
	}
	else
	{
		#region Boss Dying Script
		
		#region Get Rid of stuns
		
		with(obj_stun)
		{
			if(target.id == other.id)
			{
				instance_destroy();
			}
		}
		
		#endregion
		
		with(global.boss_manager)
		{	
			var _fragments_sprites = boss_manager_current_fragments_sprites[1];
			var _fragments_total_num = array_length(_fragments_sprites) + 1;
			var _fragment_xscale = 1;
			var _fragment_id = 0;
		
			if(_fragments_total_num - boss_hp_fragments_left == 0)
			{
				_fragment_xscale = -1;
			}
			else
			{
				_fragment_id = boss_hp_fragments_left - 1;	
			}
			
			var _boss_killed = (--boss_hp_fragments_left <= 0);
			var _boss_is_affected = (boss_current_enum != boss_idle_form_enum);
			
			EffectCreate(fragments_ellipse_x,fragments_ellipse_y,_fragments_sprites[_fragment_id],_fragment_xscale,false,true);
			
			//with(global.oBoss)
			//{
			//	//Destroy HP
			//	EffectCreateOnTargetOffset(boss_current_hp_death_sprite,image_xscale,self,boss_current_hp_xoffset,boss_current_hp_yoffset,false);
			//	boss_hp_alive = false;
			//}
			
			if(_boss_killed)
			{
				if(!_boss_is_affected)
				{
					with(global.oBoss)
					{
						var _first_kill = (bossCurentStage == 0);
						var _last_kill = (bossCurentStage == bossStageNum-1);
						
						if(_first_kill)
						{
							BossExplosionCreate();
							SaveGame();
							alarm[2] = FRAME_RATE * 2; // Steal New Element
						}
						
						if(_last_kill)
						{
							alarm[6] = FRAME_RATE * 1.5; // Final Death	
							BestiaryButtonHide();
							MusicStop();
						}
					}
				}
				else
				{
					with(global.oBoss)
					{
						//Drop Crystal
						alarm[5] = AnimationGetFrameLength(boss_current_hp_death_sprite) + AnimationGetFrameLength(boss_current_hp_sprite);
					}			
				}
				
				global.pause_available = false;
				with(global.oBoss)
				{
					BossMakeInviolable();
					bossCurentStage++;	
					global.boss_manager.bossCurentStage++;
				}
			}
			else
			{
				with(global.oBoss)
				{
					BossMakeInviolable();
					var _drop = EnemyDropItem();
					
					if(_boss_is_affected)
					{
						//Make Sure Special Stack matches the stolen Element
						if(_drop.object_index == obj_drop_special_fragment)
						{
							//while(_drop.image_index == global.boss_manager.boss_current_enum)
							//{
							//	_drop.image_index = irandom(SKILLS.NUMBER-1);	
							//}
							_drop.image_index = global.boss_manager.boss_current_enum;
						}
					}
					
					var _alarm_time = AnimationGetFrameLength(boss_current_hp_death_sprite) + AnimationGetFrameLength(boss_current_hp_sprite);
					if(global.boss_manager.boss_hp_fragments_left == _fragments_total_num / 2)
					{
						alarm[9] = _alarm_time;//Start Shielding
					}
					else
					{
						alarm[4] = _alarm_time;//Surge New HP
					}
				}
			}
		}
		
		#endregion
	}
	
}
