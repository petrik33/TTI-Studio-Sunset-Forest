function PauseGame(){
	
	if(global.pause_available)
	{
	
		StopGame();
		
		clock_hide();
		
		CameraMoveTo(global.oCamera.x,camera_pause_y_target,CAMERA_CS_SPD / 9,true);
		
		//PauseBGMusic(MILI_TO_SECONDS * 3);
		
		with(global.oPlayer)
		{
			paused_y = y;
			pausing = true;
			player_gui_display = false;
			
			pause_waving_progress = 0;
		
			instance_create_layer(x-7,y-37,"Effects",obj_pause_explosion);
		}
		
		BossHideGUI();
	}
	
}

function PlayerStop(){
	previous_image_speed = image_speed;
	image_speed = 0;
	paused_image_index = image_index;
	paused_sprite = sprite_index;
	if(time_source_exists(frost_ui_time_source))
	{
		time_source_pause(frost_ui_time_source);
	}
}

function PlayerUnstop(){
	if(image_speed == 0)
	{
		image_speed = previous_image_speed;
		image_index = paused_image_index;
		sprite_index = paused_sprite;
	}
	if(time_source_exists(frost_ui_time_source))
	{
		time_source_resume(frost_ui_time_source);
	}
}