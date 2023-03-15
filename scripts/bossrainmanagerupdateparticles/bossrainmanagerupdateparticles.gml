///@arg enum
function BossManagerUpdate(_enum){
	//if(!instance_exists(global.boss_manager))
	//{
	//	global.boss_manager = instance_create_layer(0,0,"Managers",obj_boss_manager);
	//}
	with(global.boss_manager)
	{
		BossManagerUpdateParticles(_enum);
		BossManagerUpdateParticlesGUI(_enum);
		BossManagerUpdateAmbient(_enum);
		
		boss_current_enum = _enum;
		
		if(_enum != boss_idle_form_enum)
		{
			boss_hp_fragments_left = boss_affected_hp_fragments;	
			boss_manager_current_fragments_sprites = [sprite_hp_fragments_affected,sprites_hp_frags_death_affected];
		}
		else
		{
			boss_hp_fragments_left = boss_idle_hp_fragments;
			boss_manager_current_fragments_sprites = [sprite_hp_fragments_idle,sprites_hp_frags_death_idle];
		}
		
		teleport_out_sprite = global.oBoss.teleport_sprites[boss_tp.out];
		if(teleport_out_sprite == noone)
		{
			teleport_out_sprite = global.oBoss.teleport_sprites[boss_tp.in];
			teleport_out_sprite_reversed = true;
		}
		else
		{
			teleport_out_sprite_reversed = false;
		}
	}	
}

function BossManagerUpdateAmbient(_enum){
	if(_enum == boss_idle_form_enum)
	{
		if(audio_exists(boss_ambient))
		{
			audio_sound_gain(boss_ambient,0,fade_time.normal);
		}
		return;	
	}
	audio_stop_sound(boss_ambient);
	boss_ambient = PlayerSoundMake(boss_ambient_assets[_enum],,,true,fade_time.normal);	
}

///@arg enum
function BossManagerUpdateParticles(_enum){
		
	#region//View Vars
	//var _camera = view_camera[0];
	//var _view_x = camera_get_view_x(_camera);
	var _view_y = camera_pause_y_target - global.oCamera.view_h_half;
	//var _view_w = camera_get_view_width(_camera);
	var _stream_buffer = 16;
	//var _x_buffer = 768;
	
	//var _x_min = max(-80,_view_x - _x_buffer);
	//var _x_max = min(room_width,_view_x+_x_buffer+_view_w);
	#endregion 
	
	part_emitter_clear(global.particle_system,boss_rain_emitter);
	if(_enum == boss_idle_form_enum) return;
		
	switch(_enum)
	{
		case SKILLS.ICE_TRAP:
		#region
			
		part_emitter_region(
			global.particle_system,
			boss_rain_emitter,
			-80,
			room_width,
			_view_y-_stream_buffer,
			_view_y-_stream_buffer,
			ps_shape_rectangle,
			ps_distr_linear
		)
			
		part_emitter_stream(
			global.particle_system,
			boss_rain_emitter,
			boss_rain_particles[_enum],
			boss_rain_particles_number[_enum]
		)
			
		break;
		#endregion
			
		case SKILLS.FIRE_BALL:
		#region
			
		part_emitter_region(
			global.particle_system,
			boss_rain_emitter,
			0,
			room_width,
			_view_y+_stream_buffer * 8,
			FLOOR_Y,
			ps_shape_rectangle,
			ps_distr_linear
		)
			
		part_emitter_stream(
			global.particle_system,
			boss_rain_emitter,
			boss_rain_particles[_enum],
			boss_rain_particles_number[_enum]
		)
			
		break;
		#endregion
			
		case SKILLS.WIND:
		#region
			
		var _boss_side = global.oBoss.image_xscale;
		boss_wind_particles_gui_direction = _boss_side;
		var _boss_edge_x = room_width/2 - ((room_width/2 + _stream_buffer) * _boss_side);
			
		part_emitter_region(
			global.particle_system,
			boss_rain_emitter,
			_boss_edge_x,
			_boss_edge_x,
			_view_y+_stream_buffer*8,
			FLOOR_Y,
			ps_shape_rectangle,
			ps_distr_linear
		)
			
		var _wind_part = boss_rain_particles[_enum];
			
		var dir_min = 90 - _boss_side * 95;
		var dir_max = 90 - _boss_side * 85;
			
		if(_boss_side == 1)
		{
			part_type_direction(
				_wind_part,
				dir_min,
				dir_max,
				0,
				1
			)
		}
		else
		{
			part_type_direction(
				_wind_part,
				dir_max,
				dir_min,
				0,
				1
			)	
		}
			
		part_emitter_stream(
			global.particle_system,
			boss_rain_emitter,
			_wind_part,
			boss_rain_particles_number[_enum]
		)
			
		break;
		#endregion
			
		case SKILLS.THUNDER:
		#region
		
		part_emitter_region(
			global.particle_system,
			boss_rain_emitter,
			-80,
			room_width,
			_view_y-_stream_buffer,
			_view_y-_stream_buffer,
			ps_shape_rectangle,
			ps_distr_linear
		);
			
		part_emitter_stream(
			global.particle_system,
			boss_rain_emitter,
			boss_rain_particles[_enum],
			boss_rain_particles_number[_enum]
		);
			
		break;
		#endregion
			
		default:
			
		break;
			
	}
}
	
