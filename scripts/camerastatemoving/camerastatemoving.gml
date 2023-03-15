function CameraStateMoving(){	
	direction = point_direction(x,y,xTo,yTo);
	
	if(point_distance(x,y,xTo,yTo)>=camera_spd)
	{
		x += lengthdir_x(camera_spd,direction)
		y += lengthdir_y(camera_spd,direction)
	}
	else
	{
		x = xTo;
		y = yTo;
		if(!camera_move_stay)
		{
			camera_state = camera_previous_state;
		}
		exit;
	}
}

///@arg x
///@arg y
///@arg spd
function CameraMoveTo(_x,_y,_spd,_stay){
	with(global.oCamera)
	{
		camera_move_stay = _stay;
		camera_previous_state = camera_state;
		camera_state = CameraStateMoving;
		xTo = clamp(_x,view_w_half+BUFF,room_width-view_w_half-BUFF);
		yTo = clamp(_y,view_h_half+BUFF,room_height-view_h_half-BUFF);
		if(_spd != noone)
		{
			camera_spd = _spd;
		}
		else
		{
			camera_spd = CAMERA_CS_SPD;	
		}
	}
		
}