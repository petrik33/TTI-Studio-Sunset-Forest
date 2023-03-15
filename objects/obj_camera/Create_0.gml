cam = view_camera[0];
//camera_set_view_size(cam,global.view_w,global.view_h);

//global.windowed = true;

camera_clamp = true;

var display_w = display_get_width();
var display_h = display_get_height();
view_wport[0] = display_w;
view_hport[0] = display_h;

if(!global.windowed)
{
	WindowSet(display_w,display_h);
	window_set_fullscreen(true);
}
else
{
	//WindowSetSize(display_w/windowed_downscale,display_h/windowed_downscale);
	WindowSetSize(1366,900);
	window_set_fullscreen(false);
}
//WindowSet(1333,850);

camera_y_offset = 120;
x = camera_start_x;
y = CAMERA_Y;

camera_previous_state = noone;

#region//Audio

audio_listener_set_orientation(0,0,0,1,0,-1,0);

#endregion

camera_set_view_pos(cam,x-view_w_half,y-view_h_half);
camera_state = CameraStateStatic;

follow_target = -1;
xTo = -1;
yTo = -1;

camera_spd = CAMERA_CS_SPD;

camera_vibration_magnitude = 0;
camera_vibration_x = x;
camera_vibration_y = y;

//camera_zoom = 1;

secondary_follow_target = noone;

shake_remain = 0;
shake_magnitude = 0;
shake_length = 0;

function CameraClamp(flag=true){
	camera_clamp = flag;
}

//earthquake_magintude = 0;
