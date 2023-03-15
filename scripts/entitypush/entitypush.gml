///@arg Inst
///@arg Speed
///@arg Left_Right
///@arg Direction
function EntityPush(_inst,_spd,_side,_angle){
	with(_inst) {
		if(!push_vulnerable)
		{
			return;	
		}
		
		if(object_index == obj_player)
		{
			if(player_shielded || state == PlayerStateThunderForm)
			{
				return;	
			}
		}
		
		if(object_index == obj_dummy_alternative && !dummyWalking)
		{
			angle_speed += (_side * _spd) / push_weight;
			return;
		}
			
		if(object_is_ancestor(object_index,pobj_bullet))
		{
			shooter_id = other.id;
			enemy_parent = other.enemy_parent;
			_spd = (_spd + (sqrt(Vx * Vx + Vy * Vy))) / 2;
			_angle /= 2;
			if(object_is_ancestor(object_index,pobj_targeted_bullet))
			{
				target = noone;	
			}
		}
				
		var _pushed_direction = 90 - (90 - _angle) * _side;
				
		Vx = lengthdir_x(_spd,_pushed_direction);
		Vy = lengthdir_y(_spd,_pushed_direction);
				
		if(object_is_ancestor(object_index,pobj_alive_entity))
		{
			previous_state = state;
			if(!flying)
			{
				state = EntityStatePushed;
			}
			else
			{
				state = EntityStateFlyingPushed;
				Vy = 0;
			}
				
			sprite_index = sprite_pushed;
			image_index = 0;
					
			if(object_index = obj_player) 
			{
				CameraShake(8,FRAME_RATE*0.8);
				input_buffered = noone;
			}
		}
	}
}

///@arg Inst
///@arg Speed
///@arg Left_Right
///@arg Direction
function ObjectPush(_inst,_spd,_side,_direction){
	var _pushed_direction = 90 - (90 - _direction) * _side;
	with(_inst)
	{
		Vx = lengthdir_x(_spd,_pushed_direction);
		Vy = lengthdir_y(_spd,_pushed_direction);
	}
}
