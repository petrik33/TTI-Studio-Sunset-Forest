///@arg sound_id
///@arg x
///@arg y
function sound_xy(_sound_id,_x = x, _y = y)
{
	var _sound = audio_play_sound_at(_sound_id,_x,_y,0,falloff_ref_dist,falloff_max_dist,falloff_factor,false,1);
	audio_sound_gain(_sound,sounds_hidden_gain * global.sounds_group_gain,0);
	return (_sound);	
}