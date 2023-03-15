///@arg sprite
function AttachedLightCreate(_sprite){
	var _light_inst = instance_create_layer(x,y,"Lights",pobj_light);
	var spr_spd = sprite_get_speed(sprite_index);
	var spr_spd_type = sprite_get_speed_type(sprite_index);
	with(_light_inst)
	{
		sprite_index = _sprite;
		sprite_set_speed(sprite_index,spr_spd,spr_spd_type);
		image_angle = other.image_angle;
		image_xscale = other.image_xscale;	
	}
	return _light_inst;
}

///@arg sprite
///@arg target
function DynamicLightOnTarget(_sprite,_target){
	var _light_inst = instance_create_layer(_target.x,_target.y,"Lights",pobj_dynamic_light);
	with(_light_inst)
	{
		sprite_index = _sprite;
		image_xscale = _target.image_xscale;
		attack_target_inst = _target;
	}
	return _light_inst;
}

function BulletAttachedLightUpdate(){
	if(instance_exists(light_instance))
	{
		light_instance.x = x;
		light_instance.y = y;
		light_instance.image_angle = image_angle;
	}
}

///@arg x
///@arg y
///@arg sprite
function LightCreate(_x,_y,_sprite){
	var _light = instance_create_layer(_x,_y,"Lights",pobj_light);
	with(_light)
	{
		sprite_index = _sprite;	
	}
	return _light
}