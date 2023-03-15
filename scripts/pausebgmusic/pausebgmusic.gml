/////@arg time
//function PauseBGMusic(_time){
//	with(global.music_manager)
//	{
//		music_paused = global.current_music;
//		if(audio_exists(music_paused))
//		{
//			audio_sound_gain(global.current_music,0,_time);
//			alarm[2] = ceil(_time / MILI_TO_SECONDS); //pause the music when it gets silent
//		}
//	}
//}

/////@arg time
//function UnPauseBGMusic(_time){
//	with(global.music_manager)
//	{
//		if(global.current_music != music_paused)
//		{
//			MusicStop();
//		}
//		if(audio_exists(music_paused))
//		{ 
//			audio_resume_sound(music_paused);
//			audio_sound_gain(music_paused,1,_time);
//		}
//	}
//}