///@arg text
function scene_new_text() {
	with(global.current_text_box)
	{
		text_progress = 0;
		text = argument0;
	}
	cutscene_end_scene()


}
