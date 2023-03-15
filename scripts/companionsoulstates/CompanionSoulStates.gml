///@arg enum
///@arg x
///@arg y
function CompanionSoulDrop(_enum,_x,_y)
{
	var _soul = instance_create_layer(_x,_y,"Effects",obj_companion_soul);
	with(_soul)
	{
		//audio_play_sound_at(soul_drop_sound[_enum],_x,_y,0,falloff_ref_dist,falloff_max_dist,falloff_factor,false,1);
		sound_xy(soul_drop_sound[_enum]);
		state = CompanionSoulDead;
		sprite_index = sprites_dead[_enum];
		current_companion = _enum;
		image_angle = 270;
	}
	return _soul;
}

function CompanionSoulPrepareForDeath(){
	state = CompanionSoulDead;
	sprite_index = sprites_dead[current_companion];
	image_index = 0;
	_gravity /= 2;
	underground_gravity /= 2;
	reactivate_y = room_height * 10;
}

function CompanionSoulFlyToBoss(){
	state = CompanionSoulStateFlyingToBoss;
	var _x_target = global.oBoss.x + boss_comp_kill_xoffset * global.oBoss.image_xscale;
	var _y_target = global.oBoss.y + boss_comp_kill_yoffset;
	direction = point_direction(x,y,_x_target,_y_target);
	image_angle = direction;
}

function CompanionSoulCameToBoss(){
	
}

function CompanionSoulStateFlyingToBoss(){
	var _x_target = global.oBoss.x + boss_comp_kill_xoffset * global.oBoss.image_xscale;
	var _y_target = global.oBoss.y + boss_comp_kill_yoffset;
	if(point_distance(x,y,_x_target,_y_target) > spd)
	{
		x+=lengthdir_x(spd,direction);
		y+=lengthdir_y(spd,direction);	
	}
	else
	{
		x = _x_target;
		y = _y_target;
		state = CompanionSoulCameToBoss;
	}
}

function CompanionSoulDead(){
	if(y>FLOOR_Y)
	{
		if(!entered_ground)
		{
			entered_ground = true;
			CompanionSoulDirtEffectCreate();
			emitter_sound(sn_comp_soul_enter_ground,false);
		}
		y+=underground_gravity;
	}
	else
	{
		y+=_gravity;
	}
	if(y>=reactivate_y)
	{
		CompanionSoulReactivate();
	}
}

function CompanionSoulReactivate(){
	current_companion = irandom(COMPANION.bird);
	sprite_index = sprites_reactivating[current_companion];
	image_index = 0;
	state = CompanionSoulReactivating;
	emitter_sound(sn_comp_soul_activate,false);
}

function CompanionSoulReactivating(){
	if(AnimationEnd())
	{
		sprite_index = sprites_idle[current_companion];
		image_index = 0;
		state = CompanionSoulMoveToTarget;
		CompanionSoulFindTargetX();
	}
}

function CompanionSoulDirtEffectCreate(){
	dirt_effect = instance_create_layer(x,y,"Effects",obj_dirt_effect);
	with(dirt_effect)
	{
		depth = --other.depth;
		attack_target_inst = other;
		//x_offset = 0;
		//y_offset = 0;
		
	}
}

function CompanionSoulDirtEffectDestroy(){
	with(dirt_effect) fading_out = true;	
}

function CompanionSoulFindTargetX(){
	do
	{
		target_x = RangeArrayGetNumber(companion_seeds_spawn_range[irandom(1)],false);
	}
	until(abs(x-target_x)>curved_movement_distance)
}

function CompanionSoulMoveToTarget(){
	if(y - FLOOR_Y<=spd)
	{
		y = FLOOR_Y;
		CompanionSoulTransformIntoSeed();
	}
	else
	{
		var x_distance = target_x - x;
		var x_direction = sign(x_distance);
		if(abs(x_distance)<=curved_movement_distance)
		{
			direction += radtodeg((spd/curved_movement_distance)) * x_direction;
		}
		else
		{
			direction = radtodeg(arccos(x_direction));//0 or 180 degrees
		}
		x+=lengthdir_x(spd,direction);
		y+=lengthdir_y(spd,direction);
		image_angle = direction;
	}
}

function CompanionSoulTransformIntoSeed(){
	CompanionSoulDirtEffectDestroy();
	var _sprite = seeds_surging_sprites[current_companion];
	var _object = seeds_objects[current_companion];
	SurgeSimple(x,FLOOR_Y,"Instances_Background",_sprite,_object,-EnemyFindMovementDirection());
	y = FLOOR_Y;
	sound_xy(sn_comp_soul_enter_ground);
	sound_xy(sn_comp_seed_growth);
	instance_destroy();
}

//function CompanionSoulInSeed(){
		
//}