function UnpauseGame(){
	if(global.pause_available)
	{
		with(global.oPlayer)
		{
			unpausing = true;
			instance_create_layer(x-7,y-37,"Effects",obj_pause_explosion);
		}
	
		with(global.oCamera)
		{
			camera_state = camera_previous_state;	
		}
	
		with(obj_pause_menu)
		{
			MenuClose();
		}
	}
	
}