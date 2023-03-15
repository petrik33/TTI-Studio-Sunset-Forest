/// @description Ending the Game
event_inherited();
if(!global.boss_earthquake)
{
	global.lose = true;
	instance_destroy(crystal_light);
	with(obj_candle_tower) instance_destroy();
	
	with(global.oPlayer)
	{
		DyingScript();
	}
	cutscene_run(obj_CS_defeat);
}
else
{
	global.boss_earthquake = false;
}	
