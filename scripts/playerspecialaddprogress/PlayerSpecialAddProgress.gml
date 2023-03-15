///@arg id
function PlayerSpecialAddProgress(_id){
	with(global.oPlayer)
	{
		if(skills[_id][SKILL.SPECIAL_PROGRESS] < spec_stacks_needed)
		{
			skills[@ _id][@ SKILL.SPECIAL_PROGRESS]+=1;
			var _stacks_count = skills[@ _id][@ SKILL.SPECIAL_PROGRESS];
		
			var _stack_sprite = spec_stacks_sprites[_id];
			var _stack_special = false;
		
			#region//If Full Stack
		
			if(_stacks_count >= spec_stacks_needed)
			{
				//audio_play_sound(spec_activation_sounds[_id],1,false);
				PlayerSoundMake(spec_activation_sounds[_id]);
				skills[@ _id][@ SKILL.SPECIAL_PROGRESS] = spec_stacks_needed;
				skills_cooldowns[@ _id] = 0;	
				//skills[@ _id][@ SKILL.SPECIAL_PROGRESS] = spec_stacks_needed;
				with(pobj_player_special_stack)
				{
					if(skill_id == _id)
					{
						instance_destroy();	
					}
				}
				_stack_sprite = spr_boss_stealing_particles;
				_stack_special = true;
				_stacks_count = 0;
			}
		
			#endregion
			#region//Create Skill Stack
		
			var _rot_prog = spec_stacks_rot_prog + (pi / 2) * _id + (_stacks_count - 1) * (pi / 12);
		
			with (instance_create_layer(x,y + hero_special_stacks_y_offset,"Effects",pobj_player_special_stack)){
				skill_id = _id;
			
				target = other;
				depth_start = target.depth;
			
				#region//Simultaneous Animation
			
				with(pobj_player_special_stack)
				{
					if(skill_id == _id)
					{
						other.image_index = image_index;	
					}
				}
			
				#endregion
				
				sprite_index =_stack_sprite;
				if(_stack_special)
				{
					image_index = skill_id;
					image_speed = 0;
					special_stack = true;
					#region//Simultaneous Rotation
				
					with(pobj_player_special_stack)
					{
						if(image_angle!=0) other.image_angle = image_angle;	
					}
				
					#endregion
				}
			
				rotation_progress = _rot_prog;
				var _cos_value = cos(rotation_progress);		
				x = (target.bbox_left + target.bbox_right) / 2 + _cos_value * rotation_R;
			}
			#endregion
		}
	}
}