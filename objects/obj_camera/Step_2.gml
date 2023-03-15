script_execute(camera_state);

//screen shake
if(shake_remain>0)
{
	x+=random_range(-shake_remain,shake_remain);
	y+=random_range(-shake_remain,shake_remain);
	//if(!global.boss_earthquake)
	//{
		shake_remain=max(0,shake_remain-((1/shake_length)*shake_magnitude));
	//}
}

if(camera_clamp)
{
	x = clamp(x,global.leftEdge + view_w_half+BUFF,global.rightEdge-view_w_half-BUFF);
}
//y=clamp(y,view_h_half+BUFF,room_height-view_h_half-BUFF); can't happen normally

var _camera_x = x - view_w_half;

#region//Parallax Scrolling

for(var i = 0;i<array_length(bg_layers);i++)
{
	layer_x(bg_layers[i],lerp(0,_camera_x,bg_layers_spd[i]));
}

#endregion

//Update camera view
camera_set_view_pos(cam,_camera_x,y-view_h_half);

//Listener Postion Change
audio_listener_position(x,y,0);