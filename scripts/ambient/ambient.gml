///@arg time
function forest_ambient_start(_time = fade_time.normal){
	with(obj_game)
	{
		if(!audio_is_playing(forest_ambient))
		{
			forest_ambient = PlayerSoundMake(forest_ambient_asset,,,true,_time);	
		}
		else
		{
			audio_sound_gain(forest_ambient,sounds_hidden_gain * global.sounds_group_gain,_time);	
		}
	}
}

///@arg crows
///@arg time
function forest_ambient_stop(_crows,_time = fade_time.fast){
	with(obj_game)
	{
		if(audio_is_playing(forest_ambient))
		{
			audio_sound_gain(forest_ambient,0,_time);
			if(_crows){
				PlayerSoundMake(sn_bird_flight8_1);	
			}
		}
	}
}