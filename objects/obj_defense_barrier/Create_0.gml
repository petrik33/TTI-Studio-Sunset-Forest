image_alpha = 0;
animation_progress = 0;
//animation_speed = (pi) / (FRAME_RATE * 2);
animation_speed = (1) / (FRAME_RATE * 1);
target = noone;
duration = 0;
step_sound_resource = sn_defense_barrier_step;
step_sound = PlayerSoundMake(step_sound_resource,,,true);
ui_id = -1;

function ShieldRemove(){
	if(target == global.oPlayer)
	{
		PlayerRemoveBuffUI(ui_id);
		global.oPlayer.player_shielded = false;
	}
	instance_destroy();	
}