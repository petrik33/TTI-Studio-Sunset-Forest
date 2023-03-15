function IcicleStateFree(){
	#region//Movement
	
	var _owner_side = owner.image_xscale
	image_xscale = _owner_side;
	
	var _target_x = owner.x + x_offset_to_owner * _owner_side;
	var _target_y = owner.y + y_offset_to_owner;
	var _x_diff = _target_x - x;
	var _y_diff = _target_y - y;
	
	var _direction = point_direction(x,y,_target_x,_target_y);
	var _Vx = lengthdir_x(spd,_direction);
	var _Vy = lengthdir_y(spd,_direction);
	
	
	if(abs(_x_diff) <= _Vx)
	{
		x = _target_x;	
	}
	else
	{
		x += _Vx;
	}
	
	if(abs(_y_diff) <= _Vy)
	{
		y = _target_y;	
	}
	else
	{
		y += _Vy;
	}
	#endregion
	
	#region//Attack Detecting
	
	var _owners_list = owner.hit_by_attack;
	if(!ds_list_empty(_owners_list))
	{
		var _inst = _owners_list[| 0];
		if(instance_exists(_inst))
		{
			IcicleAttack(_inst);
		}
	}
	
	
	#endregion
}

///@arg inst
function IcicleAttack(_inst){
	sprite_index = sprite_attack;
	image_index = 0;
	target = _inst;
	state = IcicleStateAttack;
	target_y_offset = (target.bbox_top + target.bbox_bottom) / 2 - target.y;
}

function IcicleStateAttack(){
	if(instance_exists(target))
	{
		var _direction = point_direction(x,y,target.x,target.y + target_y_offset);
		var _Vx = lengthdir_x(attack_spd,_direction);
		var _Vy = lengthdir_y(attack_spd,_direction);
		x+=_Vx;
		y+=_Vy;
		if(place_meeting(x,y,target))
		{
			lives_left --;
			EntityDamage(target,sign(_Vx));
			if(lives_left>0)
			{
				EntityMakeFree();	
			}
			else
			{
				DyingScript();	
			}
		}
	}
	else
	{
		EntityMakeFree();	
	}
}