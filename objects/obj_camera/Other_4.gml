view_enabled = true;
view_visible[0] = true;
cam = view_camera[0];
camera_set_view_size(cam,view_w_half * 2,view_h_half * 2);

if(room == room0)
{
	x = camera_start_x;
	
	#region//Paralax Scrolling

	var bg_layer_trees = layer_get_id("Trees");
	var bg_layer_sky = layer_get_id("Background");

	bg_layers = [bg_layer_trees,bg_layer_sky];
	bg_layers_spd = [0.26,0.66];

	var _camera_x = camera_get_view_x(view_camera[0]);
	for(var i = 0;i<array_length(bg_layers);i++)
	{
		layer_x(bg_layers[i],lerp(0,_camera_x,bg_layers_spd[i]));
	}

	#endregion
}