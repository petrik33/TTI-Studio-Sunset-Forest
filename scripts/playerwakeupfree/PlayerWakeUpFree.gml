function PlayerWakeUpFree(){
	global.oPlayer.state_before_sleep = PlayerStateFree;
	global.oPlayer.player_gui_display = true;
	PlayerWakeUp();
}