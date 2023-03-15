// Inherit the parent event
event_inherited();

EffectCreate(x,y,sprite_death,image_xscale,false);

with(instance_create_layer(x+particle_xoffset,y+particle_yoffset,"Instances",obj_returned_particle))
{
	var _stolen_skill = other.element;
	part_type_color1(spark_particle,particles_colors[_stolen_skill]);
	part_type_sprite(small_particle,particles_sprites[_stolen_skill],false,false,false);
	skill_stolen = _stolen_skill;
	image_index = skill_stolen;	
}
