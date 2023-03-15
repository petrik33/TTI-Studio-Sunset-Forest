///@arg text
///@arg font
function scene_textbox_create(_text,_font){
	TextBoxCreate(_text,_font)
	cutscene_end_scene();
}

///@arg text
///@arg [font,sprite,sound]
function TextBoxCreate(_text,_textbox_array){
	if(!instance_exists(pobj_textbox))
	{
		global.current_text_box = instance_create_layer(0,0,"GUI",pobj_textbox);
	}
	with(global.current_text_box)
	{
		if(is_array(_textbox_array))
		{
			var _new_sprite = _textbox_array[1];
			var _new_font = _textbox_array[0];
			var	_new_sound = _textbox_array[2];	
			if(Font(text_font) != Font(_new_font) || _new_sprite != sprite_index)
			{
				lerp_progress = 0;
				x1 = global.GUI_W/2;
				x2 = global.GUI_W/2;
			}
			text_font = Font(_new_font);
			sprite_index = _new_sprite;
			var _text_sound_fadeIn_time = MILI_TO_SECONDS * 0.25;
			if(text_sound_resource != _new_sound)
			{
				if(audio_is_playing(global.text_sound))
				{
					audio_stop_sound(global.text_sound);
				}
				text_sound_resource = _new_sound;
				global.text_sound = PlayerSoundMake(text_sound_resource,,,true,_text_sound_fadeIn_time);
			}
		}
		text = TextSeparate(_text,text_font,text_width);
		text_progress = 0;
	}
}

///@arg text
///@arg font
///@arg width
function TextSeparate(_text,_font,_max_line_width){
	draw_set_font(_font);
	
	var _last_new_line_position = 1;
	var _text_length = string_length(_text);
	
	while(string_width(string_copy(_text,_last_new_line_position,_text_length - _last_new_line_position)) > _max_line_width)
	{
		var _space_position = _last_new_line_position;
		var _next_space = _space_position;
		
		do
		{
			_space_position = _next_space;
			_next_space = string_pos_ext(" ",_text,_space_position);
			if(_next_space == 0) _next_space = _text_length;

			var _text_line_string = string_copy(_text,_last_new_line_position,_next_space - _last_new_line_position);
			var _text_line_width = string_width(_text_line_string);
		}
		until(_text_line_width >= _max_line_width);
		
		_text = string_delete(_text,_space_position,1);
		_text = string_insert("\n",_text,_space_position);
		_last_new_line_position = _space_position+1;
	}
	
	return _text;
}
