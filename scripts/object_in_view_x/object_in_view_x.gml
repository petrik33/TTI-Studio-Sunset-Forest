/////@arg inst
//function object_in_view_x(_inst){
	
//	var _in_view = false;
	
//	if(instance_exists(_inst))
//	{
//		var _camera_x1 = camera_get_view_x(view_camera[0]);
//		var _camera_w = global.view_w;
	
//		var _camera_x2 = _camera_x1 + _camera_w;
	
//		if(_inst.bbox_left >= _camera_x1 && _inst.bbox_right <= _camera_x2)
//		{
//			_in_view = true;	
//		}
//	}
	
//	return _in_view

//}