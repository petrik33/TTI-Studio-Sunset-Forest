//function DummyWalkTargetFind(){
//	var _targets_number = array_length(dummy_transform_targets);
//	for(var i = 0; i < _targets_number; i++)
//	{
//		var _attack_target_inst = noone;
//		var _inst_counter = 0;
//		do
//		{
//			_attack_target_inst = instance_find(dummy_transform_targets[i],_inst_counter);
//			_inst_counter++;
//			if(_attack_target_inst != noone && ds_list_find_index(global.dummy_targets_list,_attack_target_inst.id) == -1)
//			{
//				return _attack_target_inst;
//			}
//		}
//		until (_attack_target_inst == noone);
//	}
//	return noone;
//}

function DummyTransformCheck(){
	if(!ds_queue_empty(global.dummy_targets_queue))
	{
		DummyTransform();
	}	
}
	
///@arg instance
function DummyWalkingAddTarget(_inst = id){
	if(global.dummy_exists)
	{
		ds_queue_enqueue(global.dummy_targets_queue,_inst);
		with(obj_dummy_alternative)
		{
			if(!dummyWalking && sprite_index != sprite_transform)
			{
				DummyTransform();
			}
			else
			{
				if(dummy_target == noone || !instance_exists(dummy_target))
				{
					DummyWalkingNextTarget();
				}
			}
		}
	}
}

function DummyWalkingNextTarget(){
	if(!ds_queue_empty(global.dummy_targets_queue))
	{
		var _inst = noone;
		_inst = ds_queue_dequeue(global.dummy_targets_queue);
		dummy_target = _inst;
		EntityMakeFree();
		return true;
	}
	else
	{
		dummy_target = noone;
	}
	return false;
}

///@arg id
function DummyWalkingRemoveTarget(_id = id) {
	with(obj_dummy_alternative)
	{
		//var _target_id = -1;
		//with(dummy_target)
		//{
		//	_target_id = id;
		//}
		if(dummy_target == _id)
		{
			dummy_target = noone;
		}
		else
		{
			if(ds_queue_find(global.dummy_targets_queue,_id))
			{
				ds_queue_delete(global.dummy_targets_queue,_id);
			}
		}
	}
}

function DummyTransform(){
	if(abs(sin(degtorad(image_angle))) <= 0.1)
	{
		sprite_index = sprite_transform;
		image_index = 0;
		image_speed = 1;
		state = DummyStateTransform;
		push_vulnerable = false;
		damage_vulnerable = false;
	}
	else
	{
		alarm[0] = dummy_transform_check_frqncy;		
	}
	//if(instance_exists(dummy_target))
	//{
	//	if(abs(sin(degtorad(image_angle))) <= 0.1)
	//	{
	//		sprite_index = sprite_transform;
	//		image_index = 0;
	//		state = DummyStateTransform;
	//		push_vulnerable = false;
	//		damage_vulnerable = false;
	//	}
	//	else
	//	{
	//		alarm[2] = 1; //Dummy Transformation Check Repeat Next Frame
	//	}
	//}
	//else
	//{
	//	alarm[0] = 1; // New Dummy Transformation Check	
	//}
}

function DummyDestroy(){
	with(obj_dummy_alternative)
	{
		revive = false;
		instance_destroy();
	}
	instance_destroy(obj_dummy_pole);
	ds_queue_clear(global.dummy_targets_queue);
	global.dummy_exists = false;
}

function DummyStateTransform(){
	if(AnimationEnd())
	{
		dummyWalking = true;
		push_vulnerable = true;
		damage_vulnerable = true;
		flying = false;
		angle_speed = 0;
		_gravity = 0.4;
		sprite_index = spr_dummy_walking;
		image_index = 0;
		EntityUpdateSprites(spr_dummy_walking,spr_dummy_walking_death);
		state_free = DummyWalkingStateFree;
		state = state_free;
		if(!DummyWalkingNextTarget())
		{
			DummyTransformBack();	
		}
	}
}

