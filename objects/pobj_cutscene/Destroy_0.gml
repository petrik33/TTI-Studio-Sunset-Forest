ds_list_destroy(scene_temporary_values);
global.pause_available = true;
HideBlackBars(1);
if(stop_music)
{
	MusicResume(fade_time.slow);
}
if(bestiary_closed)
{
	BestiaryButtonPopUp();	
}
//global.pause_available = true;
