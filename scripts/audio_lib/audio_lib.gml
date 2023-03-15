///@arg sound
///@arg time
///@arg loops
function AudioFadeIn(_sound_id,_time,_loops){
	var _sound = audio_play_sound(_sound_id,sounds_hidden_gain * global.sounds_group_gain,_loops);
	audio_sound_gain(_sound,0,0);
	audio_sound_gain(_sound,sounds_hidden_gain * global.sounds_group_gain,_time);
	return (_sound);
}

///@arg *[sounds]
///@arg min_pitch
///@arg max_pitch
///@arg min_gain
///@arg max_gain
///@arg loops
function AudioPlaySoundRandom(_sn_array,_min_pitch = MIN_PITCH_DEFT,_max_pitch = MAX_PITCH_DEFT,_min_gain = MIN_GAIN_DEFT,_max_gain = MAX_GAIN_DEFT,_loops = false)
{
	if(is_array(_sn_array))
	{
		var _sound = _sn_array[irandom(array_length(_sn_array)-1)];
	}
	else
	{
		var _sound = _sn_array;
	}
	
	var _pitch = random_range(_min_pitch,_max_pitch);
	var _gain = random_range(_min_gain,_max_gain);
	
	//var _played_sound = audio_play_sound_on(my_emitter,_sound,_loops,1);
	var _played_sound = emitter_sound(_sound,_loops);
	audio_sound_pitch(_played_sound,_pitch);
	audio_sound_gain(_played_sound,_gain * sounds_hidden_gain * global.sounds_group_gain,0);
	
	return _played_sound;
}
