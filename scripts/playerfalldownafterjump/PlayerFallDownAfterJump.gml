function PlayerFallDownAfterJump(){
	PlayerSoundMake(sn_hero_jump_fall);
	if(FLOOR_Y - y <= 1)
	{
		DustEffectOnFallCreate();
	}
	jumped = false;
	jumped_twice = false;
}