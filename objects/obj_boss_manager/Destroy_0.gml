part_emitter_clear(global.particle_system,boss_rain_emitter);
part_emitter_destroy(global.particle_system,boss_rain_emitter);
part_emitter_clear(global.gui_particle_system,boss_rain_emitter_gui);
part_emitter_destroy(global.gui_particle_system,boss_rain_emitter_gui);

for(var i = 0; i < SKILLS.NUMBER; i++)
{
	part_type_destroy(boss_rain_particles[i]);
	if( i != SKILLS.THUNDER)
	{
		part_type_destroy(boss_rain_particles_gui[i]);
	}
	else
	{
		var _particles_arr = boss_rain_particles_gui[i];
		for(var j = 0; j < array_length(_particles_arr); j++)
		{
			part_type_destroy(_particles_arr[j]);	
		}
	}
}

for(var i = 0; i < array_length(boss_thunder_gui_emitters); i++){
	part_emitter_clear(global.gui_particle_system,boss_thunder_gui_emitters[i]);
	part_emitter_destroy(global.gui_particle_system,boss_thunder_gui_emitters[i]);	
}

audio_stop_sound(boss_ambient);