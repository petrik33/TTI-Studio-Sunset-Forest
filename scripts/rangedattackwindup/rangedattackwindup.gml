function RangedAttackWindUp(){
	//var _shooting_index = image_index;
	//if(attack_struct.attack_sprite_is_VFX) _shooting_index = attack_struct.attack_vfx.image_index;
	with(attack_struct)
	{
		//if(attack_charge_count >= attack_ranged_targeting_buffer)
		//{
			if(!attack_range_delayed && attack_charge_count == attack_ranged_targeting_buffer)
			{
				AttackPlayerWorry();
				RangedAttackTarget();
			}
			if(attack_charge_count == attack_charge_target)
			{
				if(instance_exists(attack_target_inst))
				{
					//Shoot
					attack_cooldown = 0;
					if(attack_ranged_targeted)
					{
						BulletShoot(attack_owner,attack_x_offset,attack_y_offset,bullet_object,attack_direction,attack_target_inst);
					}
					else
					{
						BulletShoot(attack_owner,attack_x_offset,attack_y_offset,bullet_object);	
					}
				
					with(attack_owner)
					{
						emitter_sound(other.attack_sound,false);
						if(!other.attack_sprite_is_VFX)
						{
							EntityWindDown();
						}
						else
						{
							EntityMakeFree();
						}
					}
				}
				else
				{
					with(attack_owner) EntityMakeFree();
					exit;
				}
			}
		//}
		//else
		//{
		//	if(instance_exists(attack_target_inst))
		//	{
		//		if(attack_sprite_is_vfx && attack_vfx_targeted)
		//		{
		//			var _target_offset = SpriteBBoxYOffsetCenter(attack_target_inst.sprite_index,true) * 0.8;//0.25 of the bbox height
		//			with(attack_vfx)
		//			{
		//				var _direction = point_direction(x,y,other.attack_target_inst.x,other.attack_target_inst.bbox_bottom + _target_offset);
		//				image_angle = _direction;
		//			}
		//		}
		//	}
		//	else
		//	{
		//		EntityMakeFree();
		//		exit;
		//	}
		//}
		
		attack_charge_count++;
	}
}

function RangedAttackTarget(){
	var _max_angle_sin = 0;
	
	var _x = attack_owner.x + attack_x_offset * attack_owner.image_xscale;
	var _y = attack_owner.y + attack_y_offset;
	
	if(attack_ranged_targeted)
	{
		var _target_offset = SpriteBBoxYOffsetCenter(attack_target_inst.sprite_index,true) * 0.8;//0.25 of the bbox height
		var _shot_direction = point_direction(_x,_y,attack_target_inst.x,attack_target_inst.bbox_bottom + _target_offset);
		var _rad_dir = degtorad(_shot_direction);
		
		if(sin(_rad_dir) > _max_angle_sin)
		{
			var _cos_sign = sign(cos(_rad_dir));
			_rad_dir = arcsin(_max_angle_sin);
			if(_cos_sign == -1) _rad_dir = pi - _rad_dir;
			_shot_direction = radtodeg(_rad_dir);
		}
		attack_direction = _shot_direction;
	}
	else
	{
		attack_direction = 90 - 90 * attack_owner.image_xscale;	
	}
}

///@arg shooter
///@arg xoffset
///@arg yoffset
///@arg bullet
///@arg direction*
///@arg target*
function BulletShoot(_shooter,_xoffset,_yoffset,_bullet){
	with(instance_create_layer(_shooter.x + _xoffset*_shooter.image_xscale,_shooter.y+_yoffset,"Effects",_bullet))
	{
		if(argument_count > 4)
		{
			//Targeted Shot
			direction = argument[4];
			image_angle = direction;
			Vx = lengthdir_x(spd,direction);
			Vy = lengthdir_y(spd,direction);
		}
		else
		{
			image_xscale = _shooter.image_xscale;
			Vx = spd * image_xscale;
		}
		
		if(object_is_ancestor(object_index,pobj_targeted_bullet))
		{
			target = argument[5];//target inst
		}
		shooter_id = _shooter.id;
	}
		
}

/////@arg shooter
/////@arg xoffset
/////@arg yoffset
/////@arg bullet
/////@arg xscale
/////@arg target
//function BulletShootSide(_shooter,_xoffset,_yoffset,_bullet,_side){
//	with(instance_create_layer(_shooter.x + _xoffset*_shooter.image_xscale,_shooter.y+_yoffset,"Effects",_bullet))
//	{
//		image_xscale =_side;
//		Vx = spd * _side;
//		if(object_get_parent(object_index) == pobj_targeted_bullet)
//		{
//			target = argument[5];//target inst
//			direction = _shot_direction;
//		}
//		shooter_id = _shooter.id;
//	}
		
//}