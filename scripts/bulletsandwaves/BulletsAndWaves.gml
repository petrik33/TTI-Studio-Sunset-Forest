function BulletCollision(){
	var _collided_with = instance_place(x+Vx,y+Vy,pobj_colliding_entity);
	x+=Vx;
	y+=Vy;
	if(y>FLOOR_Y)
	{
		if(hit_effect != noone)
		{
			//Hitting Floor
			with(EffectCreate(x,FLOOR_Y,hit_effect,image_xscale,false))
			{
				image_angle = other.image_angle;	
			}
		}
		instance_destroy();	
	}
	return _collided_with;
}

function BulletAnimation(){
	if(!anim_looped)
	{
		if(!anim_ended && AnimationEnd())
		{
			//image_index = last_frame;
			image_speed = 0;
			anim_ended = true;
		}
	}	
}

function WaveCollision(){
	x += Vx;
	y += Vy;
	if(floor_colliding && y > FLOOR_Y)
	{
		instance_destroy();
		exit;
	}
	#region//Entity Collision
	var _hit_list = ds_list_create();
	var _hit_number = instance_place_list(x,y,pobj_colliding_entity,_hit_list,false);
	for(var i = 0;i<_hit_number;i++)
	{
		var _inst_hit = _hit_list[| i];
		if(_inst_hit.id != shooter_id)
		{
			var _obj_id = _inst_hit.object_index;
			if(object_is_ancestor(_obj_id,pobj_wave))
			{
				instance_destroy(_inst_hit);
				instance_destroy();
				break;
			}
			if(ds_list_find_index(hit_by_attack,_inst_hit)=-1)
			{
				ds_list_add(hit_by_attack,_inst_hit);
				if(push_effect != noone)
				{
					EntityPush(_inst_hit,push_effect[0],image_xscale,push_effect[1]);
				}
				if(object_is_ancestor(_obj_id,enemy_parent))
				{
					switch(on_hit_script)
					{	
						case EntityDamage:
						
						on_hit_script(_inst_hit,image_xscale);
						
						break;
						
						case PlayerSpecialAddProgress:
						
						on_hit_script(skill_enum);
						
						break;
						
						default:
						
						break;
					}
				}
			}
		}
		else
		{
			_hit_number--;
		}
	}
	if(_hit_number > 0)
	{
		if(destroy_on_hit) instance_destroy();	
	}
	ds_list_destroy(_hit_list);
	#endregion
}