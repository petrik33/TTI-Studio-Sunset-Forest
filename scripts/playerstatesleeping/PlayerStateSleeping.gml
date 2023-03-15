function PlayerStateSleeping(){
	
	y = paused_y - abs(sin(pause_waving_progress)) * pause_waving_amplitude;
	pause_waving_progress+=pause_waving_spd;
	if(pause_waving_progress>2*pi) pause_waving_progress -= 2*pi;
	
}