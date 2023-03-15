image_speed = 0;

text_font = Font(fn_cutscenes);

draw_set_font(text_font);
var _default_box_height = string_height("Default Text\n Default Text") + GUI_BOUND * 2;
box_height = _default_box_height
box_width = global.GUI_W - GUI_BOUND * 2 - 32;
text_width = box_width - GUI_BOUND * 2
x1 = global.GUI_W/2;
x2 = global.GUI_W/2;

x1Target = GUI_BOUND;
x2Target = global.GUI_W - GUI_BOUND;

sentence_end_chars = [".","!","?",","];
sentence_end = false;

text_progress = 0;
lerp_progress = 0;

//box_sprite = -1;

text = "Default Text";

text_sound_resource = noone;
if(text_sound_resource != noone)
{
	if(!audio_is_playing(global.text_sound))
	{
		global.text_sound = PlayerSoundMake(text_sound_resource,,,true,text_sound_fadein_time);	
	}
	else
	{
		audio_sound_gain(global.text_sound,sounds_hidden_gain * global.sounds_group_gain,text_sound_fadein_time);	
	}
}

between_sentence_pause = FRAME_RATE * 0.4;
pause_timer = 0;
