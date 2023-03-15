function GlobalParticleTypesCreate(){
	
	#region//Dust
	
	var _dust_particle = part_type_create();
	part_type_sprite(_dust_particle,spr_dust,false,false,true)
	part_type_life(_dust_particle,FRAME_RATE * 1, FRAME_RATE * 2);

	part_type_scale(_dust_particle,1,1);
	part_type_size(_dust_particle,0.6,1,-0.001,0);
	part_type_orientation(_dust_particle,0,360,0.01,0,true);
	part_type_blend(_dust_particle,false);

	part_type_alpha3(_dust_particle,1,1,0)

	part_type_direction(_dust_particle,0,30,0,0);
	part_type_speed(_dust_particle,0.8,1.2,-0.008,0.01);
	part_type_gravity(_dust_particle,0.0002,270);
	
	global.dust_particle = _dust_particle;
	
	#endregion
	
	#region//Dirt
	var _dirt_particle = part_type_create();
	
	part_type_sprite(_dirt_particle,spr_dirt_part,false,false,true)
	part_type_life(_dirt_particle,FRAME_RATE * 8, FRAME_RATE * 8);

	part_type_scale(_dirt_particle,1,1);
	part_type_size(_dirt_particle,1,2,-0.001,0);
	part_type_orientation(_dirt_particle,0,360,0.01,0,true);
	part_type_blend(_dirt_particle,false);

	part_type_alpha3(_dirt_particle,1,1,0)

	part_type_direction(_dirt_particle,0,40,0,0);
	part_type_speed(_dirt_particle,4,5,-0.05,0);
	part_type_gravity(_dirt_particle,0.1,270);
	
	global.dirt_particle = _dirt_particle;
	
	#endregion
	
	#region//Enemy Blood
	
	//var _color = make_color_rgb(255, 0, 50);
	
	global.enemy_blood_part_sprites = [spr_enemy_blood_part1,spr_enemy_blood_part2,spr_enemy_blood_part3];
	
	var _blood_particle = part_type_create();
	//part_type_shape(_blood_particle,pt_shape_sphere);
	//part_type_color_rgb(_blood_particle,235,255,0,20,30,70);
	part_type_sprite(_blood_particle,spr_enemy_blood_part1,true,true,true);
	part_type_life(_blood_particle,FRAME_RATE * 1, FRAME_RATE * 1.25);

	part_type_scale(_blood_particle,1,1);
	part_type_size(_blood_particle,1,1.5,0,0);
	part_type_orientation(_blood_particle,0,360,0,0,true);
	part_type_blend(_blood_particle,false);

	part_type_alpha3(_blood_particle,1,1,0);

	part_type_speed(_blood_particle,2,4,-0.05,0);
	
	global.enemy_blood_part = _blood_particle;
	
	#endregion
	
	global.particle_types = [global.dust_particle,global.dirt_particle,global.enemy_blood_part];
	
}
	
function GlobalParticlesTypesDestroy(){
	var num = array_length(global.particle_types);
	for(var i = 0; i < num; i++)
	{
		part_type_destroy(global.particle_types[i])	
	}
}
	
function ParticleSystemsDestroy() {
	part_emitter_destroy_all(global.particle_system);
	//part_emitter_destroy_all(global.particle_system_front);
	part_emitter_destroy_all(global.gui_particle_system);
	part_system_destroy(global.particle_system);
	part_system_destroy(global.gui_particle_system);
	//part_system_destroy(global.particle_system_front);
}