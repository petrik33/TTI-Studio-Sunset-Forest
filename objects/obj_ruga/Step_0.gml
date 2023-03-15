event_inherited();
if(!global.game_is_paused)
{
	if(!ruga_weakened && state!=RugaStateDamaged)
	{
		RugaDamagedCheck();
	}
}
