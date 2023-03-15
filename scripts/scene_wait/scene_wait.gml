///@arg seconds
function scene_wait(argument0) {
	if(skip_button) scene_timer = argument0*FRAME_RATE
	if(scene_timer >= argument0*FRAME_RATE)
	{
		cutscene_end_scene();	
	}
}

///@arg seconds
function scene_wait_dark_matter_CS(argument0) {
	if(skip_button)
	{
		scene_timer = argument0*FRAME_RATE;
		global.oPlayer.Vx = 0;
	}
	if(scene_timer >= argument0*FRAME_RATE)
	{
		cutscene_end_scene();	
	}
}
