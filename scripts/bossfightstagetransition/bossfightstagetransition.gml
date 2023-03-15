///@arg enum
function BossFightStageTransition(_new_stage_enum){
	if(!instance_exists(obj_boss_fight_shader_manager))
	{
		var _boss_cycler = instance_create_layer(0,0,"Managers",obj_boss_fight_shader_manager);
		with(_boss_cycler)
		{
			past_color_mix = global.time_cycler.color_mix;
			past_con_sat_brt = global.time_cycler.con_sat_brt_mix;
		}
		instance_destroy(global.time_cycler);
		global.time_cycler = _boss_cycler;
	}
	else
	{
		with(global.time_cycler)
		{
			past_color_mix = color_mix;
			past_con_sat_brt = con_sat_brt_mix;
		}	
	}
	
	with(global.time_cycler)
	{
		stage_transition = true;
		transition_progress = 0;
		transition_stage = _new_stage_enum+1;
		//transition_stage = _new_stage_enum;
	}
}