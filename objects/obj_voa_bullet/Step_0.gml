if(!global.game_is_paused)
{
	var _inst = instance_find(enemy_parent,0);
	if(_inst != noone)
	{
		var _direction = point_direction(x,y,_inst.x,_inst.bbox_top+20);
	
		var _dist = abs(_inst.x - x);
		var _dist_k = ((_dist - magnet_min_dist) / (magnet_max_dist - magnet_min_dist));
		var _magnetic_k = (1 - clamp(_dist_k,0,1)) * magnet_gravityK;
		Vx += lengthdir_x(_gravity*_magnetic_k,_direction);
	}
	
	Vy += _gravity;
	
	x += Vx;
	y += Vy;
	
	image_angle = point_direction(0,0,Vx,Vy);
	
	var _collided_with = instance_place(x,y,enemy_parent);
	if(_collided_with!=noone)
	{
		EntityDamage(_collided_with,0);
		CameraShake(8,12);
		EffectCreateOnTarget(hit_effect,image_xscale,_collided_with,false);
		emitter_sound(sn_default_hit,false);
		instance_destroy();
	}
	if(y >= FLOOR_Y)
	{
		EffectCreate(x,FLOOR_Y,spr_voa_hit_effect,image_xscale,false);
		//audio_play_sound_on(my_emitter,sn_default_hit,false,1);
		emitter_sound(sn_default_hit,false);
		instance_destroy();
	}
}
