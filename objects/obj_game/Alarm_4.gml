///@desc Text Sound Stop
if(audio_is_playing(global.text_sound) && audio_sound_get_gain(global.text_sound) <= 0)
{
	audio_stop_sound(global.text_sound);	
}