///@arg enum
function BossManagerUpdateParticlesGUI(_enum){
	
	#region//View Vars
	//var _view_y = camera_pause_y_target - global.oCamera.view_h_half;
	#endregion
	
	//var _stream_buffer = 4;
	
	if(boss_current_enum == SKILLS.THUNDER) {
		for(var i = 0; i < array_length(boss_thunder_gui_emitters); i++) {
			part_emitter_clear(global.gui_particle_system,boss_thunder_gui_emitters[i]);
		}
	}
	
	part_emitter_clear(global.gui_particle_system,boss_rain_emitter_gui);
	if(_enum == boss_idle_form_enum) return;
		
	switch(_enum)
	{
		case SKILLS.ICE_TRAP:
		#region
			
		//part_emitter_region(
		//	global.gui_particle_system,
		//	boss_rain_emitter_gui,
		//	0,
		//	global.GUI_W,
		//	-_stream_buffer,
		//	-_stream_buffer,
		//	ps_shape_rectangle,
		//	ps_distr_linear
		//)
			
		//part_emitter_stream(
		//	global.gui_particle_system,
		//	boss_rain_emitter_gui,
		//	boss_rain_particles_gui[_enum],
		//	boss_rain_particles_number_gui[_enum]
		//)
			
		break;
		#endregion
			
		case SKILLS.FIRE_BALL:
		#region
			
		part_emitter_region(
			global.gui_particle_system,
			boss_rain_emitter_gui,
			0,
			global.GUI_W,
			0,
			global.GUI_H,
			ps_shape_rectangle,
			ps_distr_linear
		)
			
		part_emitter_stream(
			global.gui_particle_system,
			boss_rain_emitter_gui,
			boss_rain_particles_gui[_enum],
			boss_rain_particles_number_gui[_enum]
		)
			
		break;
		#endregion
			
		case SKILLS.WIND:
		#region
			
		//var _boss_edge_x = global.GUI_W/2 - ((global.GUI_W/2 + _stream_buffer) * boss_wind_particles_gui_direction);
			
		//part_emitter_region(
		//	global.gui_particle_system,
		//	boss_rain_emitter_gui,
		//	_boss_edge_x,
		//	_boss_edge_x,
		//	0,
		//	global.GUI_H,
		//	ps_shape_rectangle,
		//	ps_distr_linear
		//)
			
		//var _wind_part = boss_rain_particles_gui[_enum];
			
		//var dir_min = 90 - boss_wind_particles_gui_direction * 95;
		//var dir_max = 90 - boss_wind_particles_gui_direction * 85;
			
		//if(boss_wind_particles_gui_direction == 1)
		//{
		//	part_type_direction(
		//		_wind_part,
		//		dir_min,
		//		dir_max,
		//		0,
		//		1
		//	)
		//}
		//else
		//{
		//	part_type_direction(
		//		_wind_part,
		//		dir_max,
		//		dir_min,
		//		0,
		//		1
		//	)	
		//}
			
		//part_emitter_stream(
		//	global.gui_particle_system,
		//	boss_rain_emitter_gui,
		//	_wind_part,
		//	boss_rain_particles_number_gui[_enum]
		//)
			
		break;
		#endregion
			
		case SKILLS.THUNDER:
		#region
			
		var _particles_num_array = boss_rain_particles_number_gui[SKILLS.THUNDER];
		var _particle_types_array = boss_rain_particles_gui[SKILLS.THUNDER];
		var _thunder_particles_num = array_length(_particle_types_array);
		
		for(var i = 0; i < _thunder_particles_num; i++)
		{
			var _emitter = boss_thunder_gui_emitters[i];
			var _part_type = _particle_types_array[i];
			var _part_num = _particles_num_array[i];
			part_emitter_region(
				global.gui_particle_system,
				_emitter,
				0,
				global.GUI_W,
				0,
				global.GUI_H,
				ps_shape_rectangle,
				ps_distr_invgaussian
			);
		
			part_emitter_stream(
				global.gui_particle_system,
				_emitter,
				_part_type,
				_part_num
			);
		}
			
			
		break;
		#endregion
			
		default:
			
		break;
			
	}
}