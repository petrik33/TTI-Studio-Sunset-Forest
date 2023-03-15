///@arg visible
function LayersSetVisible(_visible = true){
	var _backg_layer = layer_get_id("Background");
	var _tiles_layer = layer_get_id("Tiles")
	var _trees_layer = layer_get_id("Trees")
		
	layer_set_visible(_backg_layer,_visible);
	layer_set_visible(_tiles_layer,_visible);
	layer_set_visible(_trees_layer,_visible);
}