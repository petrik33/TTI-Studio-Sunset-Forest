/// @desc zooms camera view
function CameraZoom(zoom = 1){
	with(obj_camera)
	{
		var view_width = global.initial_viewW / zoom;
		view_w_half = view_width / 2;
		var view_height = global.initial_viewH / zoom;
		view_h_half = view_height / 2;
		
		global.viewScale = zoom;
	
		camera_set_view_size(cam,view_width,view_height);
	}
}