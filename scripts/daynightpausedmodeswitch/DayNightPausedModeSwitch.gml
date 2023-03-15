///@arg off_stopped_on
///@arg update_time
function DayNightPausedModeSwitch(_mode,_update_time){
	with(global.time_cycler)
	{
		if(_update_time != undefined && _update_time)
		{
			paused_time = global.time;	
		}
		switch(_mode)
		{
			case 1:
			
			paused_time_on = false;
			day_night_paused_mode = true;
			fireflies_on = false;
			
			break;
			case 2:
			paused_time_on = true;
			day_night_paused_mode = true;
			fireflies_on = false;
			
			break;
			
			case 0:
			
			day_night_paused_mode = false;
			fireflies_on = true;
			
			break;
			
		}
	}
}