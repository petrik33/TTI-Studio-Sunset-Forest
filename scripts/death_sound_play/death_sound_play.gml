function death_sound_play(){
	if(death_sound!=noone)
	{
		//audio_play_sound_at(death_sound,x,y,0,falloff_ref_dist,falloff_max_dist,falloff_factor,0,1);
		sound_xy(death_sound);
	}
}