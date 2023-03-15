///@arg string
function scene_textbox_insert_text() {
	with(global.current_text_box)
	{
		text += " " + argument[0];
	}
	cutscene_end_scene();
}
