///@target
///@duration
function EntityGiveShield(_target,_duration){
	with(instance_create_layer(_target.x,(_target.bbox_bottom + _target.bbox_top) / 2,"Effects",obj_defense_barrier))
	{
		target = _target;
		if(target == global.oPlayer)
		{
			global.oPlayer.player_shielded = true;
			ui_id = PlayerAddBuffUI(spr_drop_defense);	
		}
		duration = _duration * FRAME_RATE;
	}
}