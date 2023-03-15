///@arg x
///@arg y
///@arg spd
function scene_camera_move(xx, yy, _spd) {
	with(global.oCamera)
	{
		if(other.scene_first_frame)
		{
			other.scene_first_frame = false;
			if(camera_state == CameraStateFollow)
			{
				camera_state = CameraStateStatic;	
			}
		}
		
		if(camera_clamp)
		{
			xx=clamp(xx,view_w_half+BUFF,room_width-view_w_half-BUFF);
			yy=clamp(yy,view_h_half+BUFF,room_height-view_h_half-BUFF);
		}
		
		direction = point_direction(x,y,xx,yy);
	
		//Skipping
		if(other.skip_button)
		{
			x = xx;
			y = yy;
		}
	
		if(point_distance(x,y,xx,yy)>=_spd)
		{
			x += lengthdir_x(_spd,direction)
			y += lengthdir_y(_spd,direction)
		}
		else
		{
			x = xx;
			y = yy;
			with(other)
			{
				cutscene_end_scene();
			}
		}
	}


}
