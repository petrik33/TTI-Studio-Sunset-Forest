///@arg x
///@arg y
///@arg layer
///@arg obj
function scene_create_object() {
	var new_inst = instance_create_layer(argument[0],argument[1],argument[2],argument[3]);
	cutscene_end_scene();
	return new_inst
}
