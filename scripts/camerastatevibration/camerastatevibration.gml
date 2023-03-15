function CameraStateVibration(){
	var _direction = random_range(0,360);
	var _xx = lengthdir_x(camera_vibration_magnitude,_direction);
	var _yy = lengthdir_y(camera_vibration_magnitude,_direction);
	x = camera_vibration_x + _xx;
	y = camera_vibration_y + _yy;
}

///@arg magnitude
function CameraStartVibration(_magnitude){
	with(global.oCamera)
	{
		camera_state = CameraStateVibration;
		camera_vibration_x = x;
		camera_vibration_y = y;
		camera_vibration_magnitude = _magnitude;
	}
}

///@arg value
function CameraVibrationIncrease(_value){
	with(global.oCamera)
	{
		camera_vibration_magnitude += camera_vibration_magnitude * _value;
	}
}

function CameraStopVibration(){
	with(global.oCamera)
	{
		x = camera_vibration_x;
		y = camera_vibration_y;
		camera_vibration_magnitude = 0;
	}
}