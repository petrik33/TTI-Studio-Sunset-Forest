#region//Colors Count
if(!day_night_paused_mode)
{
	if(stage_transition)
	{
	
		color_mix = [
				 lerp(past_color_mix[0],colors[0][transition_stage,0],transition_progress),
				 lerp(past_color_mix[1],colors[0][transition_stage,1],transition_progress),
				 lerp(past_color_mix[2],colors[0][transition_stage,2],transition_progress)];

		con_sat_brt_mix = [
					 lerp(past_con_sat_brt[0],con_sat_brt[0][transition_stage,0],transition_progress),
					 lerp(past_con_sat_brt[1],con_sat_brt[0][transition_stage,1],transition_progress),
					 lerp(past_con_sat_brt[2],con_sat_brt[0][transition_stage,2],transition_progress),
					 lerp(past_con_sat_brt[3],con_sat_brt[0][transition_stage,3],transition_progress),
					 lerp(past_con_sat_brt[4],con_sat_brt[0][transition_stage,4],transition_progress)];
		
		if(!global.game_is_paused)
		{
			transition_progress+=transition_speed;
			if(transition_progress >= 1)
			{
				stage_transition = false;
				current_stage = transition_stage;
				cycle_progress = 0;
				cycle_direction = 1;
				transition_progress = 0;
			}
		}
	}
	else
	{
		color_mix = [
				 lerp(colors[0][current_stage][0],colors[1][current_stage][0],cycle_progress),
				 lerp(colors[0][current_stage][1],colors[1][current_stage][1],cycle_progress),
				 lerp(colors[0][current_stage][2],colors[1][current_stage][2],cycle_progress)];

		con_sat_brt_mix = [
					 lerp(con_sat_brt[0][current_stage][0],con_sat_brt[1][current_stage][0],cycle_progress),
					 lerp(con_sat_brt[0][current_stage][1],con_sat_brt[1][current_stage][1],cycle_progress),
					 lerp(con_sat_brt[0][current_stage][2],con_sat_brt[1][current_stage][2],cycle_progress),
					 lerp(con_sat_brt[0][current_stage][3],con_sat_brt[1][current_stage][3],cycle_progress),
					 lerp(con_sat_brt[0][current_stage][4],con_sat_brt[1][current_stage][4],cycle_progress)];
				 
		if(!global.game_is_paused)
		{
			cycle_progress+=cycle_spd*cycle_direction;
			if(cycle_progress>1)
			{
				cycle_progress = 1;
				cycle_direction*=-1;
			}
			if(cycle_progress < 0)
			{
				cycle_progress = 0;
				cycle_direction *= -1;
			}
		}
	}
}
else
{
	DayNightPauseValuesMix();
}
#endregion