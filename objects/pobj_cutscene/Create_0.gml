scene_timer = 0;
scene_temporary_values = ds_list_create();
scene_first_frame = true;

scene = 0;
scene_info = -1;
global.current_cutscene = self;
global.pause_available = false;
//global.pause_available = false;

//cutscene_paused = false;

condition_timer = 0;
condition_timer2 = 0;

bestiary_closed = BestiaryButtonHide();

if(stop_time)
{
	time_state_change(time_state_stop);	
	clock_hide();
}

if(stop_music)
{
	MusicPause(fade_time.slow);
}

#region//Black Bars

if(black_bars_on)
{

	if(global.GUI_H != ORIGINAL_VIEW_H)
	{
		CreateBlackBars((global.GUI_H - ORIGINAL_VIEW_H) / 2, 1);
	}
	
}

#endregion
