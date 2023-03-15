enum fade_time{
	fast = MILI_TO_SECONDS * 1,
	normal = MILI_TO_SECONDS * 3,
	slow = MILI_TO_SECONDS * 5
};

//// One Playing Track and One Paused
//enum ms_track_type {
//	play,
//	pause,
//	tracks_num
//}

//enum ms_track {
//	music_,
//	state,
//	enum_size
//}

//enum ms_track_state{
//	transition,
//	ready,
//	states_num
//}

music_track = noone;
pause_track = noone;

music_tsource_parent = time_source_create_empty(time_source_game);

music_tsource_next_track = time_source_create_empty(music_tsource_parent);
//music_tsource_playing_update = time_source_create_empty(music_tsource_parent);
music_tsource_pausing = time_source_create_empty(music_tsource_parent);
music_tsource_stopping = time_source_create_empty(music_tsource_parent);
music_tsource_stopping_pause = time_source_create_empty(music_tsource_parent);
//music_tsource_resuming = time_source_create_empty(music_tsource_parent);

//music_tsource_next_track_paused = time_source_create_empty(music_tsource_parent);

next_track_callback = global.MusicCallbackNone;
loop_delay = [0,0];

//music_tsource_stop = time_source_create_empty(music_tsource_parent); // both stops and pauses music
//music_tsource_start = time_source_create_empty(music_tsource_parent);
//music_tsource_update_playing = time_source_create_empty(music_tsource_parent);

tracks_queue = [ms_new_main,ms_night_music];

function DayNightMusicStartTimesSet(){
	//var _music_day_min_edge = 0.3;
	//var _music_night_min_edge = TIME_MENU;

	var _music_day_len = audio_sound_length(ms_new_main)/day_length*FRAME_RATE;
	var _music_night_len = audio_sound_length(ms_night_music)/day_length*FRAME_RATE;
	
	var _total_music_len = _music_day_len + _music_night_len;
	var _music_gap_total = (1 - _total_music_len) * day_length;
	
	music_day_night_gap = (_music_gap_total / 2); // In Game Frames

	//var _music_day_max_edge = _music_night_min_edge - _music_day_len;
	//var _music_night_max_edge = _music_day_min_edge - _music_night_len;

	//if(_music_night_max_edge < 0)
	//{
	//	_music_night_max_edge = 1 + _music_night_max_edge;	
	//}
	
	//tracks_start_time_range = [[_music_day_min_edge,_music_day_max_edge],[_music_night_min_edge,_music_night_max_edge]];
}

music_day_night_gap = 1;
//tracks_start_time_range = array_create(2,array_create(2,0));

if(audio_group_is_loaded(music))
{
	DayNightMusicStartTimesSet();
}
else
{
	alarm[0] = 10;	
}

//next_track_start_time = -1;
//Time Proper Format Checks
queue_pos = 0;

//pausing_track = false;
//unpausing_track = false;

//pause_music = noone;

//ms_paused_check_frqcy = 3;

//music_paused = noone;


