function GameStartGeneral(){
	
	clock_unhide();
	
	global.game_on = true;
	
	CameraStateChange(CameraStateFollow);
	
	global.time_cycler.time_state = time_state_free;
	
	with(pobj_wall_barrier)
	{
		barrier_visible = true;
		barrier_working = true;
		sprite_index = spr_wall_barrier_enemy;
	}
	
	MusicDayNightStart();
	
}