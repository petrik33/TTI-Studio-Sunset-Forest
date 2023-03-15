///@arg sound_id
///@arg loops
function emitter_sound(_sound_id,_loops = false){
	var _sound = audio_play_sound_on(my_emitter,_sound_id,_loops,1);
	audio_sound_gain(_sound,sounds_hidden_gain * global.sounds_group_gain,0);
	return _sound;
}