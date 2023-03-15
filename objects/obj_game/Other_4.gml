if(room == room0)
{
	
	global.leftEdge = 0;
	global.rightEdge = map_width;
	
	global.lose = false;

	#region//Global Objects Create

	global.oPlayer = instance_create_layer(player_x_start,FLOOR_Y,"Hero",obj_player);

	global.time_cycler = instance_create_layer(0,0,"Managers",obj_time_cycler);
	
	instance_create_layer(global.leftEdge,FLOOR_Y,"Effects",pobj_wall_barrier);
	with(instance_create_layer(global.rightEdge,FLOOR_Y,"Effects",pobj_wall_barrier))
	{
		image_xscale = -1;
	}
	
	#endregion
	
	#region Particles
	
	global.particle_system = part_system_create();
	//global.particle_system_front = part_system_create();
	global.gui_particle_system = part_system_create();

	GlobalParticleTypesCreate();

	part_system_automatic_draw(global.gui_particle_system,false);
	part_system_automatic_draw(global.particle_system,true);
	//part_system_automatic_draw(global.particle_system_front,true);
	
	part_system_layer(global.particle_system,"Particles");
	//part_system_layer(global.particle_system_front,"ParticlesFront");
	
	#endregion

	global.leftCandle = instance_nearest(shrine_zone_left_x,FLOOR_Y,obj_candle_tower);
	global.rightCandle = instance_nearest(shrine_zone_right_x,FLOOR_Y,obj_candle_tower);

	if(!global.game_loaded)
	{
		global.oMenu = instance_create_layer(0,0,"Managers",obj_menu_alternative);
		forest_ambient_start(fade_time.slow);
	}
	else
	{
		PlayerLoadControls();
		QuickStart();
		LoadedGameDataApply();
		if(global.restart_game)
		{
			PortalsBlock();
			cutscene_run(obj_CS_restart);
		}
		global.game_loaded = false;
	}
	
	ds_queue_clear(global.bestiary_queue);
	
	LayersSetVisible(true);
	
	//if(global.game_final)
	//{
	//	GameReset();
	//	RoomStartWithTransitions();
	//}
	
}