///@desc Boss GUI
if(boss_gui_display)
{
	for(var i = 0;i < SKILLS.NUMBER; i++)
	{
		if(i != fragment_defeated)
		{
			var _sprite = boss_fragments_sprites[i];
			//var _draw_x = fragments_x + fragments_gap * i;
			var _draw_XY = BossManagerGetFragmentXY(i);
		
			var _fragment_dead = !boss_affecteds_available[i];
			var _img_index = 0;
			if(_fragment_dead)
			{
				_img_index = sprite_get_number(_sprite) - 1;
			}
			draw_sprite(_sprite,_img_index,_draw_XY[0],_draw_XY[1]);
		}
	}

	var _fragments_sprite = boss_manager_current_fragments_sprites[0];
	//var _fragments_max_num = sprite_get_number(_fragments_sprite);
	for(var i = 0; i < boss_hp_fragments_left; i++)
	{
		draw_sprite(_fragments_sprite,i,fragments_ellipse_x,fragments_ellipse_y);	
	}
	
	if(boss_shield_active)
	{
		var percent;
		if(boss_shield_invoking)
		{
			percent = boss_shield_invoke_timer / boss_shield_invoke_time;
		}
		else
		{
			percent = boss_shield_duration_left / boss_shield_duration_time;
		}
		var surface_width = boss_shield_radius * 2;
		var surface_height = ceil(boss_shield_radius * percent);
		if(!surface_exists(boss_shield_surface))
		{	
			boss_shield_surface = surface_create(surface_width,surface_height);	
		}
		else
		{
			surface_resize(boss_shield_surface,surface_width,surface_height);	
		}
		surface_set_target(boss_shield_surface);
		
		//var _vx = camera_get_view_x(view_camera[0]);
        //var _vy = camera_get_view_y(view_camera[0]);
		
		var _color = boss_state_colors[boss_current_enum];
		
		draw_set_circle_precision(32);
		
		draw_circle(surface_width/2,0,boss_shield_radius,false);
		
		surface_reset_target();
		
		draw_surface_ext(boss_shield_surface,global.GUI_W/2 - boss_shield_radius,0,1,1,0,_color,0.75);
	}
	
	
	//for(var i = _fragments_max_num - 1; i >= (_fragments_max_num - boss_hp_fragments_left); i--)
	//{
	
	//	draw_sprite(_fragments_sprite,i,fragments_ellipse_x,fragments_ellipse_y);	
	//}
}

if(boss_current_enum == SKILLS.ICE_TRAP)
{
	var _sprite_size = 30;
	var _width = 30;
	var _vLen = global.GUI_H;
	var _hLen = global.GUI_W;
	
	var _widthScale = _width / _sprite_size;
	var _verticalScale = _vLen / _sprite_size;
	var _horizontalScale = _hLen / _sprite_size
	
	
	if(instance_exists(global.oPlayer) && instance_exists(global.oBoss))
	{
		var _dist = abs(global.oPlayer.x - global.oBoss.x);
		var _dist_lerp = 1 - ((_dist - ice_gradient_multiply_min_distance) / (ice_gradient_multiply_max_distance - ice_gradient_multiply_min_distance));
		ice_gradient_distance_multiplier = clamp(_dist_lerp,0,1);
	}
	
	ice_gradient_alpha_multiplier = lerp(ice_gradient_alpha_multiplier,ice_gradient_alpha_multiplier_target,0.01);//Smooth Transition
	ice_gradient_alpha = ice_gradient_distance_multiplier * ice_gradient_alpha_multiplier;
	
	draw_sprite_ext(spr_ice_gradient,0,0,0,_widthScale,_verticalScale,0,c_white,ice_gradient_alpha);//Left
	draw_sprite_ext(spr_ice_gradient,0,global.GUI_W,global.GUI_H,_widthScale,_verticalScale,180,c_white,ice_gradient_alpha);//Right
	draw_sprite_ext(spr_ice_gradient,0,global.GUI_W,0,_widthScale,_horizontalScale,-90,c_white,ice_gradient_alpha);//Top
	draw_sprite_ext(spr_ice_gradient,0,0,global.GUI_H,_widthScale,_horizontalScale,90,c_white,ice_gradient_alpha);//Bottom
}