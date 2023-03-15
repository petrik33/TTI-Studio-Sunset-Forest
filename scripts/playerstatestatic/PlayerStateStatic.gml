function PlayerStateStatic() {
	EntityMovement()
}

function PlayerMakeStatic(){
	with(global.oPlayer)
	{
		EntityMakeStatic();
		player_gui_display = false;
	}
}

function PlayerMakeFree(){
	with(global.oPlayer)
	{
		state = PlayerStateFree;
		player_gui_display = true;
	}
}