function CameraStateFollowDouble() {
	//Update destination
	if(instance_exists(follow_target))
	{
		//xTo=follow_target.x;
		//yTo=follow_target.y - camera_y_offset;
		yTo=follow_target.y - camera_y_offset;
		if(instance_exists(secondary_follow_target))
		{
			xTo=follow_target.x;
			//Find Side Relative to each other
			var _range = 0;
			var _left_edge = 0;
			var _left_target = follow_target;
			var _right_target = secondary_follow_target;
			if(secondary_follow_target.x < _left_target.x)
			{
				_left_target = secondary_follow_target;
				_right_target = follow_target;
			}
			
			_left_edge = _left_target.bbox_left;
			_range = _right_target.bbox_right - _left_edge;
			
			if(_range < camera_get_view_width(view_camera[0]))
			{
				xTo = _left_edge + _range / 2;
			}
		}
	}
	
	//Update object position
	x+=(xTo-x)/10;
	y+=(yTo-y)/10;
}
