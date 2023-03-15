if(!global.game_is_paused)
{
	event_inherited();
	script_execute(state);

	//Waving
	script_execute(candle_waving_state);

	//Damaged
	if(damage_recieved)
	{
		damaged_animation_progress += damaged_animation_speed;
		x = xstart + animcurve_channel_evaluate(damaged_channel,damaged_animation_progress mod 1);
		if(damaged_animation_progress >= 1)
		{
			damage_recieved = false;
			sprite_index = sprite_idle;
			image_index = 0;
		}
	}
}