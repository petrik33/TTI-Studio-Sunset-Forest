///@arg width
///@arg height
function WindowSet(window_width,window_height){
	window_width = max(window_width,ORIGINAL_VIEW_W);
	window_height = max(window_height,ORIGINAL_VIEW_H);
	
	var _view_scale = min(window_width div ORIGINAL_VIEW_W,window_height div ORIGINAL_VIEW_H);
	
	var view_width = clamp(window_width / _view_scale,ORIGINAL_VIEW_W,MAX_VIEW_W);
	var view_height = clamp(window_height / _view_scale,ORIGINAL_VIEW_H,MAX_VIEW_H);
	
	#region Application Surface
	
	var surface_width = view_width * _view_scale;
	var surface_height = view_height * _view_scale;

	surface_resize(application_surface,surface_width,surface_height);
	with(pobj_time_cycler)
	{
		if(surface_exists(srf_lights))
		{
			surface_resize(srf_lights,view_width,view_height);
		}	
	}
	
	#endregion
	
	#region GUI
	
	var _gui_xoffset = (window_width - surface_width) / 2;
	var _gui_yoffset = (window_height - surface_height) / 2;

	display_set_gui_maximize(_view_scale,_view_scale,_gui_xoffset,_gui_yoffset);
	
	global.initial_viewW = view_width;
	global.initial_viewH = view_height;
	global.initial_viewScale = _view_scale;
	
	global.GUI_W = view_width;
	global.GUI_H = view_height;
	
	global.GUI_SCALE = _view_scale;
	
	global.GUI_XOFFSET = _gui_xoffset;
	global.GUI_YOFFSET = _gui_yoffset;

	#endregion
	
	#region Camera
	
	with(obj_camera)
	{
		view_w_half = view_width * 0.5;
		view_h_half = view_height * 0.5;
		
		global.viewScale = 1;
	
		camera_set_view_size(cam,view_width,view_height);
	}
	
	#endregion
	
	
	
}