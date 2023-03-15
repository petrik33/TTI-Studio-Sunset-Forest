#region Sounds Managment

///@arg sound
///@arg time
///@arg loops
function MusicFadeIn(_sound_id,_time,_loops = false){
	var _sound = audio_play_sound(_sound_id,1,_loops);
	audio_sound_gain(_sound,0,0);
	audio_sound_gain(_sound,global.music_group_gain,_time);
	return (_sound);
}

///@arg sound
///@arg time
function MusicFadeResume(_sound,_time){
	audio_resume_sound(_sound);
	audio_sound_gain(_sound,global.music_group_gain,_time);
	return _sound;
}

///@arg sound
///@arg time
function MusicFadeOut(_sound,_time){
	//if(!audio_exists(_sound_id)) return _sound_id;
	audio_sound_gain(_sound,0,_time);
	return _sound;
}

///@arg sound
///@arg time
function MusicFadeOutStop(_sound,_time = fade_time.normal) {
	if(audio_exists(_sound))
	{
		MusicFadeOut(_sound,_time);
		var _callback = function (_sound) {
			audio_stop_sound(_sound);	
		}
		time_source_reconfigure(music_tsource_stopping,_time/MILI_TO_SECONDS,time_source_units_seconds,_callback,[_sound]);
		time_source_start(music_tsource_stopping);
	}
}

///@arg time
function PauseMusicFadeOutStop(_time = fade_time.normal) {
	if(audio_exists(pause_track))
	{
		MusicFadeOut(pause_track,_time);
		var _callback = function () {
			audio_stop_sound(pause_track);	
		}
		time_source_reconfigure(music_tsource_stopping_pause,_time/MILI_TO_SECONDS,time_source_units_seconds,_callback);
		time_source_start(music_tsource_stopping_pause);
	}
}

#endregion

#region Global Callbacks

function MusicCallbackNone(){
	with(global.music_manager)
	{
		music_track = noone;
	}
}

function MusicCallbackDayNight(){
	with(global.music_manager)
	{
		next_track_callback = function(){
			var _track = global.music_manager.tracks_queue[queue_pos];
			MusicStart(_track,fade_time.fast,global.MusicCallbackDayNight);
		}
	
		queue_pos++;
		if(queue_pos == array_length(tracks_queue))
		{
			queue_pos = 0;	
		}
		
		//var _start_time = RangeArrayGetNumber(tracks_start_time_range[queue_pos],false);
		//var _time_wait = _start_time - global.time;
		//if(_time_wait < 0) _time_wait += 1;
		//_time_wait *= day_length;
		
		var _time_wait = music_day_night_gap;
	
		music_track = noone;
		
		time_source_reconfigure(music_tsource_next_track,round(_time_wait),time_source_units_frames,next_track_callback);
		time_source_start(music_tsource_next_track);
		
	}
}

function MusicCallbackLoopDelayed(){
	with(global.music_manager)
	{
		var _loopedTrack = audio_get_name(music_track);
		var _loopedAsset = asset_get_index(_loopedTrack);
		
		//var _gap = _delay;
		//if(is_array(_delay))
		//{
		//	_gap = RangeArrayGetNumber(_delay,false);	
		//}
		
		var _delay = RangeArrayGetNumber(loop_delay,false);
		
		music_track = noone;
		
		next_track_callback = function(_music){
			MusicStart(_music,,global.MusicCallbackLoopDelayed);
		}
		
		time_source_reconfigure(music_tsource_next_track,_delay,time_source_units_seconds,next_track_callback,[_loopedAsset]);
		time_source_start(music_tsource_next_track);
		
		//music_tracks[ms_track.playing] = noone;
		
		//audio_sound_set_track_position(music_tracks[@ ms_track.playing],0);
	}
}
	
#endregion
	
function MusicDayNightStart(){
	with(global.music_manager)
	{
		MusicStart(tracks_queue[queue_pos],fade_time.slow,global.MusicCallbackDayNight);	
	}
}

///@arg music
///@arg time
///@arg callback
function MusicStart(_music,_time = fade_time.normal,_callback = global.MusicCallbackNone){
	with(global.music_manager)
	{	
		MusicStop(_time);	
		music_track = MusicFadeIn(_music,_time);
		
		var _music_len = audio_sound_length(_music);
		
		next_track_callback = _callback;
		
		time_source_reconfigure(music_tsource_next_track,_music_len,time_source_units_seconds,_callback);
		time_source_start(music_tsource_next_track);
	}
}

///Debug
function MusicSkip(){
	with(global.music_manager)
	{
		var _track = music_track;
		if(audio_exists(_track) && audio_is_playing(_track))
		{
			var trackLen = 	audio_sound_length(_track);
			audio_sound_set_track_position(_track,trackLen*0.95);
			time_source_reconfigure(music_tsource_next_track,trackLen*0.05,time_source_units_seconds,next_track_callback);
			time_source_start(music_tsource_next_track);
		}
		else
		{
			if(time_source_active(music_tsource_next_track))
			{
				time_source_reconfigure(music_tsource_next_track,1,time_source_units_seconds,next_track_callback);
				time_source_start(music_tsource_next_track);
			}
		}
	}
}

///@arg time
function MusicStop(_time = fade_time.normal){
	with(global.music_manager)
	{
		time_source_stop_active(music_tsource_next_track);
		//time_source_stop_active(music_tsource_playing_update);
		//time_source_stop_active(music_tsource_resuming);
		
		var _track = music_track;
		
		if(audio_exists(_track) && audio_is_playing(_track))
		{
			MusicFadeOutStop(_track,_time);
		}
		else
		{
			return;
		}
		
		music_track = noone;
	}
}

///@arg time
function MusicPause(_time = fade_time.normal){
	with(global.music_manager)
	{
		if(time_source_active(music_tsource_next_track))
		{
			time_source_pause(music_tsource_next_track);
		}
		
		var _playingTrack = music_track;
		if(_playingTrack == noone || !audio_is_playing(_playingTrack))
		{
			return;
		}
		
		MusicFadeOut(_playingTrack,_time);
		
		var callBackMusicPause = function(){
			audio_pause_sound(music_track);
		}
		
		time_source_reconfigure(music_tsource_pausing,_time/MILI_TO_SECONDS,time_source_units_seconds,callBackMusicPause);
		time_source_start(music_tsource_pausing);
	}	
}
	
///@arg time
function MusicResume(_time = fade_time.normal){
	with(global.music_manager)
	{
		time_source_stop_active(music_tsource_pausing);
		
		time_source_resume(music_tsource_next_track);
		
		if(music_track == noone)
		{
			return;
		}
		
		MusicFadeResume(music_track,_time);
	}
}

function PauseMusicPlay(_track,_time = fade_time.normal){
	with(global.music_manager)
	{
		if(pause_track == noone || !audio_is_playing(pause_track) || (audio_get_name(pause_track) != audio_get_name(_track)))
		{
			pause_track = MusicFadeIn(_track,_time,true);
		}
		else
		{
			audio_sound_gain(pause_track,global.music_group_gain,_time);
		}
		time_source_stop_active(music_tsource_stopping_pause);
	}
}

///@arg time
function PauseMusicStop(_time = fade_time.normal) {
	with(global.music_manager)
	{
		PauseMusicFadeOutStop(_time);
	}
}

///@arg track
///@arg time
function MenuMusicPlay(_track,_time = fade_time.normal){
	MusicPause(_time);
	PauseMusicPlay(_track,_time);
}

///@arg time
function MenuMusicStop(_time = fade_time.normal){
	PauseMusicStop(_time);
	MusicResume(_time);
}