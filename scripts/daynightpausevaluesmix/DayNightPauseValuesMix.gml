function DayNightPauseValuesMix(){
	var _colors = paused_colors;
	var _con_sat_brt = paused_con_sat_brt;
	key_previous = 0;
	key_next = 1;
	
	var lerp_amount;
	if(paused_time > 1)
	{
		if(paused_time > 2)
		{
			paused_time %= 2;
			lerp_amount = paused_time;
		}
		else
		{
			lerp_amount = 2 - paused_time;
		}
	}
	else
	{
		lerp_amount = paused_time;	
	}
	color_mix = mix_key_colors(key_previous,key_next,lerp_amount,_colors);
	con_sat_brt_mix = mix_key_con_sat_brt(key_previous,key_next,lerp_amount,_con_sat_brt);
	
	if(paused_time_on) paused_time += paused_time_spd;
}