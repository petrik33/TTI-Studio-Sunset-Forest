event_inherited();
if(!global.game_is_paused)
{
	if(state = seed_state_being_opened)
	{
		y = lerp(FLOOR_Y,bird_companion_flying_y,global.oPlayer.image_index/(global.oPlayer.image_number-1));	
	}
}
