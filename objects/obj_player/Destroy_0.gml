/// @description Game Over: Run Ending CS
event_inherited();
ds_list_destroy(ice_special_caught_list);
ds_list_destroy(hit_by_attack);
if(!global.game_final)
{
	with(pobj_companion) DyingScript();
	if(!global.lose)
	{
		cutscene_run(obj_CS_defeat);
	}
}

