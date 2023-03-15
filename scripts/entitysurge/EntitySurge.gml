///@arg sprite
///@arg object
///@arg x
///@arg y
///@arg layer
///@arg xscale
///@arg sound
function EntitySurge(_sprite_surging,_object_to_surge,_x,_y,_layer_id,_image_xscale,_sound){
	var _surged_entity = instance_create_layer(_x,_y,_layer_id,_object_to_surge)
	with(_surged_entity)
	{
		sprite_index = _sprite_surging;
		state = EntityStateSurging;
		InstanceRotateCentrally(_image_xscale);
		if(_sound != noone)
		{
			sound_xy(_sound);
		}
	}
	
	return _surged_entity;
}