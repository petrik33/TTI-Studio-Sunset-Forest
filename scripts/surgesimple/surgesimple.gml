///@arg x
///@arg y
///@arg layer
///@arg sprite
///@arg object
///@arg image_xscale
function SurgeSimple(_x,_y,_layer_id,_sprite_surging,_object_to_surge,_image_xscale){
	var _surged = instance_create_layer(_x,_y,_layer_id,pobj_surger);
	with(_surged)
	{
		sprite_index = _sprite_surging;
		object_to_surge = _object_to_surge;
		image_xscale = _image_xscale;
	}
	
	return _surged;
}