function DummyTransformBack(){
	sprite_index = sprite_transform;
	image_xscale = 1;
	image_index = image_number - 1;
	image_speed = -1;
	state = DummyStateTransformBack;
	push_vulnerable = false;
	damage_vulnerable = false;
}

function DummyStateTransformBack(){
	if(AnimationEndReverse())
	{
		dummyWalking = false;
		dummy_target = noone;
		push_vulnerable = true;
		damage_vulnerable = true;
		flying = true;
		_gravity = 0;
		sprite_index = spr_dummy_body;
		image_index = 0;
		image_speed = 1;
		state_free = DummyStateFree;
		state = state_free;
		EntityUpdateSprites(spr_dummy_body,spr_dummy_body_death);
	}
}

function DummyWalkingReturnToIdle(){
	state = DummyWalkingStateReturn;	
}

function DummyWalkingStateReturn(){
	if(instance_exists(global.dummy_pole_inst))
	{
		var _target_x = global.dummy_pole_inst.x;
		var _dist = _target_x - x;
		if(abs(_dist) >= abs(Vx))
		{
			movement_direction = sign(_dist);
			InstanceRotateCentrally(sign(Vx));
		}
		else
		{
			x = _target_x;
			movement_direction = 0;
			Vx = 0;
			DummyTransformBack();
		}
		EntityMovement();
	}
}

function DummyWalkingStateFree(){
	if(dummy_target == noone || !instance_exists(dummy_target))
	{
		dummy_target = noone;
		if(!DummyWalkingNextTarget())
		{
			DummyWalkingReturnToIdle();
			return;
		}
	}
	var _target_x = 0;
	with(dummy_target)
	{
		_target_x = x;
	}	
	var _dist_vec = _target_x - x;
	if(sign(Vx - _dist_vec) == sign(Vx))
	{
		//Reaching Target
		x = _target_x;
		Vx = 0;
		movement_direction = 0;
	}
	else
	{
		movement_direction = sign(_dist_vec);
		InstanceRotateCentrally(sign(Vx));
	}
	EntityMovement();
	
}

function DummyStateFree(){
	
	//Swing Sound On The Center Of the Ascillation
	if(angle_speed!=0)
	{
		if( abs(angle_difference(image_angle,0)) <= abs(angle_speed) && !audio_is_playing(swing_sound))
		{
			//swing_sound = audio_play_sound_on(my_emitter,sn_dummy_swing,false,1);
			swing_sound = emitter_sound(sn_dummy_swing,false);
			audio_sound_gain(swing_sound,audio_sound_get_gain(swing_sound) * abs(angle_speed/max_angle_speed),0);
		}
	}
	
	//Look for traps
	//if(--transformation_timer <=0)
	//{
	//	var _trap_x = DummyWalkTargetFind();
	//	if(_trap_x!=-1)
	//	{
	//		DummyTransform();	
	//	}
	//}
	
	var _angles_difference = angle_difference(image_angle,angle_goal);
	angle_speed -= sign(_angles_difference) * angle_acceleration;
	
	//Creaking Sound On The Edge Of Ascillation
	if(sign(angle_speed) != sign(angle_speed + sign(_angles_difference) * angle_acceleration))
	{
		//creaking_sound = audio_play_sound_on(my_emitter,sn_dummy_creaking,false,1);
		creaking_sound = emitter_sound(sn_dummy_creaking,false);
		var _gain_level = min(abs(image_angle)/90,1);
		audio_sound_gain(creaking_sound,_gain_level,0);
	}
	
	image_angle += angle_speed;
	
	if(abs(_angles_difference)>1.5)
	{
		image_angle -= _angles_difference/friction_K;
	}
	else
	{
		image_angle -= _angles_difference;
		//image_angle = 0;
	}

	if(abs(angle_speed)>max_angle_speed)
	{
		angle_speed = 0;
		DyingScript();	
	}	
}


















