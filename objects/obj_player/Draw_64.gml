if(player_gui_display)
{
	
	#region//Dark Matter
	
	if(dark_matter_bar_w != 0)
	{
	
		var _DM_bar_y1 = global.GUI_H - dark_matter_bar_gui_y
	
		#region//Draw Edges
		//Draw9Sliced(
		//spr_dark_matter_bar,
		//dark_matter_bar_gui_x,
		//_DM_bar_y1,
		//dark_matter_bar_gui_x + dark_matter_bar_w,
		//_DM_bar_y1 + dark_matter_bar_h
		//)
		draw_sprite_stretched(
		spr_dark_matter_bar,
		0,
		dark_matter_bar_gui_x,
		_DM_bar_y1,
		dark_matter_bar_w,
		dark_matter_bar_h
		)
		#endregion
	
		#region//Draw Filling
		if(dark_matter_current!=0)
		{
			var _x1 = dark_matter_bar_gui_x+dark_matter_filling_offset;
			var _y1 = _DM_bar_y1+dark_matter_filling_offset;
			var filling_rate = dark_matter_current / dark_matter_max;
			Draw9Sliced(
			spr_dark_matter_bar_filling,
			_x1,
			_y1,
			_x1 + filling_rate * (dark_matter_bar_w - dark_matter_filling_offset*2),
			_y1 + dark_matter_filling_h
			)
		}
		#endregion
		
	}
	
	#region Transition
	
	if(dark_matter_bar_target_w != dark_matter_bar_w  && !hp_in_transition)
	{
		dark_matter_bar_w = lerp(dark_matter_bar_w,dark_matter_bar_target_w,0.05);
		if(abs(dark_matter_bar_w - dark_matter_bar_target_w) <= 0.5)
		{
			dark_matter_bar_w = dark_matter_bar_target_w;
		}
	}
	
	#endregion
	
	#endregion
	
	#region//HP
	
	#region Transition
	
	if(hp_in_transition)
	{
		hp_transition_progress += hp_transition_spd;
		hp_show_y = lerp(hp_top_y,hp_bot_y,hp_transition_progress);
		if(hp_transition_progress == hp_transition_down)
		{
			hp_in_transition = false;
		}
	}
	
	#endregion
	
	for(var i=0;i<current_hp;i++)
	{
		var _hp_y = global.GUI_H - hp_show_y;
		var additional_y = animcurve_channel_evaluate(hp_anim_channel,(hp_animation_progress + hp_jitterings[i]) mod 1)
		draw_sprite(hp_sprite,hp_leaves[i],hp_show_x+hp_gap*i,_hp_y+additional_y);
	}
	#endregion
	
	#region Buffs
	
	var _total_width = 0;
	for(var i = 0; i < player_max_buffs; i++)
	{
		var _buff = buffs_list[i];
		if(_buff != -1)
		{
			var _buff_width = sprite_get_width(_buff);
			
			#region Animation
			
			var _buff_img_spd = sprite_get_speed(_buff) / FRAME_RATE;
			var _buff_img_num = sprite_get_number(_buff);
			var _buff_xoffset = sprite_get_xoffset(_buff);
			buffs_anim_list[i] += _buff_img_spd;
			if(buffs_anim_list[i] >= _buff_img_num)
			{
				buffs_anim_list[i] -= _buff_img_num;	
			}
			var _buff_img_id = buffs_anim_list[i];
			
			#endregion
			
			draw_sprite(_buff,_buff_img_id,buffs_show_x + _buff_xoffset + _total_width,global.GUI_H - hp_show_y - buffs_show_y);
			_total_width += _buff_width * 1.25;
		}
	}
	
	#endregion
	
	#region//Skills
	
	for(var i=0;i<SKILLS.NUMBER;i++)
	{
		var skill = skills[i];
		
		var _spec_prog = skill[SKILL.SPECIAL_PROGRESS];
		
		var frame_draw_x = skill_icons_x+skill_icons_gap*i;
		var icon_draw_x = frame_draw_x - icon_width/2;
		
		var frame_draw_y = global.GUI_H - skill_icons_y;
		var icon_draw_y = frame_draw_y - icon_height/2;
		
		var _frame_sprite = spr_skill_frame;
		var _frame_img_index = 0;
		
	
		if(ultimate_skill_id != i)
		{
		
			#region//Draw Icon
			if(_spec_prog < spec_stacks_needed)
			{
				#region//Draw Skill Icon
				var cd_left = skills_cooldowns[i];
				var cd_total = skill[SKILL.COOLDOWN];
				var cd_percent = min((cd_total - cd_left) / cd_total,1);
				var active_height = icon_height * cd_percent;
			
				//Icon Passive
				draw_sprite(skill[SKILL.ICON],1,icon_draw_x,icon_draw_y);
				//Icon Active
				var _passive_height = icon_height - active_height;
				draw_sprite_part(
					skill[SKILL.ICON],
					0,
					0,
					_passive_height,
					icon_width,
					active_height,
					icon_draw_x,
					icon_draw_y + _passive_height
				)
				#endregion
			}
			else
			{
				#region//Draw Special Skill Icon
				spec_icons_img_prog[i] += spec_icons_img_spd[i];
				spec_icons_img_prog[i] %= spec_icons_img_num[i];
				draw_sprite(special_skills[i][SKILL.ICON],spec_icons_img_prog[i],icon_draw_x,icon_draw_y);
				#endregion
			
				#region//Frame
				_frame_sprite = spec_frame_sprite;
				spec_frame_img_prog[i] += spec_frame_img_spd;
				spec_frame_img_prog[i] %= spec_frame_img_num;
				_frame_img_index = spec_frame_img_prog[i];
				#endregion
		
			}
			#endregion
			
		}
		else
		{
			#region Ultimate Skill Icon Draw
			
			ultimate_skill_img_index += ultimate_skill_img_spd;
			ultimate_skill_img_index %= ultimate_skill_img_number;
			
			ultimate_skill_icon_wave_progress += ultimate_skill_icon_wave_spd;
			ultimate_skill_icon_wave_progress %= (double_pi);
			var _yoffset = -abs(sin(ultimate_skill_icon_wave_progress)) * ultimate_skill_icon_wave_amp;
			icon_draw_y += _yoffset;
			frame_draw_y += _yoffset;
			
			draw_sprite(ultimate_skill_icon_sprite,ultimate_skill_img_index,icon_draw_x,icon_draw_y);
			
			_frame_sprite = spr_ultimate_skill_frame;
			
			#endregion
		}
		
		#region//Draw Frame
		
		draw_sprite(_frame_sprite,_frame_img_index,frame_draw_x,frame_draw_y);
		
		#endregion
	}
	#endregion
	
	#region//Skill Bar
	if(state = PlayerStateCastSkill)
	{
		var skill_CD = current_skill[SKILL.FULL_CAST];
		var casted_part = min(1,image_index / skill_CD);
		var bar_width = casted_part * skill_bar_width;
		
		if(casted_part>=1) var bar_image_index = 1;
		else bar_image_index = 0;
		
		var _skill_bar_y = global.GUI_H - skill_bar_y;
		
		draw_sprite(spr_skill_cast_frame,bar_image_index,skill_bar_x,_skill_bar_y);
		if(casted_part!=0)
		{
			Draw9Sliced(spr_skill_cast_bar,skill_bar_x,_skill_bar_y,skill_bar_x + bar_width,_skill_bar_y+skill_bar_height)
		}
	}
	#endregion
		
	#region//Enemy Info
	if(instance_exists(last_hitted))
	{
		draw_sprite(last_hitted.portrait,0,enemy_info_x,global.GUI_H - enemy_info_y);
		var enemy_hp = last_hitted.current_hp;
		var _hp_image = !last_hitted.drop_matter;
		var _enemy_hp_y = global.GUI_H - enemy_hp_y;
		for(var i = 0; i < enemy_hp;i++)
		{
			draw_sprite(spr_enemy_hp_frag,_hp_image,enemy_hp_x + enemy_hp_gap * i,_enemy_hp_y);	
		}
	}
	#endregion
}