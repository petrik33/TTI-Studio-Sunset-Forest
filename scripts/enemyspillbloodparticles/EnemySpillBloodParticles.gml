///@arg side
function EnemySpillBloodParticles(_side){
	
	var _y_center = y + SpriteBBoxYOffsetCenter(sprite_index,true);
	
	var _number = irandom_range(7,10);
	
	var _hit_direction = 90 - 90 * _side;
	
	var _random_id = irandom(array_length(global.enemy_blood_part_sprites) - 1);
	var _part_sprite = global.enemy_blood_part_sprites[_random_id];
	
	part_type_sprite(global.enemy_blood_part,_part_sprite,true,true,false);
	
	part_type_direction(global.enemy_blood_part,_hit_direction - 40,_hit_direction + 40,0,0);
	part_type_orientation(global.enemy_blood_part,0,0,0,0,true);
	
	part_particles_create(global.particle_system,x,_y_center,global.enemy_blood_part,_number);

}