if(!global.game_is_paused)
{
	state();
	if(first_one_of_type)
	{
		if(instance_exists(obj_player))
		{
			var _dist = abs(global.oPlayer.x - x);
			if(_dist <= bestiary_open_distance)
			{
				BestiaryEnqueue(BESTIARY_PAGE_TYPE.ENEMY,enemy_id);
				first_one_of_type = false;
				global.enemies[ENEMY.BESTIARY_OPENED][enemy_id] = true;
				with(global.enemies[ENEMY.OBJECT][enemy_id])
				{
					first_one_of_type = false;
				}
			}
		}
	}
	event_inherited();
}