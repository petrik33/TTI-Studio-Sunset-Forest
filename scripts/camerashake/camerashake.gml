/// @desc CameraShake (magnitude,frames)
/// @arg Magnitude sets the strength of the shake (radius in pixels)
/// @arg Frames sets the length of the shakes in frames
function CameraShake(argument0, argument1) {
	with(obj_camera)
	{
		if(camera_state != CameraStateStatic)
		{
			if(argument0 > shake_remain)
			{
				shake_magnitude=argument0;
				shake_remain=argument0;
				shake_length=argument1;
			}
		}
	}


}
																		