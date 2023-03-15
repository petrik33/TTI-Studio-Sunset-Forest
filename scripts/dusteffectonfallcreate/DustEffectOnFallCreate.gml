function DustEffectOnFallCreate(){
	part_type_direction(global.dust_particle,0,24,0,0);
	//To The Right
	part_particles_create(global.particle_system,x,bbox_bottom,global.dust_particle,irandom(2));
	//Change Direction
	part_type_direction(global.dust_particle,156,180,0,0);
	//To The Left
	part_particles_create(global.particle_system,x,bbox_bottom,global.dust_particle,irandom(2))
}