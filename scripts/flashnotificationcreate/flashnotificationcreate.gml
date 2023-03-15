///@arg sprite
///@arg side
///@arg particle
///@arg particle_direction
///@arg time
function FlashNotificationCreate(_sprite,_side,_particle = noone,_particle_direction = 0,_time = FRAME_RATE * 0.75){
	var _flash_x = 0;
	if(_side == 1)
	{
		_flash_x = global.GUI_W;
	}
	var _inst = instance_create_layer(_flash_x,0,"GUI",pobj_worry_flash);
	with(_inst)
	{
		flash_spd = 1 / _time;
		sprite_index = _sprite;
		
		#region//Particle Create
		if(_particle != noone)
		{

			var particles_emitter = part_emitter_create(global.gui_particle_system);
			part_emitter_region(global.gui_particle_system,particles_emitter,x,x,0,global.GUI_H,ps_shape_line,ps_distr_gaussian);
			
			var main_direction = 90 - (90 - _particle_direction) * sign(image_xscale);

			part_type_direction(_particle,main_direction-10,main_direction+10,0,0);

			var _part_number = irandom_range(30,40);

			part_emitter_burst(global.gui_particle_system,particles_emitter,_particle,_part_number);

			part_emitter_destroy(global.gui_particle_system,particles_emitter);
	
		}
		#endregion
		
	}
}