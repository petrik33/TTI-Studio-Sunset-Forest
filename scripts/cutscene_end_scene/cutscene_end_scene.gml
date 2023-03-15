function cutscene_end_scene() {
	scene_timer = 0;
	scene++;
	scene_first_frame = true;

	if(scene>=array_length(scene_info))
	{
		time_state_change(time_state_free);
		
		instance_destroy(global.current_text_box);
		global.current_text_box = noone;
		
		script_execute(cutscene_ending);
		
		instance_destroy(self);
		global.current_cutscene = noone;
		exit;
	}
	
	var new_scene = scene_info[@ scene];
	
	if(new_scene[0]!=scene_textbox)
	{
		if(instance_exists(pobj_textbox))
		{
			instance_destroy(global.current_text_box)	
		}
	}
}
