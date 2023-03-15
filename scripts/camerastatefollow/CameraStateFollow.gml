function CameraStateFollow() {
	//Update destination
	if(instance_exists(follow_target))
	{
		xTo=follow_target.x;
		yTo=follow_target.y - camera_y_offset;
	}
	
	//Update object position
	x+=(xTo-x)/10;
	y+=(yTo-y)/10;
}
