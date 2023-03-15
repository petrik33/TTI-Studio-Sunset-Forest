function PlayerStatePush() {
#region//Movement

#region//Controls

#region//Movement Controls
var grounded = (FLOOR_Y - y) <= from_floor_to_jump;
var key_right = ( keyboard_check(vk_right) || keyboard_check(ord("D")) ); 
var key_left = ( keyboard_check(vk_left) || keyboard_check(ord("A")) );
var key_jump = keyboard_check_pressed(vk_space);
#endregion

#endregion

if(key_jump && grounded)
{
	Vy = -jump_spd;	
}

movement_direction = key_right - key_left;

spd *= hero_in_attack_spd_factor;
EntityMovement();
spd /= hero_in_attack_spd_factor;

#endregion

#region//Pushing

var _previous_mask = mask_index;
mask_index = pushingHB;

var hit_list = ds_list_create();
var entity_hits_number = instance_place_list(x,y,pobj_colliding_entity,hit_list,true);

for(var i=0;i<entity_hits_number;i++)
{
	var _inst = hit_list[| i];
	if(ds_list_find_index(hit_by_attack,_inst)=-1)
	{
		if(!object_is_ancestor(_inst.object_index,pobj_boss))
		{
			EntityPush(_inst,pushing_speed,image_xscale,pushing_direction);
			with(_inst) AudioPlaySoundRandom(sn_enemy_hit1);
			ds_list_add(hit_by_attack,_inst);
		}
	}
}	

mask_index = _previous_mask;
ds_list_destroy(hit_list);

#endregion

if(AnimationEnd())
{
	EntityMakeFree();
	ds_list_clear(hit_by_attack);
}

if(Vx!=0)
{
	if(!keyboard_check(global.backwards_control))
	{
		InstanceRotateCentrally(sign(Vx));
	}
}

}
