///@arg x
function SubmergeDirtThrow(_x){
	part_type_direction(global.dirt_particle,12,40,0,0);
	//To The Right
	part_particles_create(global.particle_system,_x,FLOOR_Y,global.dirt_particle,irandom_range(5,6));
	//Change Direction
	part_type_direction(global.dirt_particle,140,168,0,0);
	//To The Left
	part_particles_create(global.particle_system,_x,FLOOR_Y,global.dirt_particle,irandom_range(5,6));
	PlayerSoundMake(sn_crystal_submerge9_1);
}