function PlayerJump(){
	if(state != PlayerStateCastSkill && state!=PlayerStateDash)
	{
		sprite_index = spr_hero_jump;
		image_index = 0;
	}
	jumped = true;
	if(FLOOR_Y - y>=from_floor_to_jump)
	{
		jumped_twice = true;
		PlayerSoundMake(second_jump_sounds);
	}
	else
	{
		PlayerSoundMake(jump_sounds);
	}
	Vy = -jump_spd;
	
	
}