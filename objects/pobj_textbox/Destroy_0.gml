if(audio_is_playing(global.text_sound))
{
	audio_sound_gain(global.text_sound,0,text_sound_fadein_time);
	with(obj_game)
	{
		alarm[4] = 30;//Stop Sound	
	}
}