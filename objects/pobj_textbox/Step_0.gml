lerp_progress += (1-lerp_progress) / 100;
skip_button = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left);

if(skip_button)
{
	lerp_progress = 1;
	//var _closest_sentence_end = string_length(text);
	//for(var j = 0; j < array_length(sentence_end_chars)-1; j++)
	//{
	//	var _closest_sign = string_pos_ext(sentence_end_chars[j],text,text_progress+1);
	//	if(_closest_sign>text_progress)
	//	{
	//		_closest_sentence_end = min(_closest_sentence_end,_closest_sign);
	//	}
	//}
	text_progress = string_length(text);
	pause_timer = 0;
}

if(text_progress<string_length(text))
{
	image_index = 0;
	if(!sentence_end)
	{
		text_progress += global.text_speed;	
		#region//Check For The Sentence End
		var _current_char = string_char_at(text,text_progress);
		var _end_chars_number = array_length(sentence_end_chars);
		for(var i = 0;i<_end_chars_number;i++)
		{
			if(_current_char == sentence_end_chars[i])
			{
				sentence_end = true;
				var _end_chars_number_no_comma = _end_chars_number - 1;
				
				#region//Double End Sign Check
				var _next_char = string_char_at(text,text_progress+1);
				for(var d = 0;d<_end_chars_number_no_comma;d++)
				{
					if(_next_char == sentence_end_chars[d])
					{
						sentence_end = false;
						break;
					}
				}
				#endregion
				
				break;
			}
		}
		#endregion
	}
	else
	{
		//Between Sentence Pause
		if(++pause_timer>=between_sentence_pause)
		{
			text_progress++;
			pause_timer = 0;
			sentence_end = false;
		}
	}
	
}
else
{
	image_index = 1;
}


x1 = lerp(x1,x1Target,lerp_progress);
x2 = lerp(x2,x2Target,lerp_progress);
