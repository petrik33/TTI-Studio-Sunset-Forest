sprite_idle = sprite_index;
current_indicator = noone;
life_counter = 0;

seed_activate = true;

#region//Audio

my_emitter = emitter_create();


#endregion

#region//States

state_free = function(){
	if(instance_exists(global.oPlayer) && (abs(global.oPlayer.x - x) < global.seed_opening_radius))
	{
		sprite_index = sprite_steady;
		if(seed_activate)
		{
			seed_activate = false;
			emitter_sound(sn_comp_seed_activate,false);
		}
		if(!instance_exists(current_indicator))
		{
			current_indicator = instance_create_layer(x + sign(x- room_width/2) * 48,bbox_top - 8,"Effects",pobj_open_seed_indicator);
			with(current_indicator) sprite_idle = other.sprite_indicator;
		}
	}
	else
	{
		sprite_index = sprite_idle;
		seed_activate = true;
	}

	if(++life_counter >= life_time)
	{
		instance_destroy();
		EffectCreateReversed(x,y,sprite_surging,image_xscale);
		CompanionSoulDrop(companion_enum,x,y);
	}
}

seed_state_being_opened = function(){
	//Nothing
	if( !instance_exists(global.oPlayer) || global.oPlayer.state!=PlayerStateOpeningSeed)
	{
		instance_destroy();
		CompanionSoulDrop(companion_enum, x,y)
	}
}

seed_state_already_opened = function(){
	if(AnimationEnd())
	{
		with(instance_create_layer(x+spawn_offset_x,y+spawn_offset_y,layer,companion_spawned))
		{
			if(x!=shrine_x) image_xscale = sign(x - shrine_x);
		}
		instance_destroy();
	}	
}

#endregion

state = state_free;
step_sound = noone;
