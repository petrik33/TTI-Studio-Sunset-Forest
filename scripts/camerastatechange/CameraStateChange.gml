///@arg state
function CameraStateChange(_state){
	with(global.oCamera)
	{
		camera_state = _state;
	}
}

///@arg target
function CameraChangeTarget(_target){
	if(instance_exists(_target))
	{
		with(global.oCamera)
		{
			follow_target = _target;
		}
	}
}

///@arg target
function CameraChangeSecondaryTarget(_target){
	with(global.oCamera)
	{
		secondary_follow_target = _target;	
	}	
}